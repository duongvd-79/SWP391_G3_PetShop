/*
 */
package controller;

import dal.ProductDAO;
import helper.PartForm;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import model.Product;
import model.User;

/**
 *
 * @author duongvu
 */
@MultipartConfig
public class MarketingProductDetailServlet extends HttpServlet {

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
            out.println("<title>Servlet MarketingProductDetail</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet MarketingProductDetail at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession(false);
        if (session != null) {
            User user = (User) session.getAttribute("user");
            if (user != null && user.getRoleId() == 2) {
                ProductDAO pdao = new ProductDAO();

                String idRaw = request.getParameter("id");
                if (idRaw != null && !idRaw.isEmpty()) {
                    int id = Integer.parseInt(idRaw);
                    Product product = pdao.getProductById(id);
                    request.setAttribute("product", product);
                }

                request.getRequestDispatcher("marketingProductDetail.jsp").forward(request, response);
            } else {
                response.sendRedirect("404.html");
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
        HttpSession session = request.getSession(true);

        ProductDAO pdao = new ProductDAO();

        // Get part
        Part idPart = request.getPart("id");
        Part thumbURLPart = request.getPart("thumbnailURL");
        Part titlepPart = request.getPart("title");
        Part descriptionPart = request.getPart("description");
        Part quantityPart = request.getPart("quantity");
        Part statusPart = request.getPart("status");
        Part importPricePart = request.getPart("importPrice");
        Part listPricePart = request.getPart("listPrice");
        Part featuredPart = request.getPart("featured");
        Part categoryPart = request.getPart("category");

        // Convert to string
        String idRaw = PartForm.getValueFromPart(idPart);
        String thumbURL = PartForm.getValueFromPart(thumbURLPart).trim();
        String title = PartForm.getValueFromPart(titlepPart).trim();
        String description = PartForm.getValueFromPart(descriptionPart);
        String quantityRaw = PartForm.getValueFromPart(quantityPart);
        String status = PartForm.getValueFromPart(statusPart);
        String importPriceRaw = PartForm.getValueFromPart(importPricePart);
        String listPriceRaw = PartForm.getValueFromPart(listPricePart);
        String featured = PartForm.getValueFromPart(featuredPart);
        String categoryRaw = PartForm.getValueFromPart(categoryPart);

        if (idRaw != null && !idRaw.isEmpty()) {
            int id = Integer.parseInt(idRaw);
            Product product = pdao.getProductById(id);
            if (thumbURL != null && !thumbURL.isEmpty()) {
                product.setThumbnail(thumbURL);
            }
            if (title != null && !title.trim().isEmpty()) {
                product.setTitle(title);
            }
            if (description != null && !description.isEmpty()) {
                product.setDescription(description);
            }
            if (quantityRaw != null && !quantityRaw.isEmpty()) {
                int quantity = Integer.parseInt(quantityRaw);
                product.setQuantity(quantity);
            }
            if (status != null && !status.isEmpty()) {
                product.setStatus(status);
            }
            if (importPriceRaw != null && !importPriceRaw.isEmpty()) {
                double importPrice = Double.parseDouble(importPriceRaw);
                product.setImportPrice(importPrice);
            }
            if (listPriceRaw != null && !listPriceRaw.isEmpty()) {
                double listPrice = Double.parseDouble(listPriceRaw);
                product.setListPrice(listPrice);
            }
            if (featured != null && !featured.isEmpty()) {
                product.setIsFeatured(featured.equals("Is Featured"));
            }
            if (categoryRaw != null && !categoryRaw.isEmpty()) {
                int category = Integer.parseInt(categoryRaw);
                product.setCategoryId(category);
            }
            if (pdao.updateProduct(product)) {
                session.setAttribute("noti", "Product updated successfully!");
                session.setAttribute("toastType", "success");
            } else {
                session.setAttribute("noti", "Failed to update Product!");
                session.setAttribute("toastType", "error");
            }

            response.sendRedirect("marketingproductdetail?id=" + idRaw);
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
