package filter;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class AuthFilter implements Filter {
    public void init(FilterConfig config) throws ServletException {}

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        // Check if the user is trying to access a JSP directly
//        String uri = req.getRequestURI();
//        if (uri.endsWith(".jsp")) {
//            res.sendRedirect("404.html");
//            return;
//        }

        chain.doFilter(request, response);
    }

    public void destroy() {}
}