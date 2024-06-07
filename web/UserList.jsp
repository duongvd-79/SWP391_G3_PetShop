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

        <!-- Customized Bootstrap Stylesheet -->
        <link href="css/bootstrap.min.css" rel="stylesheet">

        <!-- Template Stylesheet -->
        <link href="css/style.css" rel="stylesheet">
        <title>User List</title>
    </head>
    <body>
        <div class="container-fluid position-relative bg-white d-flex p-0">
            <!-- Sidebar Start -->
            <div class="sidebar pe-4 pb-3">
                <nav class="navbar bg-light navbar-light">
                    <a href="#" class="navbar-brand mx-4 mb-3">
                        <h1 class="text-primary"><i class="fa fa-hashtag me-2"></i>ADMIN</h1>
                    </a>
                    <div class="d-flex align-items-center ms-4 mb-4">

                    </div>
                    <div class="navbar-nav w-100">
                        <a href="#" class="nav-item nav-link h6"><i class="fa fa-tachometer-alt me-2"></i>Dashboard</a>
                        <a href="setting" class="nav-item nav-link h6"><i class="bi bi-gear-fill me-2"></i>Setting</a>
                        <a href="userlist" class="nav-item nav-link h6 active"><i class="bi bi-gear-fill me-2"></i>User List</a>
                    </div>
                </nav>
            </div>
            <!-- Sidebar End -->


            <!-- Content Start -->
            <div class="content">
                <!-- Navbar Start -->
                <nav style="z-index:2;" class="navbar navbar-expand bg-light navbar-light sticky-top px-4 py-0">
                    <a href="index.html" class="navbar-brand d-flex d-lg-none me-4">
                        <h2 class="text-primary mb-0"><i class="fa fa-hashtag"></i></h2>
                    </a>
                    <a href="#" class="sidebar-toggler flex-shrink-0">
                        <i class="fa fa-bars"></i>
                    </a>

                    <div class="navbar-nav align-items-center ms-auto">

                        <div class="nav-item dropdown">
                            <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
                                <img class="rounded-circle me-lg-2" src="img/user.jpg" alt="" style="width: 40px; height: 40px;">
                                <span class="d-none d-lg-inline-flex">John Doe</span>
                            </a>
                            <div class="dropdown-menu dropdown-menu-end bg-light border-0 rounded-0 rounded-bottom m-0">
                                <a href="#" class="dropdown-item">My Profile</a>
                                <a href="#" class="dropdown-item">Log Out</a>
                            </div>
                        </div>
                    </div>
                </nav>
                <!-- Navbar End -->


                <div class="container-fluid rounded bg-white mt-5 mb-5 shadow-sm">
                    <div class="row">
                        <div class="row d-flex align-items-center mb-3">
                            <div class="col-md-5 function">
                                <div class="input-group d-flex ">
                                    <form style="width:80%;" class="d-none d-md-flex ms-4 mt-2" action="searchuser" method="get">
                                        <input type="search" name="search" class="form-control" placeholder="Enter name, email, role,.. to search user" value="">
                                    </form>

                                </div>
                            </div>



                            <div class="col-md-3 function mb-3">
                                <label>Sort User By: </label>
                                <select name="type" class="form-select" id="type" onchange="if (this.value)
                                            window.location.href = this.value">
                                    <option>All Users</option>
                                    <option value="sortuser?order_by=id"}>User ID</option>
                                    <option value="sortuser?order_by=name"}>FullName</option>
                                    <option value="sortuser?order_by=gender"}>Gender</option>
                                    <option value="sortuser?order_by=email"}>Email</option>
                                    <option value="sortuser?order_by=phone"}>Mobile</option>
                                    <option value="sortuser?order_by=role_id"}>Role ID</option>
                                    <option value="sortuser?order_by=status"}>Status</option>
                                </select>

                            </div>

                            <div class="col-md-4 d-flex justify-content-end align-items-center">
                                <a  href="#popup1" class="btn py-1 px-4 ms-2" type="button">Add New</a>
                            </div>



                            <div class="container-fluid">
                                <div class="row">
                                    <div class="col-lg-12 table">
                                        <table class="table text-start align-middle table-bordered table-hover mb-0">
                                            <thead style="font-size:21px;">
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Fullname</th>

                                                    <th>
                                                        <select class="gender-dropdown" onchange="if (this.value)
                                                                    window.location.href = this.value">
                                                            <option>Gender:</option>
                                                            <option value="userlist">All User</option>
                                                            <option value="filteruser?gender=male">Male</option>
                                                            <option value="filteruser?gender=female">Female</option>
                                                        </select>
                                                    </th>
                                                    <th>Email</th>
                                                    <th>Mobile</th>
                                                    <th> <select class="gender-dropdown" onchange="if (this.value)
                                                                window.location.href = this.value">
                                                            <option selected>Role</option>
                                                            <option value="userlist">All Role</option>
                                                            <c:forEach items="${roleList}" var="r">
                                                                <option value="filteruser?role=${r.id}" >${r.name}</option>
                                                            </c:forEach>
                                                        </select></th>
                                                    <th> <select class="gender-dropdown" onchange="if (this.value)
                                                                window.location.href = this.value">
                                                            <option>Status</option>
                                                            <option value="userlist">All Status</option>
                                                            <c:forEach items="${statusList}" var="s">
                                                                <option value="filteruser?status=${s}" >${s}</option>
                                                            </c:forEach>
                                                        </select></th>
                                                    <th>Action</th>
                                                </tr>
                                            </thead>
                                            <tbody style="font-size:24px;">
                                                <c:forEach items="${userList}" var="u">
                                                    <tr>
                                                        <td>${u.id}</td>
                                                        <td>${u.name}</td>
                                                        <td>${u.gender}</td>
                                                        <td>${u.email}</td>
                                                        <td>${u.phone}</td>
                                                        <td>${u.roleId}</td>
                                                        <td>${u.status}</td>
                                                        <td>
                                                            <div class="d-flex justify-content-evenly align-items-center py-2">
                                                                <div class="me-4"><a href="edituser?id=${u.id}&name=${u.name}&gender=${u.gender}&email=${u.email}&phone=${u.phone}&roleid=${u.roleId}&status=${u.status}"><img height="35" src="https://img.icons8.com/?size=100&id=114169&format=png&color=000000" height="50px"></a></div>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </c:forEach>

                                            </tbody>
                                        </table>
                                    </div>
                                </div>

                                <div class="text-left text-danger">${msg}</div>

                            </div>

                        </div>

                    </div>
                    <div id="popup1" class="overlay">
                        <div class="popup">
                            <h2 class="ms-3 mb-3">Add New User</h2>
                            <a class="close" href="#">&times;</a>
                            <div class="container-fluid">

                                <form method="post" action="adduser" class="row">
                                    <input type="hidden" name="action" value="add">
                                    <div class="col-md-12 mb-2"><label class="labels">Email</label><input type="email" name="email" class="form-control" placeholder="Enter email" required=""></div>
                                    <div class="col-md-12 mb-2"><label class="labels">Password</label><input type="password" name="password" class="form-control" placeholder="Enter Password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" title="Must contain at least one number, one uppercase and lowercase letter, and at least 8 or more characters" required></div>
                                    <div class="col-md-7 mb-2"><label class="labels">Name</label><input type="text" name="name" class="form-control" placeholder="" value="" required></div>
                                    <div class="col-md-5"><label class="labels">Role</label>
                                        <select class="form-select" id="roles" name="roleid">
                                            <c:forEach items="${roleList}" var="r">
                                                <option value="${r.id}">${r.name}</option>
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

                <!-- JavaScript Libraries -->
                <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
                <script src="lib/chart/chart.min.js"></script>
                <script src="lib/easing/easing.min.js"></script>
                <script src="lib/owlcarousel/owl.carousel.min.js"></script>

                <!-- Template Javascript -->
                <script src="js/admin.js"></script>
                </body>
                <style>
                    /********** Template CSS **********/
                    :root {
                        --primary: #009CFF;
                        --light: #F3F6F9;
                        --dark: #191C24;
                    }

                    .back-to-top {
                        position: fixed;
                        display: none;
                        right: 45px;
                        bottom: 45px;
                        z-index: 99;
                    }


                    /*** Spinner ***/
                    #spinner {
                        opacity: 0;
                        visibility: hidden;
                        transition: opacity .5s ease-out, visibility 0s linear .5s;
                        z-index: 99999;
                    }

                    #spinner.show {
                        transition: opacity .5s ease-out, visibility 0s linear 0s;
                        visibility: visible;
                        opacity: 1;
                    }



                    /*** Layout ***/
                    .sidebar {
                        position: fixed;
                        top: 0;
                        left: 0;
                        bottom: 0;
                        width: 250px;
                        height: 100vh;
                        overflow-y: auto;
                        background: var(--light);
                        transition: 0.5s;
                        z-index: 999;
                    }

                    .content {
                        margin-left: 250px;
                        min-height: 100vh;
                        background: #FFFFFF;
                        transition: 0.5s;
                    }

                    @media (min-width: 992px) {
                        .sidebar {
                            margin-left: 0;
                        }

                        .sidebar.open {
                            margin-left: -250px;
                        }

                        .content {
                            width: calc(100% - 250px);
                        }

                        .content.open {
                            width: 100%;
                            margin-left: 0;
                        }
                    }

                    @media (max-width: 991.98px) {
                        .sidebar {
                            margin-left: -250px;
                        }

                        .sidebar.open {
                            margin-left: 0;
                        }

                        .content {
                            width: 100%;
                            margin-left: 0;
                        }
                    }


                    /*** Navbar ***/
                    .sidebar .navbar .navbar-nav .nav-link {
                        padding: 7px 20px;
                        color: var(--dark);
                        font-weight: 500;
                        border-left: 3px solid var(--light);
                        border-radius: 0 30px 30px 0;
                        outline: none;
                    }

                    .sidebar .navbar .navbar-nav .nav-link:hover,
                    .sidebar .navbar .navbar-nav .nav-link.active {
                        color: var(--primary);
                        background: #FFFFFF;
                        border-color: var(--primary);
                    }

                    .sidebar .navbar .navbar-nav .nav-link i {
                        width: 40px;
                        height: 40px;
                        display: inline-flex;
                        align-items: center;
                        justify-content: center;
                        background: #FFFFFF;
                        border-radius: 40px;
                    }

                    .sidebar .navbar .navbar-nav .nav-link:hover i,
                    .sidebar .navbar .navbar-nav .nav-link.active i {
                        background: var(--light);
                    }

                    .sidebar .navbar .dropdown-toggle::after {
                        position: absolute;
                        top: 15px;
                        right: 15px;
                        border: none;
                        content: "\f107";
                        font-family: "Font Awesome 5 Free";
                        font-weight: 900;
                        transition: .5s;
                    }

                    .sidebar .navbar .dropdown-toggle[aria-expanded=true]::after {
                        transform: rotate(-180deg);
                    }

                    .sidebar .navbar .dropdown-item {
                        padding-left: 25px;
                        border-radius: 0 30px 30px 0;
                    }

                    .content .navbar .navbar-nav .nav-link {
                        margin-left: 25px;
                        padding: 12px 0;
                        color: var(--dark);
                        outline: none;
                    }

                    .content .navbar .navbar-nav .nav-link:hover,
                    .content .navbar .navbar-nav .nav-link.active {
                        color: var(--primary);
                    }

                    .content .navbar .sidebar-toggler,
                    .content .navbar .navbar-nav .nav-link i {
                        width: 40px;
                        height: 40px;
                        display: inline-flex;
                        align-items: center;
                        justify-content: center;
                        background: #FFFFFF;
                        border-radius: 40px;
                    }

                    .content .navbar .dropdown-toggle::after {
                        margin-left: 6px;
                        vertical-align: middle;
                        border: none;
                        content: "\f107";
                        font-family: "Font Awesome 5 Free";
                        font-weight: 900;
                        transition: .5s;
                    }

                    .content .navbar .dropdown-toggle[aria-expanded=true]::after {
                        transform: rotate(-180deg);
                    }

                    @media (max-width: 575.98px) {
                        .content .navbar .navbar-nav .nav-link {
                            margin-left: 15px;
                        }
                    }
                    .btn {
                        padding: 0 10px;
                        background: #009CFF;
                        color: #fff;
                    }

                    .btn:hover {
                        color: #fff;
                        background-color: #009CFF;
                        border-color: #204d74;
                    }
                    .stt{
                        position: relative;
                    }
                    .sort-icon{
                        position:absolute;
                        right:5%;
                        top:26%;
                    }
                    .overlay {
                        position: fixed;
                        z-index: 999;
                        top: 0;
                        bottom: 0;
                        left: 0;
                        right: 0;
                        background: rgba(0, 0, 0, 0.7);
                        transition: opacity 500ms;
                        display: none;
                        opacity: 0;
                    }
                    .overlay:target {
                        display: block;
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
                </style>
                </html>