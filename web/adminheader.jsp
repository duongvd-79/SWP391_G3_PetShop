<%-- 
    Document   : adminheader
    Created on : Jun 10, 2024, 11:33:07 PM
    Author     : ACER
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
        <style>
            .nav-item{
                font-size: 16px;
                font-weight: 700;
            }
        </style>
<nav style="background-color: #F3F6F9; z-index: 2;" class="navbar navbar-expand sticky-top px-4 py-0">
                    <a href="index.html" class="navbar-brand d-flex d-lg-none me-4">
                        <h2 class="text-primary mb-0"><i class="fa fa-hashtag"></i></h2>
                    </a>
                    <a href="#" class="sidebar-toggler flex-shrink-0">
                        <i class="fa fa-bars"></i>
                    </a>
                    <form id="search-form" class="d-none d-md-flex ms-4" action="setting" method="get">
                        <input class="form-control border-0" type="search" placeholder="Search" name="search" value="${requestScope.sName}">
                    </form>
                    <div class="navbar-nav align-items-center ms-auto">
                        <div class="nav-item me-3">
                            <a class="nav-link" href="home">HOME</a>
                        </div>
                        <div class="nav-item me-3">
                            <a class="nav-link" href="#">ABOUT</a>
                        </div>
                        <div class="nav-item me-3">
                            <a class="nav-link" href="productlist">PRODUCT</a>
                        </div>
                        <div class="nav-item me-3">
                            <a class="nav-link" href="bloglist">BLOG</a>
                        </div>
                        <div class="nav-item dropdown">
                            <a href="#" class="nav-link dropdown-toggle me-3 active" data-bs-toggle="dropdown">
                                <div class="d-lg-inline-flex nav-item text-uppercase">${sessionScope.user.getName()}</div>
                            </a>
                            <div class="dropdown-menu dropdown-menu-end bg-light border-0 rounded-0 rounded-bottom m-0">
                                <a href="#profilepopup" class="dropdown-item text-uppercase">My Profile</a>
                                <a href="login?logout=true" class="dropdown-item text-uppercase">Log Out</a>
                            </div>
                        </div>
                    </div>
                    <%--<jsp:include page="profilepopup.jsp"></jsp:include>--%>
                </nav>
