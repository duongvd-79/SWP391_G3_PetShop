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
        <title>Setting List</title>
    </head>
    <jsp:include page="header.jsp"></jsp:include>
        <body>
            <div class="container-fluid position-relative bg-white d-flex p-0">
                <div class="row">

                    <!-- Sidebar Start -->
                    <div style="z-index: 2;background-color: transparent;position: relative;" class="col-2 sidebar pe pb-3 shadow-sm mt-4">
                        <form style="border:2px #cccccc solid;" id="search-form" class="d-none d-md-flex ms-4" action="setting" method="get">
                            <input class="form-control border-0" type="search" placeholder="Search" name="search" value="${requestScope.sName}">
                    </form>
                    <div style="top:130px;" class="w-100 mb-1 sticky-top">
                        <a href="admindashboard" class="nav-link"><i class="fa fa-tachometer-alt me-2"></i>DASHBOARD</a>
                        <a href="setting" class="nav-link active"><i class="bi bi-gear-fill me-2"></i>SETTING</a>
                        <a href="userlist?page=1" class="nav-link"><i class="bi bi-people-fill me-2"></i>USER LIST</a>
                    </div>
                </div>
                <!-- Sidebar End -->


                <!-- Content Start -->
                <div class="col-10 container-fluid rounded bg-white mt-4 mb-5 pb-1 px-4">
                    <div clas="row">
                        <div class="row d-flex align-items-center mb-3">

                            <div class="col-md-3 function">
                                <select name="type" class="form-select" id="type" onchange="if (this.value)
                                            window.location.href = this.value">
                                    <option value="setting?page=1&search=${requestScope.sName}&sort=${requestScope.sort}&action=filter&status=${requestScope.status}">All type</option>
                                    <c:forEach items="${requestScope.types}" var="t">
                                        <option value="setting?page=1&search=${requestScope.sName}&sort=${requestScope.sort}&action=filter&type=${t}&status=${requestScope.status}" ${t.equals(requestScope.type) ? 'selected' : ''}>${t}</option></a>
                                    </c:forEach>                          
                                </select>
                            </div>
                            <div class="col-md-2 function">
                                <select class="form-select function" id="status" onchange="if (this.value)
                                            window.location.href = this.value">
                                    <option value="setting?page=1&search=${requestScope.sName}&sort=${requestScope.sort}&action=filter&type=${requestScope.type}">All Status</option>
                                    <option value="setting?page=1&search=${requestScope.sName}&sort=${requestScope.sort}&action=filter&status=Pending&type=${requestScope.type}" ${'Pending'.equals(requestScope.status) ? 'selected' : ''}>Pending</option>
                                    <option value="setting?page=1&search=${requestScope.sName}&sort=${requestScope.sort}&action=filter&status=Active&type=${requestScope.type}" ${'Active'.equals(requestScope.status) ? 'selected' : ''}>Active</option>
                                    <option value="setting?page=1&search=${requestScope.sName}&sort=${requestScope.sort}&action=filter&status=Inactive&type=${requestScope.type}" ${'Inactive'.equals(requestScope.status) ? 'selected' : ''}>Inactive</option>
                                </select>
                            </div>
                            <div class="col-md-1 function">
                                <div class="btn py-1 px-4 ms-2">
                                    <a value="" style="text-decoration: none;color: white;" href="setting" >Clear</a>
                                </div>
                            </div>
                            <div class="col-md-6 d-flex justify-content-end">
                                <div class="btn py-1 px-4 ms-2">
                                    <a href="#popup1" style="text-decoration: none;color: white;" type="button">Add New</a>
                                </div>
                            </div>

                        </div>
                        <div class="row">
                            <div class="col-lg-12 table">
                                <table class="table text-start align-middle table-bordered table-hover mb-0">
                                    <thead style="font-size:21px;">
                                        <tr>
                                            <th>ID</th>
                                            <th><div class="d-flex justify-content-between">Setting type <a class="d-flex align-items-center" href="setting?page=1&sort=type&search=${requestScope.sName}&action=filter&status=${requestScope.status}&type=${requestScope.type}"><i class="bi bi-sort-up"></i></a></div></th>
                                            <th>Name</th>
                                            <th><div class="d-flex justify-content-between">Order <a class="d-flex align-items-center" href="setting?page=1&sort=order&search=${requestScope.sName}&action=filter&status=${requestScope.status}&type=${requestScope.type}"><i class="bi bi-sort-up"></i></a></div></th>
                                            <th><div class="d-flex justify-content-between">Status <a class="d-flex align-items-center" href="setting?page=1&sort=status&search=${requestScope.sName}&action=filter&status=${requestScope.status}&type=${requestScope.type}"><i class="bi bi-sort-up"></i></a></div></th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody style="font-size:24px;">
                                        <c:forEach items="${requestScope.settingList}" var="s">
                                            <tr>
                                                <td>${s.getId()}</td>
                                                <td >${s.getType()}</td>
                                                <td >${s.getName()}</td>
                                                <td >${s.getOrder()}</td>
                                                <td class="${s.getStatus().equals('Active') ? 'text-primary' : 'text-danger'} fw-bolder">${s.getStatus()}</td>
                                                <td ><div class="d-flex justify-content-evenly align-items-center py-2">
                                                        <div class="me-4"><a href="setting?action=edit&id=${s.getId()}"><img class="mb-1" height="35" src="https://img.icons8.com/?size=100&id=114169&format=png&color=000000" height="50px"></a></div>
                                                        <div class="btn py-1 ${s.getStatus().equals('Active') ? 'bg-danger' : 'bg-primary'}" style="line-height: 25px;width:100px;">
                                                            <c:if test="${s.getId()!=1}">
                                                                <a value="" style="text-decoration: none;color: white;" href="setting?id=${s.getId()}&cstatus=${s.getStatus().equals('Active') ? 'Inactive' : 'Active'}" >${s.getStatus().equals('Active') ? 'Disable' : 'Activate'}</a>
                                                            </c:if>
                                                            <c:if test="${s.getId() == 1}">
                                                                <span>Unchange</span>
                                                            </c:if>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>

                                    </tbody>
                                </table>
                            </div>
                        </div>
                                            <c:if test="${pageNum == 0}">
                                                <div style="text-align: center" class="h5 mt-4">No Setting Here </div>
                                            </c:if>
                                            <c:if test="${pageNum > 0}">
                        <nav aria-label="setting list paging">
                            <ul class="pagination d-flex justify-content-end mb-2">
                                <li class="page-item"><a class="page-link ${requestScope.page == 1 ? 'd-none' : ''}" href="setting?page=${requestScope.page-1}&search=${requestScope.sName}&sort=${requestScope.sort}&action=filter&status=${requestScope.status}&type=${requestScope.type}">Previous</a></li>
                                <li class="page-item ${ 1 == requestScope.page ? 'active': ''}"><a class="page-link" href="setting?page=1&search=${requestScope.sName}&sort=${requestScope.sort}&action=filter&status=${requestScope.status}&type=${requestScope.type}">1</a></li>
                                <c:if test="${requestScope.page > 2}">
                                    <li class="page-item"><a class="page-link" href="">...</a></li>
                                </c:if>
                                <c:choose>
                                    <c:when test="${requestScope.page >= requestScope.pageNum-2 && requestScope.pageNum > 4} ">
                                        <c:forEach begin="${requestScope.pageNum-2}" end="${requestScope.pageNum-1}" var="i">
                                            <li class="page-item ${ i == requestScope.page ? 'active': ''}"><a class="page-link" href="setting?page=${i}&search=${requestScope.sName}&sort=${requestScope.sort}&action=filter&status=${requestScope.status}&type=${requestScope.type}">${i}</a></li>
                                        </c:forEach>
                                    </c:when>
                                    <c:when test="${requestScope.page >= 2 && requestScope.page <= requestScope.pageNum-1}">
                                        <c:forEach begin="${requestScope.page}" end="${requestScope.page+1}" var="i">
                                            <li class="page-item ${ i == requestScope.page ? 'active': ''}"><a class="page-link" href="setting?page=${i}&search=${requestScope.sName}&sort=${requestScope.sort}&action=filter&status=${requestScope.status}&type=${requestScope.type}">${i}</a></li>
                                        </c:forEach>
                                    </c:when>
                                </c:choose>
                                <c:if test="${requestScope.page <= requestScope.pageNum-2}">
                                    <li class="page-item"><a class="page-link" href="">...</a></li>
                                </c:if>
                                <c:if test="${requestScope.page != requestScope.pageNum-1 && requestScope.pageNum != 1}">
                                <li class="page-item ${ requestScope.pageNum == requestScope.page ? 'active': ''}"><a class="page-link" href="setting?page=${requestScope.pageNum}&search=${requestScope.sName}&sort=${requestScope.sort}&action=filter&status=${requestScope.status}&type=${requestScope.type}">${requestScope.pageNum}</a></li>
                                </c:if>
                                <li class="page-item"><a class="page-link ${(requestScope.pageNum == 0 || requestScope.page == requestScope.pageNum) ? 'd-none' : ''}" href="setting?page=${requestScope.page+1}&search=${requestScope.sName}&sort=${requestScope.sort}&action=filter&status=${requestScope.status}&type=${requestScope.type}">Next</a></li>
                            </ul>
                        </nav>
                                            </c:if>
                        <div id="popup1" class="overlay">
                            <div class="popup">
                                <div class="h5 ms-3 mb-3">Add New Setting</div>
                                <a class="close" href="#">&times;</a>
                                <div class="container-fluid">
                                    <form method="post" action="setting" class="row">
                                        <input type="hidden" name="action" value="add">
                                        <div class="col-md-7"><label class="labels">Group</label>
                                            <select class="form-select" id="roles" name="type" >
                                                <c:forEach items="${requestScope.types}" var="t">
                                                    <option value="${t}">${t}</option>
                                                </c:forEach>                             
                                            </select>
                                        </div>
                                        <div class="col-md-5"><label class="labels">Order</label><input type="text" name="order" class="form-control" placeholder="Enter Setting Order" required=""></div>
                                        <div class="col-md-12 my-3"><label class="labels">Name</label><input type="text" name="name" class="form-control" placeholder="Enter Setting Name" required=""></div>
                                        <div class="col-md-12"><label class="labels">Description</label>
                                            <textarea class="form-control" id="note" name="note" rows="3" value="${detail.getDescription()}" placeholder="Description"></textarea>
                                        </div>
                                        <div class="d-flex justify-content-center">
                                            <div class="mt-4"><button class="btn py-1 px-4 ms-2" type="button submit">Add</button></div>
                                        </div>
                                    </form>
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
    </body>
</html>
