<%-- 
    Document   : myorders
    Created on : Jun 13, 2024, 8:57:04 AM
    Author     : ACER
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page import="model.User"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="shortcut icon" href="images/icon.ico" type="image/x-icon">
        <link rel="apple-touch-icon" href="images/apple-touch-icon.png">

        <!-- Bootstrap CSS -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
        <!-- Icon CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <!-- Site CSS -->
        <link rel="stylesheet" href="css/style.css">
        <!-- Responsive CSS -->
        <link rel="stylesheet" href="css/responsive.css">
        <link rel="stylesheet" href="css/public/productList.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
        <title>JSP Page</title>
        <style>
            a:hover{
                color:white;
            }
            .status{
                width:15%;
                font-size: 16px;
                font-weight: 700;
            }
            .active {
                border-radius: 5px;
                border-bottom-width:3px !important;
            }
            .page-link.active{
                color: white;
                background-color: rgb(176, 180, 53) !important;
            }
            .page-item.active .page-link {
                background-color: #b0b435;
                border-color: #b0b435;
            }
            .page-link {
                color: #212121;
            }
            .page-link:hover{
                color: #212121;
            }
            #clearSearchInput {
                display: none;
            }
            #toast-container > .toast {
                opacity: 1 !important;
            }
        </style>
    </head>
    <jsp:include page="header.jsp"></jsp:include>

        <body>
            <div class="all-title-box">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12">
                            <ul style="font-weight:bold;background-color: transparent;" class="breadcrumb float-left">
                                <li style="color:#b0b435;" class="breadcrumb-item active">ORDER INFORMATION</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container-fluid">               
                <div style="min-height:759px;" class="container-fluid mt-2 ">
                    <div class="row">
                        <div class="sidebar container-fluid col-sm-3">
                            <!-- Start Sidebar  -->
                            <div class="container-fluid sticky-top" style="top: 126px;z-index: 2;">
                                <div class="row">
                                    <div class="col-12 text-center mt-3">
                                        <h3 style="font-weight: 700; font-size: 32px; margin: 20px 0px;">Product Filter</h3>
                                    </div>
                                </div>
                                <form action="productlist" method="get">
                                    <input name="category" value="${category}" hidden>
                                <div class="row border-top pt-3">
                                    <div class="col-12 input-group mb-3">
                                        <input type="text" class="form-control" id="search" name="search" placeholder="Search" value="${search}" list="searchList">
                                        <button type="button" class="input-group-text btn" id="clearSearchInput">&times;</button>
                                        <button type="submit" class="input-group-text btn"><i class="bi bi-search"></i></button>
                                        <datalist id="searchList">
                                            <c:forEach items="${allSearchList}" var="asl">
                                                <option value="${asl.title}"></option>
                                            </c:forEach>
                                            <c:forEach items="${applicationScope.prcategory}" var="cate">
                                                <option value="Category: ${cate.name}"></option>
                                            </c:forEach>
                                        </datalist>
                                    </div>
                                    <div class="col-12 mb-0 blog-box pt-2">
                                        <h2 style="font-weight: 700">Categories</h2>
                                    </div>
                                    <c:forEach items="${applicationScope.prcategory}" var="pcate">
                                        <div class="col-12 input-group product-content" title="${pcate.name}">
                                            <div class="latest-product-content">
                                                <div style="padding: 0px 5px;">
                                                    <h3>
                                                        <a href="productlist?category=${pcate.id}&priceOption=${priceOption}&minPrice=${minPrice}&maxPrice=${maxPrice}&sort=${sort.replace(" ", "%20")}">${pcate.name}</a>
                                                    </h3>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                    <div class="col-12 mb-3 blog-box pt-2">
                                        <h2 style="font-weight: 700">Price</h2>
                                    </div>
                                    <div class="col-12">

                                    </div>
                                    <div class="col-12">
                                        <div class="form-check">
                                            <input class="form-check-input" id="price1" type="radio" name="priceOption" value="price1" ${priceOption eq "price1" ? "checked" : ""}>
                                            <label class="form-check-label" for="price1">Less than 100.000đ</label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" id="price2" type="radio" name="priceOption" value="price2" ${priceOption eq "price2" ? "checked" : ""}>
                                            <label class="form-check-label" for="price2">100.000đ - 350.000đ</label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" id="price3" type="radio" name="priceOption" value="price3" ${priceOption eq "price3" ? "checked" : ""}>
                                            <label class="form-check-label" for="price3">350.000đ - 600.000đ</label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" id="price4" type="radio" name="priceOption" value="price4" ${priceOption eq "price4" ? "checked" : ""}>
                                            <label class="form-check-label" for="price4">More than 600.000đ</label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" id="customPrice" type="radio" name="priceOption" value="customPrice" ${priceOption eq "customPrice" ? "checked" : ""}>
                                            <label class="form-check-label" for="customPrice">Custom Price:</label>
                                        </div>
                                        <div class="display row">
                                            <input type="number" class="form-control col" name="minPrice" id="min" value="${minPrice}">
                                            <span class="col-2 text-center" style="padding: 5px 2px 0  0">to</span>
                                            <input type="number" class="form-control col" name="maxPrice" id="max" value="${maxPrice}">
                                        </div>
                                    </div>
                                    <div class="col-12 text-center mb-4">
                                        <button type="submit" class="btn btn-apply">Apply</button>
                                    </div>
                                </div>
                                <input name="sort" value="${sort}" hidden>
                                <input name="page" value="1" hidden>
                            </form>
                            <div class="row border-top">
                                <div class="col-12 text-center mt-3">
                                    <h3 style="font-weight: 700; font-size: 32px; margin: 20px 0px;">Latest Product</h3>
                                </div>
                            </div>
                            <div class="row border-top pt-3">
                                <c:forEach items="${latestproduct}" var="lp" begin="0" end="1">
                                    <div class="col-12 blog-box" title="${lp.title}"
                                         onclick="window.location.href = 'productdetail?id=${lp.id}'" style="cursor: pointer">
                                        <div>
                                            <div class="latest-blog-img">
                                                <img class="img-fluid" src="${lp.thumbnail}" alt="" />
                                            </div>
                                            <div class="latest-product-content">
                                                <div style="padding: 0px 5px;">
                                                    <h3>
                                                        <a href="productdetail?id=${lp.id}">${lp.title}</a>
                                                    </h3>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                        <!-- End Sidebar  -->
                    </div>
                    <div class="col-sm-9">
                        <div class="row">
                            <div style="margin-top: 41px;margin-bottom: 35px;" class="col-10 d-flex align-items-baseline flex-column ms-4">
                                <div style="color:black;" class="h4 font-weight-bold">Order ID : ${order.getId()} - ${order.payment_method} - <span style="color: ${'Submitted'.equals(order.getStatus())?'#007bff':''}
                                                                                                                          ${'Success'.equals(order.getStatus())?'#28a745':''}
                                                                                                                          ${'Confirmed'.equals(order.getStatus())?'#17a2b8':''}
                                                                                                                          ${'Shipping'.equals(order.getStatus())?'#ffc107':''}
                                                                                                                          ${'Cancelled'.equals(order.getStatus())?'#dc3545':''}">${order.getStatus()}</span></div>
                                <div class="h6 ">${order.getOrderedDate()}</div>

                            </div>
                            <div style="margin-top: 41px;margin-bottom: 35px;" class="col-2 d-flex align-items-center ">
                                <a style="${'Submitted'.equals(order.getStatus())?'':'display:none;'}" id="cancel-order-btn" class="btn btn-apply bg-danger" href="">Cancel Order</a>
                                <c:if test="${'Shipping'.equals(order.getStatus())}">
                                    <a style="background-color: #b0b435" id="received-order-btn" class="btn btn-apply" href="">Received</a>
                                </c:if>
                            </div>
                            <div style="border-left:#b0b435 4px solid;" class="col-6">
                                <div class="h5">RECEIVER</div>
                                <div>Information : ${sessionScope.user.getName()},&emsp; ${user.getGender()}</div>
                                <div>Contact : ${sessionScope.user.getEmail()},&emsp; ${sessionScope.user.getPhone()}</div>
                            </div>
                            <div style="border-left:#b0b435 4px solid;" class="col-6">
                                <div class="h5">ADDRESS</div>
                                <div>${address.getDistrict()} - ${address.getCity()}</div>
                                <div>${address.getDetail()}</div>
                            </div>
                            <div style="background-color: #f9f9f9;color:black;font-size: 20px;border: #dadada solid 1px;" class="col-12 mt-3">
                                <c:forEach begin="0" end="${length}" var="i" step="1">
                                    <div style="min-height: 200px;border-bottom:#dadada 1px solid; " class="row">
                                        <div class="col-sm-2 d-flex justify-content-center align-items-center">
                                            <img class="mx-4" height="170" src="${pList[i].thumbnail}" alt="alt"/>
                                        </div>
                                        <div class="col-sm-7">
                                            <div style="font-size: 20px;" class="mt-2">${pList[i].title} x ${odList[i].quantity}</div>
                                            <c:set var="formattedPrice">
                                                    <fmt:formatNumber value="${pList[i].listPrice * 1000}" type="number" groupingUsed="true" minFractionDigits="0" maxFractionDigits="0"/>
                                                </c:set>
                                            <div class="mt-1 mb-4">Unit Price : ${formattedPrice} đ</div>
                                            <a style="line-height: 1rem;color:white; ${('Success'.equals(order.getStatus()) || 'Cancelled'.equals(order.getStatus()))? '' : 'pointer-events: none;background-color: #9da13a;'}" 
                                               class="btn btn-apply mt-4 mr-3" href="productdetail?id=${pList[i].id}">Re-buy</a>
                                            <a style="line-height: 1rem;color:white;${'Success'.equals(order.getStatus())? '' : 'pointer-events: none;background-color: #9da13a;'}
                                               ${fbList[i] == -1 ? '':'pointer-events: none;background-color: #9da13a;'}" 
                                               class="btn btn-apply mt-4" href="feedback?productid=${pList[i].id}">Leave a feedback</a>
                                        </div>
                                        <div class="col-sm-3 d-flex align-items-center">
                                            <c:set var="total" value="${pList[i].listPrice * odList[i].quantity}"></c:set>
                                            <c:set var="formattedPrice">
                                                <fmt:formatNumber value="${total * 1000}" type="number" groupingUsed="true" minFractionDigits="0" maxFractionDigits="0"/>
                                            </c:set>
                                            <div><b>Total ${formattedPrice} đ</b></div>
                                        </div>
                                    </div>
                                </c:forEach>
                                <div style="height:100px" class="row">
                                    <div style="font-size: 20px;color:black;" class="col-sm-3 d-flex justify-content-start align-items-center">
                                        <c:set var="formattedPrice">
                                            <fmt:formatNumber value="${order.getTotal() * 1000}" type="number" groupingUsed="true" minFractionDigits="0" maxFractionDigits="0"/>
                                        </c:set>
                                        <b>TOTAL : ${formattedPrice} đ</b></div>
                                    <div class="col-sm-7"></div>
                                    
                                </div>
                            </div>

                        </div>

                    </div>

                </div>

            </div>
        </div>
    </body>
    <jsp:include page="footer.jsp"></jsp:include>
        <script src="js/jquery-3.2.1.min.js"></script>
        <script src="js/popper.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
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
        <script>
                                             document.addEventListener('DOMContentLoaded', function () {
                                                 const predefinedPrices = document.querySelectorAll('input[name="priceOption"]:not([value="customPrice"])');
                                                 const customPriceRadio = document.querySelector('input[name="priceOption"][value="customPrice"]');
                                                 const customPriceInputs = document.querySelectorAll('.display input');

                                                 function updateStates() {
                                                     if (customPriceRadio.checked) {
                                                         customPriceInputs.forEach(input => input.disabled = false);
                                                     } else {
                                                         customPriceInputs.forEach(input => input.disabled = true);
                                                     }
                                                 }

                                                 // Initial state check
                                                 updateStates();

                                                 predefinedPrices.forEach(price => {
                                                     price.addEventListener('change', function () {
                                                         updateStates();
                                                     });
                                                 });
                                                 customPriceRadio.addEventListener('change', function () {
                                                     updateStates();
                                                 });
                                             });
        </script>
        <script>
            // Clear search button
            const searchInput = document.getElementById('search');
            const clearButton = document.getElementById('clearSearchInput');

            document.addEventListener('DOMContentLoaded', () => {
                if (searchInput.value.trim() !== '') {
                    clearButton.style.display = 'block';
                }
            });
            searchInput.addEventListener('input', () => {
                if (searchInput.value !== '') {
                    clearButton.style.display = 'block';
                } else {
                    clearButton.style.display = 'none';
                }
            });
            searchInput.addEventListener('focusout', () => {
                if (searchInput.value === '') {
                    clearButton.style.display = 'none';
                }
            });
            clearButton.addEventListener('click', () => {
                searchInput.value = '';
                clearButton.style.display = 'none';
            });
        </script>
        <script>
            document.getElementById('cancel-order-btn').addEventListener('click', function (event) {
                event.preventDefault(); // Prevent the default link behavior
                toastr.clear();
                toastr.warning('<div class="d-flex"><div>Are you sure you want to cancel the order?</div><button id="yes-btn" class="btn btn-danger">Yes</button></div>', 'Confirm', {
                    closeButton: true,
                    preventDuplicates: true,
                    timeOut: 0,
                    extendedTimeOut: 0,
                    onShown: function () {
                        document.getElementById('yes-btn').addEventListener('click', function () {
                            // Create and submit a form with the POST method
                            var form = document.createElement('form');
                            form.method = 'POST';
                            form.action = 'orderinformation';

                            var hiddenField = document.createElement('input');
                            hiddenField.type = 'hidden';
                            hiddenField.name = 'cancelid';
                            hiddenField.value = `${order.getId()}`;
                            form.appendChild(hiddenField);

                            document.body.appendChild(form);
                            form.submit();
                        });
                    }
                });
            });
    </script>
    <script>
        document.getElementById('received-order-btn').addEventListener('click', function (event) {
            event.preventDefault(); // Prevent the default link behavior
            toastr.clear();
            toastr.success('<div><div>Are you sure confirmed order?</div><button id="yes-btn" class="btn btn-Success">Yes</button></div>', 'Confirm', {
                closeButton: true,
                preventDuplicates: true,
                timeOut: 0,
                extendedTimeOut: 0,
                onShown: function () {
                    // id customerid cid
                    document.getElementById('yes-btn').addEventListener('click', function () {
                        // Create and submit a form with the POST method
                        var form = document.createElement('form');
                        form.method = 'GET';
                        form.action = 'orderinformation';

                        var hiddenField = document.createElement('input');
                        hiddenField.type = 'hidden';
                        hiddenField.name = 'id';
                        hiddenField.value = `${order.id}`;
                        form.appendChild(hiddenField);

                        var hiddenField = document.createElement('input');
                        hiddenField.type = 'hidden';
                        hiddenField.name = 'uid';
                        hiddenField.value = `${order.customerId}`;
                        form.appendChild(hiddenField);

                        var hiddenField = document.createElement('input');
                        hiddenField.type = 'hidden';
                        hiddenField.name = 'cid';
                        hiddenField.value = `${order.id}`;
                        form.appendChild(hiddenField);

                        document.body.appendChild(form);
                        form.submit();
                    });
                }
            });
        });
    </script>
</html>
