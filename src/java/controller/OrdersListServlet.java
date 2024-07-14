/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.OrderDAO;
import dal.OrderDetailsDAO;
import dal.ProductDAO;
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
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Order;
import model.Product;
import model.User;

/**
 *
 * @author ACER
 */
public class OrdersListServlet extends HttpServlet {

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
            out.println("<title>Servlet OrdersListServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet OrdersListServlet at " + request.getContextPath() + "</h1>");
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
        User user = (User) session.getAttribute("user");
        if (session.getAttribute("user") != null && (user.getRoleId() == 3 || user.getRoleId() == 4)) {
            OrderDAO oDAO = new OrderDAO();
            ProductDAO pDAO = new ProductDAO();
            OrderDetailsDAO odDAO = new OrderDetailsDAO();
            UserDAO uDAO = new UserDAO();
            //paging
            int page = 1;
            int num = 4;
            try {
                page = Integer.parseInt(request.getParameter("page"));
            } catch (Exception e) {
            }
            //search
            String searchby = request.getParameter("searchby");
            String search = request.getParameter("search");

            //get parameter
            String sortby = request.getParameter("sortby");
            String order = request.getParameter("order");
            String status = request.getParameter("status");
            String start = request.getParameter("start");
            String end = request.getParameter("end");
            int saleid = 0;
            try{
            saleid = Integer.parseInt(request.getParameter("saleid"));
            if(saleid!=0){
                user = uDAO.getUserByID(saleid);
            }
            }catch(Exception e){}

            //Initialize
            List<Order> oList;
            List<Product> pList;
            List<Integer> remainNum;
            List<Integer> pQuantity = new ArrayList<>();
            List<User> saleList = new ArrayList<>();

            //get data
            oList = oDAO.getAll(user, page, num, search, searchby, sortby, order, status, start, end);
            pList = pDAO.getProductForEachOrder(user, page, num, search, searchby, sortby, order, status, start, end);
            remainNum = oDAO.getRemainNumOfProductEachOrder(user, page, num, search, searchby, sortby, order, status, start, end);
            for (int i = 0; i < oList.size(); i++) {
                pQuantity.add(odDAO.getQuantity(pList.get(i).getId(), oList.get(i).getId()));
            }
            int size = oDAO.getAll(user, 1, Integer.MAX_VALUE, search, searchby, sortby, order, status, start, order).size();
            try {
                saleList = uDAO.getAllSale();
            } catch (SQLException ex) {
            }
            
            //set attribute
            request.setAttribute("search", search);
            request.setAttribute("searchby", searchby);
            request.setAttribute("sortby", sortby);
            request.setAttribute("order", order);
            request.setAttribute("status", status);
            request.setAttribute("start", start);
            request.setAttribute("end", end);
            request.setAttribute("page", page);
            request.setAttribute("pageNum", ((size % num == 0) ? (size / num) : (size / num + 1)));
            request.setAttribute("oList", oList);
            request.setAttribute("pList", pList);
            request.setAttribute("pQuantity", pQuantity);
            request.setAttribute("remainNum", remainNum);
            request.setAttribute("length", oList.size() - 1);
            request.setAttribute("saleList", saleList);
            request.setAttribute("saleid", saleid);

            request.getRequestDispatcher("orderslist.jsp").forward(request, response);
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
