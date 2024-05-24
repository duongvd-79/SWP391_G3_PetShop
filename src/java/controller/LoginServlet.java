package controller;

import dal.DBContext;
import dal.UserDAO;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import helper.MD5; // Đảm bảo bạn có lớp MD5 để mã hóa mật khẩu

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet LoginServlet</title>");
            out.println("</head>");
            out.println("<body>");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String pass = request.getParameter("pass");
        String remember = request.getParameter("remember");

        DBContext dbContext = new DBContext();
        UserDAO d = new UserDAO();
        User a = d.login(name, MD5.getMD5(pass)); // Sử dụng phương thức mã hóa MD5 của bạn

        if (a == null) {
            request.setAttribute("error", "Username or password does not exist!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            HttpSession session = request.getSession();
            session.setAttribute("userid", a.getId());
            session.setAttribute("account", a);
            Cookie cuser = new Cookie("user", name);
            Cookie cpass = new Cookie("pass", pass);
            Cookie cremember = new Cookie("remember", remember);
            if (remember == null) {
                cuser.setMaxAge(0);
                cpass.setMaxAge(0);
                cremember.setMaxAge(0);
            } else {
                cuser.setMaxAge(86400 * 365);
                cpass.setMaxAge(86400 * 365);
                cremember.setMaxAge(86400 * 365);
            }
            response.addCookie(cuser);
            response.addCookie(cpass);
            response.addCookie(cremember);
            response.sendRedirect("home.jsp");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
