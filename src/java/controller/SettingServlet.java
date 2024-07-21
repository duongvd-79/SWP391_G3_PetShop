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
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import model.Setting;
import model.User;

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
        HttpSession session = request.getSession();
        if (session.getAttribute("user") != null && ((User) session.getAttribute("user")).getRoleId() == 1) {
            //Lấy danh sách setting
            SettingDAO sDAO = new SettingDAO();
            String sort = request.getParameter("sort");
            request.setAttribute("sort", sort);

            sDAO = new SettingDAO();

            //active hoặc inactive
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                String stat = request.getParameter("cstatus");
                if (stat != null && stat.equals("Active")) {
                    sDAO.active(id);
                } else if (stat != null && (stat.equals("Inactive") || stat.equals("Pending"))) {
                    sDAO.inactive(id);
                }
            } catch (NumberFormatException e) {
            }

            //Lấy danh sách setting
            List<Setting> sList = sDAO.getAll();

            //Lay type setting
            List<String> types = sDAO.getAllType();
            request.setAttribute("types", types);

            String action = request.getParameter("action");
            //Điều hướng setting detail
            if (action != null && action.equals("edit")) {
                int id = Integer.parseInt(request.getParameter("id"));
                Setting s = sDAO.getById(id);
                request.setAttribute("detail", s);
                session.setAttribute("detail", s);
                session.setAttribute("types", types);
                response.sendRedirect("settingdetails.jsp");
            }
            else{
            String type = request.getParameter("type");
            String status = request.getParameter("status");
            String sName = request.getParameter("search");
            //Nếu có search
            if (sName != null) {
                request.setAttribute("sName", sName);
                sList = sDAO.getAllByName(sName.trim());
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

            

            //sort 
            if (sort != null && sort.equals("type")) {
                Collections.sort(sList, (o1, o2) -> Integer.compare(o1.getTypeId(), o2.getTypeId()));
            } else if (sort != null && sort.equals("order")) {
                Collections.sort(sList, (o1, o2) -> Integer.compare(o1.getOrder(), o2.getOrder()));
            } else if (sort != null && sort.equals("status")) {
                Collections.sort(sList, (o1, o2) -> o1.getStatus().compareTo(o2.getStatus()));
            }
            //Phân trang
            int page = 0;
            int rows = 4;
            try {
                page = Integer.parseInt(request.getParameter("page"));
            } catch (NumberFormatException e) {
                page = 1;
            }
            int pageNum = 0;
            if (sList.size() % rows == 0) {
                pageNum = sList.size() / rows;
            } else {
                pageNum = sList.size() / rows + 1;
            }
            request.setAttribute("pageNum", pageNum);
            request.setAttribute("page", page);
            sList = getByPage(sList, page, rows);

            request.setAttribute("settingList", sList);
            request.getRequestDispatcher("settinglist.jsp").forward(request, response);
            }
        }
        else {
            response.sendRedirect("404.html");
        }
    }
        //Lấy theo phân trang
    public static List<Setting> getByPage(List<Setting> list, int page, int rows) {
        List<Setting> outputlist = new ArrayList<>();
        for (int i = (page - 1) * rows; i <= (page - 1) * rows + rows - 1; i++) {
            if (i >= list.size()) {
                return outputlist;
            }
            outputlist.add(list.get(i));
        }
        return outputlist;
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
            HttpSession session = request.getSession();
            SettingDAO sDAO = new SettingDAO();
            String action = request.getParameter("action");
            String type = request.getParameter("type");
            String status = request.getParameter("status");
            
            //Lấy danh sách setting
            List<Setting> sList = sDAO.getAll();

            //Update setting
            if (action != null && action.equals("update")) {
                int id = Integer.parseInt(request.getParameter("id"));
                String typeName = request.getParameter("type");
                int typeId = sDAO.getTypeId(typeName);
                int order = Integer.parseInt(request.getParameter("order"));
                String name = request.getParameter("name");
                String description = request.getParameter("note");
                Setting changeSetting = new Setting(id, typeId, type, order, name, status, description);
                sDAO.updateSetting(id, changeSetting);
                String Noti = "Change saved!";
                    session.setAttribute("noti", Noti);
                    session.setAttribute("toastType", "success");
                sList = sDAO.getAll();
            }

            //Add setting
            if (action != null && action.equals("add")) {
                String typeName = request.getParameter("type");
                int typeId = sDAO.getTypeId(typeName);
                int order = Integer.parseInt(request.getParameter("order"));
                String name = request.getParameter("name");
                String desciption = request.getParameter("note");
                sDAO.addNew(typeId, order, name, status, desciption);
                String Noti = "New setting added!";
                    session.setAttribute("noti", Noti);
                    session.setAttribute("toastType", "success");
                sList = sDAO.getAll();
            }
            
            response.sendRedirect("setting");
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
