<%-- 
    Document   : admindashboard
    Created on : Jun 11, 2024, 12:27:50 AM
    Author     : ACER
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Favicon -->
        <link href="img/favicon.ico" rel="icon">

        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">

        <!-- Icon Font Stylesheet -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

        <!-- Customized Bootstrap Stylesheet -->
        <link href="css/bootstrap.min.css" rel="stylesheet">

        <!-- Template Stylesheet -->
        <link href="css/style.css" rel="stylesheet">
        <!-- Toastr -->
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css">
        <link href="css/admin.css" rel="stylesheet">
        <title>Sale DASHBOARD</title>
        <style>
            #search{
                width: 15% !important;
            }
        </style>
    </head>
    <jsp:include page="header.jsp"></jsp:include> 

        <body>
            <div class="container-fluid position-relative bg-white d-flex p-0 ">
                <div class="w-100 row">
                    <!-- Sidebar Start -->

                    <div style="z-index: 2;background-color: transparent;position: relative;" class="col-2 sidebar pe pb-3 shadow-sm">
                        <div style="top:130px;" class="w-100 mb-1 sticky-top">

                            <div class="navbar-nav w-100 mb-1">
                                <a href="SaleDashboard" class="nav-item nav-link"><i class="fa fa-tachometer-alt me-2"></i>DASHBOARD</a>
                                <a href="orderslist" class="nav-item nav-link"><i class="fas fa-file-alt me-2"></i>ORDERS LIST</a>
                                <div class="border-0 mb-1">
                                    <a style="margin-left: 74px;" href="#" class="nav-item active h7">Order Details</a>
                                </div>
                            </div>
                        </div>

                    </div>
                    <!-- Sidebar End -->
                    <!-- Content Start -->
                    <div class="col-sm-9 ms-5 px-0 mb-5">
                        <div class="row">
                            <div style="margin-top: 41px;margin-bottom: 35px;" class="col-8 d-flex align-items-baseline flex-column ms-0">
                                <span style="color:black;" class="h4 font-weight-bold">Order ID : ${order.getId()} - ${order.payment_method} </span>
                            <select style="border: 0 !important;color:${'Success'.equals(order.getStatus())?'#28a745':''}
                                    ${'Submitted'.equals(order.status)?'#007bff':''}
                                    ${'Confirmed'.equals(order.status)?'#17a2b8':''}
                                    ${'Shipping'.equals(order.status)?'#ffc107':''}
                                    ${'Cancelled'.equals(order.status)?'#dc3545':''}" class="form-select function w-25 mb-1" ${('Cancelled'.equals(order.status)||'Success'.equals(order.status))?'disabled':''} onchange="if (this.value)
                                                window.location.href = this.value">
                                <c:if test="${'Success'.equals(order.getStatus())}">
                                    <option selected style="color: #007bff;">Success</option>
                                </c:if>
                                <option ${'Submitted'.equals(order.status)?'selected':''} value="orderdetails?id=${order.getId()}&changestatus=Submitted" style="color: #007bff;">Submitted</option>
                                <option ${'Confirmed'.equals(order.status)?'selected':''} value="orderdetails?id=${order.getId()}&changestatus=Confirmed" style="color: #17a2b8;">Confirmed</option>
                                <option ${'Shipping'.equals(order.status)?'selected':''} value="orderdetails?id=${order.getId()}&changestatus=Shipping" style="color: #ffc107;">Shipping</option>
                                <option ${'Cancelled'.equals(order.status)?'selected':''} value="orderdetails?id=${order.getId()}&changestatus=Cancelled" style="color: #dc3545;">Cancelled</option>
                            </select>
                            <div class="h6">${order.getOrderedDate()}</div>
                        </div>
                        <div style="margin-top: 41px;margin-bottom: 35px;" class="col-4 d-flex align-items-center ">
                            <a id="btnsale" ${user.getId()==4 ? 'href="#salelist"':''} class="py-2 pe-2">
                                <img src="${requestScope.sale.getPfp()}" height="80" class="ms-3" alt="alt"/>
                                <span class="h5 mb-0 ms-4">Sale : ${sale.getName()}</span>
                            </a>                         
                        </div>
                        <div style="border-left:#b0b435 4px solid;" class="col-6">
                            <div class="h5">RECEIVER</div>
                            <div>Information : ${customer.getName()},&emsp; ${customer.getGender()}</div>
                            <div>Contact : <a href="mailto:customer.getEmail()">${customer.getEmail()}</a>,&emsp; <a href="tel:${customer.getPhone()}">${customer.getPhone()}</a></div>
                        </div>
                        <div style="border-left:#b0b435 4px solid;" class="col-6">
                            <div class="h5">ADDRESS</div>
                            <div>${address.getDistrict()} - ${address.getCity()}</div>
                            <div>${address.getDetail()}</div>
                        </div>

                        <div class="col-12 mt-2">
                            <div class="h5">SALE NOTE</div>
                            <form action="orderdetails" method="get">
                                <input type="hidden" name="id" value="${order.getId()}"/>
                                <textarea  name="note" rows="3" cols="80" value="${order.getSaleNote()}">${order.getSaleNote()}</textarea>
                                <button type="submit" style="height:47px;margin-left: 15px;width:10%;bottom:8px;" class=" btn position-absolute ">Save</button>
                            </form>
                        </div>
                        <div style="background-color: #f9f9f9;color:black;font-size: 20px;border: #dadada solid 1px;" class="col-12 mt-3">
                            <c:forEach begin="0" end="${length}" var="i" step="1">
                                <div style="min-height: 200px;border-bottom:#dadada 1px solid; " class="row">
                                    <div class="col-sm-2 d-flex justify-content-center align-items-center">
                                        <img class="mx-4" height="170" src="${pList[i].thumbnail}" alt="alt"/>
                                    </div>
                                    <div class="col-sm-7">
                                        <div style="font-size: 20px;" class="mt-2">${pList[i].title} x ${odList[i].quantity}</div>
                                        <div class="mt-1 mb-4">Unit Price : ${pList[i].listPrice}</div>
                                    </div>
                                    <div class="col-sm-3 d-flex align-items-center">
                                        <c:set var="total" value="${pList[i].listPrice * odList[i].quantity}"></c:set>
                                        <c:set var="formattedPrice">
                                            <fmt:formatNumber value="${total * 1000}" type="number" groupingUsed="true" minFractionDigits="0" maxFractionDigits="0"/>
                                        </c:set>
                                        <div class="pt-4"><b>Total ${formattedPrice} đ</b></div>
                                    </div>
                                </div>
                            </c:forEach>
                            <div style="height:100px" class="row">
                                <div style="font-size: 20px;color:black;" class="col-sm-2 d-flex justify-content-center align-items-center">
                                    <c:set var="formattedPrice">
                                        <fmt:formatNumber value="${order.getTotal() * 1000}" type="number" groupingUsed="true" minFractionDigits="0" maxFractionDigits="0"/>
                                    </c:set>
                                    <b>TOTAL : ${formattedPrice} đ</b></div>
                                <div class="col-sm-7"></div>
                                <div class="col-sm-3">

                                </div>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
            <div id="salelist" class="overlay" >
                <div class="popup w-50">
                    <h2 class="ms-3 mb-3 h4">Sale List</h2>
                    <a class="close" href="#">&times;</a>
                    <div class="container-fluid">
                        <c:forEach items="${saleList}" var="s">
                            <a href="orderdetails?id=${order.id}&changesale=${s.getId()}">
                                <div style="border-left:#b0b435 4px solid;" class="d-flex align-items-center my-3 row">
                                    <img src="${s.getPfp()}" width="60" class="ms-3 col-2" alt="alt"/>
                                    <span class="h5 mb-0 col-6">Sale : ${s.getName()}</span>
                                    <span class="h5 mb-0 col-3"></span>
                                </div>
                            </a>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>

    </body>
    <jsp:include page="footer.jsp"></jsp:include>
        <!-- Content End -->

        <!-- JavaScript Libraries -->
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
        <!--<script src="lib/chart/chart.min.js"></script>-->
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script src="lib/easing/easing.min.js"></script>
        <script src="lib/owlcarousel/owl.carousel.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
        <!-- Template Javascript -->
        <script src="js/admin.js"></script>
        <script>
                                        $(document).ready(function () {
                                            var toastMessage = `${sessionScope.noti}`;
                                            if (toastMessage) {
                                                toastr.success(toastMessage);
        <% 
                    session.removeAttribute("noti");
        %>
                                            }
                                        });
    </script>

</html>
