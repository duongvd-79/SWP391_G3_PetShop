/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.OrderDAO;
import dal.OrderDetailsDAO;
import dal.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import model.Order;
import model.Product;
import model.User;

/**
 *
 * @author ACER
 */
public class MyOrdersServlet extends HttpServlet {

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
            out.println("<title>Servlet MyOrdersServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet MyOrdersServlet at " + request.getContextPath() + "</h1>");
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
        if (session.getAttribute("user") != null && ((User) session.getAttribute("user")).getRoleId() == 5) {
            OrderDAO oDAO = new OrderDAO();
            ProductDAO pDAO = new ProductDAO();
            OrderDetailsDAO odDAO = new OrderDetailsDAO();
            int page = 1;
            int num = 4;
            try {
                page = Integer.parseInt(request.getParameter("page"));
            } catch (Exception e) {
            }
            String status = request.getParameter("status");
            if (request.getParameter("status") == null) {
                status = "submitted";
            }

            User user = (User) session.getAttribute("user");
            List<Order> oList;
            List<Product> pList;
            List<Integer> remainNum;
            List<Integer> pQuantity = new ArrayList<>();

            oList = oDAO.getAll(status, user.getId(), page, num);
            pList = pDAO.getProductForEachOrder(((User) session.getAttribute("user")).getId(), status, page, num);
            remainNum = oDAO.getRemainNumOfProductEachOrder(status, user.getId(), page, num);
            for (int i = 0; i < oList.size(); i++) {
                pQuantity.add(odDAO.getQuantity(pList.get(i).getId(), oList.get(i).getId()));
            }
            int size = oDAO.getAll(status, user.getId(), 1, Integer.MAX_VALUE).size();
            request.setAttribute("page", page);
            request.setAttribute("pageNum", ((size % num == 0) ? (size / num) : (size / num + 1)));
            request.setAttribute("oList", oList);
            request.setAttribute("pList", pList);
            request.setAttribute("status", status);
            request.setAttribute("pQuantity", pQuantity);
            request.setAttribute("remainNum", remainNum);
            request.setAttribute("length", oList.size() - 1);

            request.getRequestDispatcher("myorders.jsp").forward(request, response);
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
