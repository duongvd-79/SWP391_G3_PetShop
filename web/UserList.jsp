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
        <link href="css/admin.css" rel="stylesheet">
        <title>User List</title>
    </head>
    <style>
        #search-form{
            display:none !important;
        }

        .gender-dropdown {
            border: none; /* Remove border */
            font-weight: bold; /* Make text bold */
            background: none; /* Remove background */
            appearance: none; /* Remove default appearance */
            -webkit-appearance: none; /* Remove default appearance for Safari */
            -moz-appearance: none; /* Remove default appearance for Firefox */
            padding: 5px; /* Add some padding */
            padding-right: 25px; /* Ensure space for the arrow */
            cursor: pointer; /* Change cursor to pointer */
            background-image: url('data:image/svg+xml;charset=UTF-8,<svg xmlns="http://www.w3.org/2000/svg" width="10" height="5" viewBox="0 0 10 5"><path fill="black" d="M0 0l5 5 5-5z"/></svg>');
            background-repeat: no-repeat;
            background-position: calc(100% - 10px) center; /* Adjust the position of the arrow */
            background-size: 10px; /* Adjust the size of the arrow */
        }

        /* Style for option elements */
        .gender-dropdown option {
            font-weight: normal; /* Set the weight of options to normal if needed */
        }

        /* If you want to change the text of the headers only */
        th select.gender-dropdown {
            font-weight: bold; /* Make header text bold */
        }
    </style>
    <jsp:include page="header.jsp"></jsp:include>
        <body>
            <div class="container-fluid position-relative bg-white d-flex p-0">
                <div class="row">
                    <!-- Sidebar Start -->
                    <div style="z-index: 2;background-color: transparent;position: relative;" class="col-2 sidebar pe pb-3 shadow-sm">
                        <div style="top:130px;" class="w-100 mb-1 sticky-top">
                            <a href="admindashboard" class="nav-link"><i class="fa fa-tachometer-alt me-2"></i>DASHBOARD</a>
                            <a href="setting" class="nav-link"><i class="bi bi-gear-fill me-2"></i>SETTING</a>
                            <a href="#" class="nav-link active"><i class="bi bi-people-fill me-2"></i>USER LIST</a>
                        </div>
                    </div>
                    <!-- Sidebar End -->


                    <!-- Content Start -->
                    <div class="col-10 container-fluid rounded bg-white mt-2 mb-5">
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
                                        <option value="sortuser?order_by=id&page=1"}>User ID</option>
                                        <option value="sortuser?order_by=name&page=1"}>FullName</option>
                                        <option value="sortuser?order_by=gender&page=1"}>Gender</option>
                                        <option value="sortuser?order_by=email&page=1"}>Email</option>
                                        <option value="sortuser?order_by=phone&page=1"}>Mobile</option>
                                        <option value="sortuser?order_by=role_id&page=1"}>Role ID</option>
                                        <option value="sortuser?order_by=status&page=1"}>Status</option>
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
                                                                <option>Gender</option>
                                                                <option value="userlist?page=1">All User</option>
                                                                <option value="filteruser?gender=male&page=1">Male</option>
                                                                <option value="filteruser?gender=female&page=1">Female</option>
                                                            </select>
                                                        </th>
                                                        <th>Email</th>
                                                        <th>Mobile</th>
                                                        <th> <select class="gender-dropdown" onchange="if (this.value)
                                                                    window.location.href = this.value">
                                                                <option selected>Role</option>
                                                                <option value="userlist?page=1">All Role</option>
                                                            <c:forEach items="${roleList}" var="r">
                                                                <option value="filteruser?role=${r.id}&page=1" >${r.name}</option>
                                                            </c:forEach>
                                                        </select></th>
                                                    <th> <select class="gender-dropdown" onchange="if (this.value)
                                                                window.location.href = this.value">
                                                            <option>Status</option>
                                                            <option value="userlist?page=1">All Status</option>
                                                            <c:forEach items="${statusList}" var="s">
                                                                <option value="filteruser?status=${s}&page=1" >${s}</option>
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
                                                        <td class="${u.getStatus().equals('Active') ? 'text-primary' : 'text-danger'} fw-bolder">${u.status}</td>
                                                        <td>
                                                            <div class="d-flex justify-content-evenly align-items-center py-2">
                                                                <div class="me-4"><a href="userdetails?id=${u.id}&name=${u.name}&gender=${u.gender}&email=${u.email}&phone=${u.phone}&roleid=${u.roleId}&status=${u.status}"><img height="35" src="https://img.icons8.com/?size=100&id=114169&format=png&color=000000" height="50px"></a></div>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </c:forEach>

                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <c:if test="${link == 'userlist'}">
                                    <nav style="position: absolute;bottom: -30px; right: 42px" aria-label="setting list paging">
                                        <ul class="pagination d-flex justify-content-end mb-2">
                                            <li class="page-item"><a class="page-link ${requestScope.page == 1 ? 'd-none' : ''}" href="userlist?page=${page-1}">Previous</a></li>
                                                <c:forEach begin="1" end="${requestScope.pageNum}" var="i">
                                                <li class="page-item ${ i == requestScope.page ? 'active': ''}"><a class="page-link" href="userlist?page=${i}">${i}</a></li>
                                                </c:forEach>

                                            <li class="page-item"><a class="page-link ${(requestScope.pageNum == 0 || requestScope.page == requestScope.pageNum) ? 'd-none' : ''}" href="userlist?page=${page + 1}">Next</a></li>
                                        </ul>
                                    </nav>
                                </c:if>
                                <c:if test="${link == 'sortuser'}">
                                    <nav style="position: absolute;bottom: -30px; right: 42px" aria-label="setting list paging">
                                        <ul class="pagination d-flex justify-content-end mb-2">
                                            <li class="page-item"><a class="page-link ${requestScope.page == 1 ? 'd-none' : ''}" href="sortuser?order_by=${order_by}&page=${page-1}">Previous</a></li>
                                                <c:forEach begin="1" end="${requestScope.pageNum}" var="i">
                                                <li class="page-item ${ i == requestScope.page ? 'active': ''}"><a class="page-link" href="sortuser?order_by=${order_by}&page=${i}">${i}</a></li>
                                                </c:forEach>

                                            <li class="page-item"><a class="page-link ${(requestScope.pageNum == 0 || requestScope.page == requestScope.pageNum) ? 'd-none' : ''}" href="sortuser?order_by=${order_by}&page=${page + 1}">Next</a></li>
                                        </ul>
                                    </nav>
                                </c:if>
                                <c:if test="${link == 'filteruser' and gender != null}">
                                    <nav style="position: absolute;bottom: -30px; right: 42px" aria-label="setting list paging">
                                        <ul class="pagination d-flex justify-content-end mb-2">
                                            <li class="page-item"><a class="page-link ${requestScope.page == 1 ? 'd-none' : ''}" href="filteruser?gender=${gender}&page=${page-1}">Previous</a></li>
                                                <c:forEach begin="1" end="${requestScope.pageNum}" var="i">
                                                <li class="page-item ${ i == requestScope.page ? 'active': ''}"><a class="page-link" href="filteruser?gender=${gender}&page=${i}">${i}</a></li>
                                                </c:forEach>

                                            <li class="page-item"><a class="page-link ${(requestScope.pageNum == 0 || requestScope.page == requestScope.pageNum) ? 'd-none' : ''}" href="filteruser?gender=${gender}&page=${page + 1}">Next</a></li>
                                        </ul>
                                    </nav>
                                </c:if>
                                <c:if test="${link == 'filteruser' and role != null}">
                                    <nav style="position: absolute;bottom: -30px; right: 42px" aria-label="setting list paging">
                                        <ul class="pagination d-flex justify-content-end mb-2">
                                            <li class="page-item"><a class="page-link ${requestScope.page == 1 ? 'd-none' : ''}" href="filteruser?role=${role}&page=${page-1}">Previous</a></li>
                                                <c:forEach begin="1" end="${requestScope.pageNum}" var="i">
                                                <li class="page-item ${ i == requestScope.page ? 'active': ''}"><a class="page-link" href="filteruser?role=${role}&page=${i}">${i}</a></li>
                                                </c:forEach>

                                            <li class="page-item"><a class="page-link ${(requestScope.pageNum == 0 || requestScope.page == requestScope.pageNum) ? 'd-none' : ''}" href="filteruser?role=${role}&page=${page + 1}">Next</a></li>
                                        </ul>
                                    </nav>
                                </c:if>
                                <c:if test="${link == 'filteruser' and status != null}">
                                    <nav style="position: absolute;bottom: -30px; right: 42px" aria-label="setting list paging">
                                        <ul class="pagination d-flex justify-content-end mb-2">
                                            <li class="page-item"><a class="page-link ${requestScope.page == 1 ? 'd-none' : ''}" href="filteruser?status=${status}&page=${page-1}">Previous</a></li>
                                                <c:forEach begin="1" end="${requestScope.pageNum}" var="i">
                                                <li class="page-item ${ i == requestScope.page ? 'active': ''}"><a class="page-link" href="filteruser?status=${status}&page=${i}">${i}</a></li>
                                                </c:forEach>

                                            <li class="page-item"><a class="page-link ${(requestScope.pageNum == 0 || requestScope.page == requestScope.pageNum) ? 'd-none' : ''}" href="filteruser?status=${status}&page=${page + 1}">Next</a></li>
                                        </ul>
                                    </nav>
                                </c:if>
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
                                    <div class="form-group col-md-12 mb-2"><label class="labels">Password</label>
                                        <input id="password" type="password" name="password" class="form-control" placeholder="Enter Password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" title="Must contain at least one number, one uppercase and lowercase letter, and at least 8 or more characters" required>
                                    </div>
                                    <div class="col-md-7 mb-2"><label class="labels">Name</label><input type="text" name="name" class="form-control" 
                                                                                                        pattern="^\s*[A-Za-zÀ-ỹà-ỹ]+([A-Za-zÀ-ỹà-ỹ ]+){1,50}\s*$" required="" 
                                                                                                        title="Not contain special character or only white space" value="" required></div>
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
                                                <input class="form-check-input" type="radio" name="gender" value="Male" id="male" checked >
                                                <label class="form-check-label" for="male">
                                                    Male
                                                </label>
                                            </div>
                                            <div class="form-check custom-radio form-check-inline">
                                                <input class="form-check-input" type="radio" name="gender" value="Female" id="female" >
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
                <jsp:include page="footer.jsp"></jsp:include>
            </div>
        </div>

        <!-- JavaScript Libraries -->
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="lib/chart/chart.min.js"></script>
        <script src="lib/easing/easing.min.js"></script>
        <script src="lib/owlcarousel/owl.carousel.min.js"></script>
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
        <!-- Template Javascript -->
        <script src="js/admin.js"></script>
        <style>

        </style>
    </body>

</html>