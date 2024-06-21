/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.OrderDAO;
import dal.OrderDetailsDAO;
import dal.SettingDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import model.Setting;

/**
 *
 * @author Acer
 */
public class SaleDashboardServlet extends HttpServlet {

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
            out.println("<title>Servlet SaleDashboardServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SaleDashboardServlet at " + request.getContextPath() + "</h1>");
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
        int a = 0;
        if (a == 0) {
            OrderDAO oDAO = new OrderDAO();
            OrderDetailsDAO odDAO = new OrderDetailsDAO();
            SettingDAO sDAO = new SettingDAO();

            int numOfOrders;
            double revenues;
            int month = getCurrentMonth();
            List<Integer> orderList = new ArrayList<>();
            List<Double> monthlyRevenueList = new ArrayList<>();
            List<Double> monthlyProfitList = new ArrayList<>();
            numOfOrders = oDAO.getCountOrder(getDateXBefore(7), getCurrentDate());
            revenues = odDAO.getRevenue(getDateXBefore(7), getCurrentDate());
            orderList.add(oDAO.countOrderByStatus("success", getDateXBefore(7), getCurrentDate()));
            orderList.add(oDAO.countOrderByStatus("submitted", getDateXBefore(7), getCurrentDate()));
            orderList.add(oDAO.countOrderByStatus("cancelled", getDateXBefore(7), getCurrentDate()));

            List<Setting> pCategoryList = new ArrayList<>();
            List<String> dayReport = new ArrayList<>();
            //lấy dữ liệu biểu đồ bảng thu nhập
            for (int i = 7; i >= 1; i--) {
                int day = getCurrentDay() - i;
                monthlyRevenueList.add(odDAO.getDailyRevenue(day, month));
                monthlyProfitList.add(odDAO.getDailyProfit(day, month));
                String date = day+"";
                dayReport.add(date);
            }
            //dữ liệu cho bảng customer
            pCategoryList = sDAO.getAllProductCategory();
            //filter
            request.setAttribute("pCategoryList", pCategoryList);
            //số liệu tổng quan
            request.setAttribute("numOfOrders", numOfOrders);
            request.setAttribute("revenues", revenues);
            //dữ liệu cho biểu đồ
            request.setAttribute("orderList", orderList);
            request.setAttribute("monthlyRevenueList", monthlyRevenueList);
            request.setAttribute("monthlyProfitList", monthlyProfitList);
            request.setAttribute("dayReport", dayReport);

            request.getRequestDispatcher("SaleDashboard.jsp").forward(request, response);
        } else {
            response.sendRedirect("404.html");
        }
        
    }
    private static int getCurrentMonth() {
        LocalDate currentDate = LocalDate.now();
        return currentDate.getMonthValue();
    }
    
    private static int getCurrentDay() {
        LocalDate currentDate = LocalDate.now();
        return currentDate.getDayOfMonth();
    }

    private static String getCurrentDate() {
        LocalDate currentDate = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String formattedDate = currentDate.format(formatter);
        return formattedDate;
    }

    private static String getDateXBefore(int x) {
        LocalDate date = LocalDate.now().minusDays(x);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String formattedDate = date.format(formatter);
        return formattedDate;
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
