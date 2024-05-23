<%-- 
    Document   : login
    Created on : Feb 24, 2022, 1:37:57 PM
    Author     : huanv
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
    <head>
        <link rel="icon" href="image/101512512_p0_master1200.jpg">
        <title>Login</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <link href="https://fonts.googleapis.com/css?family=Lato:300,400,700&display=swap" rel="stylesheet">

        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

        <link rel="stylesheet" href="css/login.css">

    </head>
    <body style="background-color: black">
        <section class="ftco-section">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-md-6 text-center mb-5">
                        <h2 style='color: white' class="heading-section">Login</h2>
                    </div>
                </div>
                <div class="row justify-content-center">
                    <div class="col-md-7 col-lg-5">
                        <div class="wrap">
                            <!--<div class="img" style="background-image: url(https://preview.redd.it/nu9vyciul7081.jpg?width=640&crop=smart&auto=webp&s=1fa9321628cb05c5d33c6492d931ce5ef4ee2ecf)"></div>-->
                            <div class="login-wrap p-4 p-md-5">
                                <div class="d-flex">
                                    <div class="w-100">
                                        <h3 class="mb-4 text-center">Sign In</h3>
                                    </div>
                                </div>
                                <form action="login" method="post" class="signin-form">
                                    <p class="text-danger">${requestScope.error}</p>
                                    <div class="form-group mt-3">
                                        <input name="user" type="text" class="form-control" required value="${cookie.user.value}">
                                        <label class="form-control-placeholder" for="username">Username</label>
                                    </div>
                                    <div class="form-group">
                                        <input name="pass" id="password-field" type="password" class="form-control" required value="${cookie.pass.value}">
                                        <label class="form-control-placeholder" for="password">Password</label>

                                    </div>
                                    <div class="form-group">
                                        <button type="submit" class="form-control btn btn-primary rounded submit px-3">Sign In</button>
                                    </div>
                                    <div class="form-group d-md-flex">
                                        <div class="w-50 text-left">
                                            <label class="checkbox-wrap checkbox-primary mb-0">Remember Me
                                                <input name="remember" ${(cookie.remember.value eq 'on')? "checked" : ""} type="checkbox" value="on">
                                                <span class="checkmark"></span>
                                            </label>
                                        </div>
                                        <div class="w-50 text-md-right">
                                        </div>
                                    </div>
                                </form>
                                <p class="text-center">Don't have an account? <a href="register.jsp">Sign Up</a></p>
                                <p class="text-center"> <a href="forgot.jsp">Forgot password?</a></p>
                            </div>
                            <div class="col-md-10 col-lg-6 col-xl-7 d-flex align-items-center order-1 order-lg-2">
                                <img src="image/68478341_p0_master1200.jpg" class="img-fluid rounded">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <script src="js/jquery.min.js"></script>
        <script src="js/popper.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/main.js"></script>

    </body>
</html>


