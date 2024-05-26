package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import model.Setting;
import model.User;

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
            Setting r = new Setting(id, type_id, name, order, name, status, description);
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
    
    public void updateUser(int roleId,String status,int id){
        try {
            String sql = "UPDATE user SET role_id = ?,status = ? WHERE id = ?";
            PreparedStatement stm;
            stm = connection.prepareStatement(sql);
            stm.setInt(1, roleId);
            stm.setString(2, status);
            stm.setInt(3,id );
            stm.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);
        }
    }
    
    public void addNewUser(User u) throws SQLException{
        String sql = "insert into user(email,password,name,gender,status,role_id,phone) values (?,MD5(?),?,?,?,?,?)";
        PreparedStatement sta = connection.prepareStatement(sql);
        sta.setString(1, u.getEmail());
        sta.setString(2, u.getPassword());
        sta.setString(3, u.getName());
        sta.setBoolean(4, (u.getGender().equals("Male"))? true : false);
        sta.setString(5, u.getStatus());
        sta.setInt(6, u.getRoleId());
        sta.setString(7, u.getPhone());
        sta.executeUpdate();
    }
   
    public static void main(String[] args) throws SQLException {
        UserDAO u = new UserDAO();
        for(User s : u.getAllUser()){
            System.out.println(s.getId() + s.getPfp());
        }
        u.addNewUser(new User("hoang@gmail.com","conbuonxing","taivisao","Pending","6677028",null,true,1));
        
    }

}
