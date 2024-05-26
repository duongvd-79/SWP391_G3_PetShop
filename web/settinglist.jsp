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
                        <li class="breadcrumb-item active" aria-current="page">System Settings</li>
                    </ol>
                </nav>
                <div class="mb-3 ps-5" >
                    <h3 class="text-right">System Settings</h3>
                </div>
                <div class="row d-flex align-items-center mb-3">
                    <div class="col-md-6 function mb-3">
                        <div class="input-group d-flex ">
                            <form style="width: 82.4%" class="d-flex" action="setting" method="get">
                                <input type="search" name="search" class="form-control" placeholder="Type setting name to search" value="${requestScope.sName}">
                                <span class="input-group-addon"><button class="btn search" type="submit"><img width="25" height="25" src="https://img.icons8.com/?size=100&id=7695&format=png&color=000000" alt=""></button></span>
                            </form>

                        </div>
                    </div>
                    <div class="col-md-6 function"></div>
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
                    
                </div>
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th class="d-flex justify-content-between align-items-center">Setting type <a class="d-flex align-items-center" href="setting?page=1&sort=type&search=${requestScope.sName}&action=filter&status=${requestScope.status}&type=${requestScope.type}"><img height="20" src="https://img.icons8.com/?size=100&id=f1fhADRkTrAU&format=png&color=FFFFFF" alt="alt"/></a></th>
                                        <th>Name</th>
                                        <th class="d-flex justify-content-between align-items-center">Order <a class="d-flex align-items-center" href="setting?page=1&sort=order&search=${requestScope.sName}&action=filter&status=${requestScope.status}&type=${requestScope.type}"><img height="20" src="https://img.icons8.com/?size=100&id=f1fhADRkTrAU&format=png&color=FFFFFF" alt="alt"/></a></th>
                                        <th class="stt">Status <a class="d-inline-flex align-items-center" href="setting?page=1&sort=status&search=${requestScope.sName}&action=filter&status=${requestScope.status}&type=${requestScope.type}"><img class="sort-icon" height="20" src="https://img.icons8.com/?size=100&id=f1fhADRkTrAU&format=png&color=FFFFFF" alt="alt"/></a></th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${requestScope.settingList}" var="s">
                                        <tr>
                                            <td>${s.getId()}</td>
                                            <td>${s.getType()}</td>
                                            <td>${s.getName()}</td>
                                            <td>${s.getOrder()}</td>
                                            <td>${s.getStatus()}</td>
                                            <td><div class="d-flex justify-content-evenly align-items-center py-2">
                                                    <div class="me-4"><a href="setting?action=edit&id=${s.getId()}"><img height="35" src="https://img.icons8.com/?size=100&id=114169&format=png&color=000000" height="50px"></a></div>
                                                    <div class="btn py-1" style="line-height: 25px;width:100px;"><a value="" style="text-decoration: none;color: white;" href="setting?id=${s.getId()}&status=${s.getStatus().equals('Active') ? 'Inactive' : 'Active'}" >${s.getStatus().equals('Active') ? 'Inactive' : 'Active'}</a></div>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>

                                </tbody>
                            </table>
                        </div>
                    </div>

                    <nav aria-label="setting list paging ">
                        <ul class="pagination d-flex justify-content-end">
                            <li class="page-item"><a class="page-link ${requestScope.page == 1 ? 'd-none' : ''}" href="setting?page=${requestScope.page-1}&search=${requestScope.sName}&sort=${requestScope.sort}&action=filter&status=${requestScope.status}&type=${requestScope.type}">Previous</a></li>

                            <c:forEach begin="1" end="${requestScope.pageNum}" var="i">
                                <li class="page-item"><a class="page-link" href="setting?page=${i}&search=${requestScope.sName}&sort=${requestScope.sort}&action=filter&status=${requestScope.status}&type=${requestScope.type}">${i}</a></li>
                                </c:forEach>
                            <li class="page-item"><a class="page-link ${requestScope.page == requestScope.pageNum ? 'd-none' : ''}" href="setting?page=${requestScope.page+1}&search=${requestScope.sName}&sort=${requestScope.sort}&action=filter&status=${requestScope.status}&type=${requestScope.type}">Next</a></li>
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
        .stt{
            position: relative;
        }
        .sort-icon{
            position:absolute;
            right:5%;
            top:26%;
        }

    </style>
</html>
