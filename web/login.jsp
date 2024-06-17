<%-- 
    Document   : login
    Created on : Jun 14, 2024, 1:36:56 PM
    Author     : ACER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div id="login" class="overlay">
    <div class="popup">
        <div class="form-block">
            <div class="mb-4">
                <h3>Sign In to <strong>PetShop</strong></h3>
                <a class="close" id="login-close" href="#">&times;</a>
            </div>
            <form action="login" method="post">
                <div class="form-group first">
                    <p class="text-danger">${sessionScope.error}</p>
                    <%
                        session.removeAttribute("error");
                    %>
                    <label for="email">Email</label>
                    <input type="email" class="form-control" id="email" name="email" value="${sessionScope.username}">
                </div>
                <div class="form-group last mb-1 position-relative">
                    <label for="password">Password</label>
                    <input type="password" class="form-control" id="login-password" name="password">
                    <span id="togglePassword"><i class="bi bi-eye"></i></span>
                </div>
                <div class="d-flex mb-4 align-items-center">
                    <!--Reset password-->
                    <span class="ml-auto"><a href="#reset" class="forgot-pass">Reset Password</a></span>
                </div>
                <input type="submit" value="Log In" class="btn btn-pill text-white btn-block btn-primary">
            </form>
            <div class="social-login text-center mt-2">
                <a href="#register">or <strong>Sign Up</strong></a>
            </div>
        </div>
    </div>
</div>
