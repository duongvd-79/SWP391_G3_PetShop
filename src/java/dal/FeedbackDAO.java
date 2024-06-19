/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

/**
 *
 * @author Admin
 */
import com.mysql.cj.jdbc.Blob;
import java.io.InputStream;
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

    public int getFeedbackID(int pid, int uid) throws SQLException {
        String sql = "SELECT id FROM product_feedback WHERE product_id = ? AND user_id = ? ORDER BY created_date DESC LIMIT 1";
        try (PreparedStatement sta = connection.prepareStatement(sql)) {
            sta.setInt(1, pid);
            sta.setInt(2, uid);
            try (ResultSet rs = sta.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("id");
                }
            }
        }
        return -1; // return -1 if no feedback ID found
    }

    public void AddFeedbackImage(int cid, int fid, String image) throws SQLException {
        String sql = "INSERT INTO feedback_image (customer_id, feedback_id, image) VALUES (?,?,?);";
        try (PreparedStatement sta = connection.prepareStatement(sql)) {
            sta.setInt(1, cid);
            sta.setInt(2, fid);
            sta.setString(3, image);
            sta.executeUpdate();

        }
    }

    public ArrayList<ProductFeedback> getFeedbackImage(int feedbackId) throws SQLException {
        String sql = "select * from feedback_image where feedback_id = ?";
        PreparedStatement sta = connection.prepareStatement(sql);
        sta.setInt(1, feedbackId);
        ResultSet rs = sta.executeQuery();
        ArrayList<ProductFeedback> lst = new ArrayList<>();
        while (rs.next()) {
            int id = rs.getInt("id");
            int cid = rs.getInt("customer_id");
            int fid = rs.getInt("feedback_id");
            String image = rs.getString("image");
            ProductFeedback pf = new ProductFeedback(id, cid, fid, image);
            lst.add(pf);
        }
        return lst;
    }

    public ArrayList<ProductFeedback> getFeedbackByProductID(int productID) throws SQLException {
        String sql = "select * from product_feedback where product_id = ?";
        PreparedStatement sta = connection.prepareStatement(sql);
        sta.setInt(1, productID);
        ResultSet rs = sta.executeQuery();
        ArrayList<ProductFeedback> lst = new ArrayList<>();
        while (rs.next()) {
            int id = rs.getInt("id");
            int pid = rs.getInt("product_id");
            int uid = rs.getInt("user_id");
            String detail = rs.getString("detail");
            int star = rs.getInt("star");
            String image = rs.getString("image");
            String status = rs.getString("status");
            Date date = rs.getDate("created_date");
            ProductFeedback pf = new ProductFeedback( id,  pid,  uid,  star,  detail,  image,  status,  date); 
            lst.add(pf);
        }
        return lst;
    }
    
    public ArrayList<ProductFeedback> getFeedbackByProductIDTop3(int productID) throws SQLException {
        String sql = "select * from product_feedback where product_id = ? order by created_date DESC limit 3";
        PreparedStatement sta = connection.prepareStatement(sql);
        sta.setInt(1, productID);
        ResultSet rs = sta.executeQuery();
        ArrayList<ProductFeedback> lst = new ArrayList<>();
        while (rs.next()) {
            int id = rs.getInt("id");
            int pid = rs.getInt("product_id");
            int uid = rs.getInt("user_id");
            String detail = rs.getString("detail");
            int star = rs.getInt("star");
            String image = rs.getString("image");
            String status = rs.getString("status");
            Date date = rs.getDate("created_date");
            ProductFeedback pf = new ProductFeedback( id,  pid,  uid,  star,  detail,  image,  status,  date); 
            lst.add(pf);
        }
        return lst;
    }

    public static void main(String[] args) throws SQLException {
        FeedbackDAO f = new FeedbackDAO();
        f.AddFeedbackImage(5, 1, "data:image/jpeg;base64,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");
    }

}
