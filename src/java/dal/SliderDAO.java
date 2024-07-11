package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Slider;

public class SliderDAO extends DBContext {

    private PreparedStatement stm;
    private ResultSet rs;
    private List<Slider> sliderList;

    private static Slider setSlider(ResultSet rs) {
        Slider sl = new Slider();
        try {
            sl.setId(rs.getInt("id"));
            sl.setTitle(rs.getString("title"));
            sl.setImage(rs.getString("image"));
            sl.setBackLink(rs.getString("back_link"));
            sl.setStatus(rs.getString("status"));
            sl.setDescription(rs.getString("description"));
            sl.setCreatedBy(rs.getInt("created_by"));
            sl.setCreatedDate(rs.getDate("created_date"));
        } catch (SQLException e) {
        }
        return sl;
    }

    public List<Slider> getAll() {
        String sql = "SELECT * FROM slider";
        try {
            sliderList = new ArrayList<>();
            stm = connection.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                Slider sl = setSlider(rs);
                sliderList.add(sl);
            }
            return sliderList;
        } catch (SQLException e) {
        }
        return null;
    }

    public List<Slider> getActive() {
        String sql = "SELECT * FROM slider WHERE status = 'Active'";
        try {
            sliderList = new ArrayList<>();
            stm = connection.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                Slider sl = setSlider(rs);
                sliderList.add(sl);
            }
            return sliderList;
        } catch (SQLException e) {
        }
        return null;
    }

    public static void main(String[] args) {
        SliderDAO s = new SliderDAO();
        List<Slider> list = s.getActive();
        for (Slider ss : list) {
            System.out.println(ss.getTitle());
        }
    }
}
