<%-- 
    Document   : Cart
    Created on : Jun 10, 2024, 11:29:07 PM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        <title>ThewayShop - Ecommerce Bootstrap 4 HTML Template</title>
        <meta name="keywords" content="">
        <meta name="description" content="">
        <meta name="author" content="">

        <!-- Site Icons -->
        <link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon">
        <link rel="apple-touch-icon" href="images/apple-touch-icon.png">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.3/font/bootstrap-icons.min.css">

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
        <!-- Start Main Top -->

        <!-- End Main Top -->

        <!-- Start Main Top -->


        <jsp:include page="header.jsp"></jsp:include>
            <!-- Start All Title Box -->
            <div class="all-title-box">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12">
                            <ul class="breadcrumb">
                                <li class="breadcrumb-item"><a href="#">Shop</a></li>
                                <li class="breadcrumb-item active">Cart</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <!-- End All Title Box -->

            <!-- Start Cart  -->
            <div class="cart-box-main">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-lg-8 col-sm-12">
                            <div class="table-main table">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>Images</th>
                                            <th>Product Name</th>
                                            <th>Price</th>
                                            <th>Quantity</th>
                                            <th>Total</th>
                                            <th>Remove</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <%
                                      User user = (User) session.getAttribute("user");
                                        if (user != null) {
                                    %>
                                    <c:forEach items="${cartDetailList}" var="c">
                                        <tr>
                                            <td class="thumbnail-img">
                                                <a href="#">
                                                    <img class="img-fluid" src="${c.thumbnail}" alt="" />
                                                </a>
                                            </td>
                                            <td class="name-pr">
                                                <a href="#">
                                                    ${c.title}
                                                </a>
                                            </td>
                                            <td class="price-pr">
                                                <p>${c.list_price}00 vnd</p>
                                            </td>
                                            <td class="quantity-box">                   
                                                <input type="number" size="4" value="${c.quantity}" min="1" step="1" class="c-input-text qty text" onchange="updateQuantity(${c.productId}, this.value)">
                                            </td>
                                            <td class="total-pr">
                                                <p>${c.list_price * c.quantity}00 vnd</p>
                                            </td>
                                            <td class="remove-pr">
                                                <a href="deletecartitem?id=${c.id}">
                                                    <i class="bi bi-trash"></i>
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                            <script>
                                function updateQuantity(productid, quantity) {
                                    // Thay đổi URL bên dưới thành đường dẫn thực tế của bạn
                                    window.location = "changecart?productid=" + productid + "&quantity=" + quantity;
                                }
                            </script>
                            <% } %>
                        </div>
                    </div>
                    <div class="col-lg-4 col-sm-12">
                        <div class="order-box">
                            <h3>Order summary</h3>

                            <div class="d-flex gr-total">
                                <h5>Grand Total</h5>
                                <div class="ml-auto h5">${grand_total}00 vnd</div>
                            </div>
                            <hr> </div>
                        <div class="col-12 d-flex shopping-box justify-content-between">
                            <a href="checkout.html" class="btn hvr-hover btn-black">Continue Shopping</a>
                            <a href="checkout.html" class="btn hvr-hover">Checkout</a>
                        </div>
                    </div>
                </div>
                <div class="title-all text-center">
                    <h1>Latest Products</h1>
                    <p>Explore these similar products and seize the opportunity to add them to your cart for exclusive deals!</p>
                </div>
                <div class="row special-list">
                    <c:forEach items="${latestProductList}" var="l">
                        <div class="col-lg-3 col-md-6 special-grid best-seller">

                            <div class="products-single fix">
                                <div class="box-img-hover">
                                    <div class="type-lb">
                                        <p class="sale">New</p>
                                    </div>
                                    <img src="${l.thumbnail}" class="img-fluid" alt="Image">
                                    <div class="mask-icon">
                                        <a class="view" href="productdetail?id=${l.id}">View</a>
                                        <%
                                    
                                            if (user != null) {
                                        %>
                                        <a class="cart" href="addcart?productid=${l.id}&userid=${user.getId()}&quantity=0">Add to Cart</a>
                                        <%}%>
                                    </div>
                                </div>
                                <div class="why-text">
                                    <h4>${l.title}</h4>
                                    <h5>${l.listPrice}00 vnd</h5>
                                </div>
                            </div>

                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
        <!-- End Cart -->

        <style>
            .btn-black {
                background-color: black;
                color: white;
                border: 1px solid black;
            }

            .btn-black:hover {
                background-color: #333;
                color: white;
            }

        </style>

        <!-- Start Footer  -->
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