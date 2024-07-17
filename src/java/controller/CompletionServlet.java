/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.AddressDAO;
import dal.CartDAO;
import dal.OrderDAO;
import dal.ProductDAO;
import dal.UserDAO;
import helper.SendMailOrder;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Address;
import model.Cart;
import model.Order;
import model.Product;
import model.User;

/**
 *
 * @author Admin
 */
public class CompletionServlet extends HttpServlet {

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
            out.println("<title>Servlet CompletionServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CompletionServlet at " + request.getContextPath() + "</h1>");
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
        String payment_method = request.getParameter("payment");

        UserDAO userdao = new UserDAO();
        CartDAO cartdao = new CartDAO();
        OrderDAO orderdao = new OrderDAO();
        ProductDAO productdao = new ProductDAO();
        AddressDAO addressdao = new AddressDAO();
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("user");
        Order o = (Order) session.getAttribute("order");
        double total_cost = 0;

        String currentDateStr = getCurrentDate();

        try {
            if (u != null) {
                ArrayList<Cart> cartDetailList = cartdao.getCartDetail(u.getId());
                for (Cart c : cartDetailList) {
                    total_cost += c.getQuantity() * c.getList_price();
                }

                // create a list of user object with id and number of order
                ArrayList<User> ulist = userdao.getUserByRoleID(3);
                ArrayList<User> salelist = new ArrayList<>();
                for (User user : ulist) {
                    salelist.add(new User(user.getId(), orderdao.getTotalOrderBySaleID(user.getId())));
                }

                // find the saler with the min order number
                User minUser = salelist.get(0);
                for (User user1 : salelist) {
                    if (user1.getTotsalSale() < minUser.getTotsalSale()) {
                        minUser = user1;
                    }
                }

                // add new order to order table
                Order newOrder = new Order(o.getCustomerId(), o.getAddressId(), minUser.getId(), "Submitted", payment_method, total_cost, o.isIsDelivered(), o.isIsPaid(), currentDateStr, o.getDeliveredDate());
                orderdao.addNewOrder(newOrder);

                // add new order detail
                Order latestOrder = orderdao.getLatestOrder();
                for (Cart cart : cartDetailList) {
                    orderdao.addOrderDetail(latestOrder.getId(), cart.getProductId(), cart.getQuantity(), cart.getImport_price(), cart.getList_price());
                }
                
                // get address by address id
                Address address = addressdao.getChosenAddress(latestOrder.getAddressId());
                
                //send mail to user to confirm and complete purchasing progress
                boolean check = false;
                if(payment_method.equalsIgnoreCase("Banking")){
                check = true;
                }
                SendMailOrder.sendMailOrder(u.getEmail(), "Order Confirmation Notice From H2DV Petshop", latestOrder.getId(), u.getName(), address.getCity(), address.getDistrict(), address.getDetail(), payment_method, cartDetailList, total_cost, check);
                
                // decrease the quantity in warehouse
                for (Cart c : cartDetailList) {
                    Product p = productdao.getProductById(c.getProductId());
                    productdao.updateQuantity(p.getId(), p.getQuantity() - c.getQuantity());
                }

                // delete all the product in the cart
                cartdao.deleteAllItemOfUser(u.getId());

                request.setAttribute("payment_method", payment_method);
                request.setAttribute("orderID", latestOrder.getId());
                request.setAttribute("cartDetailList", cartDetailList);
                request.setAttribute("total_cost", total_cost);
                request.setAttribute("address", address);
                request.getRequestDispatcher("Completion.jsp").forward(request, response);
            } else {
                response.sendRedirect("home");
            }
        } catch (SQLException ex) {
            Logger.getLogger(CompletionServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private static String getCurrentDate() {
        LocalDateTime currentDateTime = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        return currentDateTime.format(formatter);
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
