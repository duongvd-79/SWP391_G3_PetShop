/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.PostDAO;
import dal.SettingDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import model.Post;
import model.Setting;

/**
 *
 * @author Acer
 */
@MultipartConfig
public class EditBlogServlet extends HttpServlet {

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
            out.println("<title>Servlet EditBlogServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditBlogServlet at " + request.getContextPath() + "</h1>");
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
        PostDAO pDAO = new PostDAO();
        SettingDAO sDAO = new SettingDAO();
        List<Setting> sList;
        List<Post> uList;
        uList = pDAO.getAllPosts("", "","","");
        sList = sDAO.getPostCategory();
        request.setAttribute("sList", sList);
        Post u = null;
        int id = Integer.parseInt(request.getParameter("id"));
        for (Post user : uList) {
            if (user.getId() == id) {
                u = user;
            }
        }
        request.setAttribute("u", u);
        request.getRequestDispatcher("PostDetail.jsp").forward(request, response);
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
        PostDAO pDAO = new PostDAO();
        String action = request.getParameter("action");
        if (action != null && action.equals("update")) {
            int id = Integer.parseInt(request.getParameter("id"));
            String title = request.getParameter("title");
            String applicationPath = request.getServletContext().getRealPath("");
            String uploadFilePath = applicationPath + File.separator + "images";
            File uploadDir = new File(uploadFilePath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            String fileName = "";
            try {
                Part part = request.getPart("file");
                if (part != null) {
                    fileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                    part.write(uploadFilePath + File.separator + fileName);
                }
            } catch (Exception e) {
            }
            String detail = request.getParameter("detail");
            String status = request.getParameter("status");
            String category = request.getParameter("category");
            pDAO.updateBlog(id, title, fileName, detail, status, category);
            response.sendRedirect("BlogManager");
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
