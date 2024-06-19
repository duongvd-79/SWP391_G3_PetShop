/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.FeedbackDAO;
import dal.ProductDAO;
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
import model.Product;
import model.ProductFeedback;
import model.User;

/**
 *
 * @author Admin
 */
public class ProductDetailServlet extends HttpServlet {

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
            out.println("<title>Servlet ProductDetailServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductDetailServlet at " + request.getContextPath() + "</h1>");
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
        ProductDAO productDAO = new ProductDAO();
        FeedbackDAO feedbackDAO = new FeedbackDAO();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        String idRaw = request.getParameter("id");
        try {
            int id = Integer.parseInt(idRaw);
            Product p = productDAO.getProductById(id);

            ArrayList<ProductFeedback> feedbackList = feedbackDAO.getNewFeedback(id);
            ArrayList<ProductFeedback> flist = feedbackDAO.getFeedbackByProductID(id);
            int sum = 0;
            for (ProductFeedback pf : flist) {
                sum += pf.getStar();
            }
            int star = (int) Math.round((double) sum / flist.size());
            
            // to pick out the image of each customer in feedback
            ArrayList<ProductFeedback> topList = feedbackDAO.getFeedbackByProductIDTop3(id);
            ArrayList<ArrayList> imageList = new ArrayList<>();
            for (ProductFeedback pf : topList) {
                ArrayList<ProductFeedback> sampleList = feedbackDAO.getFeedbackImage(pf.getId());
                imageList.add(sampleList);
            }

            List<Product> productList = productDAO.getRelatedProduct(id);
            request.setAttribute("feedbackList", feedbackList);
            request.setAttribute("product", p);
            request.setAttribute("star", star);
            request.setAttribute("reviewTotal", flist.size());
            request.setAttribute("relatedlist", productList);
            request.setAttribute("imageList", imageList);
            request.getRequestDispatcher("ProductDetail.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ProductDetailServlet.class.getName()).log(Level.SEVERE, null, ex);
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
