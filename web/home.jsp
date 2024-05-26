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
            .ellipsis-text-3 {
                display: -webkit-box;
                -webkit-line-clamp: 3;
                -webkit-box-orient: vertical;
                overflow: hidden;
                text-overflow: ellipsis;
                line-height: 1.5em; /* Adjust based on your font-size */
                max-height: 4.5em; /* 3 lines * line-height */
            }
            .ellipsis-text-1 {
                display: -webkit-box;
                -webkit-line-clamp: 1;
                -webkit-box-orient: vertical;
                overflow: hidden;
                text-overflow: ellipsis;
                line-height: 1.5em; /* Adjust based on your font-size */
                max-height: 4.5em; /* 3 lines * line-height */
            }
        </style>
    </head>
    <body>

        <jsp:include page="header.jsp"></jsp:include>

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

            <!-- Start Slider -->
            <div id="slides-shop" class="cover-slides">
                <ul class="slides-container">
                <c:forEach items="${requestScope.allproduct}" var="apr">
                    <li class="text-center">
                        <img src="${apr.thumbnail}" alt="">
                        <div class="container">
                            <div class="row">
                                <div class="col-md-12">
                                    <h1 class="m-b-20"><strong>Slider</strong></h1>
                                    <p class="m-b-40">Slider description</p>
                                    <p><a class="btn hvr-hover" href="#">Slider button</a></p>
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

        <!-- Start Categories  -->
        <div class="categories-shop">
            <div class="container">
                <div class="row">
                    <c:forEach items="${requestScope.featuredproduct}" var="fpr">
                        <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
                            <div class="shop-cat-box">
                                <img class="img-fluid" src="${fpr.thumbnail}" alt="" />
                                <a class="btn hvr-hover" href="#">${fpr.title}</a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
        <!-- End Categories -->

        <div class="box-add-products">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6 col-md-6 col-sm-12">
                        <div class="offer-box-products">
                            <img class="img-fluid" src="images/add-img-01.jpg" alt="" />
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-6 col-sm-12">
                        <div class="offer-box-products">
                            <img class="img-fluid" src="images/add-img-02.jpg" alt="" />
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Start Products  -->
        <div class="products-box">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="title-all text-center">
                            <h1>Sản phẩm</h1>
                            <p>Khám phá các sản phẩm trên Pet Shop.</p>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <div class="special-menu text-center">
                            <div class="button-group filter-button-group">
                                <button class="active" data-filter="*">Tất cả</button>
                                <button data-filter=".top-featured">Nổi bật</button>
                                <button data-filter=".best-seller">Mới</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row special-list">
                    <c:forEach items="${requestScope.allproduct}" var="apr">
                        <div class="col-lg-3 col-md-6 special-grid ${(apr.isFeatured) ? "top-featured" : "best-seller"}">
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
                                        <a class="view" href="product?id=${apr.id}">Xem</a>
                                        <%
                                            User user = (User) session.getAttribute("user");
                                            if (user != null) {
                                        %>
                                        <a class="cart" href="#">Thêm vào giỏ hàng</a>
                                        <%}%>
                                    </div>
                                </div>
                                <div class="why-text row" style="min-height: 150px">
                                    <div class="col-12">
                                        <h4>${apr.title}</h4>
                                    </div>
                                    <div class="col-12">
                                        <h5> ${apr.listPrice}00 đ</h5>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
        <!-- End Products  -->

        <!-- Start Blog  -->
        <div class="latest-blog">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="title-all text-center">
                            <h1>Bài đăng hot</h1>
                            <p>Khám phá những bài đăng có lượt truy cập nhiều nhất.</p>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <c:forEach items="${requestScope.featuredpost}" var="fp">
                        <div class="col-md-6 col-lg-4 col-xl-4" title="${fp.title}"
                             onclick="window.location.href = 'post?id=${fp.id}'" style="cursor: pointer">
                            <div class="blog-box">
                                <div class="blog-img">
                                    <img class="img-fluid" src="${fp.thumbnail}" alt="" />
                                </div>
                                <div class="blog-content">
                                    <div class="title-blog">
                                        <h3>${fp.title}</h3>
                                        <div class="ellipsis-text-3">${fp.detail}</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
        <!-- End Blog  -->

        <jsp:include page="footer.jsp"></jsp:include>

        <a href="#" id="back-to-top" title="Back to top" style="display: block;">&uarr;</a>
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
