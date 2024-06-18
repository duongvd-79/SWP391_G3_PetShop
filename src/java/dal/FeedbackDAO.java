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
import java.util.Date;
import java.util.List;
import model.Product;
import model.ProductFeedback;
import model.User;

public class FeedbackDAO extends DBContext {

    public ArrayList<ProductFeedback> getNewFeedback(int newid) throws SQLException {
        String sql = "SELECT   p.id, p.product_id, p.user_id, u.name, u.pfp, p.detail, p.star, p.image, p.status, p.created_date\n"
                + "FROM product_feedback p join user u on p.user_id = u.id\n where p.product_id = ? "
                + "ORDER BY created_date desc\n"
                + "limit 3;";
        PreparedStatement sta = connection.prepareStatement(sql);
        sta.setInt(1, newid);
        ResultSet rs = sta.executeQuery();
        ArrayList<ProductFeedback> lst = new ArrayList<>();
        while (rs.next()) {
            int id = rs.getInt("id");
            int pid = rs.getInt("product_id");
            int uid = rs.getInt("user_id");
            String name = rs.getString("name");
            int star = rs.getInt("star");
            String detail = rs.getString("detail");
            String image = rs.getString("image");
            String status = rs.getString("status");
            Date created_date = rs.getDate("created_date");
            String pfp = rs.getString("pfp");
            ProductFeedback u = new ProductFeedback(id,
                    pid, uid, star, detail,
                    image, status,
                    created_date, name,
                    pfp
            );
            lst.add(u);
        }
        return lst;
    }

    public int getCountFeedback(String pcategory) {
        String sql = "SELECT COUNT(*) AS count\n"
                + "FROM product_feedback as pf\n"
                + " JOIN product as p ON p.id = pf.product_id\n";
        if (pcategory != null) {
            sql += "WHERE p.category_id = '" + pcategory + "'";
        }
        try {
            PreparedStatement sta = connection.prepareStatement(sql);
            sta = connection.prepareStatement(sql);
            ResultSet rs = sta.executeQuery();
            if (rs.next()) {
                return rs.getInt("count");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int getCountFeedback(String start, String end, String pcategory) {
        String sql = "SELECT COUNT(*) AS count\n"
                + "FROM product_feedback as pf\n"
                + " JOIN product as p ON p.id = pf.product_id\n"
                + "where pf.created_date between '" + start + "' and '" + end + "'";
        if (pcategory != null) {
            sql += "and p.category_id = '" + pcategory + "'";
        }
        try {
            PreparedStatement sta = connection.prepareStatement(sql);
            sta = connection.prepareStatement(sql);
            ResultSet rs = sta.executeQuery();
            if (rs.next()) {
                return rs.getInt("count");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public void AddFeedback(int pid, int uid, String content, int star, String pic, String status, String date) throws SQLException {
        String sql = "INSERT INTO product_feedback (product_id, user_id, detail, star, image, status, created_date) VALUES (?,?,?,?,?,?,?);";
        try (PreparedStatement sta = connection.prepareStatement(sql)) {
            sta.setInt(1, pid);
            sta.setInt(2, uid);
            sta.setString(3, content);
            sta.setInt(4, star);
            sta.setString(5, pic);
            sta.setString(6, status);
            sta.setString(7, date);
            sta.executeUpdate();

        }
    }
    
    public void AddFeedbackImage(int pid, int uid, String image) throws SQLException {
        String sql = "INSERT INTO product_feedback (product_id, user_id, detail, star, image, status, created_date) VALUES (?,?,?,?,?,?,?);";
        try (PreparedStatement sta = connection.prepareStatement(sql)) {
            sta.setInt(1, pid);
            sta.setInt(2, uid);
            sta.setString(3, image);
            sta.executeUpdate();

        }
    }
    
    

    public static void main(String[] args) {
        FeedbackDAO f = new FeedbackDAO();
        System.out.println(f.getCountFeedback("2023-01-01", "2024-08-08", "6"));
    }

}
