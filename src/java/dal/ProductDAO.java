package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import model.Product;

public class ProductDAO extends DBContext {

    private PreparedStatement stm;
    private ResultSet rs;
    private List<Product> productList = new ArrayList<>();

    private static Product setProduct(ResultSet rs) {
        Product p = new Product();
        try {
            p.setId(rs.getInt("id"));
            p.setQuantity(rs.getInt("quantity"));
            p.setTitle(rs.getString("title"));
            p.setStatus(rs.getString("status"));
            p.setThumbnail(rs.getString("thumbnail"));
            p.setCategoryId(rs.getInt("category_id"));
            p.setImportPrice(rs.getDouble("import_price"));
            p.setListPrice(rs.getDouble("list_price"));
            p.setCreatedDate(rs.getDate("created_date"));
            p.setIsFeatured(rs.getBoolean("is_featured"));
            p.setDescription(rs.getString("description"));
        } catch (SQLException e) {
        }
        return p;
    }

    public List<Product> getAll() {
        String sql = "SELECT * FROM product";
        try {
            stm = connection.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                Product p = setProduct(rs);
                productList.add(p);
            }
            return productList;
        } catch (SQLException e) {
        }
        return null;
    }

    public List<Product> getFeatured() {
        productList.clear();
        String sql = "SELECT * FROM product WHERE featured = 1 LIMIT 5";
        try {
            stm = connection.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                Product p = setProduct(rs);
                productList.add(p);
            }
            return productList;
        } catch (SQLException e) {
        }
        return productList;
    }
    
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
            int cid = rs.getInt("category_id");
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
            int cid = rs1.getInt("category_id");
            Product p = new Product(pid, quantity, title, status, thumbnail, cid, import_price, list_price, create_date, is_featured, description);
            lst.add(p);
        }
        return lst;
    }

    public static void main(String[] args) {
        ProductDAO p = new ProductDAO();
        for (Product pr : p.getFeatured()) {
            System.out.println(pr.getTitle());
        }
    }
}
