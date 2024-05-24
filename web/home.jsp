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
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
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
        <!-- Start Main Top -->
        <div class="main-top">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
                        <!--                        <div class="custom-select-box">
                                                    <select id="basic" class="selectpicker show-tick form-control" data-placeholder="$ USD">
                                                        <option>¥ JPY</option>
                                                        <option>$ USD</option>
                                                        <option>€ EUR</option>
                                                    </select>
                                                </div>-->
                        <div class="right-phone-box">
                            <p>Liên hệ với chúng tôi: <a href="tel:0971645207"> 0971645207</a></p>
                        </div>
                        <div class="our-link">
                            <ul>
                                <%
                                    User user = (User) session.getAttribute("user");
                                    if (user != null) {
                                %>
                                <li><a href="#"><i class="fa fa-user s_color"></i> Tài khoản</a></li>
                                    <%}%>
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
                        <% if (user == null) {%>
                        <div class="login-box">
                            <select id="basic" class="selectpicker show-tick form-control" data-placeholder="Sign In">
                                <option>Đăng ký</option>
                                <option>Đăng nhập</option>
                            </select>
                        </div>
                        <%}%>
                        <div class="text-slid-box">
                            <div id="offer-box" class="carouselTicker">
                                <ul class="offer-box">
                                    <c:forEach items="${requestScope.featuredproduct}" var="fpr">
                                        <li>
                                            <p class="ellipsis-text-1"><i class="bi bi-cart3"></i>${fpr.title} - ${fpr.listPrice}00 đ</p>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- End Main Top -->

        <!-- Start Main Top -->
        <header class="main-header">
            <!-- Start Navigation -->
            <nav class="navbar navbar-expand-lg navbar-light bg-light navbar-default bootsnav">
                <div class="container">
                    <!-- Start Header Navigation -->
                    <div class="navbar-header">
                        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar-menu" aria-controls="navbars-rs-food" aria-expanded="false" aria-label="Toggle navigation">
                            <i class="bi bi-list"></i>
                        </button>
                        <a class="navbar-brand" href="index.html"><img src="images/logo.png" class="logo" alt=""></a>
                    </div>
                    <!-- End Header Navigation -->

                    <!-- Collect the nav links, forms, and other content for toggling -->
                    <div class="collapse navbar-collapse" id="navbar-menu">
                        <ul class="nav navbar-nav ml-auto" data-in="fadeInDown" data-out="fadeOutUp">
                            <li class="nav-item active"><a class="nav-link" href="home">Trang chủ</a></li>
                            <li class="nav-item"><a class="nav-link" href="about">Giới thiệu</a></li>
                            <li class="dropdown">
                                <a href="#" class="nav-link dropdown-toggle arrow bi bi-caret-down-fill" data-toggle="dropdown">SHOP</a>
                                <ul class="dropdown-menu">
                                    <li><a href="shop.html">Sidebar Shop</a></li>
                                    <li><a href="shop-detail.html">Shop Detail</a></li>
                                    <li><a href="cart.html">Giỏ hàng</a></li>
                                    <li><a href="checkout.html">Thanh toán</a></li>
                                    <li><a href="my-account.html">Tài khoản</a></li>
                                </ul>
                            </li>
                            <li class="nav-item"><a class="nav-link" href="blog">Blog</a></li>
                            <li class="nav-item"><a class="nav-link" href="contact-us">Liên hệ với chúng tôi</a></li>
                        </ul>
                    </div>
                    <!-- /.navbar-collapse -->

                    <!-- Start Atribute Navigation -->
                    <%
                        if (user != null) {
                    %>
                    <div class="attr-nav">
                        <ul>
                            <li class="search"><a href="#"><i class="fa fa-search"></i></a></li>
                            <li class="side-menu">
                                <a href="#">
                                    <i class="fa fa-shopping-bag"></i>
                                    <span class="badge">3</span>
                                    <p>Giỏ hàng của tôi</p>
                                </a>
                            </li>
                        </ul>
                    </div>
                    <%}%>
                    <!-- End Atribute Navigation -->
                </div>
                <!-- Start Side Menu -->
                <div class="side">
                    <a href="#" class="close-side"><i class="fa fa-times"></i></a>
                    <li class="cart-box">
                        <ul class="cart-list">
                            <li>
                                <a href="#" class="photo"><img src="images/img-pro-01.jpg" class="cart-thumb" alt="" /></a>
                                <h6><a href="#">Delica omtantur </a></h6>
                                <p>1x - <span class="price">$80.00</span></p>
                            </li>
                            <li>
                                <a href="#" class="photo"><img src="images/img-pro-02.jpg" class="cart-thumb" alt="" /></a>
                                <h6><a href="#">Omnes ocurreret</a></h6>
                                <p>1x - <span class="price">$60.00</span></p>
                            </li>
                            <li>
                                <a href="#" class="photo"><img src="images/img-pro-03.jpg" class="cart-thumb" alt="" /></a>
                                <h6><a href="#">Agam facilisis</a></h6>
                                <p>1x - <span class="price">$40.00</span></p>
                            </li>
                            <li class="total">
                                <a href="#" class="btn btn-default hvr-hover btn-cart">XEM GIỎ HÀNG</a>
                                <span class="float-right"><strong>Tổng</strong>: $180.00</span>
                            </li>
                        </ul>
                    </li>
                </div>
                <!-- End Side Menu -->
            </nav>
            <!-- End Navigation -->
        </header>
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

        <!-- Start Slider -->
        <div id="slides-shop" class="cover-slides">
            <ul class="slides-container">
                <li class="text-center">
                    <img src="images/banner-01.jpg" alt="">
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
                <li class="text-center">
                    <img src="images/banner-02.jpg" alt="">
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
                <li class="text-center">
                    <img src="images/banner-03.jpg" alt="">
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
                    <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
                        <div class="shop-cat-box">
                            <img class="img-fluid" src="images/categories_img_01.jpg" alt="" />
                            <a class="btn hvr-hover" href="#">Lorem ipsum dolor</a>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
                        <div class="shop-cat-box">
                            <img class="img-fluid" src="images/categories_img_02.jpg" alt="" />
                            <a class="btn hvr-hover" href="#">Lorem ipsum dolor</a>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
                        <div class="shop-cat-box">
                            <img class="img-fluid" src="images/categories_img_03.jpg" alt="" />
                            <a class="btn hvr-hover" href="#">Lorem ipsum dolor</a>
                        </div>
                    </div>
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
                                <button data-filter=".best-seller">Bán chạy</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row special-list">
                    <c:forEach items="${requestScope.allproduct}" var="fpr">
                        <div class="col-lg-3 col-md-6 special-grid top-featured">
                            <div class="products-single fix">
                                <div class="box-img-hover">
                                    <div class="type-lb">
                                        <p class="new">New</p>
                                    </div>
                                    <img src="${fpr.thumbnail}" class="img-fluid" alt="Image">
                                    <div class="mask-icon">
                                        <ul>
                                            <li><a href="#" data-toggle="tooltip" data-placement="right" title="View"><i class="fas fa-eye"></i></a></li>
                                            <li><a href="#" data-toggle="tooltip" data-placement="right" title="Compare"><i class="fas fa-sync-alt"></i></a></li>
                                            <li><a href="#" data-toggle="tooltip" data-placement="right" title="Add to Wishlist"><i class="far fa-heart"></i></a></li>
                                        </ul>
                                        <a class="cart" href="#">Thêm vào giỏ hàng</a>
                                    </div>
                                </div>
                                <div class="why-text row" style="min-height: 150px">
                                    <div class="col-12">
                                        <h4>${fpr.title}</h4>
                                    </div>
                                    <div class="col-12">
                                        <h5> ${fpr.listPrice}00 đ</h5>
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


        <!-- Start Instagram Feed  -->
        <div class="instagram-box">
            <div class="main-instagram owl-carousel owl-theme">
                <c:forEach items="${requestScope.allproduct}" var="apr">
                    <div class="item">
                        <div class="ins-inner-box">
                            <img src="${apr.thumbnail}" alt="" />
                            <div class="hov-in">
                                <a href="#"><i class="bi bi-instagram"></i></a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
        <!-- End Instagram Feed  -->


        <!-- Start Footer  -->
        <footer>
            <div class="footer-main">
                <div class="container">
                    <div class="row">
                        <!--                        <div class="col-lg-4 col-md-12 col-sm-12">
                                                    <div class="footer-top-box">
                                                        <h3>Business Time</h3>
                                                        <ul class="list-time">
                                                            <li>Monday - Friday: 08.00am to 05.00pm</li> <li>Saturday: 10.00am to 08.00pm</li> <li>Sunday: <span>Closed</span></li>
                                                        </ul>
                                                    </div>
                                                </div>
                                                <div class="col-lg-4 col-md-12 col-sm-12">
                                                    <div class="footer-top-box">
                                                        <h3>Newsletter</h3>
                                                        <form class="newsletter-box">
                                                            <div class="form-group">
                                                                <input class="" type="email" name="Email" placeholder="Email Address*" />
                                                                <i class="fa fa-envelope"></i>
                                                            </div>
                                                            <button class="btn hvr-hover" type="submit">Submit</button>
                                                        </form>
                                                    </div>
                                                </div>-->
                        <div class="col-lg-4 col-md-12 col-sm-12">
                            <div class="footer-top-box">
                                <h3>Social Media</h3>
                                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                                <ul>
                                    <li><a href="#"><i class="bi bi-facebook" aria-hidden="true"></i></a></li>
                                    <li><a href="#"><i class="bi bi-instagram" aria-hidden="true"></i></a></li>
                                    <li><a href="#"><i class="bi bi-linkedin" aria-hidden="true"></i></a></li>
                                    <li><a href="#"><i class="bi bi-google" aria-hidden="true"></i></a></li>
                                    <li><a href="#"><i class="bi bi-rss" aria-hidden="true"></i></a></li>
                                    <li><a href="#"><i class="bi bi-pinterest" aria-hidden="true"></i></a></li>
                                    <li><a href="#"><i class="bi bi-whatsapp" aria-hidden="true"></i></a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <hr>
                    <div class="row">
                        <div class="col-lg-6 col-md-12 col-sm-12">
                            <div class="footer-widget">
                                <h4>Giới thiệu</h4>
                                <p>PetShop là cửa hàng chuyên cung cấp thức ăn và phụ kiện cho thú cưng. Đến với PetShop, khách yêu shopping tận lực, PetShop tư vấn tận tâm.</p> 
                            </div>
                        </div>
                        <!--                        <div class="col-lg-4 col-md-12 col-sm-12">
                                                    <div class="footer-link">
                                                        <h4>Information</h4>
                                                        <ul>
                                                            <li><a href="#">About Us</a></li>
                                                            <li><a href="#">Customer Service</a></li>
                                                            <li><a href="#">Our Sitemap</a></li>
                                                            <li><a href="#">Terms &amp; Conditions</a></li>
                                                            <li><a href="#">Privacy Policy</a></li>
                                                            <li><a href="#">Delivery Information</a></li>
                                                        </ul>
                                                    </div>
                                                </div>-->
                        <div class="col-lg-6 col-md-12 col-sm-12">
                            <div class="footer-link-contact">
                                <h4>Thông tin liên hệ</h4>
                                <ul>
                                    <li>
                                        <p><i class="bi bi-geo-alt-fill"></i>Địa chỉ: 209 Đ. Thụy Khuê, Thuỵ Khuê, <br>Tây Hồ, Hà Nội</p>
                                    </li>
                                    <li>
                                        <p><i class="bi bi-telephone-fill"></i>Điện thoại: <a href="tel:0971645207">0971645207</a></p>
                                    </li>
                                    <li>
                                        <p><i class="bi bi-envelope-fill"></i>Email: <a href="mailto:petshop@gmail.com">petshop@gmail.com</a></p>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </footer>
        <!-- End Footer  -->

        <!-- Start copyright  -->
        <div class="footer-copyright">
            <p class="footer-company">&copy; 2024 - Bản quyền thuộc về <a href="#">PetShop</a>
        </div>
        <!-- End copyright  -->

        <a href="#" id="back-to-top" title="Back to top" style="display: none;">&uarr;</a>

        <!-- ALL JS FILES -->
        <script src="js/jquery-3.2.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
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
