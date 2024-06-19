<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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


        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
          <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->

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
                            <div class="price-with-rating">
                                <h5>
                                    <del>${requestScope.product.listPrice + 100}00 đ </del>${requestScope.product.listPrice}00 đ
                                    <c:if test="${star == 1}">
                                        <span class="product-rating">
                                            <i class="bi bi-star-fill text-warning"></i>
                                            <i class="bi bi-star"></i>
                                            <i class="bi bi-star"></i>
                                            <i class="bi bi-star"></i>
                                            <i class="bi bi-star"></i>
                                        </span>
                                    </c:if>
                                    <c:if test="${star == 2}">
                                        <span class="product-rating">
                                            <i class="bi bi-star-fill text-warning"></i>
                                            <i class="bi bi-star-fill text-warning"></i>
                                            <i class="bi bi-star"></i>
                                            <i class="bi bi-star"></i>
                                            <i class="bi bi-star"></i>
                                        </span>
                                    </c:if>
                                    <c:if test="${star == 3}">
                                        <span class="product-rating">
                                            <i class="bi bi-star-fill text-warning"></i>
                                            <i class="bi bi-star-fill text-warning"></i>
                                            <i class="bi bi-star-fill text-warning"></i>
                                            <i class="bi bi-star"></i>
                                            <i class="bi bi-star"></i>
                                        </span>
                                    </c:if>
                                    <c:if test="${star == 4}">
                                        <span class="product-rating">
                                            <i class="bi bi-star-fill text-warning"></i>
                                            <i class="bi bi-star-fill text-warning"></i>
                                            <i class="bi bi-star-fill text-warning"></i>
                                            <i class="bi bi-star-fill text-warning"></i>
                                            <i class="bi bi-star"></i>
                                        </span>
                                    </c:if>
                                    <c:if test="${star == 5}">
                                        <span class="product-rating">
                                            <i class="bi bi-star-fill text-warning"></i>
                                            <i class="bi bi-star-fill text-warning"></i>
                                            <i class="bi bi-star-fill text-warning"></i>
                                            <i class="bi bi-star-fill text-warning"></i>
                                            <i class="bi bi-star-fill text-warning"></i>
                                        </span>
                                    </c:if>
                                    (${requestScope.reviewTotal} reviews)
                                </h5>
                            </div>
                            <p class="available-stock"><span> <a href="#">${requestScope.product.quantity} remains</a></span><p>
                            <h4>Short Description:</h4>
                            <p>${requestScope.product.description}</p>
                            <%
                                User user = (User) session.getAttribute("user");
                                if (user != null) {
                            %>
                            <ul>
                                <li>
                                    <div class="form-group quantity-box">
                                        <label class="control-label">Quantity</label>
                                        <input class="form-control" id="quantity" name="quantity" value="1" min="1" max="150" step="1" type="number">
                                    </div>
                                </li>
                            </ul>

                            <div class="price-box-bar">
                                <div class="cart-and-bay-btn">
                                    <a class="btn hvr-hover" data-fancybox-close="" href="#">Buy New</a>
                                    <a id="addToCartLink" class="btn hvr-hover" data-fancybox-close="" href="#" onclick="return updateHref()">Add to cart</a>
                                </div>
                                <div>
                                    <p id="msg" style="color: red;"></p>
                                </div>
                            </div>

                            <script>
                                function updateHref() {
                                    var quantity = parseInt(document.getElementById("quantity").value);
                                    var remains = parseInt('${requestScope.product.quantity}');

                                    if (quantity > remains) {
                                        // Hiển thị thông báo lỗi
                                        document.getElementById("msg").innerText = "Sorry, the quantity exceeds available stock.";
                                        return false; // Ngăn chặn thực hiện thay đổi href
                                    } else {
                                        // Nếu quantity hợp lệ, cập nhật href cho nút "Add to cart"
                                        var productid = "${requestScope.product.id}";
                                        var href = "addcart?productid=" + productid + "&quantity=" + quantity + "&currentid=" + productid;
                                        document.getElementById("addToCartLink").href = href;
                                        document.getElementById("msg").innerText = ""; // Xóa thông báo lỗi nếu có
                                        return true; // Cho phép thực hiện chuyển hướng
                                    }
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

                                        <div class="media mb-3 border-bottom">
                                            <div class="mr-2"> 
                                                <img class="rounded-circle border p-1" src="data:image/svg+xml;charset=UTF-8,%3Csvg%20width%3D%2264%22%20height%3D%2264%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%2064%2064%22%20preserveAspectRatio%3D%22none%22%3E%3Cdefs%3E%3Cstyle%20type%3D%22text%2Fcss%22%3E%23holder_160c142c97c%20text%20%7B%20fill%3Argba(255%2C255%2C255%2C.75)%3Bfont-weight%3Anormal%3Bfont-family%3AHelvetica%2C%20monospace%3Bfont-size%3A10pt%20%7D%20%3C%2Fstyle%3E%3C%2Fdefs%3E%3Cg%20id%3D%22holder_160c142c97c%22%3E%3Crect%20width%3D%2264%22%20height%3D%2264%22%20fill%3D%22%23777%22%3E%3C%2Frect%3E%3Cg%3E%3Ctext%20x%3D%2213.5546875%22%20y%3D%2236.5%22%3E64x64%3C%2Ftext%3E%3C%2Fg%3E%3C%2Fg%3E%3C%2Fsvg%3E" alt="Generic placeholder image">
                                            </div>
                                            <div class="media-body">
                                                <p>${f.detail}</p>
                                                <div>
                                                    <img class="border  p-1 mr-2" src="data:image/jpeg;base64,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" style="width: 75px; height: 75px; object-fit: cover;" alt="User Image">
                                                    <img class="border  p-1 mr-2" src="data:image/jpeg;base64,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" style="width: 75px; height: 75px; object-fit: cover;" alt="User Image">
                                                </div>
                                                <small class="text-muted">Posted by ${f.name} on ${f.createdDate} <c:if test="${f.star == 1}">
                                                        <span class="product-rating">
                                                            <i class="bi bi-star-fill text-warning"></i>
                                                            <i class="bi bi-star"></i>
                                                            <i class="bi bi-star"></i>
                                                            <i class="bi bi-star"></i>
                                                            <i class="bi bi-star"></i>
                                                        </span>
                                                    </c:if>
                                                    <c:if test="${f.star == 2}">
                                                        <span class="product-rating">
                                                            <i class="bi bi-star-fill text-warning"></i>
                                                            <i class="bi bi-star-fill text-warning"></i>
                                                            <i class="bi bi-star"></i>
                                                            <i class="bi bi-star"></i>
                                                            <i class="bi bi-star"></i>
                                                        </span>
                                                    </c:if>
                                                    <c:if test="${f.star == 3}">
                                                        <span class="product-rating">
                                                            <i class="bi bi-star-fill text-warning"></i>
                                                            <i class="bi bi-star-fill text-warning"></i>
                                                            <i class="bi bi-star-fill text-warning"></i>
                                                            <i class="bi bi-star"></i>
                                                            <i class="bi bi-star"></i>
                                                        </span>
                                                    </c:if> 
                                                    <c:if test="${f.star == 4}">
                                                        <span class="product-rating">
                                                            <i class="bi bi-star-fill text-warning"></i>
                                                            <i class="bi bi-star-fill text-warning"></i>
                                                            <i class="bi bi-star-fill text-warning"></i>
                                                            <i class="bi bi-star-fill text-warning"></i>
                                                            <i class="bi bi-star"></i>
                                                        </span>
                                                    </c:if> 
                                                    <c:if test="${f.star == 5}">
                                                        <span class="product-rating">
                                                            <i class="bi bi-star-fill text-warning"></i>
                                                            <i class="bi bi-star-fill text-warning"></i>
                                                            <i class="bi bi-star-fill text-warning"></i>
                                                            <i class="bi bi-star-fill text-warning"></i>
                                                            <i class="bi bi-star-fill text-warning"></i>
                                                        </span>
                                                    </c:if> 
                                                </small>
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
                            <a href="feedback?productid=${requestScope.product.id}" class="btn hvr-hover">Leave a Review</a>
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
                                            if (user != null) {
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
    .product-rating {
        margin-left: 50px; /* Thay đổi giá trị để điều chỉnh khoảng cách theo ý muốn */
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