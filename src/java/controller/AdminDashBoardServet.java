/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.FeedbackDAO;
import dal.OrderDAO;
import dal.OrderDetailsDAO;
import dal.SettingDAO;
import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.Year;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import model.Setting;
import model.User;

/**
 *
 * @author ACER
 */
public class AdminDashBoardServet extends HttpServlet {

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
            out.println("<title>Servlet AdminDashBoardServet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminDashBoardServet at " + request.getContextPath() + "</h1>");
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
            String interval = request.getParameter("interval");
            OrderDAO oDAO = new OrderDAO();
            OrderDetailsDAO odDAO = new OrderDetailsDAO();
            FeedbackDAO fDAO = new FeedbackDAO();
            UserDAO uDAO = new UserDAO();
            SettingDAO sDAO = new SettingDAO();

            int numOfOrders = 0;
            double revenues = 0;
            int numOfFb = 0;
            int numOfCustomers = 0;
            double avgRating = 0;
            String year = request.getParameter("year");
            if (year == null) {
                year = getCurrentYear();
            }
            String pcategory = request.getParameter("pcategory");
            String start = request.getParameter("start");
            String end = request.getParameter("end");
            List<Integer> orderList = new ArrayList<>();
            List<Double> monthlyRevenueList = new ArrayList<>();
            List<Double> monthlyProfitList = new ArrayList<>();

            if (interval == null || interval.isEmpty() ) {
                // custom date range
                if (start != null) {
                    interval = start + " - " + end;
                    numOfOrders = oDAO.getCountOrder(start, end);
                    revenues = odDAO.getRevenue(start, end,pcategory);
                    numOfFb = fDAO.getCountFeedback(start, end, pcategory);
                    numOfCustomers = uDAO.getCountCustomer(start, end);
                    avgRating = fDAO.getAverageRating(start, end, pcategory);
                    orderList.add(oDAO.countOrderByStatus("success", start, end));
                    orderList.add(oDAO.countOrderByStatus("submitted", start, end));
                    orderList.add(oDAO.countOrderByStatus("cancelled", start, end));
                } else {
                    interval = "ALL TIME";
                }
            } // overview statistics for all time 
            if (interval.equals("ALL TIME")) {
                numOfOrders = oDAO.getCountOrder();
                revenues = odDAO.getRevenue(pcategory);
                numOfFb = fDAO.getCountFeedback(pcategory);
                numOfCustomers = uDAO.getCountCustomer();
                avgRating = fDAO.getAverageRating(pcategory);
                orderList.add(oDAO.countOrderByStatus("success"));
                orderList.add(oDAO.countOrderByStatus("submitted"));
                orderList.add(oDAO.countOrderByStatus("cancelled"));
            } else if (interval.equals("LAST 7 DAYS")) {//last 7 day
                numOfOrders = oDAO.getCountOrder(getDateXBefore(7), getCurrentDate());
                revenues = odDAO.getRevenue(getDateXBefore(7), getCurrentDate(),pcategory);
                numOfFb = fDAO.getCountFeedback(getDateXBefore(7), getCurrentDate(), pcategory);
                numOfCustomers = uDAO.getCountCustomer(getDateXBefore(7), getCurrentDate());
                avgRating = fDAO.getAverageRating(getDateXBefore(7), getCurrentDate(), pcategory);
                orderList.add(oDAO.countOrderByStatus("success", getDateXBefore(7), getCurrentDate()));
                orderList.add(oDAO.countOrderByStatus("submitted", getDateXBefore(7), getCurrentDate()));
                orderList.add(oDAO.countOrderByStatus("cancelled", getDateXBefore(7), getCurrentDate()));
            } else if (interval.equals("LAST 30 DAYS")) {//last 30 day
                numOfOrders = oDAO.getCountOrder(getDateXBefore(30), getCurrentDate());
                revenues = odDAO.getRevenue(getDateXBefore(30), getCurrentDate(),pcategory);
                numOfFb = fDAO.getCountFeedback(getDateXBefore(30), getCurrentDate(), pcategory);
                numOfCustomers = uDAO.getCountCustomer(getDateXBefore(30), getCurrentDate());
                avgRating = fDAO.getAverageRating(getDateXBefore(30), getCurrentDate(), pcategory);
                orderList.add(oDAO.countOrderByStatus("success", getDateXBefore(30), getCurrentDate()));
                orderList.add(oDAO.countOrderByStatus("submitted", getDateXBefore(30), getCurrentDate()));
                orderList.add(oDAO.countOrderByStatus("cancelled", getDateXBefore(30), getCurrentDate()));
            }

            //new customer, newly buy customers
            List<User> newCustomers = new ArrayList<>();
            List<User> newlyBuyCustomers = new ArrayList<>();
            List<Setting> pCategoryList = new ArrayList<>();
            try {
                //lấy dữ liệu biểu đồ bảng thu nhập
                for (int i = 1; i <= 12; i++) {
                    monthlyRevenueList.add(odDAO.getMonthlyRevenue(i, year));
                    monthlyProfitList.add(odDAO.getMonthlyProfit(i, year));
                }
                //dữ liệu cho bảng customer
                newCustomers = uDAO.getTop4NewCutomers();
                newlyBuyCustomers = uDAO.getTop4NewlyBuyCutomers();
                pCategoryList = sDAO.getAllProductCategory();
            } catch (SQLException ex) {
            }
           
            //filter
            request.setAttribute("interval", interval);
            request.setAttribute("start", start);
            request.setAttribute("end", end);
            request.setAttribute("pcategory", pcategory);
            request.setAttribute("pCategoryList", pCategoryList);
            request.setAttribute("year", year);
            request.setAttribute("curyear", getCurrentYear());
            //số liệu tổng quan
            request.setAttribute("numOfOrders", numOfOrders);
            request.setAttribute("revenues", revenues);
            request.setAttribute("numOfFb", numOfFb);
            request.setAttribute("avgRating", avgRating);
            request.setAttribute("numOfCustomers", numOfCustomers);
            //bảng customer
            request.setAttribute("newCustomers", newCustomers);
            request.setAttribute("newlyBuyCustomers", newlyBuyCustomers);
            //dữ liệu cho biểu đồ
            request.setAttribute("orderList", orderList);
            request.setAttribute("monthlyRevenueList", monthlyRevenueList);
            request.setAttribute("monthlyProfitList", monthlyProfitList);

            request.getRequestDispatcher("admindashboard.jsp").forward(request, response);
        } else {
            response.sendRedirect("404.html");
        }
    }

    private static String getCurrentYear() {
        return Year.now().toString();
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
