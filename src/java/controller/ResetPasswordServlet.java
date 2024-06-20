/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import model.User;
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


/**
 *
 * @author ACER
 */
public class ResetPasswordServlet extends HttpServlet {

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
            out.println("<title>Servlet ResetPasswordServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ResetPasswordServlet at " + request.getContextPath() + "</h1>");
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
        UserDAO uDAO = new UserDAO();
        String alert="";
        HttpSession session = request.getSession();
        String email = request.getParameter("email").trim();
        //check account exist
        boolean isExist = false;
        try {
            for (User user : uDAO.getAllUser()) {
                if (email.equals(user.getEmail())) {
                    isExist = true;
                }
            }
        } catch (SQLException ex) {}
        if(!isExist){
            alert="Account not exist";
            session.setAttribute("alert", alert);
            session.setAttribute("email",email);
            response.sendRedirect("home#reset");
        }
        else{
            String key= KeyGenerator.getKey();
            session.setAttribute("key", key);
            session.setAttribute("email",email);
            SendMail.sendMail(email, "Reset Your Password", "Click this link to reset your password:\n"+"http://localhost:9090/SWP391_G3_PetShop/resetverify?key="+key+"\n This link will expired in 3 minutes.");
            response.sendRedirect("home#verify");
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
        HttpSession session = request.getSession();
        UserDAO uDAO = new UserDAO();
        String alert="";
        String password = request.getParameter("password");
        String cfpassword = request.getParameter("cfpassword");
        String email = (String) session.getAttribute("checkemail");
        //password not match 
        if(!password.equals(cfpassword)){
            alert = "Confirm password does not match";
            session.setAttribute("alert1", alert);
            response.sendRedirect("home#enterreset");
        }
        else {
            uDAO.changePassword(email,password);
            alert = "Password changed success. Please login.";
            session.setAttribute("alert1", alert);
            response.sendRedirect("home#enterreset");
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
