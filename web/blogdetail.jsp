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
        <!-- Icon CSS -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
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
            .blog-content {
                padding: 10px 0px 20px;
            }
            .blog-content img, .blog-image img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                object-position: center;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>
            
            <div class="blog-detail-wrapper">
                <div class="container-fluid">
                    <div class="row justify-content-center"> 
                        <div class="col-md-8 col-sm-12 col-xs-12 text-center">
                            <div class="blog-detail-main">
                                <h1 style="font-weight: bold ; text-align: left ; font-size: 50px ; margin-top: 30px; margin-bottom: 20px">${postdetail.title}</h1>
                            <div class="blog-image">
                                <img class="blog-image-feature" src="${postdetail.thumbnail}" alt="${postdetail.title}">
                            </div>
                            <div class="blog-meta d-flex justify-content-center">
                                <p class="blog-date" style="font-size: 24px">
                                    <i class="bi bi-calendar-week"></i> ${postdetail.createdDate}
                                </p>
                                &ensp;
                                <p class="blog-author" style="font-size: 24px">
                                    <i class="bi bi-person-circle"></i> ${postdetail.user.name}
                                </p>
                            </div>
                            <div class="blog-content" id="detail-blog">
                                <div class="container" style="text-align: start; font-size: 24px">
                                    ${postdetail.detail}
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="footer.jsp"></jsp:include>
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
