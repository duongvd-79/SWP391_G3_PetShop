package dal;

import java.sql.Timestamp;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
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
            String pfp = rs.getString("pfp");
            User u = new User(id, email, pass, name, status, phone, pfp, role_id, gender, lastlog);
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
            String pfp = rs.getString("pfp");
            User u = new User(id, email, pass, fullname, status, phone, pfp, role_id, gender, lastlog);
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
            String pfp = rs.getString("pfp");
            User u = new User(id, email, pass, fullname, status, phone, pfp, role_id, gender, lastlog);
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
            String pfp = rs.getString("pfp");
            User u = new User(id, email, pass, fullname, status, phone, pfp, role_id, gender, lastlog);
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
            String pfp = rs.getString("pfp");
            User u = new User(id, email, pass, fullname, status, phone, pfp, role_id, gender, lastlog);
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
            String pfp = rs.getString("pfp");
            User u = new User(id, email, pass, fullname, status, phone, pfp, role_id, gender, lastlog);
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
            String pfp = rs.getString("pfp");
            User u = new User(id, email, pass, fullname, status, phone, pfp, role_id, gender, lastlog);
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
            String pfp = rs.getString("pfp");
            User u = new User(id, email, pass, fullname, status, phone, pfp, role_id, gender, lastlog);
            lst.add(u);
        }
        return lst;
    }

    public void updateUser(int roleId, String status, int id) {
        try {
            String sql = "UPDATE user SET role_id = ?,status = ? WHERE id = ?";
            PreparedStatement stm;
            stm = connection.prepareStatement(sql);
            stm.setInt(1, roleId);
            stm.setString(2, status);
            stm.setInt(3, id);
            stm.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void changePassword(String email, String password) {
        try {
            String sql = "UPDATE user SET password = MD5(?) WHERE email = ?";
            PreparedStatement stm;
            stm = connection.prepareStatement(sql);
            stm.setString(1, password);
            stm.setString(2, email);
            stm.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void addNewUser(User u) throws SQLException {
        String sql = "insert into user(email,password,name,gender,status,role_id,phone,create_date) values (?,MD5(?),?,?,?,?,?,NOW())";
        PreparedStatement sta = connection.prepareStatement(sql);
        sta.setString(1, u.getEmail());
        sta.setString(2, u.getPassword());
        sta.setString(3, u.getName());
        sta.setBoolean(4, (u.getGender().equals("Male")));
        sta.setString(5, "Active");
        sta.setInt(6, u.getRoleId());
        sta.setString(7, u.getPhone());
        sta.executeUpdate();
    }

    public int getLastId() throws SQLException {
        String sql = "SELECT * from user ORDER BY id DESC LIMIT 1";
        PreparedStatement sta = connection.prepareStatement(sql);
        ResultSet rs = sta.executeQuery();
        int id = 0;
        while (rs.next()) {
            id = rs.getInt("id");
        }
        return id;
    }

    public User login(String email, String password) {
        String sql = "SELECT * FROM user WHERE email = ? AND password = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, email);
            stm.setString(2, password);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setName(rs.getString("name"));
                user.setStatus(rs.getString("status"));
                user.setPhone(rs.getString("phone"));
                user.setPfp(rs.getString("pfp"));
                user.setRoleId(rs.getInt("role_id"));
                user.setGender(rs.getBoolean("gender"));
                user.setCreateDate(rs.getDate("create_date"));

                // Set last login time
                Date currentDate = new Date();
                user.setLastLog(currentDate);

                // Update last login time in database
                sql = "UPDATE user SET last_log = ? WHERE id = ?";
                stm = connection.prepareStatement(sql);
                stm.setTimestamp(1, new Timestamp(currentDate.getTime()));
                stm.setInt(2, user.getId());
                stm.executeUpdate();

                return user;
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    public void updateUserProfile(User user) {
        String sql = "UPDATE user SET name = ?, gender = ?, phone = ?, pfp = ? WHERE id = ?";
        try {
            PreparedStatement stm;
            stm = connection.prepareStatement(sql);
            stm.setString(1, user.getName());
            stm.setBoolean(2, user.getGender().equals("Male"));
            stm.setString(3, user.getPhone());
            stm.setString(4, user.getPfp());
            stm.setInt(5, user.getId());
            stm.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public int getCountCustomer() {
        String sql = "SELECT COUNT(*) as count FROM user where role_id = 5";
        try {
            PreparedStatement sta = connection.prepareStatement(sql);
            ResultSet rs = sta.executeQuery();
            if (rs.next()) {
                return rs.getInt("count");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int getCountCustomer(String start, String end) {
        String sql = "SELECT COUNT(*) as count FROM user where role_id = 5 and create_date between '" + start + "' and '" + end + "'";
        try {
            PreparedStatement sta = connection.prepareStatement(sql);
            ResultSet rs = sta.executeQuery();
            if (rs.next()) {
                return rs.getInt("count");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public ArrayList<User> getTop4NewCutomers() throws SQLException {
        String sql = "SELECT * FROM user where role_id=5 ORDER BY create_date DESC LIMIT 4 ";
        try (PreparedStatement sta = connection.prepareStatement(sql); ResultSet rs = sta.executeQuery()) {
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
                String pfp = rs.getString("pfp");
                User u = new User(id, email, pass, name, status, phone, pfp, role_id, gender, lastlog);
                lst.add(u);
            }
            return lst;
        }
    }

    public ArrayList<User> getTop4NewlyBuyCutomers() throws SQLException {
        String sql = "SELECT u.*\n"
                + "FROM user u\n"
                + "JOIN (\n"
                + "    SELECT customer_id, MAX(ordered_date) AS latest_order_date\n"
                + "    FROM `order`\n"
                + "    GROUP BY customer_id\n"
                + ") o ON u.id = o.customer_id\n"
                + "ORDER BY o.latest_order_date DESC\n"
                + "LIMIT 4;";
        try (PreparedStatement sta = connection.prepareStatement(sql); ResultSet rs = sta.executeQuery()) {
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
                String pfp = rs.getString("pfp");
                User u = new User(id, email, pass, name, status, phone, pfp, role_id, gender, lastlog);
                lst.add(u);
            }
            return lst;
        }

    }

    public User getUserByID(int uid) throws SQLException {
        String sql = "select * from user where id = ?";
        PreparedStatement sta = connection.prepareStatement(sql);
        sta.setInt(1, uid);
        ResultSet rs = sta.executeQuery();
        User u = new User();
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
            String pfp = rs.getString("pfp");
            u = new User(id, email, pass, name, status, phone, pfp, role_id, gender, lastlog);
        }
        return u;
    }
    public String getRoleStatus(int id) {
        String sql = "SELECT s.status as status FROM user as u join setting as s"
                + " on s.id=u.role_id where u.id = ?";
        try {
            PreparedStatement sta = connection.prepareStatement(sql);
            sta.setInt(1, id);
            ResultSet rs = sta.executeQuery();
            if (rs.next()) {
                return rs.getString("status");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static void main(String[] args) throws SQLException {
        UserDAO u = new UserDAO();
//        for(User s : u.getAllUser()){
//            System.out.println(s.getId() + s.getPfp());
//        }
//        u.addNewUser(new User("hoang@gmail.com","conbuonxing","taivisao","Pending","6677028",null,true,1));
//        u.changePassword("hoangdz512@gmail.com","123456" );
        for (User user : u.getTop4NewlyBuyCutomers()) {
            System.out.println(user.getName());
        }

    }
}
