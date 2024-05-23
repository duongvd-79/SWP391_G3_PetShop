/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;
import java.sql.Connection;
import java.util.ArrayList;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import model.Setting;
import model.User;

/**
 *
 * @author ACER
 */
public class settingDAO extends DBContext {

    PreparedStatement stm;
    ResultSet rs;

    public List<Setting> getAll() {
        List<Setting> list = new ArrayList<>();
        try {
            String strSelect = "SELECT s.id,setting_type_id,value,s.name,`order`,"
                    + " status, description,t.name as type FROM setting as s join setting_type as t "
                    + "on s.setting_type_id = t.id order by s.id";
            stm = connection.prepareStatement(strSelect);
            rs = stm.executeQuery();
            while (rs.next()) {
                Setting setting = new Setting(rs.getInt("id"),
                        rs.getInt("setting_Type_Id"), rs.getString("type"), rs.getInt("order"), rs.getString("name"),
                        rs.getInt("value"), rs.getString("status"), rs.getString("description")
                );
                list.add(setting);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public Setting getById(int id) {
        settingDAO s = new settingDAO();
        List<Setting> list = s.getAll();
        for (Setting st : list) {
            if (st.getId() == id) {
                return st;
            }
        }
        return null;
    }

    //Lấy ra setting type
    public List<String> getAllType() {
        List<String> types = new ArrayList<String>();
        try {
            String strSelect = "SELECT name from setting_type";
            stm = connection.prepareStatement(strSelect);
            rs = stm.executeQuery();
            while (rs.next()) {
                String t = rs.getString("name");
                types.add(t);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return types;
    }

    //Search name
    public List<Setting> getAllByName(String n) {
        List<Setting> list = new ArrayList<>();
        try {
            String strSelect = "SELECT s.id,setting_type_id,value,s.name,`order`,"
                    + " status, description,t.name as type FROM setting as s join setting_type as t "
                    + "on s.setting_type_id = t.id where s.name like ?";
            stm = connection.prepareStatement(strSelect);
            stm.setString(1, "%" + n + "%");
            rs = stm.executeQuery();
            while (rs.next()) {
                Setting setting = new Setting(rs.getInt("id"),
                        rs.getInt("setting_Type_Id"), rs.getString("type"), rs.getInt("order"), rs.getString("name"),
                        rs.getInt("value"), rs.getString("status"), rs.getString("description")
                );
                list.add(setting);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    //Lấy hết qua type
    public List<Setting> getAllByType(List<Setting> list, String type) {
        List<Setting> outputlist = new ArrayList<>();
        for (Setting s : list) {
            if (s.getType().equals(type)) {
                outputlist.add(s);
            }
        }
        return outputlist;
    }

    //Lấy hết qua status
    public List<Setting> getAllByStatus(List<Setting> list, String status) {
        List<Setting> outputlist = new ArrayList<>();
        for (Setting s : list) {
            if (s.getStatus().equals(status)) {
                outputlist.add(s);
            }
        }
        return outputlist;
    }

   public void signup(String username, String password, String email) {
    Connection con = null;
    PreparedStatement ps = null;

    try {
        con = this.connection; // Sử dụng kết nối từ DBContext
        String query = "INSERT INTO user (email, password, name) VALUES (?, ?, ?)";
        

        
        ps = con.prepareStatement(query);
        ps.setString(1, email);
        ps.setString(2, password);
        ps.setString(3, username);
       
        ps.executeUpdate();
        
        // Sau khi chèn dữ liệu thành công, bạn cần thực hiện commit thay đổi vào cơ sở dữ liệu.
        con.commit();
    } catch (SQLException e) {
        e.printStackTrace();
        // In ra thông điệp lỗi cụ thể nếu có lỗi xảy ra trong quá trình thực hiện câu truy vấn SQL để dễ dàng gỡ lỗi.
        System.out.println("Error message: " + e.getMessage());
    } finally {
        try {
            if (ps != null) {
                ps.close();
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
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, user);
            ResultSet rs = st.executeQuery();
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
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, email);
            st.setString(2, password);
            ResultSet rs = st.executeQuery();
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


    //Lấy theo phân trang
    public List<Setting> getByPage(List<Setting> list, int page) {
        List<Setting> outputlist = new ArrayList<>();
        for (int i = (page - 1) * 3; i <= (page - 1) * 3 + 2; i++) {
            if (i >= list.size()) {
                return outputlist;
            }
            outputlist.add(list.get(i));
        }
        return outputlist;
    }

    public static void main(String[] args) {
        settingDAO s = new settingDAO();

        List<Setting> sList = s.getAll();
        List<Setting> filter = s.getAllByStatus(sList, "Inactive");
        for (Setting st : filter) {
            System.out.println(st.getName() + st.getType());
        }

    }
}
