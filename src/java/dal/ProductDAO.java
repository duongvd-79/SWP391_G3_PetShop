package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Product;
import model.ProductFeedback;

public class ProductDAO extends DBContext {

    private PreparedStatement stm;
    private ResultSet rs;
    private List<Product> productList;

    private static Product setProduct(ResultSet rs) {
        Product p = new Product();
        try {
            p.setId(rs.getInt("id"));
            p.setQuantity(rs.getInt("quantity"));
            p.setTitle(rs.getString("title"));
            p.setDescription(rs.getString("description"));
            p.setStatus(rs.getString("status"));
            p.setThumbnail(rs.getString("thumbnail"));
            p.setCategoryId(rs.getInt("category_id"));
            p.setImportPrice(rs.getDouble("import_price"));
            p.setListPrice(rs.getDouble("list_price"));
            p.setCreatedDate(rs.getDate("created_date"));
            p.setIsFeatured(rs.getBoolean("is_featured"));
        } catch (SQLException e) {
        }
        return p;
    }

    public List<Product> getAll() {
        String sql = "SELECT * FROM product";
        try {
            productList = new ArrayList<>();
            stm = connection.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                Product p = setProduct(rs);
                productList.add(p);
            }
            return productList;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    public List<Product> getFeatured() {
        String sql = "SELECT * FROM product WHERE is_featured = 1 LIMIT 8";
        try {
            productList = new ArrayList<>();
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

    public Product getProductById(int id) {
        try {
            String sql = "select * from product where id = ?";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            rs = stm.executeQuery();
            if (rs.next()) {
                return setProduct(rs);
            }
        } catch (SQLException e) {
        }
        return null;
    }

    public List<Product> getRelatedProduct(int id) {
        try {
            String sql = "SELECT product.category_id FROM product WHERE product.id = ?";
            int cateID = 1;
            stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            rs = stm.executeQuery();
            if (rs.next()) {
                cateID = rs.getInt("category_id"); // Thay đổi từ "cateID" thành "category_id"
            }

            String sql1 = "SELECT * FROM product WHERE product.category_id = ? AND id <> ? LIMIT 4;";
            productList = new ArrayList<>();
            stm = connection.prepareStatement(sql1); // Sử dụng sql1 thay vì sql
            stm.setInt(1, cateID);
            stm.setInt(2, id);
            ResultSet rs1 = stm.executeQuery();
            while (rs1.next()) {
                Product p = setProduct(rs1);
                productList.add(p);
            }
            return productList;
        } catch (SQLException e) {
        }
        return null;
    }

    public static void main(String[] args) throws SQLException {
        ProductDAO p = new ProductDAO();
        for(Product pr : p.getAll()){
            System.out.println(pr.getThumbnail());
        }
    }
}
