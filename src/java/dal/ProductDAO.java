/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

/**
 *
 * @author Admin
 */
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import model.Product;
import model.User;

public class ProductDAO extends DBContext {
    
    
      public Product getProductById(int id) throws SQLException {
        String sql = "select * from product where id = ?";
        PreparedStatement sta = connection.prepareStatement(sql);
        sta.setInt(1, id);
        ResultSet rs = sta.executeQuery();
        Product p = new Product();
        while (rs.next()) {
            int pid = rs.getInt("id");
            String title = rs.getString("title");
            String description = rs.getString("description");
            double import_price = rs.getDouble("import_price");
            double list_price = rs.getDouble("list_price");
            String status = rs.getString("status");
            boolean is_featured = rs.getBoolean("featured");
            String thumbnail = rs.getString("thumbnail");
            Date create_date = rs.getDate("created_date");
            int quantity = rs.getInt("quantity");
            String cid = rs.getString("category_id");
            p = new Product(pid, quantity, title, status, thumbnail, cid, import_price, list_price, create_date, is_featured, description);

        }
        return p;
    }
      
      public ArrayList<Product> getRelatedProduct(int id) throws SQLException {
        String sql = "SELECT product.category_id FROM product WHERE product.id = ?";
        String cateID = null;
        PreparedStatement sta = connection.prepareStatement(sql);
        sta.setInt(1, id);
        ResultSet rs = sta.executeQuery();
        while (rs.next()) {
            cateID = rs.getString("category_id"); // Thay đổi từ "cateID" thành "category_id"
        }

        String sql1 = "SELECT * FROM product WHERE product.category_id = ? AND id <> ? LIMIT 4;";
        ArrayList<Product> lst = new ArrayList<>();
        sta = connection.prepareStatement(sql1); // Sử dụng sql1 thay vì sql
        sta.setString(1, cateID);
        sta.setInt(2, id);
        ResultSet rs1 = sta.executeQuery();
        while (rs1.next()) {
            int pid = rs1.getInt("id"); // Sử dụng rs1 thay vì rs
            String title = rs1.getString("title");
            String description = rs1.getString("description");
            double import_price = rs1.getDouble("import_price");
            double list_price = rs1.getDouble("list_price");
            String status = rs1.getString("status");
            boolean is_featured = rs1.getBoolean("featured");
            String thumbnail = rs1.getString("thumbnail");
            Date create_date = rs1.getDate("created_date");
            int quantity = rs1.getInt("quantity");
            String cid = rs1.getString("category_id");
            Product p = new Product(pid, quantity, title, status, thumbnail, cid, import_price, list_price, create_date, is_featured, description);
            lst.add(p);
        }
        return lst;
    }

}
//hihi