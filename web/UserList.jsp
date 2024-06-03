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
                        <li class="breadcrumb-item"><a class="root" href="home">Home</a></li>
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
                        <a  href="#popup1" class="btn btn-primary set-button d-flex align-items-center justify-content-center " type="button">Add New</a>
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
                    <div class="content container-fluid">

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
                                <div class="mt-4"><button class="btn btn-primary set-button" type="button submit">Add</button></div>
                            </div>

                        </form>
                    </div>
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
        .overlay {
            position: absolute;
            z-index: 999;
            top: 0;
            bottom: 0;
            left: 0;
            right: 0;
            background: rgba(0, 0, 0, 0.7);
            transition: opacity 500ms;
            visibility: hidden;
            opacity: 0;
        }
        .overlay:target {
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
        .btn {
            padding: 0 10px;
            background: #BBBF52;
            color: #fff;
        }
        .set-button {
            background: #BBBF52;
            box-shadow: none;
            border: none;
            font-size: 18px;
            width: 150px;
            height:50px;
            text-align: center;

        }

        .set-button:hover {
            background: #B0B435
        }
        .set-button:focus {
            background: #BBBF52;
            box-shadow: none
        }

        .set-button:active {
            background: #BBBF52;
            box-shadow: none
        }

    </style>
</html>