package controller;

import dal.AddressDAO;
import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import model.Address;
import model.User;

/**
 *
 * @author duongvu
 */
@MultipartConfig
public class UserProfileServlet extends HttpServlet {

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
            out.println("<title>Servlet UserProfileServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UserProfileServlet at " + request.getContextPath() + "</h1>");
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
        User user = (User) session.getAttribute("user");
        if (user == null) {
            session = request.getSession(true);
            String error = "Please login first!";
            session.setAttribute("error", error);
            response.sendRedirect("home#login");
        } else {
            response.sendRedirect("home#profile");
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
        HttpSession session = request.getSession(false);
        if (session == null) {
            session = request.getSession(true);
            String error = "Please login first!";
            session.setAttribute("error", error);
            response.sendRedirect("home#login");
        } else {
            User user = (User) session.getAttribute("user");
            if (user == null) {
                session = request.getSession(true);
                String error = "Please login first!";
                session.setAttribute("error", error);
                response.sendRedirect("#login");
            } else {
                // Error flag
                boolean changeFlag = true;

                UserDAO userDAO = new UserDAO();
                AddressDAO addressDAO = new AddressDAO();

                // Create path components to save the file
                String uploadPath = getServletContext().getRealPath("/") + "images\\userpfp";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdir();
                }

                // Handle file upload
                Part filePart = request.getPart("profilepfp");
                String fileName = filePart.getSubmittedFileName();
                File file = new File(uploadDir, fileName);

                // Save the file
                if (fileName != null && !fileName.equals("")) {
                    filePart.write(file.getAbsolutePath());
                    // Generate URL for the uploaded file
                    String fileUrl = "images\\userpfp\\" + fileName;
                    user.setPfp(fileUrl);
                }

                // Handle text inputs
                Part namePart = request.getPart("pfname");
                String name = getValueFromPart(namePart).trim();

                Part phonePart = request.getPart("pfphone");
                String phone = getValueFromPart(phonePart).trim();

                Part genderPart = request.getPart("pfgender");
                String gender = getValueFromPart(genderPart).trim();

                Part districtPart = request.getPart("pfdistrict");
                String district = getValueFromPart(districtPart).trim();

                Part cityPart = request.getPart("pfcity");
                String city = getValueFromPart(cityPart).trim();

                Part detailaddressPart = request.getPart("pfdetailaddress");
                String detailAddress = getValueFromPart(detailaddressPart);

                // Update user
                user.setName(name);
                if (gender != null) {
                    user.setGender(gender.equals("Male"));
                }
                user.setPhone(phone);
                userDAO.updateUserProfile(user);
                session.setAttribute("user", user);

                // Update address
                Address address = addressDAO.getAddressByUserId(user.getId());
                if (address == null) {
                    addressDAO.addAddress(city, district, detailAddress, user.getId());
                    address = addressDAO.getAddressByUserId(user.getId());
                }
                address.setCity(city);
                address.setDistrict(district);
                address.setDetail(detailAddress);
                addressDAO.updateUserAddress(address);
                session.setAttribute("address", address);

                // Display notification
                if (changeFlag) {
                    String Noti = "Updated successfully!";
                    session.setAttribute("noti", Noti);
                    session.setAttribute("toastType", "success");
                } else {
                    String Noti = "Updated failed!";
                    session.setAttribute("noti", Noti);
                    session.setAttribute("toastType", "error");
                }

                response.sendRedirect("#profile");
            }
        }
    }

    private String getValueFromPart(Part part) throws IOException {
        if (part != null) {
            StringBuilder value = new StringBuilder();
            try (BufferedReader reader = new BufferedReader(new InputStreamReader(part.getInputStream(), StandardCharsets.UTF_8))) {
                char[] buffer = new char[1024];
                int length;
                while ((length = reader.read(buffer)) > 0) {
                    value.append(buffer, 0, length);
                }
            }
            return value.toString();
        }
        return null; // or return an empty string or handle the null case accordingly
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
