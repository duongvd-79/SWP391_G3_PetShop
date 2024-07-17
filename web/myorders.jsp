<%-- 
    Document   : myorders
    Created on : Jun 13, 2024, 8:57:04 AM
    Author     : ACER
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <title>JSP Page</title>
        <style>
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
        </style>
    </head>
    <jsp:include page="header.jsp"></jsp:include>

        <body>
            <div class="all-title-box">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12">
                            <ul style="font-weight:bold;background-color: transparent;" class="breadcrumb float-left">
                                <li style="color:#b0b435;" class="breadcrumb-item active">MY ORDERS</li>
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
                        <div style="margin-top:38px;" class="row">
                            <ul class="nav nav-tabs w-100">
                                <li class="nav-item status">
                                    <a style="border-bottom:#0D6EFD solid 0px;" class="nav-link text-primary ${'submitted'.equals(requestScope.status)? 'active' : ''}" href="myorders?status=submitted">Submitted</a>
                                </li> 
                                <li class="nav-item status">
                                    <a style="border-bottom:#17a2b8 solid 0px; color:#17a2b8; " class="nav-link ${'confirmed'.equals(requestScope.status)? 'active' : ''}" href="myorders?status=confirmed">Confirmed</a>
                                </li>
                                <li class="nav-item status">
                                    <a style="border-bottom:#ffc107 solid 0px; color:#ffc107; " class="nav-link ${'shipping'.equals(requestScope.status)? 'active' : ''}" href="myorders?status=shipping">Shipping</a>
                                </li>
                                <li class="nav-item status">
                                    <a style="border-bottom:#198754 solid 0px;" class="nav-link text-success ${'success'.equals(requestScope.status)? 'active' : ''}" href="myorders?status=success">Success</a>
                                </li>
                                <li class="nav-item status">
                                    <a style="border-bottom:#DC3545 solid 0px;" class="nav-link text-danger ${'cancelled'.equals(requestScope.status)? 'active' : ''}" href="myorders?status=cancelled">Cancelled</a>
                                </li>
                                
                                
                            </ul>
                        </div>
                        <div style="max-height: 670px;background-color: #f9f9f9;border: #dadada solid 1px;position: relative;padding-bottom: 71px;" class="row d-flex">

                            <%-- List of My order--%>
                            <c:if test="${length >= 0 }">
                                <c:forEach begin="0" end="${length}" var="i" step="1">
                                    <div style="height:150px; color: black;font-size: 20px;border-bottom: #dadada solid 1px;" class="row col-12 p-0 m-0">
                                        <div class="col-2 d-flex flex-column justify-content-center ">
                                            <div>Order ID : ${oList[i].id}</div>
                                            <div>Date : ${oList[i].orderedDate}</div>
                                        </div>
                                        <div class="col-8 d-flex align-items-center">
                                            <img class="mx-4" height="100" src="${pList[i].thumbnail}" alt="alt"/>
                                            <div >
                                                <div>${pList[i].title} x ${pQuantity[i]}</div>
                                                <div>And ${remainNum[i]} more product <a class="text-primary" href="orderinformation?id=${oList[i].id}">VIEW DETAILS HERE</a></div>
                                            </div>
                                        </div>
                                        <div class="col-2 d-flex align-items-center">
                                            <div><b>Total Cost: ${oList[i].total}</b></div>
                                        </div>
                                    </div>
                                </c:forEach>
                                <nav style="position: absolute;bottom: 5px; left:10px;" aria-label="setting list paging">
                                    <ul class="pagination d-flex justify-content-end mb-2">
                                        <li class="page-item"><a class="page-link ${requestScope.page == 1 ? 'd-none' : ''}" href="myorders?status=${status}&page=${page-1}" >Previous</a></li>
                                            <c:forEach begin="1" end="${requestScope.pageNum}" step="1" var="i">
                                            <li class="page-item ${ i == requestScope.page ? 'active': ''}"><a class="page-link" href="myorders?status=${status}&page=${i}">${i}</a></li>
                                            </c:forEach>
                                        <li class="page-item"><a class="page-link ${requestScope.page == requestScope.pageNum ? 'd-none' : ''}" href="myorders?status=${status}&page=${page+1}">Next</a></li>
                                    </ul>
                                </nav>
                            </c:if>

                            <%-- Empty List --%>
                            <c:if test="${length < 0}">
                                <div class="col-12 d-flex justify-content-between align-items-center p-0">
                                    <img style="width:47%;margin: 20px auto 0px;" src="images/no-order.svg" alt="alt"/>
                                </div>
                                <div class="col-12 d-flex justify-content-center mb-5 h5">No Order Here</div>
                            </c:if>
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
</html>
