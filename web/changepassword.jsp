<%-- 
    Document   : changepassword
    Created on : Jun 13, 2024, 11:16:17 PM
    Author     : ACER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div id="changepassword" class="overlay">
    <div class="popup">
        <div class="form-block">
            <div class="mb-4">
                <h2>Change Password</h2>
                <a class="close" href="#">&times;</a>
            </div>
            
            <form action="changepassword" method="post">
                <div class="form-group first mb-1 position-relative">
                    <label for="password">Old Password</label>
                    <input type="password" name="oldpassword" id="login-password6" 
                           class="form-control" required="">
                    <span id="togglePassword6" class="toggle-password-button"><i class="bi bi-eye"></i></span>
                </div>
                <div class="form-group last mb-1 position-relative">
                    <label for="password">New Password</label>
                    <input type="password" name="newpassword" id="login-password7" 
                           pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" 
                           title="Must contain at least one number, one uppercase and lowercase letter, and at least 8 or more characters"  
                           class="form-control" required="">
                    <span id="togglePassword7" class="toggle-password-button"><i class="bi bi-eye"></i></span>
                </div>
                <div class="form-group last mb-3 position-relative">
                    <label for="password">Confirm New Password</label>
                    <input type="password" name="cfnewpassword" id="login-password8" 
                           pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" 
                           title="Must contain at least one number, one uppercase and lowercase letter, and at least 8 or more characters" 
                           class="form-control" required="">
                    <span id="togglePassword8" class="toggle-password-button"><i class="bi bi-eye"></i></span>
                </div>
                <div class="mb-3 text-danger">${sessionScope.alert}</div> 
                <%
                        session.removeAttribute("alert");
                %>
                <input type="submit" value="Save" class="btn btn-pill text-white btn-block btn-primary">
            </form>
        </div>
    </div>
</div>
