/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Setting;
import model.User;

/**
 *
 * @author Admin
 */
public class SearchUserServlet extends HttpServlet {
   
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
            out.println("<title>Servlet SearchUserServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SearchUserServlet at " + request.getContextPath () + "</h1>");
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
        String search = request.getParameter("search");
        UserDAO userDAO = new UserDAO();
        ArrayList<User> combinedUserList = new ArrayList<>();
        try {
            ArrayList<User> userListByName = userDAO.searchUserByName(search);
            ArrayList<User> userListByEmail = userDAO.searchUserByEmail(search);
            ArrayList<User> userListByPhone = userDAO.searchUserByPhone(search);
            ArrayList<User> userList = userDAO.getAllUser();
            ArrayList<Setting> roleList = userDAO.getAllRole();

            // get all status currently have in useList
            ArrayList<String> tempList = new ArrayList<>();
            for (User u : userList) {
                tempList.add(u.getStatus());
            }

            Set<String> setWithoutDuplicates = new HashSet<>(tempList);

            ArrayList<String> statusList = new ArrayList<>(setWithoutDuplicates);

            request.setAttribute("roleList", roleList);
            request.setAttribute("statusList", statusList);

            combinedUserList.addAll(userListByName);
            combinedUserList.addAll(userListByEmail);
            combinedUserList.addAll(userListByPhone);
            if (!combinedUserList.isEmpty()) {
                request.setAttribute("userList", combinedUserList);
            } else {
                request.setAttribute("msg", "There are no match to any user");
            }
            request.getRequestDispatcher("UserList.jsp").forward(request, response);

        } catch (SQLException ex) {
            Logger.getLogger(SearchUserServlet.class.getName()).log(Level.SEVERE, null, ex);
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
        processRequest(request, response);
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
