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

    //Lấy theo phân trang
    public List<Setting> getByPage(List<Setting> list, int page) {
        List<Setting> outputlist = new ArrayList<>();
        for (int i = (page - 1) * 3; i <= (page - 1) * 3 + 2; i++) {
            if(i>=list.size()) return outputlist;
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
