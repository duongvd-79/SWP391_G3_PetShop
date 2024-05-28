/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import model.Setting;

/**
 *
 * @author ACER
 */
public class SettingDAO extends DBContext {

    PreparedStatement stm;
    ResultSet rs;

    public List<Setting> getAll() {
        List<Setting> list = new ArrayList<>();
        try {
            String strSelect = "SELECT s.id, type_id, s.name,`order`,"
                    + " status, description, t.name as type FROM setting as s join setting_type as t "
                    + "on type_id = t.id order by s.id";
            stm = connection.prepareStatement(strSelect);
            rs = stm.executeQuery();
            while (rs.next()) {
                Setting setting = new Setting(rs.getInt("id"),
                        rs.getInt("type_id"), rs.getString("type"), rs.getInt("order"), rs.getString("name"),
                        rs.getString("status"), rs.getString("description")
                );
                list.add(setting);
            }
        } catch (SQLException e) {
        }
        return list;
    }

    public Setting getById(int id) {
        SettingDAO s = new SettingDAO();
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
        List<String> types = new ArrayList<>();
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
            String strSelect = "SELECT s.id,type_id,s.name,`order`,"
                    + " status, description,t.name as type FROM setting as s join setting_type as t "
                    + "on type_id = t.id where s.name like ?";
            stm = connection.prepareStatement(strSelect);
            stm.setString(1, "%" + n + "%");
            rs = stm.executeQuery();
            while (rs.next()) {
                Setting setting = new Setting(rs.getInt("id"),
                        rs.getInt("type_id"), rs.getString("type"), rs.getInt("order"), rs.getString("name"),
                        rs.getString("status"), rs.getString("description")
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

    //Lấy id từ tên type
    public int getTypeId(String n) {
        int id = 0;
        try {
            String strSelect = "select id from setting_type where name = ?";
            stm = connection.prepareStatement(strSelect);
            stm.setString(1, n);
            rs = stm.executeQuery();
            while (rs.next()) {
                id = rs.getInt("id");
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return id;
    }

    //Update setting 
    public void updateSetting(int id, Setting s) {
        try {
            String strSelect = "UPDATE setting SET type_id = ?, name = ?, `order` = ?, status = ?, description = ? WHERE id = ?";
            stm = connection.prepareStatement(strSelect);
            stm.setInt(1, s.getTypeId());
            stm.setString(2, s.getName());
            stm.setInt(3, s.getOrder());
            stm.setString(4, s.getStatus());
            stm.setString(5, s.getDescription());
            stm.setInt(6, id);
            stm.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    //active 
    public void active(int id) {
        try {
            String strSelect = "update setting set status = 'Active' where id = ?";
            stm = connection.prepareStatement(strSelect);
            stm.setInt(1, id);
            stm.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void inactive(int id) {
        try {
            String strSelect = "update setting set status = 'Inactive' where id = ?";
            stm = connection.prepareStatement(strSelect);
            stm.setInt(1, id);
            stm.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    //Add new setting
    public void addNew(int typeId, int order, String name, String status, String description) {
        try {
            String strSelect = "insert into setting(type_id,`order`,name,status,description) value (?,?,?,'Pending',?)";
            stm = connection.prepareStatement(strSelect);
            stm.setInt(1, typeId);
            stm.setInt(2, order);
            stm.setString(3, name);
            stm.setString(4, description);
            stm.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public static void main(String[] args) {
        SettingDAO s = new SettingDAO();

//        Setting st = new Setting(1, 1, "SẢn Phẩm cho mèo", 1, "Active", "hehehe");
//        s.updateSetting(3, st);
//        s.updateProductCategory(1, st);
        List<Setting> sList = s.getAll();
        for (Setting stt : sList) {
            System.out.println(stt.getName() + stt.getType());
        }
        System.out.println(s.getTypeId("Product Category"));
    }
}
