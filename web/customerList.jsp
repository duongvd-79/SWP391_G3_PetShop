<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
            <c:forEach items="${customerList}" var="c">
                #cName${c.id}:focus + .info-popup, #cPhone${c.id}:focus + .info-popup {
                    display: block;
                }
                #cEmail${c.id}:hover + .info-popup {
                    display: block;
                }
            </c:forEach>
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>
            <div class="container-fluid">
                <div class="row">

                    <!-- Sidebar Start -->
                    <div class="container col-2 position-relative" >
                        <div class="w-100 mb-1 sticky-top" style="top: 126px; z-index: 1">
                            <a href="marketingdashboard" class="nav-link"><i class="bi bi-clipboard-data-fill"></i>DASHBOARD</a>
                            <a href="customerlist" class="nav-link active"><i class="bi bi-people-fill"></i>CUSTOMERS/CONTACTS</a>
                            <a href="feedbacklist" class="nav-link"><i class="bi bi-chat-left-text-fill"></i>FEEDBACKS</a>
                            <a href="#" class="nav-link"><i class="bi bi-archive-fill"></i>PRODUCTS</a>
                            <a href="sliderlist" class="nav-link"><i class="bi bi-image"></i>SLIDERS</a>
                        </div>
                    </div>
                    <!-- Sidebar End -->

                    <!-- Content Start -->
                    <div class="col-10 container-fluid rounded bg-white mt-4 mb-5 pb-1 px-4">
                        <div clas="row">
                            <div class="row d-flex align-items-center mb-3">
                                <div class="col-md-3">
                                    <form action="customerlist" method="get">
                                        <input type="text" name="search" class="w-100" placeholder="Search..." style="min-height: 37.6px"/>
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
                                        <c:if test="${page - 2 >= 0}">
                                            <li class="page-item">
                                                <a class="page-link" href="?search=${search}&status=${status}&gender=${gender}&sort=${sort}&page=${page - 1}">Previous</a>
                                            </li>
                                        </c:if>
                                        <c:forEach begin="1" end="${totalPage}" var="i">
                                            <li class="page-item ${page == i ? "active" : ""}">
                                                <a class="page-link" href="?search=${search}&status=${status}&gender=${gender}&sort=${sort}&page=${i}">${i}</a>
                                            </li>
                                        </c:forEach>
                                        <c:if test="${page + 1 <= totalPage}">
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
                                    <form action="customerlist" method="post">
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
                                                                <img class="rounded-circle my-3" width="150px" height="150px" src="${c.pfp}" onerror="this.src='images/userpfp/default.png';this.onerror='';">
                                                                <h4 class="text-right"><strong>${c.name}</strong>'s Profile Picture</h4>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-12 col-lg-6 border-right">
                                                            <div class="row mt-2">
                                                                <div class="col-md-12">
                                                                    <label class="labels">Name</label>
                                                                    <input type="text" class="form-control" name="name" id="cName${c.id}" pattern="^[A-Za-zÀ-ỹà-ỹ]+( [A-Za-zÀ-ỹà-ỹ]+)*$" placeholder="Enter Name" value="${c.name}" required>
                                                                    <span id="cNameInfo${c.id}" class="info-popup">Letters only, max 50 characters</span>
                                                                </div>
                                                            </div>
                                                            <div class="row mt-3">
                                                                <div class="col-md-12">
                                                                    <label class="labels">Email</label>
                                                                    <input type="text" class="form-control" id="cEmail${c.id}" value="${c.email}" disabled readonly>
                                                                    <span id="cEmailInfo${c.id}" class="info-popup">You cannot change this user's email once registered</span>
                                                                </div>
                                                            </div>
                                                            <div class="row mt-3">
                                                                <div class="col-md-2">
                                                                    <label class="labels">Gender</label>
                                                                </div>
                                                                <div class="col-md-3">
                                                                    <input type="radio" name="gender" id="cMale${c.id}" value="Male" ${c.gender eq 'Male' ? "checked" : ""}>
                                                                    <label class="form-check-label">Male</label>
                                                                </div>
                                                                <div class="col-md-4">
                                                                    <input type="radio" name="gender" id="cFemale${c.id}" value="Female" ${c.gender eq 'Female' ? "checked" : ""}>
                                                                    <label class="form-check-label">Female</label>
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
                                                                    <input type="text" class="form-control" name="phone" id="cPhone${c.id}" pattern="^[0-9]{10}$" placeholder="Enter Phone" value="${c.phone}" required>
                                                                    <span id="cPhoneInfo${c.id}" class="info-popup">Numbers only, max 10 characters</span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="mt-3 text-center">
                                            <button class="btn btn-primary" id="save-button${c.id}" type="submit" disabled>Update ${c.name}'s Profile</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </c:forEach>
                        <c:forEach items="${customerList}" var="c">
                            <div id="updateRecord${c.id}" class="overlay" style="z-index: 999">
                                <div class="container rounded bg-white mt-md-2 mt-lg-5 mb-md-2 mb-lg-5 pb-4" style="max-width: 720px;max-height: 90vh;overflow-y: auto">
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
                                                                <th class="${sort eq 'Name ASC' || sort eq 'Name DESC' ? 'table-active' : ''}">
                                                                    <div class="d-flex justify-content-between">
                                                                        Date
                                                                        <a class="d-flex align-items-center" 
                                                                           href="?status=${status}&search=${search}&sort=${sort eq 'Name ASC' ? 'Name DESC' : 'Name ASC'}&page=${page}">
                                                                            <i class="bi ${sort eq 'Name ASC' ? 'bi-sort-down' : 'bi-sort-up'}"></i>
                                                                        </a>
                                                                    </div>
                                                                </th>
                                                                <th class="${sort eq 'Email ASC' || sort eq 'Email DESC' ? 'table-active' : ''}">
                                                                    <div class="d-flex justify-content-between">
                                                                        Description
                                                                        <a class="d-flex align-items-center" 
                                                                           href="?status=${status}&search=${search}&sort=${sort eq 'Email ASC' ? 'Email DESC' : 'Email ASC'}&page=${page}">
                                                                            <i class="bi ${sort eq 'Email ASC' ? 'bi-sort-down' : 'bi-sort-up'}"></i>
                                                                        </a>
                                                                    </div>
                                                                </th>
                                                                <th class="${sort eq 'Gender ASC' || sort eq 'Gender DESC' ? 'table-active' : ''}">
                                                                    <div class="d-flex justify-content-between">
                                                                        Updated By
                                                                        <a class="d-flex align-items-center" 
                                                                           href="?status=${status}&search=${search}&sort=${sort eq 'Gender ASC' ? 'Gender DESC' : 'Gender ASC'}&page=${page}">
                                                                            <i class="bi ${sort eq 'Gender ASC' ? 'bi-sort-down' : 'bi-sort-up'}"></i>
                                                                        </a>
                                                                    </div>
                                                                </th>
                                                                <th class="${sort eq 'Phone ASC' || sort eq 'Phone DESC' ? 'table-active' : ''}">
                                                                    <div class="d-flex justify-content-between">
                                                                        Affected User
                                                                        <a class="d-flex align-items-center" 
                                                                           href="?status=${status}&search=${search}&sort=${sort eq 'Phone ASC' ? 'Phone DESC' : 'Phone ASC'}&page=${page}">
                                                                            <i class="bi ${sort eq 'Phone ASC' ? 'bi-sort-down' : 'bi-sort-up'}"></i>
                                                                        </a>
                                                                    </div>
                                                                </th>
                                                            </tr>
                                                        </thead>
                                                        <tbody style="font-size:18px;">
                                                            <c:forEach items="${recordMap}" var="entry">
                                                                <c:if test="${entry.key.id == c.id}">
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
                                                                                    <td>
                                                                                        <div class="d-flex justify-content-center">${r.updatedDate}</div>
                                                                                    </td>
                                                                                    <td style="font-size: 14px">${fn:replace(r.description, "\\n", "<br>")}</td>
                                                                                    <td>
                                                                                        <c:forEach items="${customerList}" var="temp">
                                                                                            <c:if test="${temp.id == r.updatedBy}">
                                                                                                ${temp.name}
                                                                                            </c:if>
                                                                                        </c:forEach>
                                                                                    </td>
                                                                                    <td>
                                                                                        <c:forEach items="${customerList}" var="temp">
                                                                                            <c:if test="${temp.id == r.userId}">
                                                                                                ${temp.name}
                                                                                            </c:if>
                                                                                        </c:forEach>
                                                                                    </td>
                                                                                </tr>
                                                                            </c:forEach>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </c:if>
                                                            </c:forEach>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
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
            // Toggle save button on changes
            <c:forEach items="${customerList}" var="c">
            document.addEventListener('DOMContentLoaded', function () {
                var name = document.getElementById('cName${c.id}');
                var phone = document.getElementById('cPhone${c.id}');
                var male = document.getElementById('cMale${c.id}')
                var female = document.getElementById('cFemale${c.id}')
                var saveButton = document.getElementById('save-button${c.id}');
                const originalName = name.value;
                const originalPhone = phone.value;
                const originalGender = '${c.gender}';

                function toggleButton() {
                    if (name.value !== originalName || phone.value !== originalPhone
                            || (originalGender === 'Male' && female.checked)
                            || (originalGender === 'Female' && male.checked)) {
                        saveButton.disabled = false;
                    } else {
                        saveButton.disabled = true;
                    }
                }
                ;
                name.addEventListener('input', toggleButton);
                phone.addEventListener('input', toggleButton);
                male.addEventListener('change', toggleButton);
                female.addEventListener('change', toggleButton);
            });
            </c:forEach>
        </script>
    </body>
</html>
