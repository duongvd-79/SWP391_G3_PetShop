/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.CartDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Cart;
import model.User;

/**
 *
 * @author Admin
 */
public class AddCartHomepageServlet extends HttpServlet {
   
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
            out.println("<title>Servlet AddCartHomepageServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddCartHomepageServlet at " + request.getContextPath () + "</h1>");
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
         String pid = request.getParameter("productid");
        String quan = request.getParameter("quantity");

        CartDAO cartdao = new CartDAO();

        int productid = Integer.parseInt(pid);
        int quantity = Integer.parseInt(quan);

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        try {
            if(user != null){
            ArrayList<Cart> cartItemList = cartdao.getAllItemInCart(user.getId());
            boolean duplicate = false;
            for (Cart c : cartItemList) {
                if (c.getUserId() == user.getId() && c.getProductId() == productid) {
                    duplicate = true;
                   
                    cartdao.updateItemInCart(c.getQuantity() + 1, c.getId());
                    response.sendRedirect("home");
                    
                }
            }
            if (duplicate == false) {
                cartdao.AddToCart(productid, user.getId(), quantity);
                response.sendRedirect("home");
            }
            } else {
            response.sendRedirect("home");
            }
          
        } catch (SQLException ex) {
            Logger.getLogger(AddCartPageServlet.class.getName()).log(Level.SEVERE, null, ex);
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
