<%-- 
    Document   : admindashboard
    Created on : Jun 11, 2024, 12:27:50 AM
    Author     : ACER
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
        <!-- Favicon -->
        <link href="img/favicon.ico" rel="icon">

        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">

        <!-- Icon Font Stylesheet -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

        <!-- Customized Bootstrap Stylesheet -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <!-- Template Stylesheet -->
        <link href="css/style.css" rel="stylesheet">
        <link rel="stylesheet" href="css/responsive.css">
        <link rel="stylesheet" href="css/admin.css">
        <!-- Toastr -->
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css">
        <style>
            #search-form{
                display:none !important;
            }
            input[type="date"] {
                padding: 10px;
                margin: 10px 0;
                border: 2px solid #ccc;
                border-radius: 5px;
                font-size: 16px;
            }
            input[type="date"]:focus {
                border-color: #66afe9;
                outline: none;
                box-shadow: 0 0 5px rgba(102, 175, 233, 0.6);
            }
             .sidebar .active{
                color: #b0b435;
            }
        </style>
        <title>SLIDER DASHBOARD</title>
    </head>
    <jsp:include page="header.jsp"></jsp:include>
        <body>
            <div class="container-fluid position-relative bg-white d-flex p-0 ">
                <div class="row">

                    <!-- Sidebar Start -->
                    <div class="container col-2 position-relative" >
                        <div class="w-100 mb-1 sticky-top sidebar" style="top: 126px;z-index: 1;font-size: 18px;font-weight: bold">
                            <a href="#" class="nav-link"><i class="bi bi-clipboard-data-fill p-2 rounded-circle" style="background-color: lightgray"></i> DASHBOARD</a>
                            <a href="customerlist" class="nav-link"><i class="bi bi-people-fill p-2 rounded-circle" style="background-color: lightgray"></i> CUSTOMERS/<br>CONTACTS</a>
                            <a href="FeedbackManager" class="nav-link"><i class="bi bi-chat-left-text-fill p-2 rounded-circle" style="background-color: lightgray"></i> FEEDBACKS</a>
                            <a href="marketingproductlist" class="nav-link active"><i class="bi bi-archive-fill p-2 rounded-circle" style="background-color: lightgray"></i> PRODUCTS</a>
                            <a href="SliderManager" class="nav-link"><i class="bi bi-image p-2 rounded-circle" style="background-color: lightgray"></i> SLIDERS</a>
                        </div>
                    </div>
                    <!-- Sidebar End -->


                    <!-- Content Start -->
                    <div class="col-10 container-fluid rounded bg-white mt-4 mb-5 px-3">
                        <div class="row d-flex align-items-center mb-3">
                            <div class="col-md-5 function">
                                <div class="input-group d-flex ">
                                    <div class="search-container">
                                        <form action="FeedbackManager" method="GET">
                                            <label>Từ khóa</label>
                                            <input type="text" name="search" placeholder="Search...">
                                            <select name="sort" id="categorySelect">
                                                <option value="">Sort By</option>
                                                <option value="u.name">Customer Name</option>
                                                <option value="p.title">Product Name</option>
                                                <option value="fb.star">Rate</option>
                                                <option value="fb.status">Status</option>
                                            </select>
                                            <select name="orderby" id="categorySelect">
                                                <option value="desc">Descending</option>
                                                <option value="asc">Ascending</option>
                                            </select>
                                            <button type="submit">Search</button>
                                        </form>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <div class="container">
                            <div class="row">
                                <div class="col-lg-12" style="width: 1100px">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Product Name</th>
                                                <th>Customer</th>
                                                <th>Detail</th>
                                                <th>Status</th>
                                                <th>Rate</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${listFeedback}" var="u">
                                            <tr>
                                                <td>${u.id}</td>
                                                <td>${u.productName}</td>
                                                <td>${u.customerName}</td>
                                                <td>${u.detail}</td>
                                                <td>${u.status}</td>
                                                <td>${u.star} <img height="20" src="https://img.icons8.com/ios-filled/50/FFD700/star--v1.png"></td>
                                                <td><div class="d-flex justify-content-evenly align-items-center py-2">
                                                        <div class="me-4"><a href="feedbackdetail?id=${u.id}"><img height="35" src="https://img.icons8.com/?size=100&id=114169&format=png&color=000000" height="50px"></a></div>
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
                    <div class="col-md-12 mb-2"><label class="labels">Thumbnail</label><input type="file" name="file" class="form-control" required></div>
                    <div class="col-md-7 mb-2"><label class="labels">Detail</label><input type="text" name="detail" class="form-control" placeholder="Enter your content..." value="" required></div>
                    <div class="col-md-5"><label class="labels">Category</label>
                        <select class="form-select" id="roles" name="category">
                            <c:forEach items="${requestScope.listC}" var="s">
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
    <jsp:include page="footer.jsp"></jsp:include>  
</div>
</div>

<!-- Content End -->

<!-- JavaScript Libraries -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<!--<script src="lib/chart/chart.min.js"></script>-->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="lib/easing/easing.min.js"></script>
<script src="lib/owlcarousel/owl.carousel.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>
<!-- Template Javascript -->
<script src="js/admin.js"></script>

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
