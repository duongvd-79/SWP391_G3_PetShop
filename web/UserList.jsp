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
        <title>Setting List</title>
    </head>
    <body>
        <div class="container-fluid rounded bg-white mt-5 mb-5 shadow-sm">
            <div class="row">
                <nav class="mt-4 ps-5" style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                    <ol class=" h5 breadcrumb">
                        <li class="breadcrumb-item"><a class="root" href="#">Home</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Users List</li>
                    </ol>
                </nav>
                <div class="mb-3 ps-5" >
                    <h3 class="text-right">Users List</h3>
                </div>
                <div class="row d-flex align-items-center mb-3">
                    <div class="col-md-5 function">
                        <div class="input-group d-flex ">
                            <form style="width: 80%" class="d-flex" action="searchuser" method="get">
                                <input type="search" name="search" class="form-control" placeholder="Enter name, email, role,.. to search user" value="">
                                <span class="input-group-addon"><button class="btn search" type="submit"><img width="25" height="25" src="https://img.icons8.com/?size=100&id=7695&format=png&color=000000" alt=""></button></span>
                            </form>

                        </div>
                    </div>

                    <div class="col-md-1 function"></div
                    <form>
                        <div class="col-md-3 function">
                            <label>Sort User By: </label>
                            <select name="type" class="form-select" id="type" onchange="if (this.value)
                                        window.location.href = this.value">
                                <option value="userlist">All Users</option>
                                <option value="sortuser?order_by=id"}>User ID</option>
                                <option value="sortuser?order_by=name"}>FullName</option>
                                <option value="sortuser?order_by=gender"}>Gender</option>
                                <option value="sortuser?order_by=email"}>Email</option>
                                <option value="sortuser?order_by=phone"}>Mobile</option>
                                <option value="sortuser?order_by=role_id"}>Role ID</option>
                                <option value="sortuser?order_by=status"}>Status</option>
                            </select>

                        </div>
                        <!--                        <div class="col-md-2 function">
                                                    <select class="form-select function" id="status" onchange="if (this.value)
                                                                window.location.href = this.value">
                                                        <option value="">Unsorted Users</option>
                                                        <option value=""}>Pending</option>
                                                        <option value="admin?action=filter&status=Inactive&type=${requestScope.type}" ${'Inactive'.equals(requestScope.status) ? 'selected' : ''}>Inactive</option>
                                                    </select>
                        
                                                </div>-->

                    </form>


                </div>
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Fullname</th>

                                        <th>
                                            <select class="gender-dropdown" onchange="if (this.value)
                                                        window.location.href = this.value">
                                                <option value="userlist" selected>Gender:</option>
                                                <option value="filteruser?gender=male">Male</option>
                                                <option value="filteruser?gender=female">Female</option>
                                            </select>
                                        </th>
                                        <th>Email</th>
                                        <th>Mobile</th>
                                        <th> <select class="gender-dropdown" onchange="if (this.value)
                                                    window.location.href = this.value">
                                                <option value="userlist" selected>Role</option>
                                                <c:forEach items="${roleList}" var="r">
                                                    <option value="filteruser?role=${r.id}" >${r.name}</option>
                                                </c:forEach>
                                            </select></th>
                                        <th> <select class="gender-dropdown" onchange="if (this.value)
                                                    window.location.href = this.value">
                                                <option value="userlist" selected>Status</option>
                                                <c:forEach items="${statusList}" var="s">
                                                    <option value="filteruser?status=${s}" >${s}</option>
                                                </c:forEach>
                                            </select></th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${userList}" var="u">
                                        <tr>
                                            <td>${u.id}</td>
                                            <td>${u.name}</td>
                                            <td>${u.gender}</td>
                                            <td>${u.email}</td>
                                            <td>${u.phone}</td>
                                            <td>${u.roleId}</td>
                                            <td>${u.status}</td>
                                            <td><div class="d-flex justify-content-evenly align-items-center py-2">
                                                    <div class="me-4"><a href=""><img height="35" src="https://img.icons8.com/?size=100&id=114169&format=png&color=000000" height="50px"></a></div>
                                                    <div class="pe-2 btn py-1" style="line-height: 25px;"><a style="text-decoration: none;color: white;" href="#" >Active</a></div>

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
    </body>
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