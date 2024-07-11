package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.User;
import model.Record;

public class RecordDAO extends DBContext {

    private PreparedStatement stm;
    private ResultSet rs;
    private Map<User, List<Record>> recordData = new HashMap<>();

    private static Record setRecord(ResultSet rs) {
        Record r = new Record();
        try {
            r.setId(rs.getInt("id"));
            r.setUpdatedBy(rs.getInt("updated_by"));
            r.setUpdatedDate(rs.getDate("updated_date"));
            r.setDescription(rs.getString("description"));
            r.setUserId(rs.getInt("user_id"));
        } catch (SQLException e) {
        }
        return r;
    }

    public Map<User, List<Record>> getAll() {
        String sql = "SELECT * FROM petshop.update_record";
        try {
            recordData = new HashMap<>();
            stm = connection.prepareStatement(sql);
            rs = stm.executeQuery();
            UserDAO udao = new UserDAO();
            while (rs.next()) {
                Record r = setRecord(rs);
                User user = udao.getUserByID(rs.getInt("user_id"));
                if (recordData.containsKey(user)) {
                    recordData.get(user).add(r);
                } else {
                    List<Record> list = new ArrayList<>();
                    list.add(r);
                    recordData.put(user, list);
                }
            }
            return recordData;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    public Map<User, List<Record>> getByUser(int userId) {
        String sql = "SELECT * FROM petshop.record where user_id = ?";
        try {
            recordData = new HashMap<>();
            stm = connection.prepareStatement(sql);
            stm.setInt(1, userId);
            rs = stm.executeQuery();
            UserDAO udao = new UserDAO();
            List<Record> list = new ArrayList<>();
            while (rs.next()) {
                Record r = setRecord(rs);
                list.add(r);
            }
            recordData.put(udao.getUserByID(userId), list);
            return recordData;
        } catch (SQLException e) {
        }
        return null;
    }

    public static void main(String[] args) {
        RecordDAO rdao = new RecordDAO();
        Map<User, List<Record>> map = rdao.getAll();
        map.forEach((key, value) -> {
            for (Record r : value) {
                System.out.println(r.getDescription());
            }
        });
    }
}
