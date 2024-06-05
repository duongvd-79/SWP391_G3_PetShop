/*
 */

package controller;

import dal.AddressDAO;
import dal.UserDAO;
import helper.MD5;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Address;
import model.User;

/**
 *
 * @author duongvu
 */
public class LoginServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<title>Servlet LoginServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoginServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String logoutRequest = request.getParameter("logout");
        HttpSession session = request.getSession(false);
        if (session == null || logoutRequest == null) {
            response.sendRedirect("home#loginpopup");
        } else {
            session.invalidate();
            response.sendRedirect("home");
        }
    }

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        UserDAO userDAO = new UserDAO();
        AddressDAO addressDAO = new AddressDAO();
        
        String email = request.getParameter("email").trim();
        String password = request.getParameter("password");
        
        User user = userDAO.login(email, MD5.getMD5(password));
        
        if (user != null) {
            HttpSession session = request.getSession(true);
            Address address = addressDAO.getAddress(user.getId());
            session.setAttribute("user", user);
            //session.setAttribute("address", address);
            response.sendRedirect("home");
        } else {
            String error = "Wrong email or password!";
            HttpSession session = request.getSession(true);
            session.setAttribute("error", error);
            session.setAttribute("username", email);
            //request.getRequestDispatcher("home#loginpopup").forward(request, response);
            response.sendRedirect("home#loginpopup");
        }
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
