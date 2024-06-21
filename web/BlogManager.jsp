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
        </style>
        <title>ADMIN DASHBOARD</title>
    </head>
    <jsp:include page="header.jsp"></jsp:include>
        <body>
            <div class="container-fluid position-relative bg-white d-flex p-0 ">
                <div class="row">

                    <!-- Sidebar Start -->
                    <div style="z-index: 2;background-color: transparent;position: relative;" class="col-2 sidebar pe pb-3 shadow-sm">
                        <div style="top:130px;" class="w-100 mb-1 sticky-top">
                            <a href="SaleDashboard" class="nav-link "><i class="fa fa-tachometer-alt me-2"></i>DASHBOARD</a>
                            <a href="BlogManager" class="nav-link active"><i class="bi bi-gear-fill me-2"></i>BlOG LIST</a>
                        </div>
                    </div>
                    <!-- Sidebar End -->


                    <!-- Content Start -->
                    <div class="col-10 container-fluid rounded bg-white mt-4 mb-5 px-3">
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
</html>
