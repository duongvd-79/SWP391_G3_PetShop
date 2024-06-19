/*
 */
package controller;

import dal.ProductDAO;
import dal.SettingDAO;
import dal.SliderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import model.Product;
import model.Setting;
import model.Slider;

/**
 *
 * @author duongvu
 */
public class ProductListServlet extends HttpServlet {

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
            out.println("<title>Servlet ProductListServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductListServlet at " + request.getContextPath() + "</h1>");
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
        // Get product list
        ProductDAO productDAO = new ProductDAO();
        List<Product> allProduct;
        List<Product> productList;

        // Get slider list
        SliderDAO sliderDAO = new SliderDAO();
        List<Slider> sliderList = sliderDAO.getActive();
        request.setAttribute("slider", sliderList);

        // Get product category list
        SettingDAO settingDAO = new SettingDAO();
        List<Setting> productCateList = settingDAO.getActiveByType("Product Category");
        request.setAttribute("prcategory", productCateList);

        // Get attributes
        String categoryRaw = request.getParameter("category");
        String minPriceRaw = request.getParameter("minPrice");
        String maxPriceRaw = request.getParameter("maxPrice");
        String search = request.getParameter("search");
        if (categoryRaw != null && !categoryRaw.equals("")) {
            int category = Integer.parseInt(categoryRaw);

            // Highlight category in next page
            request.setAttribute("category", category);
        }
        String pageIndexRaw = request.getParameter("page");
        int pageIndex = 1;
        if (pageIndexRaw != null && !pageIndexRaw.equals("")) {
            pageIndex = Integer.parseInt(pageIndexRaw);
        }
        request.setAttribute("page", pageIndex);
        productList = productDAO.filter(true, categoryRaw, minPriceRaw, maxPriceRaw, search, pageIndex, null);
        request.setAttribute("allproduct", productList);

        // Display searched query on searchbar
        request.setAttribute("search", search);
        request.setAttribute("minPrice", minPriceRaw);
        request.setAttribute("maxPrice", maxPriceRaw);

        // Sort
        String sort = request.getParameter("sort");
        productList = productDAO.filter(true, categoryRaw, minPriceRaw, maxPriceRaw, search, pageIndex, sort);
        request.setAttribute("allproduct", productList);
        // Remember sort type
        request.setAttribute("sort", sort);

        // Product date
        Date today = new Date();
        Calendar cal = Calendar.getInstance();
        cal.setTime(today);
        cal.add(Calendar.MONTH, -1);
        Date oneMonthAgo = cal.getTime();
        request.setAttribute("oneMonthAgo", oneMonthAgo);

        // Get latest product
        allProduct = productDAO.getActive(false, 0, "Latest");
        request.setAttribute("latestproduct", allProduct);
        
        // Pagination
        int totalProduct = allProduct.size();
        int maxPage = totalProduct / 8;
        if (totalProduct % 8 != 0) {
            maxPage++;
        }
        request.setAttribute("totalPage", maxPage);

        request.getRequestDispatcher("productlist.jsp").forward(request, response);
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