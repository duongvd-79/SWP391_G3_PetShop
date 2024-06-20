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
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>ThewayShop - Ecommerce Bootstrap 4 HTML Template</title>
        <meta name="keywords" content="">
        <meta name="description" content="">
        <meta name="author" content="">
        <link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon">
        <link rel="apple-touch-icon" href="images/apple-touch-icon.png">
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.3/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/responsive.css">
        <link rel="stylesheet" href="css/custom.css">
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
          <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->
        <style>
            .empty-cart-message {
                background-color: #f8f9fa;
                padding: 40px;
                border-radius: 10px;
                margin: 20px 0;
                width: 100%;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }
            .empty-cart-message h4 {
                font-size: 24px;
                color: #000000;
                margin-bottom: 20px;
            }
            .empty-cart-message p {
                font-size: 18px;
                color: #6c757d;
            }
            .empty-cart-message .btn {
                margin-top: 20px;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>
        
        
        <div class="cart-box-main">
            <div  class="container">
                <c:choose>
                    <c:when test="${empty cartDetailList}">
                        <div class="row justify-content-center">
                            <div class="col-12 text-center">
                                <div class="empty-cart-message">
                                    <h4>Your Cart is Empty!</h4>
                                    <p>It looks like you haven't added any products to your cart yet.</p>
                                    <p>Explore our latest products and start adding items to your cart!</p>
                                    <a href="shop.html" class="btn hvr-hover btn-black">Continue Shopping</a>
                                </div>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
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
                                             <c:forEach begin="0" end="${length}" var="i" step="1">
                                                <tr>
                                                    <td class="thumbnail-img">
                                                        <a href="#">
                                                            <img class="img-fluid" src="${cartDetailList[i].thumbnail}" alt="" />
                                                        </a>
                                                    </td>
                                                    <td class="name-pr">
                                                        <a href="#">
                                                            ${cartDetailList[i].title}
                                                        </a>
                                                    </td>
                                                    <td class="price-pr">
                                                        <p>${cartDetailList[i].list_price}00 vnd</p>
                                                    </td>
                                                    <td class="quantity-box">                   
                                                        <input type="number" size="4" value="${cartDetailList[i].quantity}" min="1" step="1" max="${quantityList[i]}" class="c-input-text qty text" onchange="updateQuantity(${cartDetailList[i].productId}, this.value)">
                                                    </td>
                                                    <td class="total-pr">
                                                        <p>${cartDetailList[i].list_price * cartDetailList[i].quantity}00 vnd</p>
                                                    </td>
                                                    <td class="remove-pr">
                                                        <a href="deletecartitem?id=${cartDetailList[i].id}">
                                                            <i class="bi bi-trash"></i>
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            <% } %>
                                        </tbody>
                                    </table>
                                    <script>
                                        function updateQuantity(productid, quantity) {
                                            window.location = "changecart?productid=" + productid + "&quantity=" + quantity;
                                        }
                                    </script>
                                </div>
                            </div>
                            <div  class="col-lg-4  col-sm-12">
                                <div class="sticky-top" style="top: 135px; z-index: 2">
                                    <div class="order-box">
                                        <h3>Order summary</h3>
                                        <div class="d-flex gr-total">
                                            <h5>Grand Total</h5>
                                            <div class="ml-auto h5">${grand_total}00 vnd</div>
                                        </div>
                                        <hr> 
                                    </div>
                                    <div class="col-12 d-flex shopping-box justify-content-between">
                                        <a href="home" class="btn hvr-hover btn-black">Continue Shopping</a>
                                        <a href="cartcontact" class="btn hvr-hover">Checkout</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>

                <div class="title-all text-lg-center">
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
                                              User user = (User) session.getAttribute("user");
                                            if (user != null) {
                                        %>
                                        <a class="cart" href="addcartpage?productid=${l.id}&quantity=1">Add to Cart</a>
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
