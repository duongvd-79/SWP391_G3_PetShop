/*
 */
package controller;

import dal.FeedbackDAO;
import dal.ProductDAO;
import dal.SliderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import model.Product;
import model.ProductFeedback;
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

        // Get attributes
        String categoryRaw = request.getParameter("category");
        String minPriceRaw = null;
        String maxPriceRaw = null;
        String priceOption = request.getParameter("priceOption");
        if (priceOption != null && !priceOption.equals("")) {
            switch (priceOption) {
                case "price1" -> {
                    minPriceRaw = "0";
                    maxPriceRaw = "100000";
                }
                case "price2" -> {
                    minPriceRaw = "100000";
                    maxPriceRaw = "350000";
                }
                case "price3" -> {
                    minPriceRaw = "350000";
                    maxPriceRaw = "600000";
                }
                case "price4" -> {
                    minPriceRaw = "600000";
                    maxPriceRaw = null;
                }
                case "customPrice" -> {
                    minPriceRaw = request.getParameter("minPrice");
                    maxPriceRaw = request.getParameter("maxPrice");
                }
                default -> {
                    minPriceRaw = null;
                    maxPriceRaw = null;
                }
            }
        }
        request.setAttribute("priceOption", priceOption);
        String search = request.getParameter("search");
        request.setAttribute("search", search);

        // Handle search by category
        String[] searchArray = new String[0];
        if (search != null) {
            search = URLDecoder.decode(search, "UTF-8");
            searchArray = search.split("Category: ");

            // Handle non-UTF-8 search string
            if (searchArray.length > 1) {
                search = searchArray[1].trim();
                request.setAttribute("search", URLEncoder.encode(search, "UTF-8"));
                request.setAttribute("searchCategory", "Category: " + search);
            } else {
                search = request.getParameter("search");
                request.setAttribute("search", URLEncoder.encode(search, "UTF-8"));
                request.setAttribute("searchCategory", search);
            }
        }
        request.setAttribute("categoryName", search);

        if (categoryRaw != null && !categoryRaw.equals("") && searchArray.length > 1) {
            int category = Integer.parseInt(categoryRaw);

            // Highlight category in next page
            request.setAttribute("category", category);
        } else if (categoryRaw != null && !categoryRaw.equals("")) {
            int category = Integer.parseInt(categoryRaw);

            // Highlight category in next page
            request.setAttribute("cateList", category);
        }

        // Display page index
        String pageIndexRaw = request.getParameter("page");
        int pageIndex = 1;
        if (pageIndexRaw != null && !pageIndexRaw.equals("")) {
            pageIndex = Integer.parseInt(pageIndexRaw);
        }
        request.setAttribute("page", pageIndex);

        // Get and remember sort type
        String sort = request.getParameter("sort");
        request.setAttribute("sort", sort);

        // Remember price range
        request.setAttribute("minPrice", minPriceRaw);
        request.setAttribute("maxPrice", maxPriceRaw);

        if (searchArray.length > 1) {
            productList = productDAO.getActive(true, null,
                    minPriceRaw, maxPriceRaw, search, sort, pageIndex);
        } else {
            productList = productDAO.getActive(true, categoryRaw,
                    minPriceRaw, maxPriceRaw, search, sort, pageIndex);
        }
        request.setAttribute("allproduct", productList);
        int resultSize = productList.size();
        request.setAttribute("resultSize", resultSize);

        // Product date
        Date today = new Date();
        Calendar cal = Calendar.getInstance();
        cal.setTime(today);
        cal.add(Calendar.MONTH, -1);
        Date oneMonthAgo = cal.getTime();
        request.setAttribute("oneMonthAgo", oneMonthAgo);

        // Get latest product
        allProduct = productDAO.getActive(false, null, null, null, null, "Latest", 0);
        request.setAttribute("latestproduct", allProduct);

        // Get star rating
        FeedbackDAO feedbackDAO = new FeedbackDAO();
        List<ProductFeedback> feedbackList;
        try {
            List<Integer> starList = new ArrayList<>();
            for (Product p : productList) {
                int sum = 0;
                feedbackList = feedbackDAO.getFeedbackByProductID(p.getId());
                for (ProductFeedback pf : feedbackList) {
                    sum += pf.getStar();
                }
                int star = (int) Math.round((double) sum / feedbackList.size());
                starList.add(star);
            }
            request.setAttribute("starList", starList);
        } catch (SQLException e) {
        }

        // Pagination
        int totalProduct;
        // Get total product
        allProduct = productDAO.getActive(false, categoryRaw,
                minPriceRaw, maxPriceRaw, search, sort, 0);
        totalProduct = allProduct.size();
        int maxPage = totalProduct / 12;
        if (totalProduct % 12 != 0) {
            maxPage++;
        }
        request.setAttribute("totalPage", maxPage);

        // For all product in search popup
        allProduct = productDAO.getActive(false, categoryRaw,
                minPriceRaw, maxPriceRaw, search, sort, 0);
        request.setAttribute("allSearchList", allProduct);

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
