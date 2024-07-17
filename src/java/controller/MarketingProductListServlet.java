/*
 */
package controller;

import dal.ProductDAO;
import dal.SettingDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Product;
import model.Setting;
import model.User;

/**
 *
 * @author duongvu
 */
@MultipartConfig
public class MarketingProductListServlet extends HttpServlet {

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
            out.println("<title>Servlet MarketingProductListServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet MarketingProductListServlet at " + request.getContextPath() + "</h1>");
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
                List<Product> productList;

                // Display page index
                String pageIndexRaw = request.getParameter("page");
                int pageIndex = 1;
                if (pageIndexRaw != null && !pageIndexRaw.equals("")) {
                    pageIndex = Integer.parseInt(pageIndexRaw);
                }
                request.setAttribute("page", pageIndex);

                // Get param
                String search = request.getParameter("search");
                String category = request.getParameter("category");
                String status = request.getParameter("status");
                String featured = request.getParameter("featured");
                String sort = request.getParameter("sort");

                // Non unicode handle
                if (category != null && !category.isEmpty()) {
                    category = URLDecoder.decode(category, "UTF-8");
                    request.setAttribute("categorySelect", category);
                    request.setAttribute("category", URLEncoder.encode(category, "UTF-8"));
                }
                request.setAttribute("search", search);
                request.setAttribute("status", status);
                request.setAttribute("featured", featured);
                request.setAttribute("sort", sort);

                // Feature and hide/show product
                String idRaw = request.getParameter("id");
                String pstatus = request.getParameter("pstatus");
                String pfeatured = request.getParameter("pfeatured");

                if (idRaw != null && !idRaw.isEmpty()) {
                    int id = Integer.parseInt(idRaw);
                    if (pfeatured != null && !pfeatured.isEmpty()) {
                        if (pfeatured.equals("Is Featured")) {
                            pdao.unfeatureProduct(id);
                        } else {
                            pdao.featureProduct(id);
                        }
                    }
                    if (pstatus != null && !pstatus.isEmpty()) {
                        if (!pstatus.equals("Hidden")) {
                            pdao.hideProduct(id);
                        } else {
                            pdao.showProduct(id);
                        }
                    }
                }

                // Get product
                productList = pdao.getAllPaginated(pageIndex, 5, search, category, status, featured, sort);
                request.setAttribute("productList", productList);
                int size = productList.size();
                request.setAttribute("size", size);

                // Set temp category name map for product
                SettingDAO sdao = new SettingDAO();
                Map<Integer, String> cateMap = new HashMap<>();
                for (Setting s : sdao.getAllProductCategory()) {
                    cateMap.put(s.getId(), s.getName());
                }
                request.setAttribute("cateMap", cateMap);

                // Pagination
                int totalProduct;
                // Get total product
                totalProduct = pdao.getAllPaginated(1, pdao.getAll().size(), search, category, status, featured, null).size();
                int maxPage = totalProduct / 5;
                if (totalProduct % 5 != 0) {
                    maxPage++;
                }
                request.setAttribute("totalPage", maxPage);
                request.setAttribute("allSearchList", pdao.getAll());

                request.getRequestDispatcher("marketingProductList.jsp").forward(request, response);
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

        // Get part
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
        String thumbURL = getValueFromPart(thumbURLPart);
        String title = getValueFromPart(titlepPart);
        String description = getValueFromPart(descriptionPart);
        String quantityRaw = getValueFromPart(quantityPart);
        String status = getValueFromPart(statusPart);
        String importPriceRaw = getValueFromPart(importPricePart);
        String listPriceRaw = getValueFromPart(listPricePart);
        String featured = getValueFromPart(featuredPart);
        String categoryRaw = getValueFromPart(categoryPart);

        Product newProduct = new Product();
        if (thumbURL != null && !thumbURL.trim().isEmpty()) {
            newProduct.setThumbnail(thumbURL);
        }
        if (title != null && !title.trim().isEmpty()) {
            newProduct.setTitle(title);
        }
        if (description != null && !description.isEmpty()) {
            newProduct.setDescription(description);
        }
        if (quantityRaw != null && !quantityRaw.isEmpty()) {
            int quantity = Integer.parseInt(quantityRaw);
            newProduct.setQuantity(quantity);
        }
        if (status != null && !status.trim().isEmpty()) {
            newProduct.setStatus(status);
        }
        if (importPriceRaw != null && !importPriceRaw.isEmpty()) {
            double importPrice = Double.parseDouble(importPriceRaw);
            newProduct.setImportPrice(importPrice);
        }
        if (listPriceRaw != null && listPriceRaw.isEmpty()) {
            double listPrice = Double.parseDouble(listPriceRaw);
            newProduct.setListPrice(listPrice);
        }
        if (featured != null && !featured.isEmpty()) {
            newProduct.setIsFeatured(featured.equals("Is Featured"));
        }
        if (categoryRaw != null && !categoryRaw.isEmpty()) {
            int category = Integer.parseInt(categoryRaw);
            newProduct.setCategoryId(category);
        }

        // Create path components to save the file
        String uploadPath = getServletContext().getRealPath("/") + "images\\productthumbnail";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        // Handle file upload
        Part filePart = request.getPart("thumbnail");
        String fileName = filePart.getSubmittedFileName();
        File file = new File(uploadDir, fileName);

        // Save the file
        if (fileName != null && !fileName.equals("")) {
            filePart.write(file.getAbsolutePath());
            // Generate URL for the uploaded file
            String fileUrl = "images\\productthumbnail\\" + fileName;
            newProduct.setThumbnail(fileUrl);
        }

        // Add product
        ProductDAO pdao = new ProductDAO();
        if (pdao.addProduct(newProduct)) {
            session.setAttribute("noti", "Product addded successfully!");
            session.setAttribute("toastType", "success");
        } else {
            session.setAttribute("noti", "Failed to add Product!");
            session.setAttribute("toastType", "error");

            session.setAttribute("title", title);
            session.setAttribute("description", description);
            session.setAttribute("quantity", quantityRaw);
            session.setAttribute("status", status);
            session.setAttribute("importPrice", importPriceRaw);
            session.setAttribute("listPrice", listPriceRaw);
            session.setAttribute("featured", featured);
            session.setAttribute("category", categoryRaw);
        }

        response.sendRedirect("marketingproductlist#addNewProduct");
    }

    private String getValueFromPart(Part part) throws IOException {
        if (part != null) {
            StringBuilder value = new StringBuilder();
            try (BufferedReader reader = new BufferedReader(new InputStreamReader(part.getInputStream(), StandardCharsets.UTF_8))) {
                char[] buffer = new char[1024];
                int length;
                while ((length = reader.read(buffer)) > 0) {
                    value.append(buffer, 0, length);
                }
            }
            return value.toString();
        }
        return null; // or return an empty string or handle the null case accordingly
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
