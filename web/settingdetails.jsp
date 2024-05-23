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
                        <li class="breadcrumb-item"><a class="root" href="settinglist.jsp">System Setting</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Settings Detail</li>
                    </ol>
                </nav>
                <div class="mb-3 ps-5 d-flex justify-content-between">
                    <h3 class="text-right">Setting Detail</h4>
                    <button class="btn btn-primary set-button me-3" type="button">Add New</button>
                </div>
            </div>
            <div>
                
                <div">
                    <div class="p-2 pb-5 pt-1">
                        
                        <form class="row mt-3" method="get" action="setting?action=add&">
                            <input type="hidden" name="id" value="${detail.getId()}">
                            <div class="col-md-7"><label class="labels">Group</label>
                                <select class="form-select" id="roles" name="type" value="${detail.getType()}">
                                    <c:forEach items="${requestScope.types}" var="t">
                                        <option value="${t}" ${t.equals(requestScope.detail.getType()) ? 'selected' : ''}>${t}</option>
                                    </c:forEach>                             
                                </select>
                            </div>
                            <div class="col-md-5"><label class="labels">Order</label><input type="text" name="order" class="form-control" value="${detail.getOrder()}"></div>
                            <div class="col-md-12 mt-2"><label class="labels">Name</label><input type="text" name="name" class="form-control" value="${detail.getName()}"></div>
                            <div class="col-md-4 mt-2"><label class="labels">Value</label><input type="text" name="value" class="form-control" value="${detail.getValue()}"></div>
                            <div class="col-md-1 mt-2"></div>
                            <div class="col-md-6 mt-2">
                                <label class="labels">Status</label><br>
                                <div class="mt-2">
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


    </style>
</html>
