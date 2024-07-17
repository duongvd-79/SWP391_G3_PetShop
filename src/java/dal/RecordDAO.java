package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import model.User;
import model.Record;

public class RecordDAO extends DBContext {

    private PreparedStatement stm;
    private ResultSet rs;
    private Map<User, List<Record>> recordData;

    private static Record setRecord(ResultSet rs) {
        Record r = new Record();
        try {
            r.setId(rs.getInt("id"));
            r.setUpdatedBy(rs.getInt("updated_by"));
            r.setUpdatedDate(rs.getTimestamp("updated_date"));
            r.setDescription(rs.getString("description"));
            r.setUserId(rs.getInt("user_id"));
        } catch (SQLException e) {
        }
        return r;
    }

    public Map<User, List<Record>> getAll() {
        String sql = "SELECT * FROM petshop.update_record";
        try {
            recordData = new TreeMap<>(Comparator.comparing(User::getId));
            stm = connection.prepareStatement(sql);
            rs = stm.executeQuery();
            UserDAO udao = new UserDAO();
            while (rs.next()) {
                Record r = setRecord(rs);
                User user = udao.getUserByID(rs.getInt("user_id"));
                if (recordData.containsKey(user)) {
                    recordData.get(user).add(r);
                    Collections.sort(recordData.get(user), (r1, r2) -> Integer.compare(r1.getId(), r2.getId()));
                } else {
                    List<Record> list = new ArrayList<>();
                    list.add(r);
                    Collections.sort(list, (r1, r2) -> Integer.compare(r1.getId(), r2.getId()));
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
            recordData = new TreeMap<>(Comparator.comparing(User::getId));
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

    public void addNewRecord(int updatedBy, String description, int userId) {
        String sql = "INSERT INTO update_record (updated_by, updated_date, description, user_id)"
                + "values (?, ?, ?, ?)";
        try {
            stm = connection.prepareStatement(sql);
            stm.setInt(1, updatedBy);
            stm.setTimestamp(2, new Timestamp(new Date().getTime()));
            stm.setString(3, description);
            stm.setInt(4, userId);
            stm.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    public static void main(String[] args) {
        RecordDAO rdao = new RecordDAO();
        Map<User, List<Record>> map = rdao.getAll();
        map.forEach((key, value) -> {
            for (Record r : value) {
                System.out.println(r.getId());
            }
        });
    }
}
