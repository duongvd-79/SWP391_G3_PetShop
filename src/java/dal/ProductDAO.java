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

    public List<Product> getActive(boolean isPaginated, int index, String sortType) {
        String order = "";
        String paging = "";
        if (isPaginated) {
            paging = " LIMIT 8 OFFSET ?";
        }
        if (sortType != null) {
            switch (sortType) {
                case "Latest" -> {
                    order = "pr.created_date DESC,";
                }
                case "Oldest" -> {
                    order = "pr.created_date ASC,";
                }
                case "Price Asc" -> {
                    order = "pr.list_price ASC,";
                }
                case "Price Desc" -> {
                    order = "pr.list_price DESC,";
                }
                default -> {
                    order = "";
                }
            }
        }
        String sql = "SELECT pr.id, pr.title, pr.description, pr.import_price, "
                + "pr.list_price, pr.status, pr.is_featured, pr.thumbnail, "
                + "pr.created_date, pr.quantity, pr.category_id\n"
                + "FROM petshop.product pr JOIN petshop.setting s ON pr.category_id = s.id\n"
                + "WHERE s.status = 'Active' ORDER BY " + order + " pr.id " + paging;
        try {
            productList = new ArrayList<>();
            stm = connection.prepareStatement(sql);
            if (isPaginated) {
                stm.setInt(1, (index - 1) * 8);
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
        productList = getActive(false, 0, null);
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

    private List<Product> getActiveByCategoryId(int cateId) {
        productList = getActive(false, 0, null);
        productList.removeIf(p -> p.getCategoryId() != cateId);
        return productList;
    }

    private List<Product> getActiveByPrice(double minPrice, double maxPrice) {
        productList = getActive(false, 0, null);
        productList.removeIf(p -> p.getListPrice() > maxPrice || p.getListPrice() < minPrice);
        return productList;
    }

    private List<Product> search(String query) {
        productList = getActive(false, 0, null);
        SettingDAO sdao = new SettingDAO();
        productList.removeIf(p -> !p.getTitle().toLowerCase().contains(query)
                && !sdao.getActiveById(p.getCategoryId()).toLowerCase().contains(query));
        return productList;
    }

    public List<Product> filter(boolean flag, String categoryRaw, String minPriceRaw, String maxPriceRaw, String searchQuery, int index, String sortType) {
        if (flag) {
            productList = getActive(true, index, sortType);
        } else {
            productList = getActive(false, 0, null);
        }
        if (categoryRaw != null && !categoryRaw.equals("")) {
            int category = Integer.parseInt(categoryRaw);
            productList = getActiveByCategoryId(category);
        }
        if (minPriceRaw != null && !minPriceRaw.equals("") && maxPriceRaw != null && !maxPriceRaw.equals("")) {
            double minPrice = Double.parseDouble(minPriceRaw) / 1000;
            double maxPrice = Double.parseDouble(maxPriceRaw) / 1000;
            productList = getActiveByPrice(minPrice, maxPrice);
        }
        if (searchQuery != null && !searchQuery.equals("")) {
            productList = search(searchQuery);
        }
        return productList;
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

    public List<Product> getProductForEachOrder(int uid, String status) {
        String sql = "SELECT * FROM product p JOIN order_details od ON od.product_id = p.id\n"
                + "JOIN `order` o ON od.order_id = o.id\n"
                + "WHERE o.customer_id = ? AND o.status = ? AND (od.order_id, od.product_id) IN (\n"
                + "SELECT order_id, MIN(product_id) FROM order_details \n"
                + "GROUP BY order_id\n"
                + ")\n"
                + "ORDER BY o.ordered_date desc";
        try {
            productList = new ArrayList<>();
            stm = connection.prepareStatement(sql);
            stm.setInt(1, uid);
            stm.setString(2, status);
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
        for (Product pr : p.getActive(true, 1, "Latest")) {
            System.out.println(pr.getId());
        }
    }
}
