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
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
        <!-- Icon CSS -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <!-- Site CSS -->
        <link rel="stylesheet" href="css/style.css">
        <!-- Responsive CSS -->
        <link rel="stylesheet" href="css/responsive.css">
        <style>
            .ellipsis-text-1 {
                display: -webkit-box;
                -webkit-line-clamp: 1;
                -webkit-box-orient: vertical;
                overflow: hidden;
                line-height: 1.5em; /* Adjust based on your font-size */
                max-height: 4.5em; /* 3 lines * line-height */
            }
            .ellipsis-text-2 {
                display: -webkit-box;
                -webkit-line-clamp: 2;
                -webkit-box-orient: vertical;
                overflow: hidden;
                line-height: 1.5em; /* Adjust based on your font-size */
                max-height: 4.5em; /* 3 lines * line-height */
            }
            .ellipsis-text-3 {
                display: -webkit-box;
                -webkit-line-clamp: 3;
                -webkit-box-orient: vertical;
                overflow: hidden;
                line-height: 1.5em; /* Adjust based on your font-size */
                max-height: 4.5em; /* 3 lines * line-height */
            }
            #featured-list {
                transition:  0.5s ease-in-out;
            }
            .blog-content {
                transition: transform 0.3s, filter 0.3s;
            }
            .blog-content:hover {
                transform: scale(1.1, 1.1);
            }
            .latest-blog-content {
                width: 67%;
                float: left;
                padding-left: 10px;
            }
            .latest-blog-content h3 a {
                font-size: 20px;
            }
            .blog-box {
                border-bottom: solid lightgray 1px;
            }
            .range-slide {
                position: relative;
                margin: 20px 20px;
                height: 4px;
            }
            .slide {
                position: absolute;
                top: 0;
                height: 4px;
                background: lightgray;
                left: 9px;
                right: 9px;
            }
            .line {
                position: absolute;
                left: 0;
                right: 0;
                top: 0;
                height: 4px;
                background-color: #b0b435;
            }
            .thumb {
                position: absolute;
                z-index: 2;
                text-align: left;
                border: 1px solid gray;
                background-color: white;
                border-radius: 50%;
                outline: none;
                top: -7px;
                height: 18px;
                width: 18px;
                margin-left: -9px;
            }
            .range {
                -webkit-appearance: none;
                appearance: none;
                position: absolute;
                pointer-events: none;
                z-index: 3;
                height: 3px;
                top: 0;
                width: 100%;
                opacity: 0;
                margin: 0;
            }
            .range::-webkit-slider-thumb {
                -webkit-appearance: none;
                appearance: none;
                pointer-events: all;
                border-radius: 50%;
                cursor: pointer;
                width: 18px;
                height: 18px;
            }
            .display {
                margin: 0 20px 20px;
                display: flex;
                justify-content: space-evenly;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>
            <!-- Start Slider -->
            <div id="slides-shop" class="cover-slides">
                <ul class="slides-container">
                <c:forEach items="${requestScope.slider}" var="sl">
                    <li class="text-center">
                        <img src="${sl.image}" alt="">
                        <div class="container">
                            <div class="row">
                                <div class="col-md-12">
                                    <h1 class="m-b-20"><strong>${sl.title}</strong></h1>
                                    <p><a class="btn hvr-hover" href="${sl.backLink}">${sl.backLink.contains("product") ? "To Product Details" : "To Blog Details"}</a></p>
                                </div>
                            </div>
                        </div>
                    </li>
                </c:forEach>
            </ul>
            <div class="slides-navigation">
                <a href="#" class="next"><i class="bi bi-caret-right-fill" aria-hidden="true"></i></a>
                <a href="#" class="prev"><i class="bi bi-caret-left-fill" aria-hidden="true"></i></a>
            </div>
        </div>
        <!-- End Slider -->

        <div class="container-fluid">
            <div class="row">
                <div class="sidebar container-fluid col-sm-3">
                    <!-- Start Sidebar  -->
                    <div class="container-fluid sticky-top" style="top: 111px;z-index: 2;">
                        <div class="row">
                            <div class="col-12 text-center mt-3">
                                <h3 style="font-weight: 700; font-size: 32px; margin: 20px 0px;">Latest blog</h3>
                            </div>
                        </div>
                        <form action="productlist" method="get">
                            <div class="row border-top pt-3">
                                <div class="col-12 input-group mb-3">
                                    <input type="text" class="form-control" name="search" placeholder="Search" aria-label="search" aria-describedby="search">
                                    <span class="input-group-text btn" id="search"><i class="bi bi-search"></i></span>
                                </div>
                                <div class="col-12 mb-3 blog-box pt-2">
                                    <h2>Categories</h2>
                                </div>
                                <c:forEach items="${requestScope.prcategory}" var="pcate">
                                    <div class="col-12 blog-content" title="${pcate.name}">
                                        <div class="latest-blog-content">
                                            <div style="padding: 0px 5px;">
                                                <h3>
                                                    <a href="">${pcate.name}</a>
                                                </h3>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                                <div class="col-12 mb-3 blog-box pt-2">
                                    <h2>Price</h2>
                                </div>
                                <div class="col-12">
                                    <div class="range-slide">
                                        <div class="slide">
                                            <div class="line" id="line" style="left: 0%; right: 0%;"></div>
                                            <span class="thumb" id="thumbMin" style="left: 0%;"></span>
                                            <span class="thumb" id="thumbMax" style="left: 100%;"></span>
                                        </div>
                                        <input class="range" id="rangeMin" type="range" max="100" min="10" step="1" value="0">
                                        <input class="range" id="rangeMax" type="range" max="100" min="10" step="1" value="100">
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="display">
                                        <input class="form-control mr-5" name="minValue" id="min" value="50000">
                                        <span>to</span>
                                        <input class="form-control ml-5" name="maxValue" id="max" value="500000">
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                    <!-- End Sidebar  -->
                </div>

                <div class="col-sm-9 border-left">
                    <!-- Start Products  -->
                    <div class="products-box">
                        <div class="container">
                            <div class="row">
                                <div class="col-lg-8">
                                    <div class="title-all">
                                        <h1>All Products</h1>
                                        <p>Explore products on Pet Shop.</p>
                                    </div>
                                </div>
                                <div class="col-lg-4 d-flex align-items-start justify-content-end">
                                    <span>
                                        <span class="mr-2" style="font-size: 18px">Sort:</span>
                                        <select class="form-select py-2 px-1 mr-5 mt-4" id="sort" name="sort" title="Sort">
                                            <option value="Latest">By Newest Arrivals</option>
                                            <option value="Oldest">By Oldest Products</option>
                                            <option value="Price Asc">By Price (Low to High)</option>
                                            <option value="Price Desc">By Price (High to Low)</option>
                                        </select>
                                    </span>
                                </div>
                            </div>

                            <div class="row" id="featured-list">
                                <c:forEach items="${requestScope.allproduct}" var="apr">
                                    <div class="col-lg-3 col-md-6">
                                        <div class="products-single fix">
                                            <div class="box-img-hover">
                                                <div class="type-lb">
                                                    <c:choose>
                                                        <c:when test="${(apr.isFeatured)}">
                                                            <p class="sale">Hot</p>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <p class="new">New</p>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <img src="${apr.thumbnail}" class="img-fluid" alt="Image">
                                                <div class="mask-icon">
                                                    <a class="view" href="productdetail?id=${apr.id}">View</a>
                                                    <%
                                                        User user = (User) session.getAttribute("user");
                                                        if (user != null && user.getRoleId() == 5) {
                                                    %>
                                                    <a class="cart" href="#">Add to Cart</a>
                                                    <%}%>
                                                </div>
                                            </div>
                                            <div class="why-text row" style="min-height: 150px">
                                                <div class="col-12" style="max-height: 71.9px;">
                                                    <h4>${apr.title}</h4>
                                                </div>
                                                <div class="col-12">
                                                    <h5>${apr.listPrice}00 đ</h5>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                    <!-- End Products  -->
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
        <script>
            document.getElementById('sort').addEventListener('change', function () {
                var selectedValue = this.value;
                window.location.href = selectedValue;
            });

            let min = 10;
            let max = 100;

            const calcLeftPosition = value => 100 / (100 - 10) * (value - 10);

            document.getElementById('rangeMin').addEventListener('input', function (e) {
                const newValue = parseInt(e.target.value);
                if (newValue > max)
                    return;
                min = newValue;
                document.getElementById('thumbMin').style.left = calcLeftPosition(newValue) + '%';
                document.getElementById('min').value = newValue * 5000;
                document.getElementById('line').style.left = calcLeftPosition(newValue) + '%';
                document.getElementById('line').style.right = (100 - calcLeftPosition(max)) + '%';
            });

            document.getElementById('rangeMax').addEventListener('input', function (e) {
                const newValue = parseInt(e.target.value);
                if (newValue < min)
                    return;
                max = newValue;
                document.getElementById('thumbMax').style.left = calcLeftPosition(newValue) + '%';
                document.getElementById('max').value = newValue * 5000;
                document.getElementById('line').style.left = calcLeftPosition(min) + '%';
                document.getElementById('line').style.right = (100 - calcLeftPosition(newValue)) + '%';
            });
        </script>
    </body>
</html>
