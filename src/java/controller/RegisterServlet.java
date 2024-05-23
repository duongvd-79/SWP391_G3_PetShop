package controller;


import dal.settingDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import model.User;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {
   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet RegisterServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RegisterServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
throws ServletException, IOException {
    String name = request.getParameter("name");
    String pass = request.getParameter("pass");
    String repass = request.getParameter("repass");
    String email = request.getParameter("email");

    if (!pass.equals(repass)) {
        request.setAttribute("error", "Password does not match!");
        request.getRequestDispatcher("register.jsp").forward(request, response);
    } else {
        settingDAO dao = new settingDAO();
        User existingAccount = dao.checkUserExist(name);
        if (existingAccount == null) {               
            dao.signup(name, helper.MD5.getMD5(pass), email);
            request.setAttribute("success", "Account created successfully!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } else {
            request.setAttribute("error1", "Username already exists!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    } 
}
}
