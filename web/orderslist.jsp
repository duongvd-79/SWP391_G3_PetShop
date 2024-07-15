<%-- 
    Document   : admindashboard
    Created on : Jun 11, 2024, 12:27:50 AM
    Author     : ACER
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        <!-- Toastr -->
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css">
        <link href="css/admin.css" rel="stylesheet">
        <title>Sale DASHBOARD</title>
        <style>
            #search{
                width: 15% !important;
            }
        </style>
    </head>
    <jsp:include page="header.jsp"></jsp:include> 

        <body>
            <div class="container-fluid position-relative bg-white d-flex p-0 ">
                <div class="w-100 row">
                    <!-- Sidebar Start -->

                    <div style="z-index: 2;background-color: transparent;position: relative;" class="col-2 sidebar pe pb-3 shadow-sm">
                        <div style="top:130px;" class="w-100 mb-1 sticky-top">

                            <div class="navbar-nav w-100 mb-1">
                                <a href="SaleDashboard" class="nav-item nav-link"><i class="fa fa-tachometer-alt me-2"></i>DASHBOARD</a>
                                <a href="#" class="nav-item nav-link active"><i class="fas fa-file-alt"></i>ORDERS LIST</a>
                            </div>
                        </div>

                    </div>
                    <!-- Sidebar End -->
                    <!-- Content Start -->
                    <div style="font-size: 20px;" class="col-10 container-fluid rounded bg-white mt-5 mb-5">
                        <div style="top:-30px;" class="row ps-4 position-relative">
                            <form id="search-form" class="d-md-flex" action="orderslist" method="get">                              
                                <select style="border-bottom: 3px #b0b435 solid !important;" name="searchby" class="border-0 function pe-2">
                                    <option value="id" ${'id'.equals(requestScope.searchby)?'selected':''}>Order ID</option> 
                                <option value="name" ${'name'.equals(requestScope.searchby)?'selected':''}>Customer Name</option> 
                            </select>
                            <input style="border-bottom: 3px #b0b435 solid !important;margin-left: 20px;" class="border-0" type="search" placeholder="Search" name="search" value="${requestScope.search}" required>
                        </form>

                        <div class="col-sm-3">
                            <label class="form-label ms-1 my-0">Sort</label>
                            <select class="form-select function" onchange="if (this.value)
                                        window.location.href = this.value">
                                <c:set value="${requestScope.sortby}${requestScope.order}" var="opt"/>
                                <option value="orderslist?search=${search}&searchby=${searchby}&sortby=ordered_date&order=desc&status=${status}&start=${start}&end=${end}&saleid=${saleid}" ${'ordered_datedesc'.equals(opt)?'selected':''}>Order Date Descending</option>
                                <option value="orderslist?search=${search}&searchby=${searchby}&sortby=ordered_date&order=asc&status=${status}&start=${start}&end=${end}&saleid=${saleid}" ${'ordered_dateasc'.equals(opt)?'selected':''}>Order Date Ascending</option>
                                <option value="orderslist?search=${search}&searchby=${searchby}&sortby=name&order=desc&status=${status}&start=${start}&end=${end}&saleid=${saleid}" ${'namedesc'.equals(opt)?'selected':''}>Customer Name Descending</option>
                                <option value="orderslist?search=${search}&searchby=${searchby}&sortby=name&order=asc&status=${status}&start=${start}&end=${end}&saleid=${saleid}" ${'nameasc'.equals(opt)?'selected':''}>Customer Name Ascending</option>
                                <option value="orderslist?search=${search}&searchby=${searchby}&sortby=total&order=desc&status=${status}&start=${start}&end=${end}&saleid=${saleid}" ${'totaldesc'.equals(opt)?'selected':''}>Total Cost Descending</option> 
                                <option value="orderslist?search=${search}&searchby=${searchby}&sortby=total&order=asc&status=${status}&start=${start}&end=${end}&saleid=${saleid}" ${'totalasc'.equals(opt)?'selected':''}>Total Cost Ascending</option> 
                            </select>

                        </div>
                        <div class="col-sm-2">
                            <label class="form-label ms-1 my-0">Status</label>
                            <select class="form-select function" id="status" onchange="if (this.value)
                                        window.location.href = this.value">
                                <option value="orderslist?search=${search}&searchby=${searchby}&sortby=${sortby}&order=${order}&status=&start=${start}&end=${end}&saleid=${saleid}" selected>All Status</option>
                                <option value="orderslist?search=${search}&searchby=${searchby}&sortby=${sortby}&order=${order}&status=Submitted&start=${start}&end=${end}&saleid=${saleid}" ${'Submitted'.equals(requestScope.status)?'selected':''}>Submitted</option>
                                <option value="orderslist?search=${search}&searchby=${searchby}&sortby=${sortby}&order=${order}&status=Confirmed&start=${start}&end=${end}&saleid=${saleid}" ${'Confirmed'.equals(requestScope.status)?'selected':''}>Confirmed</option>
                                <option value="orderslist?search=${search}&searchby=${searchby}&sortby=${sortby}&order=${order}&status=Success&start=${start}&end=${end}&saleid=${saleid}" ${'Success'.equals(requestScope.status)?'selected':''}>Success</option>
                                <option value="orderslist?search=${search}&searchby=${searchby}&sortby=${sortby}&order=${order}&status=Cancelled&start=${start}&end=${end}&saleid=${saleid}" ${'Cancelled'.equals(requestScope.status)?'selected':''}>Cancelled</option>

                            </select>
                        </div>
                        <form class="col-7 row d-flex" action="orderslist" method="get">
                            <input type="hidden" name="page" value="${page}"/>
                            <input type="hidden" name="search" value="${search}"/>
                            <input type="hidden" name="searchby" value="${searchby}"/>
                            <input type="hidden" name="sortby" value="${sortby}"/>
                            <input type="hidden" name="order" value="${order}"/>
                            <input type="hidden" name="status" value="${status}"/>
                            <input type="hidden" name="saleid" value="${saleid}"/>
                            <div style="padding-right: 5px;" class="col-3 mb-3">
                                <label for="start-date" class="form-label ms-1 my-0">Start Date</label>
                                <input type="date" name="start" id="start-date" class="form-control" value="${start}" required="">
                            </div>
                            <div style="padding-right: 5px;margin-left: 7px;" class="col-3 mb-3">
                                <label for="end-date" class="form-label ms-1 my-0">End Date</label>
                                <input type="date" name="end" id="end-date" class="form-control" value="${end}" required="">
                            </div>
                            <div class="col-3 position-relative mb-3">
                                <button type="submit" style="height:47px;margin-left: 15px;width:70%;" class=" btn position-absolute bottom-0">Submit</button>
                            </div>
                            <div class="col-2 position-relative mb-3">
                                <a type="submit" style="height:47px;margin-left: 15px;width:100%;left:-30px;color: white;" href="orderslist" class="btn d-flex align-items-center justify-content-center position-absolute bottom-0"><span>Clear</span></a>
                            </div>
                        </form>
                        <c:if test="${user.getRoleId()==4}">
                            <div class="col-sm-3">
                                <label class="form-label ms-1 my-0">Sale Name</label>
                                <select class="form-select function" onchange="if (this.value)
                                        window.location.href = this.value">
                                                <option value="orderslist?search=${search}&searchby=${searchby}&sortby=${sortby}&order=${order}&status=&start=${start}&end=${end}" selected>All Sale</option>
                                                <c:forEach var="s" items="${saleList}">
                                                    <option ${saleid == s.getId()?'selected':''} value="orderslist?search=${search}&searchby=${searchby}&sortby=${sortby}&order=${order}&status=&start=${start}&end=${end}&saleid=${s.getId()}">${s.getName()}</option>
                                                </c:forEach>
                                </select>

                            </div>
                                <div class="col-9"></div>
                        </c:if>

                        <c:if test="${length >= 0 }">
                            <c:forEach begin="0" end="${length}" var="i" step="1">
                                <div style="border-left:${'Submitted'.equals(oList[i].status)?'#007bff':''}
                                     ${'Success'.equals(oList[i].status)?'#28a745':''}
                                     ${'Confirmed'.equals(oList[i].status)?'#17a2b8':''}
                                     ${'Shipping'.equals(oList[i].status)?'#ffc107':''}
                                     ${'Cancelled'.equals(oList[i].status)?'#dc3545':''}
                                     5px solid;border-radius: 5px;" 
                                     class="col-sm-6 p-2 mt-4">
                                    <div class="row">
                                        <div class="d-flex col-7 p-0 ms-3">
                                            <div class="ms-3 mb-2">Order ID : ${oList[i].id},
                                                <span class="${'Submitted'.equals(oList[i].status)?'text-primary':''}"> ${oList[i].status}</span> </div>
                                        </div>
                                        <div class="d-flex justify-content-center col-4 ms-3">
                                            <div>${oList[i].orderedDate}</div>
                                        </div>
                                        <div class="col-4 d-flex align-items-center justify-content-center">
                                            <img width="170px" src="${pList[i].thumbnail}" alt="alt"/>
                                        </div>
                                        <div class="col-8 p-0">  
                                            <div>Customer : ${oList[i].customerName}</div>
                                            <div>${pList[i].title} x ${pQuantity[i]}</div>
                                            <div>And ${remainNum[i]} more products.</div>
                                            <div><a class="text-primary" href="orderdetails?id=${oList[i].id}">View Detail Here</a></div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                            <nav style="position:relative; top:50px;right:100px;" aria-label="setting list paging">
                                <ul class="pagination d-flex justify-content-end mb-2">
                                    <li class="page-item"><a class="page-link ${requestScope.page == 1 ? 'd-none' : ''}"
                                                             href="orderslist?page=${page-1}&search=${search}&searchby=${searchby}&sortby=${sortby}&order=${order}&status=${status}&start=${start}&end=${end}&saleid=${saleid}" >Previous</a></li>
                                        <c:forEach begin="1" end="${requestScope.pageNum}" step="1" var="i">
                                        <li class="page-item ${ i == requestScope.page ? 'active': ''}"><a class="page-link"
                                                                                                           href="orderslist?page=${i}&search=${search}&searchby=${searchby}&sortby=${sortby}&order=${order}&status=${status}&start=${start}&end=${end}&saleid=${saleid}">${i}</a></li>
                                        </c:forEach>
                                    <li class="page-item"><a class="page-link ${requestScope.page >= requestScope.pageNum ? 'd-none' : ''}"
                                                             href="orderslist?page=${page+1}&search=${search}&searchby=${searchby}&sortby=${sortby}&order=${order}&status=${status}&start=${start}&end=${end}&saleid=${saleid}">Next</a></li>
                                </ul>
                            </nav>
                        </c:if>
                        <%-- Empty List --%>
                        <c:if test="${length < 0}">
                            <div class="col-10 d-flex justify-content-between align-items-center p-0">
                                <img style="width:40%;margin: 20px auto 0px;" src="images/no-order.svg" alt="alt"/>
                            </div>
                            <div class="col-10 d-flex justify-content-center mb-5 h5">No Order Here</div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </body>
    <jsp:include page="footer.jsp"></jsp:include>
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
</html>
