/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.AddressDAO;
import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Address;
import model.User;

/**
 *
 * @author ACER
 */
public class EmailVerifyServlet extends HttpServlet {

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
            out.println("<title>Servlet EmailVerifyServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EmailVerifyServlet at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        String key = request.getParameter("key");
        String alert = "";
        UserDAO uDAO = new UserDAO();
        AddressDAO aDAO = new AddressDAO();
        User u = (User) session.getAttribute("newuser");
        Address a = (Address) session.getAttribute("address");
        long creationTime = session.getCreationTime();
        long currentTime = System.currentTimeMillis();
        long maxInactiveInterval = 180 * 1000;
        //nếu khớp key gửi qua email
        if (key.equals((String) session.getAttribute("key")) && currentTime - creationTime < maxInactiveInterval ) {
            try {
                uDAO.addNewUser(u);
                aDAO.addNew(a.getCity(), a.getDistrict(), a.getDetail());
                aDAO.addNewUserAddress();
                alert = "Account is created successfully. Please Sign In.";
            } catch (SQLException ex) {
            }
        } else if (session.getAttribute("key") == null || currentTime - creationTime > maxInactiveInterval) {
            alert = "Link had been expired";
        } else {
            alert = "Not authorize access";
        }
        session.setAttribute("alert", alert);
        response.sendRedirect("home#register");

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
        processRequest(request, response);
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
