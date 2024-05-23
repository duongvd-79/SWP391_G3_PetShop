package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.User;

public class UserDAO extends DBContext {

    private PreparedStatement stm;
    private ResultSet rs;
    private List<User> userList = new ArrayList<>();

}
