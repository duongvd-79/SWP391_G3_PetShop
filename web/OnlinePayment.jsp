<!DOCTYPE html>
<html lang="en">
    <%@page contentType="text/html" pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ page import="java.util.ArrayList" %>
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
            /* Global styles for the page */
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

            #back-to-cart {
                color: #3498db;
                transition: color 0.3s;
                font-weight: bold;
            }

            #back-to-cart:hover {
                color: #2980b9;
            }

            .payment-method, .delivery-method {
                background-color: #f9f9f9;
                border: 1px solid #e0e0e0;
                padding: 20px;
                box-shadow: 0px 0px 10px 0px rgba(0,0,0,0.1);
                margin-bottom: 20px;
            }

            .payment-method .form-row, .delivery-method .form-row {
                display: flex;
                align-items: center;
                margin-bottom: 10px;
            }

            .payment-method label, .delivery-method label {
                margin-bottom: 0;
                font-weight: 500;
                margin-left: 10px;
            }

            .instructions {
                display: none;
                background-color: #fff;
                border: 1px solid #e0e0e0;
                padding: 20px;
                box-shadow: 0px 0px 10px 0px rgba(0,0,0,0.1);
                margin-top: 20px;
            }

            /* Custom radio button style for both Delivery and Payment methods */
            .payment-method input[type="radio"], .delivery-method input[type="radio"] {
                appearance: none;
                -webkit-appearance: none;
                -moz-appearance: none;
                width: 20px;
                height: 20px;
                border: 2px solid #3498db;
                border-radius: 50%;
                outline: none;
                cursor: pointer;
                margin-right: 10px;
            }

            .payment-method input[type="radio"]:checked, .delivery-method input[type="radio"]:checked {
                background-color: #3498db;
            }

            .payment-method input[type="radio"]:checked::after, .delivery-method input[type="radio"]:checked::after {
                content: '';
                display: block;
                width: 10px;
                height: 10px;
                border-radius: 50%;
                background-color: #fff;
                margin: 4px;
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
                                <div style="font-size: 16px; font-weight: 700; margin-bottom: 20px">
                                    <h3>Delivery Method</h3>
                                </div>
                                <form class="mt-3">
                                    <div class="delivery-method">
                                        <div class="form-row">
                                            <div class="form-group col-md-1">
                                                <label>
                                                    <input type="radio" name="delivery" value="standard" checked>
                                                </label>
                                            </div>
                                            <div class="form-group col-md-9">
                                                <label for="standard">Giao hàng từ 3-4 ngày (Nếu kiện hàng có kích thước to hoặc nặng hơn 2kg, nhân viên sẽ báo lại phí ship với khách)</label>
                                            </div>
                                            <div class="form-group col-md-2">
                                                26.000vnd
                                            </div>
                                        </div>
                                        <!-- Add more delivery options similarly -->
                                    </div>

                                    <div style="font-size: 16px; font-weight: 700; margin-bottom: 20px">
                                        <h3>Payment Method</h3>
                                    </div>
                                    <div class="payment-method">
                                        <div class="form-row">
                                            <div class="form-group col-md-1">
                                                <label>
                                                    <input type="radio" name="payment" value="credit-card" onclick="showPaymentInstructions('credit-card-instructions')">
                                                </label>
                                            </div>
                                            <div class="form-group col-md-11">
                                                <label for="credit-card">Pay after receiving products (COD)</label>
                                            </div>
                                        </div>
                                        <div class="form-row">
                                            <div class="form-group col-md-1">
                                                <label>
                                                    <input type="radio" name="payment" value="paypal" onclick="showPaymentInstructions('paypal-instructions')">
                                                </label>
                                            </div>
                                            <div class="form-group col-md-11">
                                                <label for="paypal">Online bank transfer</label>
                                            </div>
                                        </div>
                                     
                                    </div>
                                    <div id="payment-instructions" class="mt-3">
                                        <div id="credit-card-instructions" class="instructions">
                                            <p>1. After successfully placing an order, Shop receives information and confirms the order with the customer via Email (please check your Email).</p>
                                            <p>2. Shop creates a shipping order for the confirmed order.</p>
                                            <p>3. Play with Boss and wait for the shipper to deliver to your house.</p>
                                        </div>
                                        <div id="paypal-instructions" class="instructions">
                                            <p>Ngân hàng Quân Đội Việt Nam MBBank</p>
                                            <p>Chủ tài khoản: NGUYEN QUY DUONG</p>
                                            <p>Số tài khoản: 19036727590019</p>
                                            <p></p>
                                            <p>1. Sau khi đặt hàng và chuyển khoản thanh toán thành công (Nội dung chuyển khoản: Họ tên + mã đơn hàng).</p>
                                            <p>2. PawPaw nhận thông tin và xác nhận đơn với khách hàng qua Email (khách vui lòng kiểm tra Email).</p>
                                            <p>3. PawPaw tạo đơn vận chuyển cho đơn hàng đã được xác nhận.</p>
                                            <p>4. Chơi với Boss và đợi shipper giao hàng tận cửa.</p>
                                        </div>
                                       
                                    </div>
                                    <div class="form-row mt-4">
                                        <div class="form-group col-md-12 d-flex justify-content-between">
                                            <p><a href="cart" class="link-opacity-10-hover" id="back-to-cart">Back to cart</a></p>
                                            <button type="submit" class="btn btn-luxury ml-auto">Finish purchasing order</button>
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
                                <div class="media mb-2 border-bottom">
                                    <img src="#" class="mr-3" alt="Product Image" style="width: 100px;">
                                    <div class="media-body">
                                        <a href="#">Sample title</a>
                                        <div class="small text-muted">
                                            Price: 100₫ <span class="quantity">Quantity: 1</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="d-flex">
                                    <h4>Subtotal</h4>
                                    <div class="ml-auto font-weight-bold">100₫</div>
                                </div>
                                <div class="d-flex border-bottom">
                                    <h4>Shipping cost</h4>
                                    <div class="ml-auto font-weight-bold">-</div>
                                </div>
                                <div class="d-flex gr-total">
                                    <h5>Total</h5>
                                    <div class="ml-auto h5">200.00₫</div>
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
        <script>
                                                        function showPaymentInstructions(id) {
                                                            var instructions = document.getElementsByClassName('instructions');
                                                            for (var i = 0; i < instructions.length; i++) {
                                                                instructions[i].style.display = 'none';
                                                            }
                                                            document.getElementById(id).style.display = 'block';
                                                        }
        </script>

    </body>
</html>
