/*
 */
package controller;

import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;

/**
 *
 * @author duongvu
 */
public class CreatePasswordServlet extends HttpServlet {

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
            out.println("<title>Servlet CreatePasswordServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CreatePasswordServlet at " + request.getContextPath() + "</h1>");
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
            String key = request.getParameter("key");
            String idRaw = request.getParameter("id");
            int id = 0;
            if (idRaw != null) {
                id = Integer.parseInt(idRaw);
            }
            getServletContext().setAttribute("id", id);

            String alert;
            long creationTime = session.getCreationTime();
            long currentTime = System.currentTimeMillis();
            long maxInactiveInterval = 600 * 1000;
            if (key.equals((String) getServletContext().getAttribute("createPasswordKey")) && currentTime - creationTime < maxInactiveInterval) {
                response.sendRedirect("home#createPassword");
            } else if (currentTime - creationTime > maxInactiveInterval) {
                alert = "Link had been expired!";
                session.setAttribute("error", alert);
                response.sendRedirect("home#login");
            } else {
                alert = "Not authorized access!";
                session.setAttribute("error", alert);
                response.sendRedirect("home#login");
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
        UserDAO udao = new UserDAO();

        String idRaw = request.getParameter("id");
        int i = 0;
        if (idRaw != null) {
            i = Integer.parseInt(idRaw);
        }
        String password = request.getParameter("password");
        String cfPassword = request.getParameter("cfpassword");
        String email = "";
        try {
            email = udao.getUserByID(i).getEmail();
        } catch (SQLException e) {
        }

        String alert;
        // Check passwords
        if (!password.equals(cfPassword)) {
            alert = "Confirm password does not match";
            session.setAttribute("alert", alert);
            response.sendRedirect("home#createPassword");
        } else {
            udao.changePassword(email, password);
            String noti = "Password changed successfully!";
            session.setAttribute("noti", noti);
            session.setAttribute("toastType", "success");
            alert = "";
            session.setAttribute("alert", alert);
            response.sendRedirect("home#login");
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
