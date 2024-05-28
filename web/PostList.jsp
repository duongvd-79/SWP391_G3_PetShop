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
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 20px;
                background-color: #f4f4f4;
            }
            .search-container {
                max-width: 600px;
                margin-left: 15px;
                padding: 20px;
                background-color: #fff;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
                border-radius: 8px;
            }
            .search-container h2 {
                text-align: center;
                margin-bottom: 20px;
            }
            .search-box {
                display: flex;
            }
            .search-box input[type="text"] {
                flex: 1;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 4px 0 0 4px;
                font-size: 16px;
            }
            .search-box button {
                padding: 10px;
                background-color: #28a745;
                border: none;
                border-radius: 0 4px 4px 0;
                color: #fff;
                font-size: 16px;
                cursor: pointer;
            }
            .search-box button:hover {
                background-color: #218838;
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
                                <li><a href="#"><i class="fa fa-user s_color"></i> My Account</a></li>
                                    <%}%>
                                <li><a href="#"><i class="fas fa-location-arrow"></i> Our location</a></li>
                                <li><a href="#"><i class="fas fa-headset"></i> Contact Us</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
                        <div class="login-box">
                            <select id="basic" class="selectpicker show-tick form-control" data-placeholder="Sign In">
                                <option>Register Here</option>
                                <option>Sign In</option>
                            </select>
                        </div>
                        <div class="text-slid-box">
                            <div id="offer-box" class="carouselTicker">
                                <ul class="offer-box">
                                    <li>
                                        <i class="fab fa-opencart"></i> 20% off Entire Purchase Promo code: offT80
                                    </li>
                                    <li>
                                        <i class="fab fa-opencart"></i> 50% - 80% off on Vegetables
                                    </li>
                                    <li>
                                        <i class="fab fa-opencart"></i> Off 10%! Shop Vegetables
                                    </li>
                                    <li>
                                        <i class="fab fa-opencart"></i> Off 50%! Shop Now
                                    </li>
                                    <li>
                                        <i class="fab fa-opencart"></i> Off 10%! Shop Vegetables
                                    </li>
                                    <li>
                                        <i class="fab fa-opencart"></i> 50% - 80% off on Vegetables
                                    </li>
                                    <li>
                                        <i class="fab fa-opencart"></i> 20% off Entire Purchase Promo code: offT30
                                    </li>
                                    <li>
                                        <i class="fab fa-opencart"></i> Off 50%! Shop Now 
                                    </li>
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
                            <i class="fa fa-bars"></i>
                        </button>
                        <a class="navbar-brand" href="index.html"><img src="images/logo.png" class="logo" alt=""></a>
                    </div>
                    <!-- End Header Navigation -->

                    <!-- Collect the nav links, forms, and other content for toggling -->
                    <div class="collapse navbar-collapse" id="navbar-menu">
                        <ul class="nav navbar-nav ml-auto" data-in="fadeInDown" data-out="fadeOutUp">
                            <li class="nav-item active"><a class="nav-link" href="home">Home</a></li>
                            <li class="nav-item"><a class="nav-link" href="about">About Us</a></li>
                            <li class="dropdown">
                                <a href="#" class="nav-link dropdown-toggle arrow" data-toggle="dropdown">SHOP</a>
                                <ul class="dropdown-menu">
                                    <li><a href="shop.html">Sidebar Shop</a></li>
                                    <li><a href="shop-detail.html">Shop Detail</a></li>
                                    <li><a href="cart.html">Cart</a></li>
                                    <li><a href="checkout.html">Checkout</a></li>
                                    <li><a href="my-account.html">My Account</a></li>
                                    <li><a href="wishlist.html">Wishlist</a></li>
                                </ul>
                            </li>
                            <li class="nav-item"><a class="nav-link" href="postlist">Blog</a></li>
                            <li class="nav-item"><a class="nav-link" href="contact-us">Contact Us</a></li>
                        </ul>
                    </div>
                    <!-- /.navbar-collapse -->

                    <!-- Start Atribute Navigation -->
                    <div class="attr-nav">
                        <ul>
                            <li class="search"><a href="#"><i class="fa fa-search"></i></a></li>
                            <li class="side-menu">
                                <a href="#">
                                    <i class="fa fa-shopping-bag"></i>
                                    <span class="badge">3</span>
                                    <p>My Cart</p>
                                </a>
                            </li>
                        </ul>
                    </div>
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
                                <a href="#" class="btn btn-default hvr-hover btn-cart">VIEW CART</a>
                                <span class="float-right"><strong>Total</strong>: $180.00</span>
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
        <div class="latest-blog">
    <div class="container">
        <div class="row">
            <div class="search-container">
                <form action="postlist" method="GET">
                    <input type="text" name="search" placeholder="Nhập từ khóa tìm kiếm..." required>
                    <button type="submit">Tìm Kiếm</button>
                </form>
            </div>
            <div class="col-lg-12">
                <div class="title-all text-center">
                    <h1>Bài đăng hot</h1>
                </div>
            </div>
        </div>
        <div id="posts-container" class="row">
            <!-- Placeholder for dynamically rendered posts -->
        </div>
    </div>
    <nav aria-label="Page navigation example">
        <ul class="pagination" style="margin-left: 67%;" id="pagination-controls">
            <!-- Placeholder for pagination controls -->
        </ul>
    </nav>
</div>

<script type="text/javascript">
    document.addEventListener("DOMContentLoaded", function() {
        // Sample data from the server (Replace this with actual server data)
        const posts = [
            <c:forEach var="p" items="${listp}">
                {
                    id: "${p.id}",
                    thumbnail: "${p.thumbnail}",
                    title: "${p.title}",
                    user: "${p.user.name}",
                    createdDate: "${p.createdDate}"
                },
            </c:forEach>
        ];

        const postsPerPage = 6; // Number of posts per page
        let currentPage = 1;

        function renderPosts(page) {
            const start = (page - 1) * postsPerPage;
            const end = start + postsPerPage;
            const paginatedPosts = posts.slice(start, end);

            const postsContainer = document.getElementById("posts-container");
            postsContainer.innerHTML = "";
            paginatedPosts.forEach((post) => {
                const postElement = document.createElement("div");
                postElement.className = "col-md-6 col-lg-4 col-xl-4";
                postElement.innerHTML = `
                    <div class="blog-box">
                        <div class="blog-img">
                            <img class="img-fluid" src="`+post.thumbnail+`" alt="" />
                        </div>
                        <div class="blog-content">
                            <div class="title-blog">
                                <a href="postdetail?pid=`+post.id+`" title="`+post.title+`" class="image-resize ratiobox">
                                    <p class="ellipsis-text" style="font-weight: bold">`+post.title+`</p>
                                </a>
                            </div>
                            <div class="mr-3 d-flex align-items-center">
                                <p class="mb-0"><i class="fa fa-user"></i> `+post.user+`</p>
                            </div>
                            <div class="d-flex align-items-center">
                                <p class="mb-0"><i class="fa fa-calendar"></i> `+post.createdDate+`</p>
                            </div>
                            <a href="postdetail?pid=`+post.id+`" class="btn btn-secondary">Đọc tiếp</a>
                        </div>
                    </div>
                `;
                postsContainer.appendChild(postElement);
            });
        }

        function renderPagination() {
            const pageCount = Math.ceil(posts.length / postsPerPage);
            const paginationControls = document.getElementById("pagination-controls");
            paginationControls.innerHTML = "";

            if (currentPage > 1) {
                const prevPageItem = document.createElement("li");
                prevPageItem.className = "page-item";
                prevPageItem.innerHTML = `<a class="page-link" href="#">Previous</a>`;
                prevPageItem.addEventListener("click", function(e) {
                    e.preventDefault();
                    currentPage--;
                    renderPosts(currentPage);
                    renderPagination();
                });
                paginationControls.appendChild(prevPageItem);
            }

            for (let i = 1; i <= pageCount; i++) {
                const pageItem = document.createElement("li");
                let status = i === currentPage ? 'active' : '';
                pageItem.className = `page-item `+status;
                pageItem.innerHTML = `<a class="page-link" href="#">`+i+`</a>`;
                pageItem.addEventListener("click", function(e) {
                    e.preventDefault();
                    currentPage = i;
                    renderPosts(currentPage);
                    renderPagination();
                });
                paginationControls.appendChild(pageItem);
            }

            if (currentPage < pageCount) {
                const nextPageItem = document.createElement("li");
                nextPageItem.className = "page-item";
                nextPageItem.innerHTML = `<a class="page-link" href="#">Next</a>`;
                nextPageItem.addEventListener("click", function(e) {
                    e.preventDefault();
                    currentPage++;
                    renderPosts(currentPage);
                    renderPagination();
                });
                paginationControls.appendChild(nextPageItem);
            }
        }

        // Initial render
        renderPosts(currentPage);
        renderPagination();
    });
</script>

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
                                    <li><a href="#"><i class="fab fa-facebook" aria-hidden="true"></i></a></li>
                                    <li><a href="#"><i class="fab fa-twitter" aria-hidden="true"></i></a></li>
                                    <li><a href="#"><i class="fab fa-linkedin" aria-hidden="true"></i></a></li>
                                    <li><a href="#"><i class="fab fa-google-plus" aria-hidden="true"></i></a></li>
                                    <li><a href="#"><i class="fa fa-rss" aria-hidden="true"></i></a></li>
                                    <li><a href="#"><i class="fab fa-pinterest-p" aria-hidden="true"></i></a></li>
                                    <li><a href="#"><i class="fab fa-whatsapp" aria-hidden="true"></i></a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <hr>
                    <div class="row">
                        <div class="col-lg-4 col-md-12 col-sm-12">
                            <div class="footer-widget">
                                <h4>Giới thiệu</h4>
                                <p>PetShop là cửa hàng chuyên cung cấp thức ăn và phụ kiện cho thú cưng. Đến với PetShop, khách yêu shopping tận lực, PetShop tư vấn tận tâm.</p> 
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-12 col-sm-12">
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
                        </div>
                        <div class="col-lg-4 col-md-12 col-sm-12">
                            <div class="footer-link-contact">
                                <h4>Thông tin liên hệ</h4>
                                <ul>
                                    <li>
                                        <p><i class="fas fa-map-marker-alt"></i>Địa chỉ: 209 Đ. Thụy Khuê, Thuỵ Khuê, <br>Tây Hồ, Hà Nội</p>
                                    </li>
                                    <li>
                                        <p><i class="fas fa-phone-square"></i>Điện thoại: <a href="tel:0971645207">0971645207</a></p>
                                    </li>
                                    <li>
                                        <p><i class="fas fa-envelope"></i>Email: <a href="mailto:petshop@gmail.com">petshop@gmail.com</a></p>
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
