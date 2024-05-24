package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.User;

public class UserDAO extends DBContext {

    private PreparedStatement stm;
    private ResultSet rs;
    private List<User> userList = new ArrayList<>();

    
    public void signup(String username, String password, String email) {

    try {
       // Sử dụng kết nối từ DBContext
        String query = "INSERT INTO user (email, password, name) VALUES (?, ?, ?)";
        

        
        stm = this.connection.prepareStatement(query);
        stm.setString(1, email);
        stm.setString(2, password);
        stm.setString(3, username);
       
        stm.executeUpdate();
        
  
    } catch (SQLException e) {
        e.printStackTrace();
        // In ra thông điệp lỗi cụ thể nếu có lỗi xảy ra trong quá trình thực hiện câu truy vấn SQL để dễ dàng gỡ lỗi.
        System.out.println("Error message: " + e.getMessage());
    } finally {
        try {
            if (stm != null) {
                stm.close();
            }
            // Không đóng kết nối ở đây vì nó được quản lý bởi DBContext
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
}



public User checkUserExist(String user) {
    String sql = "SELECT * FROM `user` WHERE `email` = ?";
    try {
        // Sử dụng kết nối từ DBContext
        stm = this.connection.prepareStatement(sql);
        stm.setString(1, user);
        rs = stm.executeQuery();
        if (rs.next()) {
            return new User(
                rs.getString("id"),
                rs.getString("email"),
                rs.getString("password"),
                rs.getString("name"),
                rs.getString("status"),
                rs.getString("phone"),
                rs.getString("pfp"),
                rs.getInt("role_id"),
                rs.getBoolean("gender"),
                rs.getTimestamp("last_log")
            );
        }
    } catch (SQLException e) {
        System.out.println(e);
    }
    return null;
}

public User login(String email, String password) {
    String sql = "SELECT * FROM `user` WHERE `email` = ? AND `password` = ?";
    try {
        // Sử dụng kết nối từ DBContext
        stm = this.connection.prepareStatement(sql);
        stm.setString(1, email);
        stm.setString(2, password);
        rs = stm.executeQuery();
        if (rs.next()) {
            return new User(
                rs.getString("id"),
                rs.getString("email"),
                rs.getString("password"),
                rs.getString("name"),
                rs.getString("status"),
                rs.getString("phone"),
                rs.getString("pfp"),
                rs.getInt("role_id"),
                rs.getBoolean("gender"),
                rs.getTimestamp("last_log")
            );
        }
    } catch (SQLException e) {
        System.out.println("Lỗi SQL: " + e.getMessage());
    }
    return null;
}
}