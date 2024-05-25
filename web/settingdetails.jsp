<%-- 
    Document   : settingdetails
    Created on : May 22, 2024, 2:26:33 PM
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
        <c:set value="${requestScope.detail}" var="detail"/>
        <div class="container rounded bg-white mt-5 mb-5 shadow-sm">
            <div class="row">
                <nav class="mt-4 ps-5" style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                    <ol class=" h5 breadcrumb">
                        <li class="breadcrumb-item"><a class="root" href="#">Home</a></li>
                        <li class="breadcrumb-item"><a class="root" href="setting">System Setting</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Settings Detail</li>
                    </ol>
                </nav>
                <div class="mb-3 ps-5 d-flex justify-content-between">
                    <h3 style="line-height:40px" class="text-right">Setting Detail</h4>
                        <a  href="#popup1" class="btn btn-primary set-button me-3 d-flex align-items-center justify-content-center" type="button">Add New</a>
                </div>
            </div>
            <div>

                <div">
                    <div class="p-2 pb-5 pt-1">

                        <form class="row mt-3" method="get" action="setting">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="id" value="${detail.getId()}">
                            <input type="hidden" name="type" value="${detail.getType()}">
                            <div class="col-md-7"><label class="labels">Group</label>
                                <select class="form-select" id="roles" name="" value="${detail.getType()}" disabled >
                                    <c:forEach items="${requestScope.types}" var="t">
                                        <option value="${t}" ${t.equals(requestScope.detail.getType()) ? 'selected' : ''}>${t}</option>
                                    </c:forEach>                             
                                </select>

                            </div>
                            <div class="col-md-5"><label class="labels">Order</label><input type="text" name="order" class="form-control" value="${detail.getOrder()}"></div>
                            <div class="col-md-12 mt-2"><label class="labels">Name</label><input type="text" name="name" class="form-control" value="${detail.getName()}"></div>
                            <div class="col-md-6 mt-2">
                                <label class="labels">Status</label><br>
                                <div class="my-2">
                                    <div class="form-check custom-radio form-check-inline">

                                        <input class="form-check-input" type="radio" name="status" value="Active" id="active"${"Active".equals(requestScope.detail.getStatus()) ? 'checked' : ''} >
                                        <label class="form-check-label" for="active">
                                            Active
                                        </label>
                                    </div>
                                    <div class="form-check custom-radio form-check-inline">

                                        <input class="form-check-input" type="radio" name="status" value="Inactive" id="inactive"${"Active".equals(requestScope.detail.getStatus()) ? '':'checked'}>
                                        <label class="form-check-label" for="inactive">
                                            Inactive
                                        </label>
                                    </div>

                                </div>
                            </div>
                            <div class="col-md-12"><label class="labels">Description</label>
                                <textarea class="form-control" id="note" name="note" rows="3" value="${detail.getDescription()}">${detail.getDescription()}</textarea>
                            </div>


                            <div class="d-flex justify-content-center">
                                <div class="mt-4"><button class="btn btn-primary set-button" type="button submit">Save Changes</button></div>
                            </div>
                        </form>
                    </div>
                    <div id="popup1" class="overlay">
                        <div class="popup">
                            <h2 class="ms-3 mb-3">Add New Setting</h2>
                            <a class="close" href="#">&times;</a>
                            <div class="content container-fluid">

                                <form method="get" action="setting" class="row">
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
                                        <textarea class="form-control" id="note" name="note" rows="3" value="${detail.getDescription()}">${detail.getDescription()}</textarea>
                                    </div>
                                    <div class="d-flex justify-content-center">
                                        <div class="mt-4"><button class="btn btn-primary set-button" type="button submit">Add</button></div>
                                    </div>
                                </form>
                            </div>
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
            box-shadow: none;
        }



        .labels {
            font-size: 18px
        }
        .root{
            color: black;
            text-decoration: none
        }
        .add{
            width: 50px;
            border-radius: 99px;
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

    </style>
</html>
