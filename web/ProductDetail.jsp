<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
        <style>
            .out-of-stock-img {
                -webkit-filter: grayscale(100%);
                filter: grayscale(100%);
            }
            .img-overlay {
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                width: 100%;
                height: 20%;
                z-index:8;
            }
            .img-overlay-text {
                display: flex;
                background: rgba(0, 0, 0, 0.5);
                color: #ffffff;
                padding: 2px 10px;
                font-weight: 700;
                height: 100%;
                justify-content: center;
                align-items: center;
                text-transform: uppercase;
                font-size: 150%;
            }
        </style>
    </head>

    <body>
        <jsp:include page="header.jsp"></jsp:include>
            <!-- Start All Title Box -->
            <div class="all-title-box">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12">
                            <h2>Product Detail</h2>
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
                                <div class="carousel-inner position-relative" role="listbox">
                                    <div class="carousel-item active"><img class="d-block w-100 ${product.status eq 'Out of Stock' ? 'out-of-stock-img' : ''}" src=${product.thumbnail}></div>
                                    <c:if test="${product.status eq 'Out of Stock'}">
                                    <div class="img-overlay">
                                        <div class="img-overlay-text">Out of Stock</div>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-7 col-lg-7 col-md-6">
                        <div class="single-product-details">
                            <h2>${requestScope.product.title}</h2>
                            <div class="price-with-rating">
                                <h5><c:set var="formattedPrice">
                                        <fmt:formatNumber value="${requestScope.product.listPrice * 1000 +100000}" type="number" groupingUsed="true" minFractionDigits="0" maxFractionDigits="0"/>
                                    </c:set>
                                    <c:set var="formattedPrice2">
                                        <fmt:formatNumber value="${requestScope.product.listPrice *1000}" type="number" groupingUsed="true" minFractionDigits="0" maxFractionDigits="0"/>
                                    </c:set>
                                    <del>${formattedPrice} đ </del>${formattedPrice2} đ
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

                            <h4>Description:</h4>
                            <div>${requestScope.product.description}</div>
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
                                <%
                                    if (user != null && user.getRoleId() == 5) {
                                %>
                                <div class="cart-and-bay-btn">
                                    <a id="addToCartLink" class="btn hvr-hover" data-fancybox-close="" href="#" onclick="return updateHref()">Add to cart</a>
                                </div>
                                <div>
                                    <p id="msg" style="color: red;"></p>
                                </div>
                                <%} else {%>
                                <a class="btn hvr-hover" data-fancybox-close="" href="#loginpopup">Login to Buy</a>
                                <%}%>
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
                            <h2>Newest Reviews</h2>
                        </div>
                        <div class="card-body">
                            <c:set var="fl" value="${requestScope.feedbackList}"/>
                            <c:choose>
                                <c:when test="${not empty fl}">
                                    <c:forEach begin="0" end="${length}" var="i" step="1">

                                        <div class="media mb-3 border-bottom">
                                            <div class="mr-2"> 
                                                <img class="rounded-circle border p-1" src="data:image/svg+xml;charset=UTF-8,%3Csvg%20width%3D%2264%22%20height%3D%2264%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%2064%2064%22%20preserveAspectRatio%3D%22none%22%3E%3Cdefs%3E%3Cstyle%20type%3D%22text%2Fcss%22%3E%23holder_160c142c97c%20text%20%7B%20fill%3Argba(255%2C255%2C255%2C.75)%3Bfont-weight%3Anormal%3Bfont-family%3AHelvetica%2C%20monospace%3Bfont-size%3A10pt%20%7D%20%3C%2Fstyle%3E%3C%2Fdefs%3E%3Cg%20id%3D%22holder_160c142c97c%22%3E%3Crect%20width%3D%2264%22%20height%3D%2264%22%20fill%3D%22%23777%22%3E%3C%2Frect%3E%3Cg%3E%3Ctext%20x%3D%2213.5546875%22%20y%3D%2236.5%22%3E64x64%3C%2Ftext%3E%3C%2Fg%3E%3C%2Fg%3E%3C%2Fsvg%3E" alt="Generic placeholder image">
                                            </div>
                                            <div class="media-body">
                                                <small class="text-muted">Posted by ${fl[i].name} on ${fl[i].createdDate} <c:if test="${fl[i].star == 1}">
                                                        <span class="product-rating">
                                                            <i class="bi bi-star-fill text-warning"></i>
                                                            <i class="bi bi-star"></i>
                                                            <i class="bi bi-star"></i>
                                                            <i class="bi bi-star"></i>
                                                            <i class="bi bi-star"></i>
                                                        </span>
                                                    </c:if>
                                                    <c:if test="${fl[i].star == 2}">
                                                        <span class="product-rating">
                                                            <i class="bi bi-star-fill text-warning"></i>
                                                            <i class="bi bi-star-fill text-warning"></i>
                                                            <i class="bi bi-star"></i>
                                                            <i class="bi bi-star"></i>
                                                            <i class="bi bi-star"></i>
                                                        </span>
                                                    </c:if>
                                                    <c:if test="${fl[i].star == 3}">
                                                        <span class="product-rating">
                                                            <i class="bi bi-star-fill text-warning"></i>
                                                            <i class="bi bi-star-fill text-warning"></i>
                                                            <i class="bi bi-star-fill text-warning"></i>
                                                            <i class="bi bi-star"></i>
                                                            <i class="bi bi-star"></i>
                                                        </span>
                                                    </c:if> 
                                                    <c:if test="${fl[i].star == 4}">
                                                        <span class="product-rating">
                                                            <i class="bi bi-star-fill text-warning"></i>
                                                            <i class="bi bi-star-fill text-warning"></i>
                                                            <i class="bi bi-star-fill text-warning"></i>
                                                            <i class="bi bi-star-fill text-warning"></i>
                                                            <i class="bi bi-star"></i>
                                                        </span>
                                                    </c:if> 
                                                    <c:if test="${fl[i].star == 5}">
                                                        <span class="product-rating">
                                                            <i class="bi bi-star-fill text-warning"></i>
                                                            <i class="bi bi-star-fill text-warning"></i>
                                                            <i class="bi bi-star-fill text-warning"></i>
                                                            <i class="bi bi-star-fill text-warning"></i>
                                                            <i class="bi bi-star-fill text-warning"></i>
                                                        </span>
                                                    </c:if> 
                                                </small>
                                                <p>${fl[i].detail}</p>
                                                <div>
                                                    <c:forEach items="${imageList[i]}" var="im">
                                                        <img class="border  p-1 mr-2" src="${im.feedback_image}" style="width: 75px; height: 75px; object-fit: cover;" alt="User Image">
                                                    </c:forEach>
                                                </div>

                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <p>No reviews yet!</p>
                                </c:otherwise>
                            </c:choose>

                            <hr>
                            
                           
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