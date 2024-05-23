<%-- 
    Document   : home
    Created on : Oct 27, 2022, 9:44:37 PM
    Author     : ducan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="DAL.*" %>
<%@page import="Models.*" %>
<%@page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <link rel="icon" href="image/101512512_p0_master1200.jpg">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="CSS/bootstrap.min.css">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.10.2/css/all.css">
        <link rel="stylesheet" href="CSS/main.css">
        <title>Mangayomu</title>
        <link href="css/home.css" rel="stylesheet" />
    </head>
    <body style="background-color: #0d0c0c">

        <jsp:include page="menu.jsp"></jsp:include>
            <!-- Header-->
            <header style="background-size: 100% 280px; background-repeat: no-repeat; background-image: url(https://imagepi.otakusan.net/extendContent/Img/e05465c9-80f7-4266-982a-3fcccb1b6f7d.webp)" class="py-5">
                <div class="container px-4 px-lg-5 my-5">
                    <div class="text-center text-white">
                        <h1 class="display-4 fw-bolder" style="color: #43adff; -webkit-text-stroke: 1px white ">MangaYomi</h1>
                        <p class="lead fw-normal text-dark-50 mb-0" style="-webkit-text-stroke: 0.5px white; color: black">Website selling products related to Manga.</p>
                    </div>
                </div>
            </header>  
            <!-- Section-->
        <jsp:include page="bar.jsp"></jsp:include>
        <c:set var="page" value="${requestScope.page}"/>
        <section class="py-5">
            <div class="container px-4 px-lg-5 mt-5">
                <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4">
                    <c:forEach items="${requestScope.products}" var="p">
                        <div class="col mb-5">
                            <div class="card h-100 border-dark">
                                <!-- Product image-->
                                <img class="card-img-top" src="${p.image}" alt="..." width="150" height="350">
                                <!-- Product details-->
                                <div class="card-body p-4">
                                    <div class="text-center">
                                        <!-- Product name-->
                                        <h5 class="fw-bolder">${p.name}</h5>
                                        <!-- Product reviews-->
                                        <div style="font-weight: bold" class="d-flex justify-content-center small text-warning mb-2">
                                            Rating: ${p.rating}/5<div class="bi-star-fill"></div>
                                        </div>
                                        <!-- Product price-->
                                        Category: ${p.cat.name}<br/>
                                        Release Date: ${p.releasedate}<br/>
                                        <p style="font-weight: bold">Price: <c:if test="${p.price != 0}">$${p.price}</c:if><c:if test="${p.price == 0}">Free</c:if></p>
                                        </div>
                                    </div>
                                    <!-- Product actions-->
                                    <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                            <div class="text-center justify-content-center"><a class="btn btn-outline-dark mt-auto" href="detail?pid=${p.id}">View Detail</a></div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    <div class="text-center" style="display: inline-block; margin-right:auto; width: 100%">
                        <c:forEach begin="${1}" end="${requestScope.num}" var="i">
                            <a style='text-decoration: none; color: white;' href="home?page=${i}">
                                <button style='margin-right: 1px;' class="btn btn-outline-dark ${i == page ? "active" : ""}">
                                    ${i}
                                </button>
                            </a>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </section>
        <!-- Footer-->
        <jsp:include page="footer.jsp"></jsp:include>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
    </body>
</html>
