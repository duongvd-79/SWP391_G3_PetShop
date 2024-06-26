<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div id="reset" class="overlay">
    <div class="popup">
        <div class="form-block">
            <div class="mb-3">
                <h3><strong>Reset Password</strong></h3>
                <a class="close" href="#">&times;</a>
            </div>
            <form action="resetpassword" method="get">
                <div class="form-group first">
                    <label for="email">Email</label>
                    <input type="email" class="form-control" id="email" name="email" value="${sessionScope.email}" placeholder="Enter your email" required="">
                </div>
                <p class="text-danger mb-2">${sessionScope.alert}</p>
                <%
                        session.removeAttribute("alert");
                %>
                <input type="submit" value="Submit" class="btn btn-pill text-white btn-block btn-primary">
            </form>
        </div>
    </div>
</div>
<c:if test="${sessionScope.checkemail != null}">
    <div id="enterreset" class="overlay">
        <div class="popup">
            <div class="form-block">
                <div class="mb-3">
                    <h3><strong>Reset Password</strong></h3>
                    <a class="close" href="#">&times;</a>
                </div>
                <form action="resetpassword" method="post">
                    <div class="form-group last mb-2 position-relative">
                        <label for="password">Password</label>
                        <input type="password" class="form-control" id="login-password4" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" title="Must contain at least one number, one uppercase and lowercase letter, and at least 8 or more characters" name="password" placeholder="Enter password" required="">
                        <span id="togglePassword4" class="toggle-password-button"><i class="bi bi-eye"></i></span>
                    </div>
                    <div class="form-group last mb-3 position-relative">
                        <label for="password">Confirm password</label>
                        <input type="password" class="form-control" id="login-password5" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" title="Must contain at least one number, one uppercase and lowercase letter, and at least 8 or more characters" name="cfpassword" placeholder="Confirm your password" required="">
                        <span id="togglePassword5" class="toggle-password-button"><i class="bi bi-eye"></i></span>
                    </div>
                    <p class="text-danger mb-2">${sessionScope.alert1}</p>
                    <%
                        String alert1 = (String) session.getAttribute("alert1");
                        if (alert1 != null && alert1.equals("Password changed success. Please login.")) {
                            session.removeAttribute("checkemail");
                        }
                        session.removeAttribute("alert1"); 
                        
                    %>
                    <input type="submit" value="Submit" class="btn btn-pill text-white btn-block btn-primary">
                </form>
            </div>
        </div>
    </div>
</c:if>
