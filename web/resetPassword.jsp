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
                <input type="submit" value="Submit" class="btn btn-pill text-white btn-block btn-primary">
            </form>
        </div>
    </div>
</div>
<c:if test="${sessionScope.email != null}">
    <div id="enterreset" class="overlay">
        <div class="popup">
            <div class="form-block">
                <div class="mb-3">
                    <h3><strong>Reset Password</strong></h3>
                    <a class="close" href="#">&times;</a>
                </div>
                <form action="resetpassword" method="post">
                    <div class="form-group last mb-2">
                        <label for="password">Password</label>
                        <input type="password" class="form-control" id="password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" title="Must contain at least one number, one uppercase and lowercase letter, and at least 8 or more characters" name="password" placeholder="Enter password" required="">
                    </div>
                    <div class="form-group last mb-2">
                        <label for="password">Confirm password</label>
                        <input type="password" class="form-control" id="cfpassword" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" title="Must contain at least one number, one uppercase and lowercase letter, and at least 8 or more characters" name="cfpassword" placeholder="Confirm your password" required="">
                    </div>
                    <p class="text-danger mb-2">${sessionScope.alert1}</p>
                    <input type="submit" value="Submit" class="btn btn-pill text-white btn-block btn-primary">
                </form>
            </div>
        </div>
    </div>
</c:if>
