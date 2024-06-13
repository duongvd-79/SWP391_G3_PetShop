
<%-- 
    Document   : settinglist
    Created on : May 22, 2024, 1:39:06 AM
    Author     : ACER
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">


        <!-- Template Stylesheet -->
        <link href="css/style.css" rel="stylesheet">
        <link href="css/admin.css" rel="stylesheet">
        <title>Setting List</title>
    </head>

    <body>
        <div class="container-fluid position-relative bg-white d-flex p-0">
            <!-- Sidebar Start -->
            <div class="sidebar pe-4 pb-3">
                <nav style="padding: 10px 20px;" class="navbar">
                    <a href="#" class="navbar-brand mx-4 mb-3">
                        <h1 class="text-primary"><i class="fa fa-hashtag me-2"></i>ADMIN</h1>
                    </a>
                    <div class="d-flex align-items-center ms-4 mb-4">

                    </div>
                    <div class="navbar-nav w-100 mb-1">
                        <a href="admindashboard" class="nav-item nav-link h6"><i class="fa fa-tachometer-alt me-2"></i>Dashboard</a>
                        <a href="setting" class="nav-item nav-link h6"><i class="bi bi-gear-fill me-2"></i>Setting</a>
                        <div class="border-0 mb-1">
                            <a style="margin-left: 41%;color:#009CFF; " href="#" class="nav-item active h7">Setting Details</a>
                        </div>
                        <a href="userlist" class="nav-item nav-link h6"><i class="bi bi-gear-fill me-2"></i>User List</a>
                    </div>
                </nav>
            </div>
            <!-- Sidebar End -->


            <!-- Content Start -->
            <div class="content">
                <!-- Navbar Start -->
                <jsp:include page="adminheader.jsp"></jsp:include>
                <!-- Navbar End -->


                <c:set value="${sessionScope.detail}" var="detail"/>
                <div class="container-fluid rounded bg-white shadow-sm d-flex justify-content-center">
                    <div style="width:60%;" class="p-2 pb-5 pt-1">

                        <form class="row mt-3" method="get" action="setting">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="id" value="${detail.getId()}">
                            <input type="hidden" name="type" value="${detail.getType()}">
                            <div class="col-md-7"><label class="labels">Group</label>
                                <select class="form-select" id="roles" name="" value="${detail.getType()}" disabled >
                                    <c:forEach items="${sessionScope.types}" var="t">
                                        <option value="${t}" ${t.equals(sessionScope.detail.getType()) ? 'selected' : ''}>${t}</option>
                                    </c:forEach>                             
                                </select>

                            </div>
                            <div class="col-md-5"><label class="labels">Order</label><input type="text" name="order" class="form-control" value="${detail.getOrder()}"></div>
                            <div class="col-md-12 mt-2"><label class="labels">Name</label><input type="text" name="name" class="form-control" value="${detail.getName()}"></div>
                            <div class="col-md-6 mt-2">
                                <label class="labels">Status</label><br>
                                <div class="my-2">
                                    <div class="form-check custom-radio form-check-inline">

                                        <input class="form-check-input font-weight-bold" type="radio" name="status" value="Active" id="active" ${'Active' == detail.status ? 'checked' : ''} ${detail.name == 'admin' ? 'disabled' : ''}>
                                        <label class="form-check-label" for="active">
                                            Active
                                        </label>
                                    </div>
                                    <div class="form-check custom-radio form-check-inline">

                                        <input class="form-check-input" type="radio" name="status" value="Inactive" id="inactive" ${'Active' == detail.status ? '':'checked'} ${detail.name == 'admin' ? 'disabled' : ''}>
                                        <label class="form-check-label" for="inactive">
                                            Inactive
                                        </label>
                                    </div>

                                </div>
                            </div>
                            <div class="col-md-12"><label class="labels">Description</label>
                                <textarea class="form-control" id="note" name="note" rows="3" value="${detail.getDescription()}">${detail.getDescription()}</textarea>
                            </div>


                            <div class="d-flex justify-content-center">
                                <div class="mt-4 mx-4"><button class="btn py-1 px-4" type="button submit">Save Changes</button></div>
                                <div class="mt-4 mx-4"><a href="#popup1" class="btn py-1 px-4" type="button">Add New</a></div>
                            </div>
                        </form>
                    </div>
                    <div id="popup1" class="overlay">
                        <div class="popup">
                            <h2 class="ms-3 mb-3">Add New Setting</h2>
                            <a class="close" href="#">&times;</a>
                            <div class="container-fluid">

                                <form method="get" action="setting" class="row">
                                    <input type="hidden" name="action" value="add">
                                    <div class="col-md-7"><label class="labels">Group</label>
                                        <select class="form-select" id="roles" name="type" >
                                            <c:forEach items="${sessionScope.types}" var="t">
                                                <option value="${t}">${t}</option>
                                            </c:forEach>                             
                                        </select>
                                    </div>
                                    <div class="col-md-5"><label class="labels">Order</label><input type="text" name="order" class="form-control" placeholder="Enter Setting Order" required=""></div>
                                    <div class="col-md-12 my-3"><label class="labels">Name</label><input type="text" name="name" class="form-control" placeholder="Enter Setting Name" required=""></div>
                                    <div class="col-md-12"><label class="labels">Description</label>
                                        <textarea class="form-control" id="note" name="note" rows="3" value="${detail.getDescription()}">${detail.getDescription()}</textarea>
                                    </div>
                                    <div class="d-flex justify-content-center">
                                        <div class="mt-4"><button class="btn py-1 px-4" type="button submit">Add</button></div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                </div>     
            </div>

            <!-- Content End -->


            <!-- Back to Top -->
            <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>
        </div>

        <!-- JavaScript Libraries -->
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="lib/chart/chart.min.js"></script>
        <script src="lib/easing/easing.min.js"></script>
        <script src="lib/owlcarousel/owl.carousel.min.js"></script>

        <!-- Template Javascript -->
        <script src="js/admin.js"></script>
        <style>
            label{
                font-size: 18px;
                font-weight: bold;
                line-height: 10px;
            }
        </style>
    </body>
</html>

