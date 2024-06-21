1
<%-- 
    Document   : adminheader
    Created on : Jun 10, 2024, 11:33:07 PM
    Author     : ACER
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<nav style="z-index:99; min-height: 132px; width: 100vw" class="navbar bg-white navbar-expand sticky-top px-2 py-0 shadow-sm">
    <div class="navbar-header">
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar-menu" aria-controls="navbars-rs-food" aria-expanded="false" aria-label="Toggle navigation">
            <i class="bi bi-list"></i>
        </button>
        <a class="navbar-brand" href="home"><img height="100" src="images/logo.jpg" class="logo" alt=""></a>
        <span class="h5">H2DV PETSHOP</span>
    </div>
    <form id="search-form" class="d-none d-md-flex ms-4" action="setting" method="get">
        <input class="form-control border-0" type="search" placeholder="Search" name="search" value="${requestScope.sName}">
    </form>
    <div class="navbar-nav align-items-center ms-auto">
        <div class="nav-item me-2">
            <a class="nav-link" href="home">HOME</a>
        </div>
        <div class="nav-item me-2 ps-1">
            <a class="nav-link" href="#">ABOUT</a>
        </div>
        <div style="margin-right:14px;" class="nav-item dropdown ps-1">
            <a href="#" class="nav-link dropdown-toggle text-uppercase d-flex align-items-center" data-bs-toggle="dropdown">
                Product&nbsp;<i class="bi bi-caret-down-fill"></i>                              
            </a>
            <div class="dropdown-menu dropdown-menu-start bg-light border-0 rounded-0 rounded-bottom m-0">
                <a href="productlist" class="dropdown-item ">All Products</a></li>
                <c:forEach items="${requestScope.prcategory}" var="prcate">
                    <a class="dropdown-item" href="productlist?category=${prcate.id}">${prcate.name}</a>
                    </c:forEach>
            </div>
        </div>
        <div style="margin-right:17px;" class="nav-item">
            <a class="nav-link" href="bloglist">BLOG</a>
        </div>
        <div style="margin-right:15px; " class="nav-item dropdown pe-3">
            <a href="#" class="nav-link dropdown-toggle me-3 text-uppercase active d-flex align-items-center" data-bs-toggle="dropdown">
                ${sessionScope.user.getName()}&ensp;<i class="bi bi-caret-down-fill"></i>                              
            </a>
            <div class="dropdown-menu dropdown-menu-end bg-light border-0 rounded-0 rounded-bottom m-0">
                <a href="#profile" class="dropdown-item">My Profile</a>
                <a href="login?logout=true" class="dropdown-item ">Log Out</a>
            </div>
        </div>
    </div>
    <jsp:include page="userProfile.jsp"></jsp:include>
</nav>
