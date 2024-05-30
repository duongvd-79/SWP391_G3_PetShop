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
                    <li class="nav-item"><a class="nav-link" href="userprofile">User Profile</a></li>
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
                                <label for="email">Email</label>
                                <input type="email" class="form-control" id="email" name="email">
                            </div>
                            <div class="form-group last mb-4">
                                <label for="password">Password</label>
                                <input type="password" class="form-control" id="password" name="password">
                            </div>
                            <div class="d-flex mb-5 align-items-center">
                                <label class="control control--checkbox mb-0"><span class="caption">Remember me</span>
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
            <div id="registerpopup" class="overlay">
                <div class="popup">
                    <div class="form-block">
                        <div class="mb-4">
                            <h3>Register</h3>
                            <a class="close" href="#">&times;</a>
                        </div>
                        <form action="register" method="post">
                            <div class="form-group first">
                                <label for="email">Email</label>
                                <input type="email" class="form-control" id="email" name="email">
                            </div>
                            <div class="form-group last mb-4">
                                <label for="password">Password</label>
                                <input type="password" class="form-control" id="password" name="password">
                            </div>
                            <input type="submit" value="Sign Up" class="btn btn-pill text-white btn-block btn-primary">
                            <div class="social-login text-center mt-2">
                                <span>Already had an account? </span>
                                <a href="#loginpopup"><strong>Sign Up</strong></a>
                            </div>
                        </form>
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
                    <li class="search"><a href="#"><i class="bi bi-search"></i></a></li>
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

    .popup {
        margin: 150px auto;
        padding: 30px 40px;
        background: #fff;
        border-radius: 5px;
        width: 30%;
        position: relative;
        transition: all 5s ease-in-out;
    }
    .popup .close {
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