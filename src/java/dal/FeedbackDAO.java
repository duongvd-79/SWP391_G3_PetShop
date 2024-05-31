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
        sta.setInt(1,newid );
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
            ProductFeedback u = new ProductFeedback( id
            ,  pid,  uid,  star,  detail
            ,  image,  status
            ,  created_date,  name
            ,  pfp
            );
            lst.add(u);
        }
        return lst;
    }
    
}
