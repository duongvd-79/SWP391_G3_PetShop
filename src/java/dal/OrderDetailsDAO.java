/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.OrderDetails;

/**
 *
 * @author ACER
 */
public class OrderDetailsDAO extends DBContext {

    PreparedStatement stm;
    ResultSet rs;

    private static OrderDetails setOrderDetails(ResultSet rs) {
        OrderDetails orderDetails = new OrderDetails();
        try {
            orderDetails.setOrderId(rs.getInt("order_id"));
            orderDetails.setProductId(rs.getInt("product_id"));
            orderDetails.setQuantity(rs.getInt("quantity"));
            orderDetails.setImportPrice(rs.getDouble("import_price"));
            orderDetails.setSellPrice(rs.getDouble("sell_price"));
        } catch (SQLException e) {
        }
        return orderDetails;
    }

    public List<OrderDetails> getAll() {
        String sql = "SELECT * FROM `order`";
        try {
            List<OrderDetails> orderList = new ArrayList<>();
            stm = connection.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                OrderDetails p = setOrderDetails(rs);
                orderList.add(p);
            }
            return orderList;
        } catch (SQLException e) {
        }
        return null;
    }

    public double getRevenue() {
        try {
            String sql = "SELECT SUM(sell_price * quantity) AS totalRevenue FROM order_details";
            stm = connection.prepareStatement(sql);
            rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getDouble("totalRevenue");
            }
        } catch (SQLException ex) {
        }
        return 0;
    }

    // Method to calculate profit
    public double getProfit() {
        String sql = "SELECT SUM((sell_price - import_price) * quantity) AS totalProfit FROM order_details";
        try {
            stm = connection.prepareStatement(sql);
            rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getDouble("totalProfit");
            }
        } catch (SQLException e) {
        }
        return 0; // Return 0 if there's an error or no profit found
    }

    public double getRevenue(String start, String end) {
        String sql = "SELECT SUM(sell_price * quantity) AS totalRevenue FROM order_details as od "
                + "JOIN `order` as o ON o.id = od.order_id WHERE ordered_date between '" + start + "' and '" + end + "'";
        try {
            stm = connection.prepareStatement(sql);
            rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getDouble("totalRevenue");
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Handle or log the exception
        }
        return 0; // Return 0 if there's an error or no revenue found
    }

    // Method to calculate revenue in a specific month of a year
    public double getMonthlyRevenue(int month, String year) {
        String sql = "SELECT SUM(sell_price * quantity) AS totalRevenue FROM order_details as od"
                + " JOIN `order` as o ON o.id = od.order_id where MONTH(ordered_date) = ? and YEAR(ordered_date)=?";
        try {
            stm = connection.prepareStatement(sql);
            stm.setInt(1, month);
            stm.setString(2, year);
            rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getDouble("totalRevenue");
            }
        } catch (SQLException e) {
        }
        return 0; // Return 0 if there's an error or no revenue found
    }

    // Method to calculate profit in a specific month of a year
    public double getMonthlyProfit(int month, String year) {
        String sql = "SELECT SUM((sell_price - import_price) * quantity) AS totalProfit"
                + " FROM order_details as od JOIN `order` as o ON o.id = od.order_id"
                +" where MONTH(ordered_date) = ? and YEAR(ordered_date)=?";
        try {
            stm = connection.prepareStatement(sql);
            stm.setInt(1, month);
            stm.setString(2, year);
            rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getDouble("totalProfit");
            }

        } catch (SQLException e) {
            e.printStackTrace(); // Handle or log the exception
        }
        return 0; // Return 0 if there's an error or no profit found
    }

    public static void main(String[] args) {
        OrderDetailsDAO oDAO = new OrderDetailsDAO();
        System.out.println(oDAO.getMonthlyProfit(6, "2024"));

    }
}
