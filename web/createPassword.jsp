<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<div id="createPassword" class="overlay">
    <div class="popup">
        <div class="form-block">
            <div class="mb-3">
                <h3><strong>Create Password</strong></h3>
                <a class="close" href="#">&times;</a>
            </div>
            <form action="createpassword" method="post">
                <div class="form-group last mb-2 position-relative">
                    <label for="password"><strong>Password</strong> <span class="text-danger">(*)</span></label>
                    <input type="text" class="form-control" id="createPassword1" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" 
                           title="Must contain at least one number, one uppercase and lowercase letter, and at least 8 or more characters" 
                           name="password" placeholder="Enter password" required>
                    <span id="toggleCreate1" class="toggle-password-button"><i class="bi bi-eye"></i></span>
                </div>
                <div class="form-group last mb-3 position-relative">
                    <label for="password"><strong>Confirm password</strong> <span class="text-danger">(*)</span></label>
                    <input type="password" class="form-control" id="createPassword2" name="cfpassword" placeholder="Confirm your password" required>
                    <span id="toggleCreate2" class="toggle-password-button"><i class="bi bi-eye"></i></span>
                </div>
                <p class="text-danger mb-2">${sessionScope.alert}</p>
                <%
                    request.getSession().removeAttribute("alert"); 
                %>
                <input name="id" value="${applicationScope.id}" hidden/>
                <input type="submit" value="Submit" class="btn btn-pill text-white btn-block btn-primary">
            </form>
        </div>
    </div>
</div>
