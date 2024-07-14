/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Date;
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
            o.setAddressId(rs.getInt("address_id"));
            o.setOrderedDate(rs.getString("ordered_date"));
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

    public Order getOrderById(int id) {
        String sql = "SELECT * from `order` where id=?";
        Order p = null;
        try {
            stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            rs = stm.executeQuery();
            if (rs.next()) {
                p = setOrder(rs);
            }
        } catch (SQLException e) {
        }
        return p;
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

    public void cancelOrder(int oid) {
        String sql = "UPDATE `order` SET status = 'Cancelled' WHERE id = ?";
        try {
            PreparedStatement stm;
            stm = connection.prepareStatement(sql);
            stm.setInt(1, oid);
            stm.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public int getTotalOrderBySaleID(int saleID) {
        String sql = "SELECT COUNT(*) \n"
                + "FROM `order` \n"
                + "WHERE sale_id = ?;";
        try {
            int totalOrder = 0;
            stm = connection.prepareStatement(sql);
            stm.setInt(1, saleID);
            rs = stm.executeQuery();
            if (rs.next()) {
                totalOrder = rs.getInt(1);
            }
            return totalOrder;
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        }
    }

    public void addNewOrder(Order o) throws SQLException {
        String sql = "INSERT INTO `order` (customer_id, ordered_date, status, address_id, is_delivered, delivered_date, total, sale_id, sale_note, payment_method, is_paid)\n"
                + "VALUES (?,?,?,?,?,?,?,?,?,?,?);";
        PreparedStatement sta = connection.prepareStatement(sql);
        sta.setInt(1, o.getCustomerId());
        sta.setString(2, o.getOrderedDate());
        sta.setString(3, o.getStatus());
        sta.setInt(4, o.getAddressId());
        sta.setBoolean(5, o.isIsDelivered());
        sta.setDate(6, (Date) o.getDeliveredDate());
        sta.setDouble(7, o.getTotal());
        sta.setInt(8, o.getSaleId());
        sta.setString(9, o.getSale_note());
        sta.setString(10, o.getPayment_method());
        sta.setBoolean(11, o.isIsPaid());
        sta.executeUpdate();
    }

    public Order getLatestOrder() {
        String sql = "SELECT * FROM `order` ORDER BY ordered_date DESC LIMIT 1;";
        Order latestOrder = null;

        try (PreparedStatement stm = connection.prepareStatement(sql); ResultSet rs = stm.executeQuery()) {

            if (rs.next()) {
                int id = rs.getInt("id");
                int customerId = rs.getInt("customer_id");
                int addressId = rs.getInt("address_id");
                int saleId = rs.getInt("sale_id");
                String status = rs.getString("status");
                String saleNote = rs.getString("sale_note");
                String paymentMethod = rs.getString("payment_method");
                double total = rs.getDouble("total");
                boolean isDelivered = rs.getBoolean("is_delivered");
                boolean isPaid = rs.getBoolean("is_paid");
                String orderedDate = rs.getString("ordered_date");
                Date deliveredDate = rs.getDate("delivered_date");

                latestOrder = new Order(id, customerId, addressId, saleId, status, saleNote, paymentMethod, total, isDelivered, isPaid, orderedDate, deliveredDate);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return latestOrder;
    }

    public void addOrderDetail(int order_id, int product_id, int quantity, double import_price, double sell_price) throws SQLException {
        String sql = "insert into order_details (order_id, product_id, quantity, import_price, sell_price) VALUES (?, ?, ?, ?, ?);";
        PreparedStatement sta = connection.prepareStatement(sql);
        sta.setInt(1, order_id);
        sta.setInt(2, product_id);
        sta.setInt(3, quantity);
        sta.setDouble(4, import_price);
        sta.setDouble(5, sell_price);
        sta.executeUpdate();
    }

    public static void main(String[] args) throws SQLException {
        OrderDAO oDAO = new OrderDAO();
//        for (Order o : oDAO.getAll("submitted", 10, 0, 4)) {
//            System.out.println(o.getId());
//        }

        int total = oDAO.getTotalOrderBySaleID(2);
        Order o = oDAO.getLatestOrder();

        oDAO.addOrderDetail(100, 1, 2, 300.00, 400.00);
        System.out.println(o.getOrderedDate());
    }
}
