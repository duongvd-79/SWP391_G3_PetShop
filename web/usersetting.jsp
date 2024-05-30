<%-- 
    Document   : usersetting
    Created on : May 21, 2024, 11:15:00 PM
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
        <title></title>
    </head>
    <body>
        <div class="container rounded bg-white mt-5 mb-5 shadow-sm">
            <div class="row">
                <nav class="mt-4 ps-5" style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                    <ol class=" h5 breadcrumb">
                        <li class="breadcrumb-item"><a class="root" href="#">Home</a></li>
                        <li class="breadcrumb-item"><a class="root" href="#">User List</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Profile Settings</li>
                    </ol>
                </nav>
                <div class="mb-3" style="padding-left:47px;">
                    <h3 class="text-right">Profile Settings</h4>
                </div>
            </div>
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
                    <div class="p-2 py-5">

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
                            <form class="row" action="edituser" method="get">
                                <input name="action" value="update" hidden>
                                <input name="id" value="${u.getId()}" hidden>
                                <div class="col-md-7"><label class="labels">Role</label>
                                    <select class="form-select" id="roles" name="roleid">
                                        <c:forEach items="${requestScope.sList}" var="s">
                                            <option value="${s.getId()}" ${(requestScope.u.getRoleId() == requestScope.s.getId()) ? 'selected' : ''}>${s.getName()}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-5"><label class="labels">Status</label>
                                    <select class="form-select" id="status" name="status">
                                        <option value="Active" ${"Active".equals(requestScope.u.getStatus()) ? 'selected' : ''}>Active</option>
                                        <option value="Inactive" ${"Inactive".equals(requestScope.u.getStatus()) ? 'selected' : ''}>Inactive</option>
                                    </select>
                                </div>


                                <div class="d-flex justify-content-center align-items-center mt-3">
                                    <div class="mt-3 me-3 text-center d-flex align-items-center"><button class="btn btn-primary set-button" type="button submit">Save Profile</button></div>
                                    <div class="mt-3 ms-3 d-flex justify-content-between align-items-center">
                                        <a  href="#popup1" class="btn btn-primary set-button d-flex align-items-center justify-content-center " type="button">Add New</a>
                                    </div>
                                </div>
                            </form>
                        </div>



                    </div>
                </div>
            </div>
            <div id="popup1" class="overlay">
                <div class="popup">
                    <h2 class="ms-3 mb-3">Add New User</h2>
                    <a class="close" href="#">&times;</a>
                    <div class="content container-fluid">

                        <form method="get" action="adduser" class="row">
                            <input type="hidden" name="action" value="add">
                            <div class="col-md-12 mb-2"><label class="labels">Email</label><input type="email" name="email" class="form-control" placeholder="Enter email" required=""></div>
                            <div class="col-md-12 mb-2"><label class="labels">Password</label><input type="text" name="password" class="form-control" placeholder="Enter Password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" title="Must contain at least one number, one uppercase and lowercase letter, and at least 8 or more characters" required></div>
                            <div class="col-md-7 mb-2"><label class="labels">Name</label><input type="text" name="name" class="form-control" placeholder="" value="" required></div>
                            <div class="col-md-5"><label class="labels">Role</label>
                                <select class="form-select" id="roles" name="roleid">
                                    <c:forEach items="${requestScope.sList}" var="s">
                                        <option value="${s.getId()}">${s.getName()}</option>
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

        .form-control:focus {
            box-shadow: none;
            border-color: #BBBF52
        }
        .form-select:focus{
            box-shadow: none;
            border-color: #BBBF52
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

        .back:hover {
            color: #BBBF52;
            cursor: pointer
        }

        .labels {
            font-size: 18px
        }
        .root{
            color: black;
            text-decoration: none
        }
        .custom-radio .form-check-input[disabled] {
            opacity: 1
        }
        .overlay {
            position: fixed;
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
        .add{
            width: 50px;
            border-radius: 99px;
        }
    </style>
</html>
