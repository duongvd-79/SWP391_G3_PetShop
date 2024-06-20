package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Product;

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

    public List<Product> getActive(boolean isPaginated, String categoryRaw,
            String minPriceRaw, String maxPriceRaw,
            String search, String sortType, int index) {
        String sqlCategory = "";
        String sqlMinPrice = "";
        String sqlMaxPrice = "";
        String sqlSearch = "";
        String sqlOrder = "";
        String sqlPaging = "";
        if (isPaginated) {
            sqlPaging = " LIMIT 12 OFFSET ?";
        }
        if (categoryRaw != null && !categoryRaw.equals("")) {
            sqlCategory = "AND category_id = ? ";
        }
        if (minPriceRaw != null && !minPriceRaw.equals("")) {
            sqlMinPrice = "AND list_price >= ? ";
        }
        if (maxPriceRaw != null && !maxPriceRaw.equals("")) {
            sqlMaxPrice = "AND list_price <= ? ";
        }
        if (search != null && !search.equals("")) {
            sqlSearch = "AND s.name LIKE ? OR pr.title LIKE ? ";
        }
        if (sortType != null && !sortType.equals("")) {
            switch (sortType) {
                case "Latest" -> {
                    sqlOrder = "pr.created_date DESC,";
                }
                case "Oldest" -> {
                    sqlOrder = "pr.created_date ASC,";
                }
                case "Price Asc" -> {
                    sqlOrder = "pr.list_price ASC,";
                }
                case "Price Desc" -> {
                    sqlOrder = "pr.list_price DESC,";
                }
                default -> {
                    sqlOrder = "";
                }
            }
        }
        String sql = "SELECT pr.id, pr.title, pr.description, pr.import_price, "
                + "pr.list_price, pr.status, pr.is_featured, pr.thumbnail, "
                + "pr.created_date, pr.quantity, pr.category_id, s.name\n"
                + "FROM petshop.product pr JOIN petshop.setting s ON pr.category_id = s.id\n"
                + "WHERE s.status = 'Active' " + sqlCategory + sqlMinPrice + sqlMaxPrice + sqlSearch
                + " ORDER BY " + sqlOrder + " pr.status, pr.id " + sqlPaging;
        try {
            productList = new ArrayList<>();
            stm = connection.prepareStatement(sql);
            int count = 1;
            if (categoryRaw != null && !categoryRaw.equals("")) {
                int cateId = Integer.parseInt(categoryRaw);
                stm.setInt(count, cateId);
                count++;
            }
            if (minPriceRaw != null && !minPriceRaw.equals("")) {
                double minPrice = Double.parseDouble(minPriceRaw) / 1000;
                stm.setDouble(count, minPrice);
                count++;
            }
            if (maxPriceRaw != null && !maxPriceRaw.equals("")) {
                double maxPrice = Double.parseDouble(maxPriceRaw) / 1000;
                stm.setDouble(count, maxPrice);
                count++;
            }
            if (search != null && !search.equals("")) {
                search = "%" + search + "%";
                stm.setString(count, search);
                count++;
                stm.setString(count, search);
                count++;
            }
            if (isPaginated) {
                stm.setInt(count, (index - 1) * 12);
            }
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

    public List<Product> getActiveFeatured() {
        productList = getActive(false, null, null, null, null, null, 0);
        productList.removeIf(p -> !p.isIsFeatured());
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

    public List<Product> getProductForEachOrder(int uid, String status,int page,int num) {
        String sql = "SELECT * FROM product p JOIN order_details od ON od.product_id = p.id\n"
                + "JOIN `order` o ON od.order_id = o.id\n"
                + "WHERE o.customer_id = ? AND o.status = ? AND (od.order_id, od.product_id) IN (\n"
                + "SELECT order_id, MIN(product_id) FROM order_details \n"
                + "GROUP BY order_id\n"
                + ")\n"
                + "ORDER BY o.ordered_date desc limit ?,?";
        try {
            productList = new ArrayList<>();
            stm = connection.prepareStatement(sql);
            stm.setInt(1, uid);
            stm.setString(2, status);
            stm.setInt(3, (page-1)*num);
            stm.setInt(4, num);
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

    public List<Product> getLatestProductList() {
        String sql = "SELECT * FROM product\n"
                + "ORDER BY created_date DESC\n"
                + "LIMIT 4;";
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

    public static void main(String[] args) throws SQLException {
        ProductDAO p = new ProductDAO();
        List<Product> productList = p.getActive(true, "", "", "", "dry", "", 1);
        for (Product pr : productList) {
            System.out.println(pr.getTitle());
        }
    }
}
