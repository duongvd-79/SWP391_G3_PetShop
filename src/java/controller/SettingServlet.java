/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.SettingDAO;
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
public class SettingServlet extends HttpServlet {

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
            out.println("<title>Servlet SettingServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SettingServlet at " + request.getContextPath() + "</h1>");
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
        SettingDAO sDAO = new SettingDAO();

        String sort = request.getParameter("sort");
        request.setAttribute("sort", sort);
        
        sDAO = new SettingDAO();

        //active hoặc inactive
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String stat = request.getParameter("status");
            if(stat!=null && stat.equals("Active"))
                sDAO.active(id);
            else
                sDAO.inactive(id);
        } catch (NumberFormatException e) {
        }
        
        //Lấy danh sách setting

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
        String type = request.getParameter("type");
        String status = request.getParameter("status");
        String sName = request.getParameter("search");
        //Nếu có search
        if (sName != null) {
            request.setAttribute("sName", sName);
            sList = sDAO.getAllByName(sName);
        }

        //Lọc theo type
        if (action != null && type != null && !type.isEmpty() && action.equals("filter")) {

            request.setAttribute("type", type);
            sList = sDAO.getAllByType(sList, type);
        }
        //Lọc theo status
        if (action != null && status != null && !status.isEmpty() && action.equals("filter")) {

            request.setAttribute("status", status);
            sList = sDAO.getAllByStatus(sList, status);
        }

        //Update setting
        if (action != null && action.equals("update")) {
            int id = Integer.parseInt(request.getParameter("id"));
            String typeName = request.getParameter("type");
            int typeId = sDAO.getTypeId(typeName);
            int order = Integer.parseInt(request.getParameter("order"));
            String name = request.getParameter("name");
//          String stt = request.getParameter("status");
            String desciption = request.getParameter("note");
            Setting changeSetting = new Setting(id, typeId, order, name, status, desciption);
                sDAO.updateSetting(id, changeSetting);
            
            sList = sDAO.getAll();
        }
        //Phân trang
        int page = 0;
        try {
            page = Integer.parseInt(request.getParameter("page"));
        } catch (NumberFormatException e) {
            page = 1;
        }
        int pageNum = 0;
        if (sList.size() % 3 == 0) {
            pageNum = sList.size() / 3;
        } else {
            pageNum = sList.size() / 3 + 1;
        }
        request.setAttribute("pageNum", pageNum);
        request.setAttribute("page", page);
        sList = sDAO.getByPage(sList, page);

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
