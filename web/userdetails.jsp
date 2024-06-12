
<%-- 
    Document   : usersetting
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

        <!-- Customized Bootstrap Stylesheet -->
        <link href="css/bootstrap.min.css" rel="stylesheet">

        <!-- Template Stylesheet -->
        <link href="css/style.css" rel="stylesheet">
        <link href="css/admin.css" rel="stylesheet">
        <title>Setting List</title>
    </head>

    <body>
        <div class="container-fluid position-relative bg-white d-flex p-0">
            <!-- Sidebar Start -->
            <div class="sidebar pe-4 pb-3">
                <nav class="navbar">
                    <a href="#" class="navbar-brand mx-4 mb-3">
                        <h1 class="text-primary"><i class="fa fa-hashtag me-2"></i>ADMIN</h1>
                    </a>
                    <div class="d-flex align-items-center ms-4 mb-4">

                    </div>
                    <div class="navbar-nav w-100 mb-1">
                        <a href="admindashboard" class="nav-item nav-link"><i class="fa fa-tachometer-alt me-2"></i>DASHBOARD</a>
                        <a href="setting" class="nav-item nav-link"><i class="bi bi-gear-fill me-2"></i>SETTING</a>
                        <a href="userlist" class="nav-item nav-link"><i class="bi bi-gear-fill me-2"></i>USER LIST</a>
                        <div class="border-0 mb-1">
                            <a style="margin-left: 41%;color:#009CFF; " href="#" class="nav-item active h7">User Setting</a>
                        </div>
                    </div>
                </nav>
            </div>
            <!-- Sidebar End -->


            <!-- Content Start -->
            <div class="content">
                <!-- Navbar Start -->
                <jsp:include page="adminheader.jsp"></jsp:include>
                <!-- Navbar End -->


                <div class="container rounded bg-white mt-4 mb-5 shadow-sm">
                    <div class="row">
                        <div class="col-md-3 border-right">
                            <div class="d-flex flex-column align-items-center text-center p-2 py-4">
                                <c:if test="${empty requestScope.u.getPfp()}">
                                    <c:set var="pfp" scope="request" value="https://upload.wikimedia.org/wikipedia/commons/2/2c/Default_pfp.svg"></c:set>
                                </c:if>
                                <c:if test="${not empty requestScope.u.getPfp()}">
                                    <c:set var="pfp" scope="request" value="${requestScope.u.getPfp()}"></c:set>
                                </c:if>
                                <img class="rounded-circle mt-5" width="170px" height="170px" src="${requestScope.pfp}">
                                <span class="font-weight-bold mt-3"></span>
                                <span class="h5 text-black-20 mt-2">${requestScope.u.getEmail()}</span>
                            </div>
                        </div>
                        <div class="col-md-8 border-right">
                            <div class="p-2 py-2">

                                <div class="row mt-3">

                                    <div class="col-md-12 mb-2"><label class="labels">Name</label><input type="text" class="form-control" value="${requestScope.u.getName()}" readonly=""></div>
                                    <div class="col-md-12 mb-2"><label class="labels">Phone Number</label><input type="text" class="form-control" value="${requestScope.u.getPhone()}" readonly=""></div>
                                    <div class="col-md-12 mb-2"><label class="labels">Address</label><input type="text" class="form-control" placeholder="" value="" readonly=""></div>
                                    <div class="col-md-12 mb-2">
                                        <label class="labels">Gender</label><br>
                                        <div class="mt-2">
                                            <div class="form-check custom-radio form-check-inline">
                                                <input class="form-check-input" type="radio"  id="male" ${"Male".equals(requestScope.u.getGender()) ? 'checked' : ''} disabled>
                                                <label class="form-check-label" for="male">
                                                    Male
                                                </label>
                                            </div>
                                            <div class="form-check custom-radio form-check-inline">
                                                <input class="form-check-input" type="radio" id="female" ${"Female".equals(requestScope.u.getGender()) ? 'checked' : ''} disabled>
                                                <label class="form-check-label" for="female">
                                                    Female
                                                </label>
                                            </div>

                                        </div>

                                    </div>
                                    <form class="row" action="userdetails" method="get">
                                        <input name="action" value="update" hidden>
                                        <input name="id" value="${u.getId()}" hidden>
                                        <div class="col-md-7"><label class="labels">Role</label>
                                            <select class="form-select" id="roles" name="roleid" ${u.getRoleId()==1 ? 'disabled' : ''}>
                                                <c:forEach items="${requestScope.rList}" var="r">
                                                    <option value="${r.getId()}" ${r.getId() == u.getRoleId() ? 'selected' : ''}>${r.getName()}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="col-md-5"><label class="labels">Status</label>
                                            
                                                <c:if test="${u.getRoleId() == 1}">
                                                    <input type="text" class="form-control" value="${u.getStatus()}" readonly>
                                                </c:if> 
                                                <c:if test="${u.getRoleId() != 1}">
                                                    <select class="form-select" id="status" name="status">
                                                    <option value="Active" ${"Active".equals(requestScope.u.getStatus()) ? 'selected' : ''}>Active</option>
                                                    <option value="Inactive" ${"Inactive".equals(requestScope.u.getStatus()) ? 'selected' : ''}>Inactive</option>
                                                    </select>
                                                </c:if>
                                                
                                            
                                        </div>


                                        <div class="d-flex justify-content-center align-items-center mt-3">
                                            <div class="${u.getRoleId()==1 ? 'd-none' : ''} mt-3 me-3 text-center align-items-center"><button class="btn py-1 px-4 ms-2" type="button submit">Save Profile</button></div>
                                            <div class="mt-3 ms-3 d-flex justify-content-between align-items-center">
                                                <a href="#popup1" class="btn py-1 px-4 ms-2" type="button">Add New</a>
                                            </div>
                                        </div>
                                    </form>
                                </div>



                            </div>
                        </div>
                    </div>
                    <div id="popup1" class="overlay">
                        <div class="popup">
                            <h1 class="ms-3 mb-3">Add New User</h1>
                            <a class="close" href="#">&times;</a>
                            <div class="container-fluid">

                                <form method="post" action="adduser" class="row">
                                    <input type="hidden" name="action" value="add">
                                    <div class="col-md-12 mb-2"><label class="labels">Email</label><input type="email" name="email" class="form-control" placeholder="Enter email" required=""></div>
                                    <div class="col-md-12 mb-2"><label class="labels">Password</label><input class="form-control" type="password" name="password" class="form-control" placeholder="Enter Password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" title="Must contain at least one number, one uppercase and lowercase letter, and at least 8 or more characters" required></div>
                                    <div class="col-md-7 mb-2"><label class="labels">Name</label><input type="text" name="name" class="form-control" placeholder="" value="" required></div>
                                    <div class="col-md-5"><label class="labels">Role</label>
                                        <select class="form-select" id="roles" name="roleid">
                                            <c:forEach items="${requestScope.rList}" var="r">
                                                <option value="${r.getId()}">${r.getName()}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="col-md-12 mb-2"><label class="labels">Phone</label><input type="text" pattern="^[0-9]{10}$" title="Phone must contain 10 number" name="phone" class="form-control" placeholder="" value="" required></div>
                                    <div class="col-md-12 mb-2">
                                        <label class="labels">Gender</label><br>
                                        <div class="mt-2">
                                            <div class="form-check custom-radio form-check-inline">
                                                <input class="form-check-input" type="radio" name="gender" id="male" checked >
                                                <label class="form-check-label" for="male">
                                                    Male
                                                </label>
                                            </div>
                                            <div class="form-check custom-radio form-check-inline">
                                                <input class="form-check-input" type="radio" name="gender" id="female" >
                                                <label class="form-check-label" for="female">
                                                    Female
                                                </label>
                                            </div>

                                        </div>

                                    </div>
                                    <div class="d-flex justify-content-center">
                                        <div class="mt-4"><button class="btn py-1 px-4 ms-2" type="button submit">Add</button></div>
                                    </div>

                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Content End -->

                <!-- JavaScript Libraries -->
                <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
                <script src="lib/chart/chart.min.js"></script>
                <script src="lib/easing/easing.min.js"></script>
                <script src="lib/owlcarousel/owl.carousel.min.js"></script>

                <!-- Template Javascript -->
                <script src="js/admin.js"></script>
                </body>
                </html>
