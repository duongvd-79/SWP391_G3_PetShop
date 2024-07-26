<!DOCTYPE html>
<html lang="en">
    <%@page contentType="text/html" pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@page import="model.User"%>
        <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>PawPaw Petshop</title>
        <link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon">
        <link rel="apple-touch-icon" href="images/apple-touch-icon.png">
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/responsive.css">
        <link rel="stylesheet" href="css/custom.css">
        <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->
        <style>
            .btn-luxury {
                background-color: #f39c12;
                color: #ffffff;
                border-color: #f39c12;
                padding: 10px 20px;
                font-size: 18px;
                border-radius: 5px;
            }

            .btn-luxury:hover,
            .btn-luxury:focus {
                background-color: #e08e0b;
                color: #ffffff;
                border-color: #e08e0b;
            }

            .order-success {
                text-align: left;
                margin-top: 20px;
                margin-bottom: 50px;
            }
            .order-success h1 {
                color: #333;
                margin-bottom: 10px;
            }
            .order-success h2 {
                font-size: 22px;
                color: #333;
                margin-bottom: 10px;
            }
            .order-success p {
                font-size: 16px;
                color: #555;
                margin-bottom: 10px;
            }
            .order-success .order-message {
                display: flex;
                align-items: center;
                margin-bottom: 20px;
            }
            .order-success .order-message img {
                width: 80px; /* Adjust size as needed */
                height: auto;
                margin-right: 10px;
            }
            .order-success .order-details {
                margin-top: 20px;
                border: 1px solid #e0e0e0;
                padding: 20px;
                background-color: #f9f9f9;
                border-radius: 5px;
                text-align: left;
            }
            .order-success .order-details h3 {
                font-size: 20px;
                color: #333;
                margin-bottom: 15px;
            }
            .order-success .order-details p {
                font-size: 16px;
                color: #555;
                margin-bottom: 5px;
            }
            .order-success .order-details .btn {
                margin-top: 20px;
            }
            .order-success .order-details .support {
                margin-top: 10px;
                font-size: 14px;
                color: #777;
            }
            .order-success .order-details .support a {
                color: #3498db;
                text-decoration: none;
                font-weight: 500;
            }
            .order-success .order-details .support a:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body>

        <jsp:include page="header.jsp"></jsp:include>

            <div class="cart-box-main">
                <div class="container">
                    <div class="row new-account-login">
                        <div class="col-lg-7 mb-3">
                            <div class="sticky-top" style="top: 150px; z-index: 2;">
                                <form class="mt-3">
                                    <h1>H2DV Petshop</h1>
                                    <div class="order-success">
                                        <div class="order-message">
                                            <img src="images/success.png" alt="Success Icon">
                                            <div>
                                                <h2>Đặt hàng thành công</h2>
                                                <p>Mã đơn hàng (${orderID})</p>
                                            <p>Cám ơn bạn đã mua hàng!</p>
                                        </div>
                                    </div>
                                    <p>Chúng tôi đã gửi thông tin đơn hàng đến email ${sessionScope.user.email}, vui lòng theo dõi đơn hàng.</p>
                                    <div class="order-details">
                                        <h3>Thông tin đơn hàng</h3>
                                        <p>Thông tin giao hàng:</p>
                                        <p>${sessionScope.user.name}</p>
                                        <p>${sessionScope.user.phone}</p>
                                        <p>${address.detail}</p>
                                        <p>${address.district}</p>
                                        <p>${address.city}</p>
                                        <p>Vietnam</p>
                                        <p>Phương thức thanh toán:</p>
                                        <p>${payment_method}</p>
                                    </div>
                                    <div class="form-row mt-4">
                                        <div class="form-group col-md-12 d-flex justify-content-between">
                                            <p>Cần hỗ trợ? <a href="cart" class="link-opacity-10-hover" id="back-to-cart">Liên hệ chúng tôi</a></p>
                                            <a href="home" class="btn btn-luxury ml-auto">Tiếp tục mua hàng</a>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="col-lg-5 mb-3 rounded p-2 bg-light">
                        <div class="title-left">
                            <h3>Cart information</h3>
                        </div>
                        <div class="rounded p-2 bg-light">
                            <c:forEach items="${cartDetailList}" var="c">
                                <div class="media mb-2 border-bottom">
                                    <img src="${c.thumbnail}" class="mr-3" alt="Product Image" style="width: 100px;">
                                    <div class="media-body">
                                        <a href="#">${c.title}</a>
                                        <div class="small text-muted">
                                            <c:set var="formattedPrice">
                                            <fmt:formatNumber value="${c.list_price *1000}" type="number" groupingUsed="true" minFractionDigits="0" maxFractionDigits="0"/>
                                </c:set>
                                <div class="ml-auto font-weight-bold">${formattedPrice} đ</div>
                                            Price: ${formattedPrice} đ<span class="quantity">Quantity: ${c.quantity}</span>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                            <div class="d-flex">
                                <h4>Subtotal</h4>
                                <c:set var="formattedPrice">
                                            <fmt:formatNumber value="${total_cost *1000}" type="number" groupingUsed="true" minFractionDigits="0" maxFractionDigits="0"/>
                                </c:set>
                                <div class="ml-auto font-weight-bold">${formattedPrice} đ</div>
                            </div>
                            <div class="d-flex border-bottom">
                                <h4>Shipping cost</h4>
                                <div class="ml-auto font-weight-bold">-</div>
                            </div>
                            <div class="d-flex gr-total">
                                <h5>Total</h5>
                                <div class="ml-auto h5">${formattedPrice} đ</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="footer.jsp"></jsp:include>


        <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.21.1/axios.min.js"></script>
        <script src="js/jquery-2.2.4.min.js"></script>
        <script src="js/popper.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/plugins.js"></script>
        <script src="js/main.js"></script>
        <script src="js/custom.js"></script>
        <script src="js/active.js"></script>
    </body>
</html>
