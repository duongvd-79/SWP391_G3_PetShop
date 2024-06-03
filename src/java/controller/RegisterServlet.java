/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.AddressDAO;
import helper.SendMail;
import dal.UserDAO;
import helper.KeyGenerator;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Address;
import model.User;

/**
 *
 * @author ACER
 */
public class RegisterServlet extends HttpServlet {

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
            out.println("<title>Servlet AddUserServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddUserServlet at " + request.getContextPath() + "</h1>");
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
        List<User> uList = new ArrayList<>();
        try {
            uList = uDAO.getAllUser();
        } catch (SQLException ex) {
        }
        AddressDAO aDAO = new AddressDAO();
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String cfpassword = request.getParameter("cfpassword");
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String gender = request.getParameter("gender");
        String city = request.getParameter("city");
        String district = request.getParameter("district");
        String address = request.getParameter("address");
        boolean dup = false;
        Address a = new Address(0, district, city, address, true);
        User u = new User(email, password, name, "Peding", phone, null, (gender.equals("Male")), 5);
        for (User user : uList) {
            if (user.getEmail().equals(email)) {
                dup = true;
            }
        }

        if (dup) {
            session.setAttribute("alert", "Email had been taken.");
            session.setAttribute("address", a);
            session.setAttribute("newuser", u);
            response.sendRedirect("home#registerpopup");
        } else if (!password.equals(cfpassword)) {
            session.setAttribute("newuser", u);
            session.setAttribute("address", a);
            session.setAttribute("alert", "Password not match.");
            response.sendRedirect("home#registerpopup");
        } else {
            session.removeAttribute("alert");
            session.setAttribute("newuser", u);
            session.setAttribute("address", a);
            String key= KeyGenerator.getKey();
            session.setAttribute("key", key);
            session.setMaxInactiveInterval(180);
            SendMail.sendMail(email,"Email verificaton","Click this link to finish you registration:\n"+"http://localhost:9998/SWP391_G3_PetShop/emailverify?key="+key+"\n This link will expired in 3 minutes." );
            response.sendRedirect("home#verifypopup");
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
