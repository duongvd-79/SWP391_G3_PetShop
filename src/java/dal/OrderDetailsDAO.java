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

    public double getRevenue(String pcategory) {
        try {
            String sql = "SELECT SUM(od.sell_price * od.quantity) AS totalRevenue FROM order_details as od "
                    + "JOIN product AS p ON p.id = od.product_id join `order` as o on o.id = od.order_id where o.status='success'";
            if (pcategory != null && !pcategory.isEmpty()) {
                sql += " and p.category_id = '" + pcategory + "'";
            }
            stm = connection.prepareStatement(sql);
            rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getDouble("totalRevenue");
            }
        } catch (SQLException ex) {
        }
        return 0;
    }

    public double getProfit() {
        String sql = "SELECT SUM((sell_price - import_price) * quantity) AS totalProfit FROM order_details as od join `oder` as o on o.id = od.order_id where o.status='success'";
        try {
            stm = connection.prepareStatement(sql);
            rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getDouble("totalProfit");
            }
        } catch (SQLException e) {
        }
        return 0;
    }

    public double getRevenue(String start, String end, String pcategory) {
        String sql = "SELECT SUM(od.sell_price * od.quantity) AS totalRevenue FROM order_details as od "
                + "JOIN `order` as o ON o.id = od.order_id JOIN product AS p ON p.id = od.product_id "
                + "WHERE o.status='success' and ordered_date between '" + start + "' and '" + end + " 23:59'";
        if (pcategory != null && !pcategory.isEmpty()) {
            sql += "and p.category_id = '" + pcategory + "'";
        }
        try {
            stm = connection.prepareStatement(sql);
            rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getDouble("totalRevenue");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    public double getRevenue(String start, String end) {
        String sql = "SELECT SUM(od.sell_price * od.quantity) AS totalRevenue FROM order_details as od "
                + "JOIN `order` as o ON o.id = od.order_id JOIN product AS p ON p.id = od.product_id "
                + "WHERE ordered_date between '" + start + "' and '" + end + " 23:59'";
        try {
            stm = connection.prepareStatement(sql);
            rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getDouble("totalRevenue");
            }
        } catch (SQLException e) {
            e.printStackTrace(); 
        }
        return 0; 
    }

    // Method to calculate revenue in a specific month of a year
    public double getMonthlyRevenue(int month, String year) {
        String sql = "SELECT SUM(sell_price * quantity) AS totalRevenue FROM order_details as od"
                + " JOIN `order` as o ON o.id = od.order_id where o.status='success' and MONTH(ordered_date) = ? and YEAR(ordered_date)=?";
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
        return 0;
    }

    // Method to calculate profit in a specific month of a year
    public double getMonthlyProfit(int month, String year) {
        String sql = "SELECT SUM((sell_price - import_price) * quantity) AS totalProfit"
                + " FROM order_details as od JOIN `order` as o ON o.id = od.order_id"
                + " where o.status='success' and MONTH(ordered_date) = ? and YEAR(ordered_date)=?";
        try {
            stm = connection.prepareStatement(sql);
            stm.setInt(1, month);
            stm.setString(2, year);
            rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getDouble("totalProfit");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
        // Method to calculate revenue in a specific month of a year
    public double getDailyRevenue(int day, int month) {
        String sql = "SELECT SUM(sell_price * quantity) AS totalRevenue FROM order_details as od"
                + " JOIN `order` as o ON o.id = od.order_id where MONTH(ordered_date) = ? and DAY(ordered_date)=?";
        try {
            stm = connection.prepareStatement(sql);
            stm.setInt(1, month);
            stm.setInt(2, day);
            rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getDouble("totalRevenue");
            }
        } catch (SQLException e) {
        }
        return 0; 
    }

    // Method to calculate profit in a specific month of a year
    public double getDailyProfit(int day, int month) {
        String sql = "SELECT SUM((sell_price - import_price) * quantity) AS totalProfit"
                + " FROM order_details as od JOIN `order` as o ON o.id = od.order_id"
                +" where MONTH(ordered_date) = ? and DAY(ordered_date)=?";
        try {
            stm = connection.prepareStatement(sql);
            stm.setInt(1, month);
            stm.setInt(2, day);
            rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getDouble("totalProfit");
            }

        } catch (SQLException e) {
            e.printStackTrace(); 
        }
        return 0; 
    }

    // get product quantity
    public int getQuantity(int pid, int oid) {
        String sql = "SELECT quantity from order_details where product_id = ? and order_id = ?";
        try {
            stm = connection.prepareStatement(sql);
            stm.setInt(1, pid);
            stm.setInt(2, oid);
            rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt("quantity");
            }
        } catch (SQLException e) {
        }
        return 0;
    }
    
    public List<OrderDetails> getByOrderId(int oid){
        String sql = "SELECT * FROM order_details where order_id=?";
        try {
            List<OrderDetails> orderList = new ArrayList<>();
            stm = connection.prepareStatement(sql);
            stm.setInt(1,oid);
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

    public static void main(String[] args) {
        OrderDetailsDAO oDAO = new OrderDetailsDAO();
//        System.out.println(oDAO.getRevenue("2024-05-21","2024-06-20",null));
//        System.out.println("hehe");
        for(OrderDetails od: oDAO.getByOrderId(1)){
            System.out.println(od.getProductId());
        }
    }
}