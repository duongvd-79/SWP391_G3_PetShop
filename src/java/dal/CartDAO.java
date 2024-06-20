/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

/**
 *
 * @author Admin
 */
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.Cart;

public class CartDAO extends DBContext {

    public void AddToCart(int pid, int uid, int quan) throws SQLException {
        String sql = "INSERT INTO cart (user_id, product_id, quantity) VALUES (?,?,?);";
        try (PreparedStatement sta = connection.prepareStatement(sql)) {
            sta.setInt(1, uid);
            sta.setInt(2, pid);
            sta.setInt(3, quan);
            sta.executeUpdate();
        }
    }

    public ArrayList<Cart> getAllItemInCart(int userid) throws SQLException {
        String sql = "select * from cart where user_id = ?;";
        PreparedStatement sta = connection.prepareStatement(sql);
        sta.setInt(1, userid);
        ResultSet rs = sta.executeQuery();
        ArrayList<Cart> lst = new ArrayList<>();
        while (rs.next()) {
            int id = rs.getInt("id");
            int pid = rs.getInt("product_id");
            int uid = rs.getInt("user_id");
            int quantity = rs.getInt("quantity");
            Cart c = new Cart(id, pid, quantity, uid);
            lst.add(c);
        }
        return lst;
    }

    public void updateItemInCart(int quan, int id) throws SQLException {
        String sql = "UPDATE cart SET  quantity = ? WHERE id = ?";
        try (PreparedStatement sta = connection.prepareStatement(sql)) {
            sta.setInt(1, quan);
            sta.setInt(2, id);
            sta.executeUpdate();
        }
    }

    public ArrayList<Cart> getCartDetail(int uid) throws SQLException {
        String sql = "select c.id, c.product_id, p.title, p.thumbnail, p.list_price, c.quantity from cart c join product p on c.product_id = p.id  where c.user_id = ?";
        PreparedStatement sta = connection.prepareStatement(sql);
        sta.setInt(1, uid);
        ResultSet rs = sta.executeQuery();
        ArrayList<Cart> lst = new ArrayList<>();
        while (rs.next()) {
            int id = rs.getInt("id");
            int pid = rs.getInt("product_id");
            String title = rs.getString("title");
            String thumbnail = rs.getString("thumbnail");
            double list_price = rs.getDouble("list_price");
            int quantity = rs.getInt("quantity");
            Cart c = new Cart(id, pid, quantity, thumbnail, title, list_price);
            lst.add(c);
        }
        return lst;
    }

    public void deleteCartItem(int id) throws SQLException {
        String sql = "DELETE FROM cart WHERE id = ?";
        try (PreparedStatement sta = connection.prepareStatement(sql)) {
            sta.setInt(1, id);
            sta.executeUpdate();
        }
    }

    public static void main(String[] args) throws SQLException {
        CartDAO cartdao = new CartDAO();
        ArrayList<Cart> cartList = cartdao.getCartDetail(2);
        for (Cart c : cartList) {
            System.out.println(c.getTitle());
        }
    }
}
