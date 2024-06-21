1
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="model.User"%>
<!DOCTYPE html>
<html>
    <head>
        <meta content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>PetShop Home Page</title>

        <link rel="shortcut icon" href="images/icon.ico" type="image/x-icon">
        <link rel="apple-touch-icon" href="images/apple-touch-icon.png">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <!-- Site CSS -->
        <link rel="stylesheet" href="css/style.css">
        <!-- Responsive CSS -->
        <link rel="stylesheet" href="css/responsive.css">
        <!-- Custom CSS -->
        <link rel="stylesheet" href="css/custom.css">
        <style>
            .ellipsis-text {
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
                max-width: 100%; /* Adjust this value to limit the width as needed */
            }
        </style>
    </head>
    <body>
        <!-- Start Main Top -->
        <!-- End Main Top -->

        <!-- Start Main Top -->
        <jsp:include page="header.jsp"></jsp:include>
        <!-- End Main Top -->

        <!-- Start Top Search -->
        <div class="top-search">
            <div class="container">
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-search"></i></span>
                    <input type="text" class="form-control" placeholder="Search">
                    <span class="input-group-addon close-search"><i class="fa fa-times"></i></span>
                </div>
            </div>
        </div>


        <!-- End Top Search -->
        <div class="blog-detail-wrapper">
            <div class="container-fluid">
                <div class="row justify-content-center"> 
                    <div class="col-md-8 col-sm-12 col-xs-12 text-center">
                        <div class="blog-detail-main">
                            <h1 style="font-weight: bold ; text-align: left ; font-size: 50px ; margin-top: 30px; margin-bottom: 20px">${postdetail.title}</h1>
                            <div class="blog-image">
                                <img class="blog-image-feature" src="${postdetail.thumbnail}" alt="">
                            </div>
                            <div class="blog-meta d-flex justify-content-center">
                                <p class="blog-date">
                                    <i class="fa fa-calendar"></i> ${postdetail.createdDate}
                                </p>
                                <p class="blog-author">
                                    <i class="fa fa-user"></i> ${postdetail.user.name}
                                </p>
                            </div>
                            <div class="blog-content" id="detail-blog">
                                <p>${postdetail.detail}</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Start Footer  -->
        <jsp:include page="footer.jsp"></jsp:include>
        <!-- End Footer  -->

        <!-- Start copyright  -->
        <div class="footer-copyright">
            <p class="footer-company">&copy; 2024 - Bản quyền thuộc về <a href="#">PetShop</a>
        </div>
        <!-- End copyright  -->

        <a href="#" id="back-to-top" title="Back to top" style="display: none;">&uarr;</a>

        <!-- ALL JS FILES -->
        <script src="js/jquery-3.2.1.min.js"></script>
        <script src="js/popper.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <!-- ALL PLUGINS -->
        <script src="js/jquery.superslides.min.js"></script>
        <script src="js/bootstrap-select.js"></script>
        <script src="js/inewsticker.js"></script>
        <script src="js/bootsnav.js."></script>
        <script src="js/images-loded.min.js"></script>
        <script src="js/isotope.min.js"></script>
        <script src="js/owl.carousel.min.js"></script>
        <script src="js/baguetteBox.min.js"></script>
        <script src="js/form-validator.min.js"></script>
        <script src="js/contact-form-script.js"></script>
        <script src="js/custom.js"></script>
    </body>
</html>
