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

            <div style="min-height:759px;" class="container mt-2 ">
                <div class="row">
                    <ul class="nav nav-tabs w-100">
                        <li class="nav-item status">
                            <a style="border-bottom:#0D6EFD solid 0px;" class="nav-link text-primary ${'submitted'.equals(requestScope.status)? 'active' : ''}" href="myorders?status=submitted">Submitted</a>
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
                                    <div>And ${remainNum[i]} more product <a class="text-primary" href="#">VIEW DETAILS HERE</a></div>
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
</html>
