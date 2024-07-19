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

    public List<Slider> getSliders(String search) {
        String sql = "SELECT * FROM slider WHERE title like ?";
        try {
            sliderList = new ArrayList<>();
            stm = connection.prepareStatement(sql);
            stm.setString(1, "%" + search + "%");
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

    public Slider getSliderById(int id) {
        String sql = "SELECT * FROM slider WHERE id = ?";
        try {
            stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            rs = stm.executeQuery();
            while (rs.next()) {
                Slider sl = setSlider(rs);
                return sl;
            }
            return null;
        } catch (SQLException e) {
        }
        return null;
    }

    public void updateSlider(int id, String title, String thumbnail, String detail, String status, String back_link) {
        try {
            String sql = "UPDATE slider SET title = ?,image = ?,description = ?,status = ?,back_link = ? WHERE id = ?";
            stm = connection.prepareStatement(sql);
            stm.setString(1, title);
            stm.setString(2, thumbnail);
            stm.setString(3, detail);
            stm.setString(4, status);
            stm.setString(5, back_link);
            stm.setInt(6, id);
            stm.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public static void main(String[] args) {
        SliderDAO s = new SliderDAO();
        List<Slider> list = s.getActive();
        for (Slider ss : list) {
            System.out.println(ss.getTitle());
        }
    }
}
