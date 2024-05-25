/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import model.Product;
import model.Setting;
import model.User;

/**
 *
 * @author Admin
 */
public class UserDAO extends DBContext {

    public ArrayList<User> getAllUser() throws SQLException {
        String sql = "select * from user";
        PreparedStatement sta = connection.prepareStatement(sql);
        ResultSet rs = sta.executeQuery();
        ArrayList<User> lst = new ArrayList<>();
        while (rs.next()) {
            int id = rs.getInt("id");
            String email = rs.getString("email");
            String pass = rs.getString("password");
            String name = rs.getString("name");
            boolean gender = rs.getBoolean("gender");
            String status = rs.getString("status");
            int role_id = rs.getInt("role_id");
            String phone = rs.getString("phone");
            Date lastlog = rs.getDate("last_log");
            int update_by = rs.getInt("update_by");
            Date update_date = rs.getDate("update_date");
            String pfp = rs.getString("pfp");
            User u = new User(id, email, pass, name, status, phone, pfp, update_by, role_id, gender, lastlog, update_date);
            lst.add(u);
        }
        return lst;
    }

    public ArrayList<User> searchUserByName(String name) throws SQLException {
        String sql = "SELECT * FROM user where user.name like ?";
        PreparedStatement sta = connection.prepareStatement(sql);
        sta.setString(1, "%" + name + "%");
        ResultSet rs = sta.executeQuery();
        ArrayList<User> lst = new ArrayList<>();
        while (rs.next()) {
            int id = rs.getInt("id");
            String email = rs.getString("email");
            String pass = rs.getString("password");
            String fullname = rs.getString("name");
            boolean gender = rs.getBoolean("gender");
            String status = rs.getString("status");
            int role_id = rs.getInt("role_id");
            String phone = rs.getString("phone");
            Date lastlog = rs.getDate("last_log");
            int update_by = rs.getInt("update_by");
            Date update_date = rs.getDate("update_date");
            String pfp = rs.getString("pfp");
            User u = new User(id, email, pass, fullname, status, phone, pfp, update_by, role_id, gender, lastlog, update_date);
            lst.add(u);
        }
        return lst;
    }

    public ArrayList<User> searchUserByEmail(String mail) throws SQLException {
        String sql = "SELECT * FROM user where user.email like ?";
        PreparedStatement sta = connection.prepareStatement(sql);
        sta.setString(1, mail);
        ResultSet rs = sta.executeQuery();
        ArrayList<User> lst = new ArrayList<>();
        while (rs.next()) {
            int id = rs.getInt("id");
            String email = rs.getString("email");
            String pass = rs.getString("password");
            String fullname = rs.getString("name");
            boolean gender = rs.getBoolean("gender");
            String status = rs.getString("status");
            int role_id = rs.getInt("role_id");
            String phone = rs.getString("phone");
            Date lastlog = rs.getDate("last_log");
            int update_by = rs.getInt("update_by");
            Date update_date = rs.getDate("update_date");
            String pfp = rs.getString("pfp");
            User u = new User(id, email, pass, fullname, status, phone, pfp, update_by, role_id, gender, lastlog, update_date);
            lst.add(u);
        }
        return lst;
    }

    public ArrayList<User> searchUserByPhone(String phoneNum) throws SQLException {
        String sql = "SELECT * FROM user where user.phone like ?";
        PreparedStatement sta = connection.prepareStatement(sql);
        sta.setString(1, phoneNum);
        ResultSet rs = sta.executeQuery();
        ArrayList<User> lst = new ArrayList<>();
        while (rs.next()) {
            int id = rs.getInt("id");
            String email = rs.getString("email");
            String pass = rs.getString("password");
            String fullname = rs.getString("name");
            boolean gender = rs.getBoolean("gender");
            String status = rs.getString("status");
            int role_id = rs.getInt("role_id");
            String phone = rs.getString("phone");
            Date lastlog = rs.getDate("last_log");
            int update_by = rs.getInt("update_by");
            Date update_date = rs.getDate("update_date");
            String pfp = rs.getString("pfp");
            User u = new User(id, email, pass, fullname, status, phone, pfp, update_by, role_id, gender, lastlog, update_date);
            lst.add(u);
        }
        return lst;
    }

    public ArrayList<User> filterUserByGender(int num) throws SQLException {
        String sql = "SELECT * FROM user where user.gender like ?";
        PreparedStatement sta = connection.prepareStatement(sql);
        sta.setInt(1, num);
        ResultSet rs = sta.executeQuery();
        ArrayList<User> lst = new ArrayList<>();
        while (rs.next()) {
            int id = rs.getInt("id");
            String email = rs.getString("email");
            String pass = rs.getString("password");
            String fullname = rs.getString("name");
            boolean gender = rs.getBoolean("gender");
            String status = rs.getString("status");
            int role_id = rs.getInt("role_id");
            String phone = rs.getString("phone");
            Date lastlog = rs.getDate("last_log");
            int update_by = rs.getInt("update_by");
            Date update_date = rs.getDate("update_date");
            String pfp = rs.getString("pfp");
            User u = new User(id, email, pass, fullname, status, phone, pfp, update_by, role_id, gender, lastlog, update_date);
            lst.add(u);
        }
        return lst;
    }

    public ArrayList<Setting> getAllRole() throws SQLException {
        String sql = "SELECT * FROM setting where setting.type_id = 3 ";
        PreparedStatement sta = connection.prepareStatement(sql);
        ResultSet rs = sta.executeQuery();
        ArrayList<Setting> lst = new ArrayList<>();
        while (rs.next()) {
            int id = rs.getInt("id");
            int type_id = rs.getInt("type_id");
            int order = rs.getInt("order");
            String name = rs.getString("name");
            String status = rs.getString("status");
            String description = rs.getString("description");
            Setting r = new Setting(id, type_id, order, name, status, description);
            lst.add(r);
        }
        return lst;
    }

    public ArrayList<User> filterUserByRole(int role) throws SQLException {
        String sql = "SELECT * FROM user where user.role_id like ?";
        PreparedStatement sta = connection.prepareStatement(sql);
        sta.setInt(1, role);
        ResultSet rs = sta.executeQuery();
        ArrayList<User> lst = new ArrayList<>();
        while (rs.next()) {
            int id = rs.getInt("id");
            String email = rs.getString("email");
            String pass = rs.getString("password");
            String fullname = rs.getString("name");
            boolean gender = rs.getBoolean("gender");
            String status = rs.getString("status");
            int role_id = rs.getInt("role_id");
            String phone = rs.getString("phone");
            Date lastlog = rs.getDate("last_log");
            int update_by = rs.getInt("update_by");
            Date update_date = rs.getDate("update_date");
            String pfp = rs.getString("pfp");
            User u = new User(id, email, pass, fullname, status, phone, pfp, update_by, role_id, gender, lastlog, update_date);
            lst.add(u);
        }
        return lst;
    }

    public ArrayList<User> filterUserByStatus(String userStatus) throws SQLException {
        String sql = "SELECT * FROM user where user.status like ?";
        PreparedStatement sta = connection.prepareStatement(sql);
        sta.setString(1, userStatus);
        ResultSet rs = sta.executeQuery();
        ArrayList<User> lst = new ArrayList<>();
        while (rs.next()) {
            int id = rs.getInt("id");
            String email = rs.getString("email");
            String pass = rs.getString("password");
            String fullname = rs.getString("name");
            boolean gender = rs.getBoolean("gender");
            String status = rs.getString("status");
            int role_id = rs.getInt("role_id");
            String phone = rs.getString("phone");
            Date lastlog = rs.getDate("last_log");
            int update_by = rs.getInt("update_by");
            Date update_date = rs.getDate("update_date");
            String pfp = rs.getString("pfp");
            User u = new User(id, email, pass, fullname, status, phone, pfp, update_by, role_id, gender, lastlog, update_date);
            lst.add(u);
        }
        return lst;
    }

    public ArrayList<User> orderUserBy(String msg) throws SQLException {
        String sql = "SELECT * FROM user order by " + msg;
        PreparedStatement sta = connection.prepareStatement(sql);
        ResultSet rs = sta.executeQuery();
        ArrayList<User> lst = new ArrayList<>();
        while (rs.next()) {
            int id = rs.getInt("id");
            String email = rs.getString("email");
            String pass = rs.getString("password");
            String fullname = rs.getString("name");
            boolean gender = rs.getBoolean("gender");
            String status = rs.getString("status");
            int role_id = rs.getInt("role_id");
            String phone = rs.getString("phone");
            Date lastlog = rs.getDate("last_log");
            int update_by = rs.getInt("update_by");
            Date update_date = rs.getDate("update_date");
            String pfp = rs.getString("pfp");
            User u = new User(id, email, pass, fullname, status, phone, pfp, update_by, role_id, gender, lastlog, update_date);
            lst.add(u);
        }
        return lst;
    }

}
