/*
 */
package controller;

import dal.AddressDAO;
import dal.RecordDAO;
import dal.SettingDAO;
import dal.UserDAO;
import helper.KeyGenerator;
import helper.SendMail;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Address;
import model.User;
import model.Record;
import model.Setting;

/**
 *
 * @author duongvu
 */
public class CustomerListServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CustomerListServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CustomerListServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            User user = (User) session.getAttribute("user");
            if (user != null && user.getRoleId() == 2) {
                // Get customer list
                UserDAO udao = new UserDAO();
                List<User> customerList;

                // Enable/Disable account
                RecordDAO rdao = new RecordDAO();
                String idRaw = request.getParameter("id");
                if (idRaw != null) {
                    int id = Integer.parseInt(idRaw);
                    String cStatus = request.getParameter("cstatus");
                    if (cStatus != null && cStatus.equals("Active")) {
                        udao.updateCustomer("Inactive", id);
                        rdao.addNewRecord(user.getId(), "Disabled Account.", id);
                    } else if (cStatus != null && (cStatus.equals("Inactive") || cStatus.equals("Pending"))) {
                        udao.updateCustomer("Active", id);
                        rdao.addNewRecord(user.getId(), "Enabled Account.", id);
                    }
                }

                // Get attributes
                String status = request.getParameter("status");
                request.setAttribute("status", status);
                String gender = request.getParameter("gender");
                request.setAttribute("gender", gender);
                String search = request.getParameter("search");
                request.setAttribute("search", search);
                String sort = request.getParameter("sort");
                request.setAttribute("sort", sort);

                // Get page
                String pageIndexRaw = request.getParameter("page");
                int pageIndex = 1;
                if (pageIndexRaw != null && !pageIndexRaw.equals("")) {
                    pageIndex = Integer.parseInt(pageIndexRaw);
                }
                request.setAttribute("page", pageIndex);

                customerList = udao.getAllCustomer(true, status, gender, search, sort, pageIndex);
                request.setAttribute("customerList", customerList);
                request.setAttribute("size", customerList.size());

                // Get address for each user
                AddressDAO addressDAO = new AddressDAO();
                List<Address> addressList;
                try {
                    for (User u : customerList) {
                        addressList = addressDAO.getAddressList(u.getId());
                        request.setAttribute("addressList" + u.getId(), addressList);
                    }
                } catch (SQLException e) {
                    System.out.println(e.getMessage());
                }

                // Pagination
                int totalCustomer;
                // Get total product
                customerList = udao.getAllCustomer(false, status, gender, search, sort, 0);
                totalCustomer = customerList.size();
                int maxPage = totalCustomer / 4;
                if (totalCustomer % 4 != 0) {
                    maxPage++;
                }
                request.setAttribute("totalPage", maxPage);

                // Get update record
                Map<User, List<Record>> recordMap = rdao.getAll();
                request.setAttribute("recordMap", recordMap);

                // Sort record
                String recordSort = request.getParameter("recordSort");
                if (recordSort != null && !recordSort.trim().isEmpty()) {
                    if (recordSort.equalsIgnoreCase("Date ASC")) {
                        recordMap.forEach((key, value) -> {
                            value.sort((r1, r2) -> r1.getUpdatedDate().compareTo(r2.getUpdatedDate()));
                        });
                    } else if (recordSort.equalsIgnoreCase("Date DESC")) {
                        recordMap.forEach((key, value) -> {
                            value.sort((r1, r2) -> r2.getUpdatedDate().compareTo(r1.getUpdatedDate()));
                        });
                    }
                    request.setAttribute("recordSort", recordSort);
                }
                request.setAttribute("recordMap", recordMap);

                // For updated by collumn
                List<User> userList = udao.getAll();
                request.setAttribute("userList", userList);
                SettingDAO sdao = new SettingDAO();
                Map<Integer, String> roleMap = new HashMap<>();
                List<Setting> roleList = sdao.getAll();
                roleList.removeIf(s -> s.getTypeId() != 3);
                for (Setting s : roleList) {
                    roleMap.put(s.getId(), s.getName().toUpperCase().charAt(0)
                            + s.getName().substring(1).toLowerCase());
                }
                request.setAttribute("roleMap", roleMap);

                request.getRequestDispatcher("customerList.jsp").forward(request, response);
            } else {
                response.sendRedirect("404.html");
            }
        } else {
            response.sendRedirect("404.html");
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(true);

        // Get param
        String email = request.getParameter("email").trim();
        String name = request.getParameter("name").trim();
        String gender = request.getParameter("gender");
        String city = request.getParameter("city");
        String district = request.getParameter("district");
        String detail = request.getParameter("detailaddress").trim();
        String phone = request.getParameter("phone").trim();

        UserDAO udao = new UserDAO();
        User user = new User();
        user.setEmail(email);
        user.setPassword("");
        user.setName(name);
        user.setRoleId(5);
        user.setGender(gender.equalsIgnoreCase("Male"));
        user.setPhone(phone);
        user.setCreateDate(new Date());

        boolean flag = false;
        try {
            for (User u : udao.getAll()) {
                if (u.getEmail().equals(email)) {
                    flag = true;
                    break;
                }
            }
            if (flag) {
                session.setAttribute("noti", "The email had been registered!");
                session.setAttribute("toastType", "error");

                session.setAttribute("email", email);
                session.setAttribute("name", name);
                session.setAttribute("gender", gender);
                session.setAttribute("city", city);
                session.setAttribute("district", district);
                session.setAttribute("district", district);
                session.setAttribute("detail", detail);
                session.setAttribute("phone", phone);
                response.sendRedirect("customerlist#addNewCustomer");
            } else {
                udao.addNewUser(user);
                AddressDAO adao = new AddressDAO();
                adao.addDefaultAddress(city, district, detail);
                adao.addNewUserAddress();
                String key = KeyGenerator.getKey();
                getServletContext().setAttribute("createPasswordKey", key);
                int id = udao.getLastId();
                SendMail.sendMail(email, "Create Your Password", "Your account has been created using this email.\n"
                        + "Click this link to create your password:\n"
                        + "http://localhost:9090/SWP391_G3_PetShop/createpassword?id=" + id + "&key="
                        + key + "\nThis link will expired in 10 minutes.");

                session.setAttribute("noti", "Customer created successfully!");
                session.setAttribute("toastType", "success");
                response.sendRedirect("customerlist#addNewCustomer");
            }
        } catch (SQLException e) {
            PrintWriter out = response.getWriter();
            out.print(Arrays.toString(e.getStackTrace()));
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
