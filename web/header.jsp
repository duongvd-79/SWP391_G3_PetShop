<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="model.User"%>
<!-- Start Main Top -->
<header class="main-header">
    <!-- Start Navigation -->
    <nav class="shadow navbar navbar-expand-lg navbar-light bg-light navbar-default bootsnav">
        <div class="container">
            <!-- Start Header Navigation -->
            <div class="navbar-header">
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar-menu" aria-controls="navbars-rs-food" aria-expanded="false" aria-label="Toggle navigation">
                    <i class="bi bi-list"></i>
                </button>
                <a class="navbar-brand" href="home"><img src="images/logo.png" class="logo" alt=""></a>
            </div>
            <!-- End Header Navigation -->

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="navbar-menu">
                <ul class="nav navbar-nav ml-auto" data-in="fadeInDown" data-out="fadeOutUp">
                    <li class="nav-item active"><a class="nav-link" href="home">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="#about">About</a></li>
                    <li class="nav-item"><a class="nav-link" href="productlist">Product</a></li>
                    <li class="nav-item"><a class="nav-link" href="bloglist">Blog</a></li>
                        <%
                            User user = (User) session.getAttribute("user");
                            if (user == null) {
                        %>
                    <li class="dropdown">
                        <a href="" class="nav-link dropdown-toggle arrow bi bi-caret-down-fill" data-toggle="dropdown">Account <i class="bi bi-caret-down-fill"></i></a>
                        <ul class="dropdown-menu">
                            <li><a href="#loginpopup">Login</a></li>
                            <li><a href="#registerpopup">Register</a></li>
                        </ul>
                    </li>
                    <%} else {%>
                    <!--<li class="nav-item"><a class="nav-link" href="userprofile">${user.name}</a></li>-->
                    <li class="dropdown">
                        <a class="nav-link dropdown-toggle arrow bi bi-caret-down-fill" data-toggle="dropdown">${user.name}</a>
                        <ul class="dropdown-menu">
                            <li><a class="nav-link" href="userprofile">User Profile</a></li>
                            <li><a class="text-danger" href="login?logout=true">Logout</a></li>
                        </ul>
                    </li>
                    <%}%>
            </div>
            <!-- /.navbar-collapse -->

            <%
                if (user == null) {
            %>
            <!-- Login Popup -->
            <div id="loginpopup" class="overlay">
                <div class="popup">
                    <div class="form-block">
                        <div class="mb-4">
                            <h3>Sign In to <strong>PetShop</strong></h3>
                            <a class="close" href="#">&times;</a>
                        </div>
                        <form action="login" method="post">
                            <div class="form-group first">
                                <p class="text-danger">${sessionScope.error}</p>
                                <label for="email">Email</label>
                                <input type="email" class="form-control" id="email" name="email">
                            </div>
                            <div class="form-group last mb-4">
                                <label for="password">Password</label>
                                <input type="password" class="form-control" id="password" name="password">
                            </div>
                            <div class="d-flex mb-5 align-items-center">
                                <label class="control control--checkbox mb-0">
                                    <span class="caption">Remember me</span>
                                    <input type="checkbox" checked="checked">
                                    <div class="control__indicator"></div>
                                </label>
                                <!--Reset password-->
                                <span class="ml-auto"><a href="#" class="forgot-pass">Forgot Password</a></span>
                            </div>
                            <input type="submit" value="Log In" class="btn btn-pill text-white btn-block btn-primary">
                            <div class="social-login text-center mt-2">
                                <a href="#registerpopup">or <strong>Sign Up</strong></a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Register Popup -->
            <div id="registerpopup" class="overlay container-fluid">
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
                            <div class="form-group last mb-2">
                                <label for="password">Password</label>
                                <input type="password" class="form-control" id="password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" name="password" placeholder="Enter password" required="">
                            </div>
                            <div class="form-group last mb-2">
                                <label for="password">Confirm password</label>
                                <input type="password" class="form-control" id="cfpassword" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" name="cfpassword" placeholder="Confirm your password" required="">
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
                                <div class="col-3 form-group mt-2 mb-0">
                                    <input type="radio" name="gender" id="male" checked >
                                    <label for="male">
                                        Male
                                    </label>
                                </div>
                                <div class="col-3 form-group mt-2 mb-0">
                                    <input type="radio" name="gender" id="female" >
                                    <label for="female">
                                        Female
                                    </label>
                                </div>
                            </div>
                            <div class="form-group last mb-3">
                                <label for="fullname">Address</label>
                                <div class="d-flex justify-content-start">
                                    <div class="mr-3">
                                        <select class="form-select form-select-sm mb-3 p-2" name="city" id="city" aria-label=".form-select-sm">
                                            <option value="${address.getCity()}" selected>City</option>
                                        </select>
                                    </div>
                                    <div>
                                        <select class="form-select form-select-sm mb-3 p-2" name="district" id="district" aria-label=".form-select-sm" >
                                            <option value="${address.getDistrict()}" selected>District</option>
                                        </select>
                                    </div>
                                </div>
                                <input value="${address.getDetail()}" type="text" class="form-control" id="address" name="address" required="" placeholder="Your address">
                            </div>
                            <span class="text-danger">${sessionScope.alert}<span>
                                    <input type="submit" value="Sign Up" class="btn btn-pill text-white btn-block btn-primary">
                                    <div class="social-login text-center mt-2">
                                        <span>Already had an account? </span>
                                        <a href="#loginpopup"><strong>Sign In</strong></a>
                                    </div>

                                    </form>
                                    </div>
                                    </div>
                                    </div>
                            <%-- verify email popup --%>
                            <div id="verifypopup" class="overlay">
                        <div class="popup">
                            <h2 class="ms-3 mb-3">Announce</h2>
                            <a class="close" href="#">&times;</a>
                            <div class="content container-fluid">
                                <h3>Check your register email for verification!</h3>
                            </div>
                        </div>
                    </div>
                                    <%}%>

                                    <!-- Start Atribute Navigation -->
                                    <%
                                        if (user != null) {
                                    %>
                                    <div class="attr-nav">
                                        <ul>
                                            <li class="side-menu">
                                                <a href="#">
                                                    <i class="bi bi-basket3"></i>
                                                    <span class="badge">${requestScope.cart.size()}</span>
                                                    <p>My Cart</p>
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                    <%}%>
                                    <!-- End Atribute Navigation -->
                                    </div>
                                    </nav>

                                    <!-- End Navigation -->
                                    </header>
                                    <!-- End Main Top -->
                                    <!-- dữ liệu địa chỉ -->
                                    <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.21.1/axios.min.js"></script>
                                    <script>
                                        var cities = document.getElementById("city");
                                        var districts = document.getElementById("district");

                                        var Parameter = {
                                            url: "js/data.json",
                                            method: "GET",
                                            responseType: "application/json",
                                        };

                                        var promise = axios(Parameter);
                                        promise.then(function (result) {
                                            renderCity(result.data);
                                        });

                                        function renderCity(data) {
                                            for (const city of data) {
                                                cities.options[cities.options.length] = new Option(city.Name);
                                            }

                                            cities.onchange = function () {
                                                districts.length = 1;

                                                if (this.value !== "") {
                                                    const selectedCity = data.find(city => city.Name === this.value);

                                                    for (const district of selectedCity.Districts) {
                                                        districts.options[districts.options.length] = new Option(district.Name);
                                                    }
                                                }
                                            };
                                        }
                                    </script>
                                    <style>
                                        .overlay {
                                            position: fixed;
                                            top: 0;
                                            bottom: 0;
                                            left: 0;
                                            right: 0;
                                            background: rgba(0, 0, 0, 0.7);
                                            transition: opacity 500ms;
                                            visibility: hidden;
                                            opacity: 0;
                                        }
                                        .overlay:target {
                                            visibility: visible;
                                            opacity: 1;
                                        }
                                        .popup,.popup2{
                                            margin: 150px auto;
                                            padding: 30px 40px;
                                            background: #fff;
                                            border-radius: 5px;
                                            width: 40%;
                                            position: relative;
                                            transition: all 5s ease-in-out;
                                        }
                                        .popup2{
                                            margin: 2vh auto;
                                        }
                                        .close {
                                            position: absolute;
                                            top: 20px;
                                            right: 30px;
                                            transition: all 200ms;
                                            font-size: 30px;
                                            font-weight: bold;
                                            text-decoration: none;
                                            color: #333;
                                        }
                                        .popup .close:hover {
                                            color: #06D85F;
                                        }
                                        .popup .content {
                                            max-height: 30%;
                                            overflow: auto;
                                        }

                                    </style>