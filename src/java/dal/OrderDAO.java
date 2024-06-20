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
import model.Order;

/**
 *
 * @author ACER
 */
public class OrderDAO extends DBContext {

    PreparedStatement stm;
    ResultSet rs;

    private static Order setOrder(ResultSet rs) {
        Order o = new Order();
        try {
            o.setId(rs.getInt("id"));
            o.setCustomerId(rs.getInt("customer_id"));
            o.setOrderedDate(rs.getDate("ordered_date"));
            o.setStatus(rs.getString("status"));
            o.setIsDelivered(rs.getBoolean("is_delivered"));
            o.setDeliveredDate(rs.getDate("delivered_date"));
            o.setTotal(rs.getDouble("total"));
        } catch (SQLException e) {
        }
        return o;
    }

    public List<Order> getAll(String status, int userId, int page, int num) {
        String sql = "SELECT * FROM `order` where status=? and customer_id=? "
                + "order by ordered_date desc limit ?,?";
        try {
            List<Order> orderList = new ArrayList<>();
            stm = connection.prepareStatement(sql);
            stm.setString(1, status);
            stm.setInt(2, userId);
            stm.setInt(3, (page - 1) * num);
            stm.setInt(4, num);
            rs = stm.executeQuery();
            while (rs.next()) {
                Order p = setOrder(rs);
                orderList.add(p);
            }
            return orderList;
        } catch (SQLException e) {
        }
        return null;
    }

    public int countOrderByStatus(String status) {
        String sql = "SELECT COUNT(*) as count FROM `order` where status=?";
        try {
            List<Order> orderList = new ArrayList<>();
            stm = connection.prepareStatement(sql);
            stm.setString(1, status);
            rs = stm.executeQuery();
            while (rs.next()) {
                return rs.getInt("count");
            }
        } catch (SQLException e) {
        }
        return 0;
    }

    public int countOrderByStatus(String status, String start, String end) {
        String sql = "SELECT COUNT(*) as count FROM `order` where status=? and ordered_date between '" + start + "' and '" + end + "'";
        try {
            List<Order> orderList = new ArrayList<>();
            stm = connection.prepareStatement(sql);
            stm.setString(1, status);
            rs = stm.executeQuery();
            while (rs.next()) {
                return rs.getInt("count");
            }
        } catch (SQLException e) {
        }
        return 0;
    }

    //count all order
    public int getCountOrder() {
        String sql = "SELECT COUNT(*) as count FROM `order`";
        try {
            stm = connection.prepareStatement(sql);
            rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt("count");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    //count order base on an interval of time
    public int getCountOrder(String start, String end) {
        String sql = "SELECT COUNT(*) as count FROM `order` where ordered_date between '" + start + "' and '" + end + "'";
        try {
            stm = connection.prepareStatement(sql);
            rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt("count");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    //count product for each order
    public List<Integer> getRemainNumOfProductEachOrder(String status, int uid, int page, int num) {
        List<Integer> list = new ArrayList<>();
        String sql = "SELECT COUNT(product_id) AS count\n"
                + "FROM order_details as od join `order` as o on o.id= od.order_id \n"
                + "WHERE o.customer_id = ? and o.status =?\n"
                + "GROUP BY order_id order by ordered_date desc limit ?,?";
        try {
            stm = connection.prepareStatement(sql);
            stm.setInt(1, uid);
            stm.setString(2, status);
            stm.setInt(3, (page - 1) * num);
            stm.setInt(4, num);
            rs = stm.executeQuery();
            while (rs.next()) {
                list.add(rs.getInt("count") - 1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public static void main(String[] args) {
        OrderDAO oDAO = new OrderDAO();
        for (Order o : oDAO.getAll("submitted", 6, 0, 4)) {
            System.out.println(o.getId());
        }
    }
}
