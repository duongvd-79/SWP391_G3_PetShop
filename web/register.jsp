<%-- 
    Document   : register
    Created on : Jun 14, 2024, 1:35:36 PM
    Author     : ACER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div id="register" class="overlay">
    <div class="popup2">
        <div class="form-block">
            <div class="mb-1">
                <h3><strong>Register</strong></h3>
                <a class="close" href="#">&times;</a>
            </div>
            <form action="register" method="post">
                <div class="form-group first mb-2">
                    <label for="email">Email</label>
                    <input type="email" class="form-control" id="email" name="email" required="" placeholder="Enter email" value="${newuser.getEmail()}">
                </div>
                <div class="form-group last mb-2 position-relative">
                    <label for="password">Password</label>
                    <input type="password" class="form-control" id="login-password2" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" name="password" placeholder="Enter password" required="">
                    <span id="togglePassword2" class="toggle-password-button"><i class="bi bi-eye"></i></span>
                </div>
                <div class="form-group last mb-2 position-relative">
                    <label for="password">Confirm password</label>
                    <input type="password" class="form-control" id="login-password3" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" name="cfpassword" placeholder="Confirm your password" required="">
                    <span id="togglePassword3" class="toggle-password-button"><i class="bi bi-eye"></i></span>
                </div>
                <div class="form-group last mb-2">
                    <label for="fullname">Full Name</label>
                    <input type="text" class="form-control" id="fullname" name="name" required="" placeholder="Enter fullname" value="${newuser.getName()}">
                </div>
                <div class="form-group last mb-1">
                    <label for="phone">Phone</label>
                    <input type="text" class="form-control" pattern="^[0-9]{10}$" title="Phone must contain 10 number" id="phone" name="phone" placeholder="Phone number" required="" value="${newuser.getPhone()}">
                </div>
                <div class="row">
                    <div class="col-4 form-group mt-2 mb-1">
                        <input type="radio" name="gender" id="male" value="Male" checked>
                        <label for="male">
                            Male
                        </label>
                    </div>
                    <div class="col-3 form-group mt-2 mb-0">
                        <input type="radio" name="gender" value="Female" id="female" >
                        <label for="female">
                            Female
                        </label>
                    </div>
                </div>
                <div class="form-group last mb-3">
                    <label for="fullname">Address</label>
                    <div class="d-flex justify-content-start">
                        <div class="mr-3">
                            <select class="form-select form-select-sm mb-3 p-2" name="city" id="city" aria-label=".form-select-sm" required>
                                <option selected>${empty address.getCity() ? 'City' : address.getCity()}</option>
                            </select>
                        </div>
                        <div>
                            <select class="form-select form-select-sm mb-3 p-2" name="district" id="district" aria-label=".form-select-sm" required>
                                <option selected>${empty address.getDistrict() ? 'District' : address.getDistrict()}</option>
                            </select>
                        </div>
                    </div>
                    <input value="${address.getDetail()}" type="text" class="form-control" id="address" name="address" required="" placeholder="Your address">
                </div>
                <input type="submit" value="Sign Up" class="btn btn-pill text-white btn-block btn-primary">
            </form>
            <span class="text-danger">${sessionScope.alert}</span>   
            <div class="social-login text-center mt-2">
                <span>Already had an account? </span>
                <a href="#login"><strong>Sign In</strong></a>
            </div>
        </div>
    </div>
</div>
