package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import model.Product;
import model.Setting;
import model.User;

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

    public boolean addProduct(Product product) {
        String sql = "INSERT INTO product (title, description, thumbnail, quantity, status, import_price, list_price, is_featured, category_id, created_date)"
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, product.getTitle());
            stm.setString(2, product.getDescription());
            stm.setString(3, product.getThumbnail());
            stm.setInt(4, product.getQuantity());
            stm.setString(5, product.getStatus());
            stm.setDouble(6, product.getImportPrice());
            stm.setDouble(7, product.getListPrice());
            stm.setBoolean(8, product.isIsFeatured());
            stm.setInt(9, product.getCategoryId());
            stm.setTimestamp(10, new Timestamp(product.getCreatedDate().getTime()));
            stm.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            return false;
        }
        return true;
    }

    public double getTotalSold(int id) {
        String sql = "SELECT SUM(quantity) AS total_sold FROM order_details "
                + "WHERE product_id = ?";
        try {
            stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getDouble("total_sold");
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return 0;
    }

    public boolean updateProduct(Product product) {
        String sql = "UPDATE product SET title = ?, description = ?, thumbnail = ?,"
                + "quantity = ?, status = ?, import_price = ?, list_price = ?,"
                + "is_featured = ?, category_id = ? WHERE id = ?";
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, product.getTitle());
            stm.setString(2, product.getDescription());
            stm.setString(3, product.getThumbnail());
            stm.setInt(4, product.getQuantity());
            stm.setString(5, product.getStatus());
            stm.setDouble(6, product.getImportPrice());
            stm.setDouble(7, product.getListPrice());
            stm.setBoolean(8, product.isIsFeatured());
            stm.setInt(9, product.getCategoryId());
            stm.setInt(10, product.getId());
            stm.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            return false;
        }
        return true;
    }

    public List<Product> getAllPaginated(int page, int size, String search, String category, String status,
            String isFeatured, String sort) {
        String sql = "SELECT * FROM product";
        try {
            productList = new ArrayList<>();
            stm = connection.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                productList.add(setProduct(rs));
            }
            if (search != null && !search.trim().isEmpty()) {
                productList.removeIf(p -> (p.getDescription() == null || !p.getDescription().contains(search))
                        && (p.getTitle() == null || !p.getTitle().contains(search)));
            }
            if (category != null && !category.trim().isEmpty()) {
                List<Setting> cateList = new SettingDAO().getAllProductCategory();
                for (Setting s : cateList) {
                    if (s.getName().equals(category)) {
                        productList.removeIf(p -> p.getCategoryId() != s.getId());
                        break;
                    }
                }
            }
            if (status != null && !status.trim().isEmpty()) {
                productList.removeIf(p -> !p.getStatus().equals(status));
            }
            if (isFeatured != null && !isFeatured.trim().isEmpty()) {
                if (isFeatured.equals("Is Featured")) {
                    productList.removeIf(p -> !p.isIsFeatured());
                } else {
                    productList.removeIf(p -> p.isIsFeatured());
                }
            }
            if (sort != null && !sort.trim().isEmpty()) {
                switch (sort) {
                    case "Title ASC" ->
                        productList.sort(Comparator.comparing(Product::getTitle));
                    case "Title DESC" ->
                        productList.sort(Comparator.comparing(Product::getTitle).reversed());
                    case "Category ASC" ->
                        productList.sort(Comparator.comparing(Product::getTitle));
                    case "Category DESC" ->
                        productList.sort(Comparator.comparing(Product::getTitle).reversed());
                    case "Import Price ASC" ->
                        productList.sort(Comparator.comparing(Product::getImportPrice));
                    case "Import Price DESC" ->
                        productList.sort(Comparator.comparing(Product::getImportPrice).reversed());
                    case "List Price ASC" ->
                        productList.sort(Comparator.comparing(Product::getListPrice));
                    case "List Price DESC" ->
                        productList.sort(Comparator.comparing(Product::getListPrice).reversed());
                    case "Status ASC" ->
                        productList.sort(Comparator.comparing(Product::getStatus));
                    case "Status DESC" ->
                        productList.sort(Comparator.comparing(Product::getStatus).reversed());
                    case "Date ASC" ->
                        productList.sort(Comparator.comparing(Product::getCreatedDate));
                    case "Date DESC" ->
                        productList.sort(Comparator.comparing(Product::getCreatedDate).reversed());
                    default ->
                        productList.sort(Comparator.comparing(Product::getId));
                }
            }

            // Pagination logic
            int begin = (page - 1) * size;
            int end = Math.min(begin + size, productList.size());

            if (begin >= productList.size() || begin < 0) {
                return new ArrayList<>(); // Return empty list if page is out of range
            }

            return productList.subList(begin, end);
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
            sqlSearch = "AND (s.name LIKE ? OR pr.title LIKE ?) ";
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
                + "WHERE NOT pr.status = 'Hidden' AND s.status = 'Active' " + sqlCategory + sqlMinPrice + sqlMaxPrice + sqlSearch
                + " ORDER BY " + sqlOrder + " pr.status, pr.id " + sqlPaging;
        try {
            productList = new ArrayList<>();
            stm = connection.prepareStatement(sql);
            int count = 1;
            if (categoryRaw != null && !categoryRaw.equals("")) {
                int cateId = Integer.parseInt(categoryRaw);
                stm.setInt(count++, cateId);
            }
            if (minPriceRaw != null && !minPriceRaw.equals("")) {
                double minPrice = Double.parseDouble(minPriceRaw) / 1000;
                stm.setDouble(count++, minPrice);
            }
            if (maxPriceRaw != null && !maxPriceRaw.equals("")) {
                double maxPrice = Double.parseDouble(maxPriceRaw) / 1000;
                stm.setDouble(count++, maxPrice);
            }
            if (search != null && !search.equals("")) {
                search = "%" + search + "%";
                stm.setString(count++, search);
                stm.setString(count++, search);
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

    public void featureProduct(int productId) {
        try {
            String sql = "UPDATE product SET is_featured = 1 WHERE id = ?";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, productId);
            stm.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public void unfeatureProduct(int productId) {
        try {
            String sql = "UPDATE product SET is_featured = 0 WHERE id = ?";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, productId);
            stm.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public void hideProduct(int productId) {
        try {
            String sql = "UPDATE product SET status = ? WHERE id = ?";
            stm = connection.prepareStatement(sql);
            stm.setString(1, "Hidden");
            stm.setInt(2, productId);
            stm.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public void showProduct(int productId) {
        try {
            int quantity = getProductById(productId).getQuantity();
            String sql = "UPDATE product SET status = ? WHERE id = ?";
            stm = connection.prepareStatement(sql);
            String status;
            if (quantity > 0) {
                status = "Available";
            } else {
                status = "Out of Stock";
            }
            stm.setString(1, status);
            stm.setInt(2, productId);
            stm.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
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

    public List<Product> getProductForEachOrder(int uid, String status, int page, int num) {
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
            stm.setInt(3, (page - 1) * num);
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

    public List<Product> getProductForEachOrder(User sale, int page, int num, String search, String searchby, String sortby, String order, String status, String start, String end) {
        String sql = "SELECT * FROM product p JOIN order_details od ON od.product_id = p.id\n"
                + "JOIN `order` o ON od.order_id = o.id\n"
                + " JOIN user u on u.id = customer_id WHERE o.sale_id = ?";
        if (sale.getRoleId() == 4) {
            sql += " or o.sale_id != " + sale.getId();
        }
        if (status != null && !status.isEmpty()) {
            sql += " and o.status='" + status + "'";
        }
        if (search != null && !search.isEmpty()) {
            if (!searchby.equals("id")) {
                sql += " and " + searchby + " like '%" + search + "%'";
            } else {
                sql += " and o." + searchby + " = '" + search + "'";
            }
        }
        if (start != null && !start.isEmpty()) {
            sql += " and ordered_date between '" + start + "' AND '" + end + " 23:59'";
        }
        sql += " AND (od.order_id, od.product_id) IN (\n"
                + "SELECT order_id, MIN(product_id) FROM order_details \n"
                + "GROUP BY order_id\n"
                + ")\n";
        if (sortby != null && !sortby.isEmpty()) {
            sql += " order by " + sortby + " " + order + " limit ?,?";
        } else {
            sql += " order by ordered_date desc limit ?,?";
        }
        try {
            productList = new ArrayList<>();
            stm = connection.prepareStatement(sql);
            stm.setInt(1, sale.getId());
            stm.setInt(2, (page - 1) * num);
            stm.setInt(3, num);
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

    public List<Product> getAllByOrderId(int oid) {
        String sql = "SELECT * FROM product AS p JOIN order_details "
                + "ON id = product_id WHERE order_id = ?";
        try {
            productList = new ArrayList<>();
            stm = connection.prepareStatement(sql);
            stm.setInt(1, oid);
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

    public void updateQuantity(int pid, int quan) {
        String sql = "UPDATE product SET quantity = ? WHERE id = ?";
        try {
            PreparedStatement stm;
            stm = connection.prepareStatement(sql);
            stm.setInt(1, quan);
            stm.setInt(2, pid);
            stm.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public static void main(String[] args) throws SQLException {
        ProductDAO p = new ProductDAO();
        List<Product> productList = p.getAllPaginated(1, 5, "hat", "", "", "", "Title");
        for (Product pr : productList) {
            System.out.println(pr.getTitle());
        }
    }
}
