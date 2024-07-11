/*
 */
package controller;

import dal.AddressDAO;
import dal.RecordDAO;
import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import model.Address;
import model.User;
import model.Record;

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
//        HttpSession session = request.getSession(false);
//        if (session != null) {
//            User user = (User) session.getAttribute("user");
//            if (user != null && user.getRoleId() == 2) {
        // Get customer list
        UserDAO userDAO = new UserDAO();
        List<User> customerList;

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

        customerList = userDAO.getAllCustomer(true, status, gender, search, sort, pageIndex);
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

        // Get update record
        RecordDAO recordDAO = new RecordDAO();
        Map<User, List<Record>> recordMap = recordDAO.getAll();
        request.setAttribute("recordMap", recordMap);

        // Pagination
        int totalCustomer;
        // Get total product
        customerList = userDAO.getAllCustomer(false, status, gender, search, sort, 0);
        totalCustomer = customerList.size();
        int maxPage = totalCustomer / 4;
        if (totalCustomer % 4 != 0) {
            maxPage++;
        }
        request.setAttribute("totalPage", maxPage);

        request.getRequestDispatcher("customerList.jsp").forward(request, response);
//            } else {
//                response.sendRedirect("404.html");
//            }
//        } else {
//            response.sendRedirect("404.html");
//        }
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
