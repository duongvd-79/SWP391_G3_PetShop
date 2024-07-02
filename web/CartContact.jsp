<!DOCTYPE html>
<html lang="en">
    <%@page contentType="text/html" pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@page import="model.User"%>
    <%@page import="model.Address"%>
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
    </head>
    <body>

        <jsp:include page="header.jsp"></jsp:include>

            <div class="cart-box-main">
                <div class="container">
                    <div class="row new-account-login">
                        <div class="col-lg-7 mb-3">
                            <div class="sticky-top" style="top: 150px; z-index: 2;">
                                <div class="title-left">
                                    <h3>Delivery Information</h3>
                                </div>
                                <form class="mt-3">
                                    <div class="form-row">
                                        <div class="form-group col-md-12">
                                            <label for="InputName" class="mb-0">Fullname</label>
                                            <input type="text" class="form-control" id="InputName" value="${userinfor.getName()}" readonly>
                                    </div>
                                    <div class="form-group col-md-8">
                                        <label for="InputEmail" class="mb-0">Email</label>
                                        <input type="email" class="form-control" id="InputEmail" value="${userinfor.getEmail()}" readonly>
                                    </div>
                                    <div class="form-group col-md-4">
                                        <label for="InputPhone" class="mb-0">Phone number</label>
                                        <input type="text" class="form-control" id="InputPhone" value="${userinfor.getPhone()}" readonly>
                                    </div>
                                </div>
                                <div class="delivery-address">
                                    <div class="form-row">
                                        <h3>Delivery Address</h3>
                                        <a href="addresspopup" class="btn btn-link change-address">Change address</a>

                                    </div>
                                    <div class="form-row">
                                        <div class="form-group col-md-12">
                                            <label for="InputAddress" class="mb-0">Detail Address</label>
                                            <input type="text" class="form-control" id="InputAddress" value="${defaultAddress.getDetail()}" readonly>
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="form-group col-md-6">
                                            <label for="InputCity" class="mb-0">City</label>
                                            <input type="text" class="form-control" id="InputCity" value="${defaultAddress.getCity()}" readonly>
                                        </div>
                                        <div class="form-group col-md-6">
                                            <label for="InputDistrict" class="mb-0">District</label>
                                            <input type="text" class="form-control" id="InputDistrict" value="${defaultAddress.getDistrict()}" readonly>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-row mt-4">
                                    <div class="form-group col-md-12 d-flex justify-content-between">
                                        <p><a href="cart" class="link-opacity-10-hover" id="back-to-cart">Back to cart</a></p>
                                        <button type="submit" class="btn btn-luxury ml-auto">Continue to payment method</button>
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
                                            Price: ${c.list_price}00₫ <span class="quantity">Quantity: ${c.quantity}</span>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                            <div class="d-flex">
                                <h4>Subtotal</h4>
                                <div class="ml-auto font-weight-bold">${total_cost}00₫</div>
                            </div>
                            <div class="d-flex border-bottom">
                                <h4>Shipping cost</h4>
                                <div class="ml-auto font-weight-bold">-</div>
                            </div>
                            <div class="d-flex gr-total">
                                <h5>Total</h5>
                                <div class="ml-auto h5">${total_cost}00₫</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Change address popup -->
        <div id="addresspopup" class="overlay">
            <div class="popup">
                <form action="confirmaddress" method="get">
                    <div class="popup-header border-bottom">
                        <h3>My Address</h3>
                        <a class="close" href="#!">&times;</a> <!-- Thêm dấu X để đóng popup -->
                    </div>
                    <c:if test="${not empty addressList}">
                        <div class="addresses">
                            <c:forEach items="${addressList}" var="a">
                                <div class="addresses">
                                    <div class="address">
                                        <div class="address-details">
                                            <div class="custom-control custom-radio">
                                                <input type="radio" id="address${a.id}" name="addressid" class="custom-control-input"
                                                       value="${a.getId()}"  <c:if test="${a.isIsDefault()}">checked</c:if>>
                                                <label class="custom-control-label" for="address${a.id}">
                                                    ${a.getDetail()}<br>
                                                    ${a.getDistrict()}, ${a.getCity()}.
                                                </label>
                                            </div>
                                            <div class="actions">
                                                <c:if test="${!a.isIsDefault()}">
                                                    <a href="addressdetail?addressid=${a.getId()}" class="btn btn-link update-address">Update Address</a>
                                                    <button type="button" class="btn btn-link remove-address" onclick="confirmRemove(${a.getId()}, event)">Remove</button>
                                                </c:if>
                                            </div>

                                        </div>
                                        <hr>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:if>

                    <div class="popup-footer">
                        <a href="#addnewaddress" class="btn btn-primary" role="button">Add New Address</a>
                        <button type="submit" class="btn btn-primary">Confirm</button>
                    </div>
                </form>
            </div>
        </div>



        <!-- update address popup -->
        <div id="updateaddresspopup" class="overlay">
            <div class="popup">
                <form action="updateaddress" method="get" onsubmit="return validateAddNewAddress()">
                    <div class="popup-header border-bottom">
                        <h3>Update Address</h3>
                        <a class="close" href="#!">&times;</a>
                    </div>
                    <c:if test="${address != null}">
                        <div class="popup-body">

                            <div class="form-group">
                                <label for="inputDetailAddress">Detail Address</label>
                                <input type="hidden" id="addressId" name="aid" value="${sessionScope.address.id}">
                                <input type="text" class="form-control" id="inputDetailAddress" name="detail" value="${sessionScope.address.detail}">
                            </div>
                            <div class="form-row">
                                <div class="form-group col-md-6">
                                    <label for="pfcity">City</label>
                                    <select class="form-control" id="adcity" name="adcity">
                                        <option selected>${sessionScope.address.city}</option>

                                    </select>
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="pfdistrict">District</label>
                                    <select class="form-control" id="addistrict" name="addistrict">
                                        <option selected>${sessionScope.address.district}</option>

                                    </select>
                                </div>
                            </div>
                        </div>
                    </c:if>
                    <div class="popup-footer">
                        <a href="#addresspopup" class="btn btn-secondary" role="button">Back</a>
                        <button type="submit" class="btn btn-primary" value="Save">Save</button>
                    </div>
                </form>
            </div>
        </div>



        <!-- Add address popup -->
        <div id="addnewaddress" class="overlay">
            <div class="popup">
                <form action="addaddress" method="get" onsubmit="return validateAddNewAddress()">
                    <div class="popup-header border-bottom">
                        <h3>Update Address</h3>
                        <a class="close" href="#!">&times;</a>
                    </div>
                    <div class="popup-body">

                        <div class="form-group">
                            <label for="inputDetailAddress">Detail Address</label>
                            <input type="text" class="form-control" name="detail" id="inputDetailAddress">
                        </div>
                        <div class="form-row">
                            <div class="form-group col-md-6">
                                <label for="pfcity">City</label>
                                <select class="form-control" id="newcity" name="newcity">
                                    <option selected></option>
                                </select>
                            </div>
                            <div class="form-group col-md-6">
                                <label for="pfdistrict">District</label>
                                <select class="form-control" id="newdistrict" name="newdistrict">
                                    <option selected></option>
                                </select>
                            </div>
                        </div>

                    </div>
                    <div class="popup-footer">
                        <a href="#addresspopup" class="btn btn-secondary" role="button">Back</a>
                        <button type="submit" class="btn btn-primary" value="Save">Save</button>
                    </div>
                </form>
            </div>
        </div>

        <jsp:include page="footer.jsp"></jsp:include>

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

            #back-to-cart {
                color: #3498db;
                transition: color 0.3s;
                font-weight: bold;
            }

            #back-to-cart:hover {
                color: #2980b9;
            }

            .delivery-address {
                background-color: #f9f9f9;
                border: 1px solid #e0e0e0;
                padding: 20px;
                box-shadow: 0px 0px 10px 0px rgba(0,0,0,0.1);
                margin-bottom: 20px;
            }

            .delivery-address h3 {
                margin-bottom: 15px;
            }

            .change-address {
                float: right;
                margin-top: -30px;
            }

            .media-body {
                width: 70%;
            }
            .quantity {
                display: inline-block;
                margin-left: 10px; /* Điều chỉnh khoảng cách giữa giá và số lượng */
                color: #555; /* Đổi màu sắc nếu cần thiết */
            }

            .delivery-address {
                display: flex;
                flex-direction: column;
            }

            .delivery-address .form-row {
                display: flex;
                align-items: center;
            }

            .delivery-address h3 {
                margin-right: auto; /* Đẩy nút Change address về bên trái nhất có thể */
            }

            .change-address {
                margin-left: 10px; /* Để cách nút Change address với tiêu đề Delivery Address */
            }

            .popup {
                position: fixed;
                top: 20%;
                left: 50%;
                transform: translate(-50%, -50%);
                background: #fff;
                padding: 30px;
                border-radius: 10px;
                width: 70%;
                max-width: 600px;
                box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
                z-index: 1000;
                overflow-y: auto;
            }


            .overlay {
                position: fixed;
                top: 0;
                bottom: 0;
                left: 0;
                right: 0;
                background: rgba(0, 0, 0, 0.7);
                transition: opacity 500ms;
                display: none;
                opacity: 0;
                z-index: 999;
            }

            .overlay:target {
                display: flex;
                align-items: center;
                justify-content: center;
                opacity: 1;
            }

            .addresses {
                margin-top: 20px;
            }

            .address {
                margin-bottom: 15px;
                padding: 15px;
                background-color: #f9f9f9;
                border-radius: 8px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }

            .address-details {
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .actions {
                display: flex;
                align-items: center;
            }

            .btn-link {
                color: #3498db;
                padding: 0;
                margin-right: 10px;
                text-decoration: none;
                transition: color 0.3s ease;
            }

            .btn-link:hover {
                color: #2980b9;
            }

            .remove-address {
                color: #e74c3c;
                padding: 0;
                margin-left: auto;
                background: none;
                border: none;
                cursor: pointer;
                transition: color 0.3s ease;
            }

            .remove-address:hover {
                color: #c0392b;
            }

            .add-new-address {
                text-align: center;
                margin-top: 20px;
            }

            .add-new-address .btn-primary {
                background-color: #27ae60;
                border-color: #27ae60;
                color: #fff;
                font-weight: bold;
                text-decoration: none;
                transition: background-color 0.3s ease, border-color 0.3s ease, color 0.3s ease;
                padding: 10px 20px;
                border-radius: 5px;
                cursor: pointer;
            }

            .add-new-address .btn-primary:hover {
                background-color: #219653;
                border-color: #1e8449;
            }


            .popup-footer {
                display: flex;
                justify-content: space-between;
                margin-top: 30px;
            }

            .popup-footer .btn {
                width: 48%;
                border-radius: 5px;
                transition: background-color 0.3s ease, color 0.3s ease;
            }

            .btn-primary {
                background-color: #3498db;
                border-color: #3498db;
                color: #fff;
            }

            .btn-secondary {
                background-color: #ccc;
                border-color: #ccc;
                color: #333;
            }

            .btn-primary:hover, .btn-secondary:hover {
                background-color: #2980b9;
                border-color: #2980b9;
                color: #fff;
            }

            .popup-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px; /* Để tạo khoảng cách giữa tiêu đề và nút */
            }

            .addresses {
                max-height: 400px; /* Đặt chiều cao tối đa mà bạn muốn */
                overflow-y: auto; /* Thêm khả năng cuộn theo chiều dọc */
            }



        </style>

        <script>
            var cities3 = document.getElementById("adcity");
            var districts3 = document.getElementById("addistrict");

            var Parameter3 = {
                url: "js/data.json",
                method: "GET",
                responseType: "application/json",
            };

            var promise3 = axios(Parameter3);
            promise3.then(function (result3) {
                renderCity3(result3.data);
            });

            function renderCity3(data) {
                for (const city of data) {
                    cities3.options[cities3.options.length] = new Option(city.Name);
                }

                cities3.onchange = function () {
                    districts3.length = 1;

                    if (this.value !== "") {
                        const selectedCity = data.find(city => city.Name === this.value);

                        for (const district of selectedCity.Districts) {
                            districts3.options[districts3.options.length] = new Option(district.Name);
                        }
                    }
                };
            }
        </script>

        <script>
            var cities4 = document.getElementById("newcity");
            var districts4 = document.getElementById("newdistrict");

            var Parameter4 = {
                url: "js/data.json",
                method: "GET",
                responseType: "application/json",
            };

            var promise4 = axios(Parameter4);
            promise4.then(function (result4) {
                renderCity4(result4.data);
            });

            function renderCity4(data) {
                for (const city of data) {
                    cities4.options[cities4.options.length] = new Option(city.Name);
                }

                cities4.onchange = function () {
                    districts4.length = 1;

                    if (this.value !== "") {
                        const selectedCity = data.find(city => city.Name === this.value);

                        for (const district of selectedCity.Districts) {
                            districts4.options[districts4.options.length] = new Option(district.Name);
                        }
                    }
                };
            }
        </script>

<!--        <script>
            function validateAddNewAddress() {
                var detailAddress = document.getElementById('inputDetailAddress').value;
                var city = document.getElementById('newcity').value;
                var district = document.getElementById('newdistrict').value;

                if (detailAddress.trim() === "" || city.trim() === "" || district.trim() === "") {
                    alert("Please fill in all fields.");
                    return false;
                }
                return true;
            }
        </script>

        <script>
            function validateAddNewAddress() {
                var detailAddress = document.getElementById('inputDetailAddress').value;
                var city = document.getElementById('newcity').value;
                var district = document.getElementById('newdistrict').value;

                if (detailAddress.trim() === "" || city.trim() === "" || district.trim() === "") {
                    alert("Please fill in the information.");
                    return false;
                }

                return true;
            }
        </script>-->

        <script>
            function confirmRemove(addressId, event) {
                if (confirm("Bạn có chắc chắn muốn xóa địa chỉ này không?")) {
                    window.location.href = "deleteaddress?id=" + addressId;
                } else {
                    event.preventDefault();
                }
            }


        </script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.21.1/axios.min.js"></script>
        <script src="js/jquery-3.2.1.min.js"></script>
        <script src="js/popper.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
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