package controller;

import dal.PostDAO;
import dal.ProductDAO;
import dal.SettingDAO;
import dal.SliderDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.List;
import model.Post;
import model.Product;
import model.Setting;
import model.Slider;

/**
 *
 * @author duongvu
 */
public class HomeServlet extends HttpServlet {

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
            out.println("<title>Servlet HomeServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HomeServlet at " + request.getContextPath() + "</h1>");
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
        List<Product> allProduct = productDAO.getActive(false, null, null, null, null, "Latest", 0);
        List<Product> featuredProduct = productDAO.getActiveFeatured();
        request.setAttribute("allproduct", allProduct);
        request.setAttribute("featuredproduct", featuredProduct);

        // Get blog list
        PostDAO postDAO = new PostDAO();
        List<Post> featuredBlog = postDAO.getFeatured();
        List<Post> latestBlog = postDAO.getLatest();
        request.setAttribute("featuredblog", featuredBlog);
        request.setAttribute("latestblog", latestBlog);

        // Get slider list
        SliderDAO sliderDAO = new SliderDAO();
        List<Slider> sliderList = sliderDAO.getActive();
        request.setAttribute("slider", sliderList);

        // Get product category list
        SettingDAO settingDAO = new SettingDAO();
        List<Setting> prCategory = settingDAO.getActiveByType("Product Category");
        request.setAttribute("prcategory", prCategory);

        request.getRequestDispatcher("home.jsp").forward(request, response);
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
