<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
    <head>
        <link rel="icon" href="image/101512512_p0_master1200.jpg">
        <title>Sign up</title>
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
                        <h2 style='color: white' class="heading-section">Sign up</h2>
                    </div>
                </div>
                <div class="row justify-content-center">
                    <div class="col-md-7 col-lg-5">
                        <div class="wrap">
                            <div class="login-wrap p-4 p-md-5">
                                <div class="d-flex">
                                    <div class="w-100">
                                        <h3 class="mb-4 text-center">Sign up</h3>
                                    </div>
                                </div>
                                <form action="register" method="post" class="signin-form">
                                    <c:if test="${not empty requestScope.success}">
                                        <p class="text-success">${requestScope.success}</p>
                                    </c:if>
                                    <c:if test="${not empty requestScope.error}">
                                        <p class="text-danger">${requestScope.error}</p>
                                    </c:if>
                                    <c:if test="${not empty requestScope.error1}">
                                        <p class="text-danger">${requestScope.error1}</p>
                                    </c:if>
                                    <div class="form-group mt-3">
                                        <input name="name" type="text" class="form-control" required>
                                        <label class="form-control-placeholder" for="name">Username</label>
                                    </div>
                                    <div class="form-group">
                                        <input name="pass" id="password-field" type="password" class="form-control" required>
                                        <label class="form-control-placeholder" for="password">Password</label>
                                    </div>
                                    <div class="form-group">
                                        <input name="repass" id="password-field" type="password" class="form-control" required>
                                        <label class="form-control-placeholder" for="password">Confirm Password</label>
                                    </div>
                                    <div class="form-group">
                                        <input name="email" id="email-field" type="email" class="form-control" required>
                                        <label class="form-control-placeholder" for="email">Email</label>
                                    </div>
                                    <div class="form-group">
                                        <button type="submit" class="form-control btn btn-primary rounded submit px-3">Sign Up</button>
                                    </div>
                                    <div class="form-group d-md-flex">
                                        <div class="w-50 text-left"></div>
                                        <div class="w-50 text-md-right"></div>
                                    </div>
                                </form>
                                <p class="text-center">Already have an account? <a href="login.jsp">Login</a></p>
                                <p class="text-center"><a href="forgot.jsp">Forgot password?</a></p>
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
