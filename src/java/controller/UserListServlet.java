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
import jakarta.servlet.http.HttpSession;
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
public class UserListServlet extends HttpServlet {

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
            out.println("<title>Servlet UserListServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UserListServlet at " + request.getContextPath() + "</h1>");
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
        String pageStr = request.getParameter("page");
        int page = 0;
        if (pageStr.isEmpty() || pageStr.isBlank()) {
            page = 1;
        } else {
            page = Integer.parseInt(pageStr);
        }

        HttpSession session = request.getSession();
        if (session.getAttribute("user") != null && ((User) session.getAttribute("user")).getRoleId() == 1) {
            try {
                UserDAO userDAO = new UserDAO();
                ArrayList<User> userList = userDAO.getAllUser();
                ArrayList<Setting> roleList = userDAO.getAllRole();

                // get all status currently have in useList
                int count = 0;
                int pageNum = 0;
                ArrayList<String> tempList = new ArrayList<>();
                for (User u : userList) {
                    count++;
                    tempList.add(u.getStatus());
                }
                if (count % 4 == 0) {
                    pageNum = count / 4;
                } else if (count % 4 != 0) {
                    pageNum = (count / 4) + 1;
                }

                ArrayList<User> userListPaging = userDAO.getAllUserPaging(page);

                Set<String> setWithoutDuplicates = new HashSet<>(tempList);

                ArrayList<String> statusList = new ArrayList<>(setWithoutDuplicates);

                request.setAttribute("pageNum", pageNum);
                request.setAttribute("link", "userlist");
                request.setAttribute("page", page);
                request.setAttribute("userList", userListPaging);
                request.setAttribute("roleList", roleList);
                request.setAttribute("statusList", statusList);
                request.getRequestDispatcher("UserList.jsp").forward(request, response);

            } catch (SQLException ex) {
                Logger.getLogger(UserListServlet.class.getName()).log(Level.SEVERE, null, ex);
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
