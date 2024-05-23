/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.settingDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Setting;

/**
 *
 * @author ACER
 */
public class AdminServlet extends HttpServlet {

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
            out.println("<title>Servlet AdminServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminServlet at " + request.getContextPath() + "</h1>");
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
        
        //Lấy danh sách setting
        settingDAO sDAO = new settingDAO();
        List<Setting> sList = sDAO.getAll();
        //Lay type setting
        List<String> types = sDAO.getAllType();
        request.setAttribute("types", types);

        String action = request.getParameter("action");
        //Điều hướng setting detaisl
        if (action != null && action.equals("edit")) {
            int id = Integer.parseInt(request.getParameter("id"));
            Setting s = sDAO.getById(id);
            request.setAttribute("detail", s);
            request.getRequestDispatcher("settingdetails.jsp").forward(request, response);
        }
         String type=request.getParameter("type");
         String status=request.getParameter("status");
         String sName = request.getParameter("search");
         //Nếu có search
        if (sName != null) {
            request.setAttribute("sName", sName);
            sList = sDAO.getAllByName(sName);
        }

        //Lọc theo type
        if (action != null && type!= null && !type.isEmpty() && action.equals("filter")) {
            
            request.setAttribute("type", type);
            sList=sDAO.getAllByType(sList, type);
        }
        //Lọc theo status
        if (action != null && status!= null && !status.isEmpty() && action.equals("filter")) {
            
            request.setAttribute("status", status);
            sList=sDAO.getAllByStatus(sList, status);
        }
                //Phân trang
        int page=0;
        try{
            page = Integer.parseInt(request.getParameter("page"));
        }catch(NumberFormatException e){
            page=1;
        }
        int pageNum = 0;
        if(sList.size()%3==0)
              pageNum=sList.size()/3;
        else pageNum=sList.size()/3+1;
        request.setAttribute("pageNum", pageNum);
        request.setAttribute("page", page);
        sList=sDAO.getByPage(sList, page);
        
        request.setAttribute("settingList", sList);
        request.getRequestDispatcher("settinglist.jsp").forward(request, response);
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
