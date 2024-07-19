<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>PetShop - Marketing Features</title>

        <link rel="shortcut icon" href="images/icon.ico" type="image/x-icon">
        <link rel="apple-touch-icon" href="images/apple-touch-icon.png">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
        <!-- Icon CSS -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <!-- Site CSS -->
        <link rel="stylesheet" href="css/style.css">
        <!-- Responsive CSS -->
        <link rel="stylesheet" href="css/responsive.css">
        <style>
            .page-item.active .page-link {
                background-color: #b0b435;
                border-color: #b0b435;
            }
            .page-link {
                background-color: #fff;
                color: #212121;
            }
            .address {
                margin-bottom: 15px;
                padding: 15px;
                background-color: #f9f9f9;
                border-radius: 8px;
                box-shadow: 0 2px 5px 0px rgba(0, 0, 0, 0.1);
            }
            .info-popup {
                display: none;
                position: absolute;
                top: 100%;
                left: 15px;
                padding: 5px 10px;
                background-color: #f0f0f0;
                border-radius: 5px;
                z-index: 1;
            }
            #newname:focus + .info-popup,
            #newphone:focus + .info-popup,
            #newemail:focus + .info-popup {
                display: block;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>
            <div class="container-fluid">
                <div class="row">

                   
                   <!-- Sidebar Start -->
                    <div class="container col-2 position-relative" >
                        <div class="w-100 mb-1 sticky-top" style="top: 126px; z-index: 1; font-size: 18px">
                            <a href="#" class="nav-link"><i class="bi bi-clipboard-data-fill p-2 rounded-circle" style="background-color: lightgray"></i> DASHBOARD</a>
                            <a href="customerlist" class="nav-link active"><i class="bi bi-people-fill p-2 rounded-circle" style="background-color: lightgray"></i> CUSTOMERS/<br>CONTACTS</a>
                            <a href="FeedbackManager" class="nav-link"><i class="bi bi-chat-left-text-fill p-2 rounded-circle" style="background-color: lightgray"></i> FEEDBACKS</a>
                            <a href="marketingproductlist" class="nav-link"><i class="bi bi-archive-fill p-2 rounded-circle" style="background-color: lightgray"></i> PRODUCTS</a>
                            <a href="SliderManager" class="nav-link"><i class="bi bi-image p-2 rounded-circle" style="background-color: lightgray"></i> SLIDERS</a>
                        </div>
                    </div>
                    <!-- Sidebar End -->


                    <!-- Content Start -->
                    <div class="col-10 container-fluid rounded bg-white mt-4 mb-5 pb-1 px-4">
                        <div clas="row">
                            <div class="row d-flex align-items-center mb-3">
                                <div class="col-md-3">
                                    <form action="customerlist" method="get">
                                        <input type="text" name="search" class="w-100" placeholder="Search..." value="${search}" style="min-height: 37.6px"/>
                                    <input type="text" name="status" value="${status}" hidden/>
                                    <input type="text" name="search" value="${search}" hidden/>
                                    <input type="text" name="sort" value="${sort}" hidden/>
                                    <button type="submit" hidden></button>
                                </form>
                            </div>
                            <div class="col-md-2">
                                <select class="form-select py-2 w-100" id="status">
                                    <option value="">All Status</option>
                                    <option value="Pending" ${status eq 'Pending' ? 'selected' : ''}>Pending</option>
                                    <option value="Active" ${status eq 'Active' ? 'selected' : ''}>Active</option>
                                    <option value="Inactive" ${status eq 'Inactive' ? 'selected' : ''}>Inactive</option>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <select class="form-select py-2 w-100" id="gender">
                                    <option value="">All Gender</option>
                                    <option value="Male" ${gender eq 'Male' ? 'selected' : ''}>Male</option>
                                    <option value="Female" ${gender eq 'Female' ? 'selected' : ''}>Female</option>
                                </select>
                            </div>
                            <div class="col-md-1">
                                <a class="btn" style="text-decoration: none;color: white;background: #b0b435" href="customerlist">Clear</a>
                            </div>
                            <div class="col-md-4 d-flex justify-content-end">
                                <a class="btn" href="#addNewCustomer" style="text-decoration: none;color: white;background: #b0b435" type="button">Add New</a>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12 table-responsive">
                                <table class="table text-start align-middle table-bordered table-hover mb-0">
                                    <thead style="font-size:20px;">
                                        <tr>
                                            <th>
                                                <div class="d-flex justify-content-center">ID</div>
                                            </th>
                                            <th>
                                                <div class="d-flex justify-content-center">Profile<br>Picture</div>
                                            </th>
                                            <th class="${sort eq 'Name ASC' || sort eq 'Name DESC' ? 'table-active' : ''}">
                                                <div class="d-flex justify-content-between">
                                                    Name 
                                                    <a class="d-flex align-items-center" 
                                                       href="?status=${status}&search=${search}&sort=${sort eq 'Name ASC' ? 'Name DESC' : 'Name ASC'}&page=${page}">
                                                        <i class="bi ${sort eq 'Name ASC' ? 'bi-sort-down' : 'bi-sort-up'}"></i>
                                                    </a>
                                                </div>
                                            </th>
                                            <th class="${sort eq 'Email ASC' || sort eq 'Email DESC' ? 'table-active' : ''}">
                                                <div class="d-flex justify-content-between">
                                                    Email 
                                                    <a class="d-flex align-items-center" 
                                                       href="?status=${status}&search=${search}&sort=${sort eq 'Email ASC' ? 'Email DESC' : 'Email ASC'}&page=${page}">
                                                        <i class="bi ${sort eq 'Email ASC' ? 'bi-sort-down' : 'bi-sort-up'}"></i>
                                                    </a>
                                                </div>
                                            </th>
                                            <th class="${sort eq 'Gender ASC' || sort eq 'Gender DESC' ? 'table-active' : ''}">
                                                <div class="d-flex justify-content-between">
                                                    Gender 
                                                    <a class="d-flex align-items-center" 
                                                       href="?status=${status}&search=${search}&sort=${sort eq 'Gender ASC' ? 'Gender DESC' : 'Gender ASC'}&page=${page}">
                                                        <i class="bi ${sort eq 'Gender ASC' ? 'bi-sort-down' : 'bi-sort-up'}"></i>
                                                    </a>
                                                </div>
                                            </th>
                                            <th class="${sort eq 'Phone ASC' || sort eq 'Phone DESC' ? 'table-active' : ''}">
                                                <div class="d-flex justify-content-between">
                                                    Phone 
                                                    <a class="d-flex align-items-center" 
                                                       href="?status=${status}&search=${search}&sort=${sort eq 'Phone ASC' ? 'Phone DESC' : 'Phone ASC'}&page=${page}">
                                                        <i class="bi ${sort eq 'Phone ASC' ? 'bi-sort-down' : 'bi-sort-up'}"></i>
                                                    </a>
                                                </div>
                                            </th>
                                            <th class="${sort eq 'Status ASC' || sort eq 'Status DESC' ? 'table-active' : ''}">
                                                <div class="d-flex justify-content-between">
                                                    Status 
                                                    <a class="d-flex align-items-center" 
                                                       href="?status=${status}&search=${search}&sort=${sort eq 'Status ASC' ? 'Status DESC' : 'Status ASC'}&page=${page}">
                                                        <i class="bi ${sort eq 'Status ASC' ? 'bi-sort-down' : 'bi-sort-up'}"></i>
                                                    </a>
                                                </div>
                                            </th>
                                            <th>
                                                <div class="d-flex justify-content-center">
                                                    Action
                                                </div>
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody style="font-size:24px;">
                                        <c:choose>
                                            <c:when test="${size == 0}">
                                                <tr>
                                                    <td colspan="7"><h2 class="text-center">There is nothing to show!</h2></td>
                                                </tr>
                                            </c:when>
                                            <c:otherwise>
                                                <c:forEach items="${customerList}" var="c">
                                                    <tr>
                                                        <td>
                                                            <div class="d-flex justify-content-center">
                                                                ${c.id}
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <div class="d-flex justify-content-center">
                                                                <img class="rounded" src="${c.pfp}" onerror="this.src='images/userpfp/default.png';this.onerror='';" style="max-width: 50px"/>
                                                            </div>
                                                        </td>
                                                        <td>${c.name}</td>
                                                        <td>${c.email}</td>
                                                        <td>${c.gender}</td>
                                                        <td>${c.phone}</td>
                                                        <td>
                                                            <span class="badge ${c.status eq 'Active' ? 'badge-success' : (c.status eq 'Inactive' ? 'badge-danger' : 'badge-secondary')}">${c.status}</span>
                                                        </td>
                                                        <td>
                                                            <div class="d-flex justify-content-between">
                                                                <a href="#editCustomer${c.id}" title="Edit"><i class="bi bi-person-lines-fill"></i></a>
                                                                <a type="button" title="Enable/Disable Customer" href="?id=${c.id}&cstatus=${c.status}&status=${status}&search=${search}&gender=${gender}&sort=${sort}&page=${page}">
                                                                    ${c.status eq 'Active' ? '<i class="bi bi-ban"></i>' : '<i class="bi bi-circle"></i>'}
                                                                </a>
                                                                <a href="#updateRecord${c.id}" title="Change history"><i class="bi bi-clock-history"></i></a>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </c:otherwise>
                                        </c:choose>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="px-3 pt-3">
                            <div class="row justify-content-end">
                                <nav>
                                    <ul class="pagination">
                                        <c:if test="${page > 1}">
                                            <li class="page-item">
                                                <a class="page-link" href="?search=${search}&status=${status}&gender=${gender}&sort=${sort}&page=${page - 1}">Previous</a>
                                            </li>
                                        </c:if>
                                        <c:set var="ellipsis" value="false" />
                                        <c:forEach begin="1" end="${totalPage}" var="i">
                                            <c:choose>
                                                <c:when test="${i <= 2 or i >= totalPage - 1 or (i >= page - 1 and i <= page + 1)}">
                                                    <li class="page-item ${page == i ? 'active' : ''}">
                                                        <a class="page-link" href="?search=${search}&status=${status}&gender=${gender}&sort=${sort}&page=${i}">${i}</a>
                                                    </li>
                                                    <c:set var="showEllipsis" value="true" />
                                                </c:when>
                                                <c:otherwise>
                                                    <c:if test="${!ellipsis}">
                                                        <li class="page-item disabled">
                                                            <a class="page-link">...</a>
                                                        </li>
                                                        <c:set var="ellipsis" value="true" />
                                                    </c:if>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                        <c:if test="${page < totalPage}">
                                            <li class="page-item">
                                                <a class="page-link" href="?search=${search}&status=${status}&gender=${gender}&sort=${sort}&page=${page + 1}">Next</a>
                                            </li>
                                        </c:if>
                                    </ul>
                                </nav>
                            </div>
                        </div>
                        <c:forEach items="${customerList}" var="c">
                            <div id="editCustomer${c.id}" class="overlay" style="z-index: 999">
                                <div class="container rounded bg-white mt-md-2 mt-lg-5 mb-md-2 mb-lg-5 pb-4" style="max-width: 720px;max-height: 90vh;overflow-y: auto">
                                    <form>
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="p-3 pt-5 pb-3">
                                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                                        <h2 class="text-right"><strong>${c.name}'s Profile</strong></h2>
                                                        <a class="close" href="#!">&times;</a>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-12 border-left">
                                                            <div class="mb-2">
                                                                <h3><strong>Information</strong></h3>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-12 col-lg-6 border-left">
                                                            <div class="d-flex flex-column align-items-center text-center">
                                                                <img class="rounded-circle my-3" style="width: 150px;height: 150px; object-fit: cover" src="${c.pfp}" onerror="this.src='images/userpfp/default.png';this.onerror='';">
                                                                <h4 class="text-right"><strong>${c.name}</strong>'s Profile Picture</h4>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-12 col-lg-6 border-right">
                                                            <div class="row mt-2">
                                                                <div class="col-md-12">
                                                                    <label class="labels">Name</label>
                                                                    <input type="text" class="form-control" value="${c.name}" readonly>
                                                                </div>
                                                            </div>
                                                            <div class="row mt-3">
                                                                <div class="col-md-12">
                                                                    <label class="labels">Email</label>
                                                                    <input type="text" class="form-control" value="${c.email}" readonly>
                                                                </div>
                                                            </div>
                                                            <div class="row mt-3">
                                                                <div class="col-md-3">
                                                                    <label class="labels">Gender</label>
                                                                </div>
                                                                <div class="col-md-auto">
                                                                    <input type="text" class="form-control" value="${c.gender}" readonly>
                                                                </div>

                                                            </div>
                                                        </div>
                                                        <div class="col-12">
                                                            <div class="mt-2">
                                                                <h3><strong>Contact</strong></h3>
                                                            </div>
                                                            <div class="row pr-3">
                                                                <div class="col-12">
                                                                    <label class="labels">Addresses</label>
                                                                </div>
                                                                <div class="addresses w-100 ml-2 px-3 py-2" style="max-height: 200px;overflow-y: auto;border: solid lightgray 1px;border-radius: 10px;">
                                                                    <c:if test="${requestScope['addressList'.concat(c.getId())] eq null}">
                                                                        <div>Nothing</div>
                                                                    </c:if>
                                                                    <c:forEach items="${requestScope['addressList'.concat(c.getId())]}" var="a">
                                                                        <c:if test="${a.isDefault}">
                                                                            <div class="address" style="background-color: rgba(176, 180, 53, 0.1)">
                                                                                <div class="d-flex justify-content-between">
                                                                                    <div class="address-details">
                                                                                        <label for="address${a.id}">
                                                                                            ${a.detail}<br>
                                                                                            ${a.district}, ${a.city}.
                                                                                        </label>
                                                                                    </div>
                                                                                    <div class="d-flex align-items-center">
                                                                                        <span class="text-light" style="padding: 0 5px;background: #b0b435;border-radius: 5px">Default</span>
                                                                                    </div>
                                                                                </div>
                                                                                <hr style="margin: 0 0 5px">
                                                                            </div>
                                                                        </c:if>
                                                                    </c:forEach>
                                                                    <c:forEach items="${requestScope['addressList'.concat(c.getId())]}" var="a">
                                                                        <c:if test="${!a.isDefault}">
                                                                            <div class="address">
                                                                                <div class="address-details">
                                                                                    <label for="address${a.id}">
                                                                                        ${a.detail}<br>
                                                                                        ${a.district}, ${a.city}.
                                                                                    </label>
                                                                                </div>
                                                                                <hr style="margin: 0 0 5px">
                                                                            </div>
                                                                        </c:if>
                                                                    </c:forEach>
                                                                </div>
                                                            </div>
                                                            <div class="row mt-3 pr-3">
                                                                <div class="col-md-3">
                                                                    <label class="labels">Phone</label>
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <input type="text" class="form-control" value="${c.phone}" readonly>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="mt-3 text-center">
                                            <a class="btn text-light" href="#!" style="min-width: 100px;background-color: #b0b435">OK</a>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </c:forEach>
                        <c:forEach items="${customerList}" var="c">
                            <div id="updateRecord${c.id}" class="overlay" style="z-index: 999">
                                <div class="container rounded bg-white mt-md-2 mt-lg-5 mb-md-2 mb-lg-5 pb-4" style="max-width: 720px;max-height: 90vh;overflow-y: auto;">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="p-3 pt-5 pb-3">
                                                <div class="d-flex justify-content-center align-items-center mb-3">
                                                    <h2 class="text-center"><strong>${c.name}'s update records</strong></h2>
                                                    <a class="close" href="#!">&times;</a>
                                                </div>
                                                <div class="row">
                                                    <table class="table text-start align-middle table-bordered table-hover mb-0">
                                                        <thead style="font-size:20px;">
                                                            <tr>
                                                                <th>
                                                                    <div class="d-flex justify-content-center">ID</div>
                                                                </th>
                                                                <th class="${recordSort eq 'Date ASC' || sort eq 'Date DESC' ? 'table-active' : ''}">
                                                                    <div class="d-flex justify-content-between">
                                                                        Date
                                                                        <a class="d-flex align-items-center" 
                                                                           href="?recordSort=${recordSort eq 'Date ASC' ? 'Date DESC' : 'Date ASC'}&status=${status}&search=${search}&sort=${sort}&page=${page}#updateRecord${c.id}">
                                                                            <i class="bi ${recordSort eq 'Date ASC' ? 'bi-sort-down' : 'bi-sort-up'}"></i>
                                                                        </a>
                                                                    </div>
                                                                </th>
                                                                <th>
                                                                    <div class="d-flex justify-content-start">Description</div>
                                                                </th>
                                                                <th>
                                                                    <div class="d-flex justify-content-start">Updated By</div>
                                                                </th>
                                                            </tr>
                                                        </thead>
                                                        <tbody style="font-size:18px;">
                                                            <c:set var="keyFound" value="false"></c:set>
                                                            <c:forEach items="${recordMap}" var="entry">
                                                                <c:if test="${entry.key.id == c.id}">
                                                                    <c:set var="keyFound" value="true"></c:set>
                                                                    <c:choose>
                                                                        <c:when test="${empty entry.value}">
                                                                            <tr>
                                                                                <td colspan="5"><h2 class="text-center">No records yet!</h2></td>
                                                                            </tr>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <c:forEach items="${entry.value}" var="r">
                                                                                <tr>
                                                                                    <td>
                                                                                        <div class="d-flex justify-content-center">${r.id}</div>
                                                                                    </td>
                                                                                    <td style="max-width: 125px">
                                                                                        <div class="d-flex justify-content-center">
                                                                                            <fmt:formatDate value="${r.updatedDate}" pattern="dd-MM-yyyy hh:mm:ss"/>
                                                                                        </div>
                                                                                    </td>
                                                                                    <td style="font-size: 14px; word-wrap: break-word;white-space: normal;max-width: 200px;">${fn:replace(r.description, "\\n", "<br>")}</td>
                                                                                    <td>
                                                                                        <c:forEach items="${userList}" var="temp">
                                                                                            <c:if test="${temp.id == r.updatedBy}">
                                                                                                ${temp.name} - <b>${roleMap[temp.roleId]}</b>
                                                                                            </c:if>
                                                                                        </c:forEach>
                                                                                    </td>
                                                                                </tr>
                                                                            </c:forEach>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </c:if>
                                                            </c:forEach>
                                                            <c:if test="${!keyFound}">
                                                                <tr>
                                                                    <td colspan="5"><h2 class="text-center">No records yet!</h2></td>
                                                                </tr>
                                                            </c:if>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                        <div id="addNewCustomer" class="overlay" style="z-index: 999">
                            <div class="container rounded bg-white mt-md-2 mt-lg-5 mb-md-2 mb-lg-5 pb-4" style="max-height: 100vh;overflow-y: auto">
                                <form action="customerlist" method="post">
                                    <div class="row">
                                        <div class="col-12">
                                            <div class="p-3 pt-5 pb-3">
                                                <div class="d-flex justify-content-between align-items-center mb-3">
                                                    <h2 class="text-right"><strong>Add new Customer</strong></h2>
                                                    <a class="close" href="#!">&times;</a>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12 col-lg-6 border-left border-right">
                                                        <div class="mb-2">
                                                            <h3><strong>Information</strong></h3>
                                                        </div>
                                                        <div class="row mt-2">
                                                            <div class="col-md-12">
                                                                <label class="labels"><strong>Email</strong> <span class="text-danger">(*)</span></label>
                                                                <input type="email" class="form-control" name="email" id="newemail" placeholder="example@domain.com" value="${sessionScope.email}">
                                                                <% request.getSession().removeAttribute("email"); %>
                                                            </div>
                                                        </div>
                                                        <div class="row mt-3">
                                                            <div class="col-md-12">
                                                                <label class="labels"><strong>Password</strong> <span class="text-danger">(*)</span></label>
                                                                <input type="text" class="form-control" name="password" id="newpassword" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" placeholder="Enter Name" value="" required>
                                                                <span id="name-info" class="info-popup">Letters only, max 50 characters. Each word is separated by only 1 space.</span>
                                                            </div>
                                                        </div>
                                                        <div class="row mt-3">
                                                            <div class="col-md-12">
                                                                <label class="labels"><strong>Name</strong> <span class="text-danger">(*)</span></label>
                                                                <input type="text" class="form-control" name="name" id="newname" pattern="^[A-Za-zÀ-ỹà-ỹ]+( [A-Za-zÀ-ỹà-ỹ]+)*$" placeholder="Enter Name" value="${sessionScope.name}" required>
                                                                <span id="name-info" class="info-popup">Letters only, max 50 characters. Each word is separated by only 1 space.</span>
                                                                <% request.getSession().removeAttribute("name"); %>
                                                            </div>
                                                        </div>
                                                        <div class="row mt-3">
                                                            <div class="col-md-3">
                                                                <label class="labels"><strong>Gender</strong> <span class="text-danger">(*)</span></label>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <input class="form-check-inline" type="radio" name="gender" id="newmale" value="Male" required>
                                                                <label class="form-check-label" ${sessionScope.gender eq 'Male' ? 'checked' : ''}>Male</label>
                                                            </div>
                                                            <div class="col-md-auto">
                                                                <input class="form-check-inline" type="radio" name="gender" id="newfemale" value="Female" required>
                                                                <label class="form-check-label" ${sessionScope.gender eq 'Female' ? 'checked' : ''}>Female</label>
                                                            </div>
                                                            <% request.getSession().removeAttribute("gender"); %>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-12 col-lg-6 border-left border-right">
                                                        <div class="mb-2">
                                                            <h3><strong>Contact</strong></h3>
                                                        </div>
                                                        <div class="row mt-1">
                                                            <div class="col-md-6">
                                                                <label class="labels"><strong>City</strong> <span class="text-danger">(*)</span></label>
                                                                <select class="form-select p-2" name="city" id="newcity" style="max-width: 100%;min-width:100%;" required>
                                                                    <option ${sessionScope.city == null ? 'selected' : ''}value="">City</option>
                                                                </select>
                                                                <% request.getSession().removeAttribute("city"); %>
                                                            </div>
                                                            <div class="col-md-6">
                                                                <label class="labels"><strong>District</strong> <span class="text-danger">(*)</span></label>
                                                                <br>
                                                                <select class="form-select p-2" name="district" id="newdistrict" style="max-width: 100%;min-width:100%;" required>
                                                                    <option ${sessionScope.district == null ? 'selected' : ''} value="">District</option>
                                                                </select>
                                                                <% request.getSession().removeAttribute("district"); %>
                                                            </div>
                                                        </div>
                                                        <div class="row mt-3">
                                                            <div class="col-md-12">
                                                                <label class="labels"><strong>Detailed Address</strong> <span class="text-danger">(*)</span></label>
                                                                <input type="text" class="form-control" name="detailaddress" id="newdetailaddress" pattern="^.{1,255}$" placeholder="Enter address" value="${sessionScope.detail}" required>
                                                                <% request.getSession().removeAttribute("detail"); %>
                                                            </div>
                                                        </div>
                                                        <div class="row mt-3">
                                                            <div class="col-md-12">
                                                                <label class="labels"><strong>Phone</strong> <span class="text-danger">(*)</span></label>
                                                            </div>
                                                            <div class="col-md-6">
                                                                <input type="text" class="form-control" name="phone" id="newphone" pattern="^[0-9]{10}$" placeholder="Enter Phone" value="${sessionScope.phone}" required>
                                                                <span id="phone-info" class="info-popup">Numbers only, max 10 characters</span>
                                                            </div>
                                                            <% request.getSession().removeAttribute("phone"); %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <input type="text" class="form-control text-danger" id="pathName" name="page" value="" hidden>
                                    <div class="mt-3 text-center">
                                        <button class="btn text-light" id="save-button" type="submit" style="background-color: #b0b435">Add Customer</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Content End -->
            </div>
        </div>
        <jsp:include page="footer.jsp"></jsp:include>

            <!-- JavaScript Libraries -->
            <script src="js/jquery-3.2.1.min.js"></script>
            <script src="js/popper.min.js"></script>
            <script src="js/bootstrap.min.js"></script>

            <!-- ALL PLUGINS -->
            <script src="js/bootstrap-select.js"></script>
            <script src="js/inewsticker.js"></script>
            <script src="js/images-loded.min.js"></script>
            <script src="js/isotope.min.js"></script>
            <script src="js/owl.carousel.min.js"></script>
            <script src="js/baguetteBox.min.js"></script>
            <script src="js/form-validator.min.js"></script>
            <script src="js/custom.js"></script>
            <script>
                document.getElementById('status').addEventListener('change', function () {
                    var selectedValue = this.value;
                    window.location.href = '?status=' + selectedValue + '&gender=${gender}'
                            + '&search=${search}' + '&sort=${sort}';
                });
                document.getElementById('gender').addEventListener('change', function () {
                    var selectedValue = this.value;
                    window.location.href = '?status=${status}' + '&gender=' + selectedValue
                            + '&search=${search}' + '&sort=${sort}';
                });
        </script>
        <script>
            // Render cites & districts
            var newcities = document.getElementById("newcity");
            var newdistricts = document.getElementById("newdistrict");
            var newParameter = {
                url: "js/data.json",
                method: "GET",
                responseType: "application/json",
            };
            var newpromise = axios(newParameter);
            newpromise.then(function (result) {
                renderNewCity(result.data);
                renderNewDistrict(newcities.value, result.data);
            });
            function renderNewCity(data) {
                for (const city of data) {
                    const option = new Option(city.Name);
                    option.value = city.Name;
                    option.selected = city.Name === '${sessionScope.city}';
                    newcities.add(option);
                }
                newcities.onchange = function () {
                    renderNewDistrict(this.value, data);
                };
            }
            function renderNewDistrict(selectedCityName, data) {
                newdistricts.length = 1;
                if (selectedCityName !== "") {
                    const selectedCity = data.find(city => city.Name === selectedCityName);
                    for (const district of selectedCity.Districts) {
                        const option = new Option(district.Name);
                        option.value = district.Name;
                        option.selected = district.Name === '${sessionScope.district}';
                        newdistricts.add(option);
                    }
                }
            }
        </script>
    </body>
</html>
