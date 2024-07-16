/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.AddressDAO;
import dal.FeedbackDAO;
import dal.OrderDAO;
import dal.OrderDetailsDAO;
import dal.ProductDAO;
import model.Address;
import model.User;
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
import model.OrderDetails;
import model.Product;

/**
 *
 * @author ACER
 */
public class OrderInformationServlet extends HttpServlet {

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
            out.println("<title>Servlet OrderInformationServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet OrderInformationServlet at " + request.getContextPath() + "</h1>");
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
        if (session.getAttribute("user") != null && ((User) session.getAttribute("user")).getRoleId() == 5) {
            ProductDAO pDAO = new ProductDAO();
            OrderDAO oDAO = new OrderDAO();
            OrderDetailsDAO odDAO = new OrderDetailsDAO();
            //thông tin khách hàng
            AddressDAO aDAO = new AddressDAO();
            // order chỉ được feedback 1 lần
            FeedbackDAO fbDAO = new FeedbackDAO();

            List<Product> lastestProduct = new ArrayList<>();
            List<Product> pList = new ArrayList<>();
            List<OrderDetails> odList = new ArrayList<>();
            List<Integer> fbList = new ArrayList<>();
            Address address = null;

            int id = Integer.parseInt(request.getParameter("id"));
            Order order = oDAO.getOrderById(id);
            try {
                address = aDAO.getChosenAddress(order.getAddressId());
                pList = pDAO.getAllByOrderId(id);
                odList = odDAO.getByOrderId(id);
                for (OrderDetails od : odList) {
                    fbList.add(fbDAO.getFeedbackID(od.getProductId(), user.getId()));
                }
            } catch (SQLException ex) {
                Logger.getLogger(OrderInformationServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            lastestProduct = pDAO.getActive(false, null, null, null, null, "Latest", 0);

            request.setAttribute("order", order);
            request.setAttribute("address", address);
            request.setAttribute("latestproduct", lastestProduct);
            request.setAttribute("pList", pList);
            request.setAttribute("odList", odList);
            request.setAttribute("fbList", fbList);
            request.setAttribute("length", odList.size() - 1);
            request.getRequestDispatcher("orderinformation.jsp").forward(request, response);
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
        HttpSession session = request.getSession();
        int oid = 0;
        ProductDAO pDAO = new ProductDAO();
        OrderDetailsDAO odDAO = new OrderDetailsDAO();
        OrderDAO oDAO = new OrderDAO();

        List<Product> pList = new ArrayList<>();
        List<OrderDetails> odList = new ArrayList<>();
        try {
            oid = Integer.parseInt(request.getParameter("cancelid"));
        } catch (Exception e) {
        }
        pList = pDAO.getAllByOrderId(oid);
        odList = odDAO.getByOrderId(oid);
        
        for(int i=0;i<pList.size();i++){
            pDAO.updateQuantity(pList.get(i).getId(), pList.get(i).getQuantity()+ odList.get(i).getQuantity());
        }

        oDAO.changeStatus(oid, "Cancelled");

        String Noti = "Order cancelled success!";
        session.setAttribute("noti", Noti);
        session.setAttribute("toastType", "success");
        response.sendRedirect("myorders");
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
