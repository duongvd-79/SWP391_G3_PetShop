<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User"%>
<!DOCTYPE html>
<html lang="en">
    <!-- Basic -->

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">

        <!-- Mobile Metas -->
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Site Metas -->
        <title>PetShop Product Details</title>
        <meta name="keywords" content="">
        <meta name="description" content="">
        <meta name="author" content="">

        <!-- Site Icons -->
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

    </head>

    <body>
        <jsp:include page="header.jsp"></jsp:include>
            <!-- Start All Title Box -->
            <div class="all-title-box">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12">
                            <h2>Shop Detail</h2>
                        </div>
                    </div>
                </div>
            </div>
            <!-- End All Title Box -->

            <!-- Start Shop Detail  -->
            <div class="shop-detail-box-main">
                <div class="container">
                    <div class="row">
                        <div class="col-xl-5 col-lg-5 col-md-6">
                            <div id="carousel-example-1" class="single-product-slider carousel slide" data-ride="carousel">
                                <div class="carousel-inner" role="listbox">
                                    <div class="carousel-item active"> <img class="d-block w-100" src=${product.thumbnail}> </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-7 col-lg-7 col-md-6">
                        <div class="single-product-details">
                            <h2>${requestScope.product.title}</h2>
                            <h5><del>${requestScope.product.listPrice + 100}00 đ</del>&nbsp;&nbsp;${requestScope.product.listPrice}00 đ</h5>
                            <p class="available-stock"><span> <a href="#">8 sold</a></span><p>
                            <h4>Description:</h4>
                            <p>${requestScope.product.description}</p>
                            <%
                                 User user = (User) session.getAttribute("user");
                                    if (user != null) {
                            %>
                            <ul>
                                <li>
                                    <div class="form-group quantity-box">
                                        <label class="control-label">Quantity</label>
                                        <input class="form-control" id="quantity" name="quantity" value="1" min="0" max="20" type="number">
                                    </div>
                                </li>
                            </ul>

                            <div class="price-box-bar">
                                <%
                                    User user = (User) session.getAttribute("user");
                                    if (user != null && user.getRoleId() == 5) {
                                %>
                                <div class="cart-and-bay-btn">
                                    <a class="btn hvr-hover" data-fancybox-close="" href="#">Buy New</a>
                                    <a id="addToCartLink" class="btn hvr-hover" data-fancybox-close="" href="#" onclick="updateHref()">Add to cart</a>
                                </div>
                                <%} else {%>
                                <a class="btn hvr-hover" data-fancybox-close="" href="#loginpopup">Login to Buy</a>
                                <%}%>
                            </div>

                            <script>
                                function updateHref() {
                                    var quantity = document.getElementById("quantity").value;
                                    var productid = "${requestScope.product.id}";
                                    var href = "addcart?productid=" + productid + "&quantity=" + quantity + "&currentid=" + productid;
                                    document.getElementById("addToCartLink").href = href;
                                }

                            </script>
                            <% } %>
                        </div>
                    </div>
                </div>

                <div class="col-12 my-5 px-0 ms-2">
                    <div class="card card-outline-secondary my-4 px-0">
                        <div class="card-header">
                            <h2>Product Reviews</h2>
                        </div>
                        <div class="card-body">
                            <c:set var="fl" value="${requestScope.feedbackList}"/>
                            <c:choose>
                                <c:when test="${not empty fl}">
                                    <c:forEach items="${fl}" var="f">
                                        <div class="media mb-3">
                                            <div class="mr-2"> 
                                                <img class="rounded-circle border p-1" src="data:image/svg+xml;charset=UTF-8,%3Csvg%20width%3D%2264%22%20height%3D%2264%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%2064%2064%22%20preserveAspectRatio%3D%22none%22%3E%3Cdefs%3E%3Cstyle%20type%3D%22text%2Fcss%22%3E%23holder_160c142c97c%20text%20%7B%20fill%3Argba(255%2C255%2C255%2C.75)%3Bfont-weight%3Anormal%3Bfont-family%3AHelvetica%2C%20monospace%3Bfont-size%3A10pt%20%7D%20%3C%2Fstyle%3E%3C%2Fdefs%3E%3Cg%20id%3D%22holder_160c142c97c%22%3E%3Crect%20width%3D%2264%22%20height%3D%2264%22%20fill%3D%22%23777%22%3E%3C%2Frect%3E%3Cg%3E%3Ctext%20x%3D%2213.5546875%22%20y%3D%2236.5%22%3E64x64%3C%2Ftext%3E%3C%2Fg%3E%3C%2Fg%3E%3C%2Fsvg%3E" alt="Generic placeholder image">
                                            </div>
                                            <div class="media-body">
                                                <p>${f.detail}</p>
                                                <small class="text-muted">Posted by ${f.name} on ${f.createdDate}</small>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <p>No reviews yet!</p>
                                </c:otherwise>
                            </c:choose>

                            <hr>
                            <c:if test="${not empty fl}">
                                <a href="#" class="btn hvr-hover">See more</a>
                            </c:if>
                            <a href="#" class="btn hvr-hover">Leave a Review</a>
                        </div>
                    </div>
                </div>
                <div class="title-all text-center">
                    <h1>Related Product</h1>
                    <p>Explore these similar products and seize the opportunity to add them to your cart for exclusive deals!</p>
                </div>
                <div class="row special-list">

                    <c:forEach items="${relatedlist}" var="p">
                        <div class="col-lg-3 col-md-6 special-grid best-seller">
                            <div class="products-single fix">
                                <div class="box-img-hover">
                                    <div class="type-lb">
                                        <p class="sale">Sale</p>
                                    </div>
                                    <img src=${p.thumbnail} class="img-fluid" alt="Image">
                                    <div class="mask-icon">
                                        <a class="view" href="productdetail?id=${p.id}">View</a>
                                        <%
                                            if (user != null && user.getRoleId() == 5) {
                                        %>
                                        <a class="cart" href="addcart?productid=${p.id}&quantity=1&currentid=${requestScope.product.id}">Add to Cart</a>
                                        <%}%>
                                    </div>
                                </div>
                                <div class="why-text">
                                    <h4>${p.title}</h4>
                                    <h5>${p.listPrice}00 đ</h5>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- End Cart -->

<jsp:include page="footer.jsp"></jsp:include>

<style>
    nav.navbar .navbar-brand img.logo {
        width: 250px; /* Đặt kích thước tối đa cho chiều ngang */
    }
</style>

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