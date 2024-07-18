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
import model.Address;
import model.Order;
import model.OrderDetails;
import model.Product;
import model.User;

/**
 *
 * @author ACER
 */
public class OrderDetailsServlet extends HttpServlet {

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
            out.println("<title>Servlet OrderDetailsServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet OrderDetailsServlet at " + request.getContextPath() + "</h1>");
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
            ProductDAO pDAO = new ProductDAO();
            OrderDAO oDAO = new OrderDAO();
            OrderDetailsDAO odDAO = new OrderDetailsDAO();
            AddressDAO aDAO = new AddressDAO();
            UserDAO uDAO = new UserDAO();

            List<Product> lastestProduct = new ArrayList<>();
            List<Product> pList = new ArrayList<>();
            List<OrderDetails> odList = new ArrayList<>();
            List<Integer> fbList = new ArrayList<>();
            List<User> saleList = new ArrayList<>();
            User customer = null;
            Address address = null;
            User sale = null;
            int saleid = 0;
            int id = 0;
            try {
                id = Integer.parseInt(request.getParameter("id"));
            } catch (NumberFormatException e) {
            }
            if (request.getParameter("changesale") != null && !request.getParameter("changesale").isEmpty()) {
                saleid = Integer.parseInt(request.getParameter("changesale"));
            }
            String note = (String) request.getParameter("note");
            if (note != null && !note.isEmpty()) {
                oDAO.changeSaleNote(note, id);
            }
            String changestatus = (String) request.getParameter("changestatus");
            if (changestatus != null && !changestatus.isEmpty()) {
                oDAO.changeStatus(id, changestatus);
                if (changestatus.equals("Cancelled")) {
                    List<Product> pListUpdate = new ArrayList<>();
                    List<OrderDetails> odListUpdate = new ArrayList<>();
                    
                    pListUpdate = pDAO.getAllByOrderId(id);
                    odListUpdate = odDAO.getByOrderId(id);
                    
                    for (int i = 0; i < pListUpdate.size(); i++) {
                        pDAO.updateQuantity(pListUpdate.get(i).getId(), pListUpdate.get(i).getQuantity() + odListUpdate.get(i).getQuantity());
                    }
                }
            }
            Order order = oDAO.getOrderById(id);
            if (saleid != 0) {
                order.setSaleId(saleid);
                oDAO.changeSale(order.getId(), saleid);
            }

            try {
                customer = uDAO.getUserByID(order.getCustomerId());
                address = aDAO.getChosenAddress(order.getAddressId());
                sale = uDAO.getUserByID(order.getSaleId());
                pList = pDAO.getAllByOrderId(id);
                odList = odDAO.getByOrderId(id);
                saleList = uDAO.getUserByRoleID(3);
            } catch (SQLException ex) {
                Logger.getLogger(OrderInformationServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            lastestProduct = pDAO.getActive(false, null, null, null, null, "Latest", 0);

            request.setAttribute("order", order);
            request.setAttribute("customer", customer);
            request.setAttribute("address", address);
            request.setAttribute("sale", sale);
            request.setAttribute("saleList", saleList);
            request.setAttribute("latestproduct", lastestProduct);
            request.setAttribute("pList", pList);
            request.setAttribute("odList", odList);
            request.setAttribute("length", odList.size() - 1);
            request.getRequestDispatcher("orderdetails.jsp").forward(request, response);
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
