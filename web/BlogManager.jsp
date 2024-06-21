1
<%-- 
    Document   : BlogManager
    Created on : Jun 17, 2024, 12:32:15 AM
    Author     : Acer
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Setting List</title>
    </head>
    <body>
        <div class="container-fluid rounded bg-white mt-5 mb-5 shadow-sm">
            <div class="row">
                <nav class="mt-4 ps-5" style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                    <ol class=" h5 breadcrumb">
                        <li class="breadcrumb-item"><a class="root" href="#">Home</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Blogs List</li>
                    </ol>
                </nav>

                <div class="mb-3 ps-5" >
                    <h3 class="text-right">Blogs List</h3>
                </div>
                <div class="row d-flex align-items-center mb-3">
                    <div class="col-md-5 function">
                        <div class="input-group d-flex ">
                            <div class="search-container">
                                <form action="BlogManager" method="GET">
                                    <label>Từ khóa</label>
                                    <input type="text" name="search" placeholder="Search...">
                                    <label>Thể loại</label>  
                                    <select name="categoryID" id="categorySelect">
                                        <option value="">All</option>
                                        <c:forEach items="${listC}" var="category">
                                            <option value="${category.id}">${category.name}</option>
                                        </c:forEach>
                                    </select>
                                    <button type="submit">Search</button>
                                </form>
                            </div>

                        </div>
                    </div>

                    <div class="col-md-1 function"><a  href="#popup1" class="btn btn-primary" type="button">Add New</a></div>


                </div>
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Title</th>
                                        <th>Thumbnail</th>
                                        <th>Created Date</th>
                                        <th>Created By</th>
                                        <th>Category</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${listp}" var="u">
                                        <tr>
                                            <td>${u.id}</td>
                                            <td>${u.title}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${fn:startsWith(u.thumbnail, 'https')}">
                                                        <img src="${u.thumbnail}" alt="alt" height="200px"/>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img src="./images/${u.thumbnail}" alt="alt" height="200px"/>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>${u.createdDate}</td>
                                            <td>${u.user.name}</td>
                                            <td>${u.setting.name}</td>
                                            <td><div class="d-flex justify-content-evenly align-items-center py-2">
                                                    <div class="me-4"><a href="editblog?id=${u.id}"><img height="35" src="https://img.icons8.com/?size=100&id=114169&format=png&color=000000" height="50px"></a></div>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>

                                </tbody>
                            </table>
                        </div>
                    </div>

                    <div class="text-left text-danger">${msg}</div>



                    <nav aria-label="setting list paging ">
                        <ul class="pagination d-flex justify-content-end">
                            <li class="page-item"><a class="page-link" href="#">Previous</a></li>
                            <li class="page-item"><a class="page-link" href="#!">1</a></li>
                            <li class="page-item"><a class="page-link" href="#">2</a></li>
                            <li class="page-item"><a class="page-link" href="#">3</a></li>
                            <li class="page-item"><a class="page-link" href="#">Next</a></li>
                        </ul>
                    </nav>
                </div>

            </div>

        </div>
        <div id="popup1" class="overlay">
            <div class="popup">
                <h2 class="ms-3 mb-3">Add New Blog</h2>
                <a class="close" href="#">&times;</a>
                <div class="content container-fluid">

                    <form method="post" action="addblog" class="row" enctype="multipart/form-data">
                        <input type="hidden" name="action" value="add">
                        <div class="col-md-12 mb-2"><label class="labels">Title</label><input type="text" name="title" class="form-control" placeholder="Enter title..." required=""></div>
                        <div class="col-md-12 mb-2"><label class="labels">Thumbnail</label><input type="file" name="file" class="form-control"></div>
                        <div class="col-md-7 mb-2"><label class="labels">Detail</label><input type="text" name="detail" class="form-control" placeholder="Enter your content..." value="" required></div>
                        <div class="col-md-5"><label class="labels">Category</label>
                            <select class="form-select" id="roles" name="category">
                                <c:forEach items="${requestScope.sList}" var="s">
                                    <option value="${s.getId()}">${s.getName()}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-12 mb-2">
                            <label class="labels">Status</label><br>
                            <div class="mt-2">
                                <div class="form-check custom-radio form-check-inline">
                                    <input class="form-check-input" type="radio" name="status" id="male" value="1" checked >
                                    <label class="form-check-label" for="male">
                                        Show
                                    </label>
                                </div>
                                <div class="form-check custom-radio form-check-inline">
                                    <input class="form-check-input" type="radio" name="status" value="0" id="female" >
                                    <label class="form-check-label" for="female">
                                        Hide
                                    </label>
                                </div>

                            </div>

                        </div>
                        <div class="d-flex justify-content-center">
                            <div class="mt-4"><button class="btn btn-primary set-button" type="button submit">Add</button></div>
                        </div>

                    </form>
                </div>
            </div>
        </div>
    </body>
    <style>

        .form-control:focus {
            box-shadow: none;
            border-color: #BBBF52
        }
        .form-select:focus{
            box-shadow: none;
            border-color: #BBBF52
        }

        .set-button {
            background: #BBBF52;
            box-shadow: none;
            border: none;
            font-size: 18px;
            width: 150px;
            height:50px;
            text-align: center;

        }

        .set-button:hover {
            background: #B0B435
        }
        .set-button:focus {
            background: #BBBF52;
            box-shadow: none
        }

        .set-button:active {
            background: #BBBF52;
            box-shadow: none
        }

        .back:hover {
            color: #BBBF52;
            cursor: pointer
        }

        .labels {
            font-size: 18px
        }
        .root{
            color: black;
            text-decoration: none
        }
        .custom-radio .form-check-input[disabled] {
            opacity: 1
        }
        .overlay {
            position: fixed;
            top: 0;
            bottom: 0;
            left: 0;
            right: 0;
            background: rgba(0, 0, 0, 0.7);
            transition: opacity 500ms;
            visibility: hidden;
            opacity: 0;
        }
        .overlay:target {
            visibility: visible;
            opacity: 1;
        }

        .popup {
            margin: 70px auto;
            padding: 20px;
            background: #fff;
            border-radius: 5px;
            width: 50%;
            position: relative;
            transition: all 5s ease-in-out;
        }
        .popup .close {
            position: absolute;
            top: 20px;
            right: 30px;
            transition: all 200ms;
            font-size: 30px;
            font-weight: bold;
            text-decoration: none;
            color: #333;
        }
        .popup .close:hover {
            color: #06D85F;
        }
        .popup .content {
            max-height: 30%;
            overflow: auto;
        }
        .add{
            width: 50px;
            border-radius: 99px;
        }


    </style>
    <style>

        body {
            background: #EEEEEE
        }
        .root{
            color: black;
            text-decoration: none
        }
        .wishlist-box-main{
            padding: 70px 0px;
        }
        .table th {
            vertical-align: middle;
            white-space: nowrap;
        }
        table thead{
            background: #BBBF52;
            color: #ffffff;

        }
        .table thead th{
            font-size: 18px;
        }
        th,td{
            border-right: solid #e7e7e7 1px;
        }
        table td{
            vertical-align: middle;
            font-size: 16px;
        }
        tr{
            border-top: none;
        }
        .table-main table td.thumbnail-img{
            width: 120px;
        }
        .form-select:focus,.btn:focus,.page-link:focus{
            box-shadow: none;
            border-color: #BBBF52
        }
        .page-link:focus{
            background-color: #BBBF52;
        }
        .page-link,.page-link:hover,.page-link:focus{
            color: black;
        }
        .input-group .input-group-addon [type="submit"], .input-group .input-group-addon button {
            border: none;
            border-radius: 0;
        }
        .search {
            padding: 0 10px;
            line-height: 50px;
            background: #BBBF52;
            color: #fff;
        }
        .btn {
            padding: 0 10px;

            background: #BBBF52;
            color: #fff;

        }

        .btn:hover {
            color: #fff;
            background-color: #B0B435;
            border-color: #204d74;
        }

        .gender-dropdown {
            width: 100%;
            padding: 5px;
            border: none;
            background-color: #BBBF52; /* Đảm bảo màu nền của dropdown giống với các ô khác */
        }

        .gender-dropdown:focus {
            outline: none;
        }

    </style>
</html>
