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
                        <img class="rounded-circle mt-5" width="170px" height="170px" src="https://images.unsplash.com/photo-1715833027976-7183e02993da?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D">
                        <span class="font-weight-bold mt-3">Vũ Tuấn Hoàng</span>
                        <span class="text-black-10 mt-2">hoangdz512@mail.com</span>
                    </div>
                </div>
                <div class="col-md-8 border-right">
                    <div class="p-2 py-5">

                        <div class="row mt-3">
                            <div class="col-md-12"><label class="labels">Name</label><input type="text" class="form-control" placeholder="Full Name" value=""></div>
                            <div class="col-md-12"><label class="labels">Phone Number</label><input type="text" class="form-control" placeholder="" value=""></div>
                            <div class="col-md-12"><label class="labels">Address</label><input type="text" class="form-control" placeholder="" value=""></div>
                            <div class="col-md-12">
                                <label class="labels">Gender</label><br>
                                <div class="mt-2">
                                    <div class="form-check custom-radio form-check-inline">
                                        <input class="form-check-input" type="radio" name="flexRadioDefault" id="male" disabled>
                                        <label class="form-check-label" for="male">
                                            Male
                                        </label>
                                    </div>
                                    <div class="form-check custom-radio form-check-inline">
                                        <input class="form-check-input" type="radio" name="flexRadioDefault" id="female" checked disabled>
                                        <label class="form-check-label" for="female">
                                            Female
                                        </label>
                                    </div>

                                </div>
                            </div>
                            <div class="col-md-7"><label class="labels">Role</label>
                                <select class="form-select" id="roles">
                                    <option value="volvo">Role 1</option>
                                    <option value="saab">Role 2</option>
                                    <option value="opel">Role 3</option>
                                    <option value="audi">Role 4</option>
                                    <option value="audi">Role 5</option>
                                </select>
                            </div>
                            <div class="col-md-5"><label class="labels">Status</label>
                                <select class="form-select" id="status">
                                    <option value="volvo">Pending</option>
                                    <option value="saab">Active</option>
                                    <option value="opel">Blocked</option>
                                </select>
                            </div>
                        </div>
                        <div class="d-flex justify-content-center">
                            <div class="me-5 mt-5 text-center d-inline-block"><button class="btn btn-primary profile-button" type="button">Save Profile</button></div>
                            <div class="mt-5 text-center d-inline-block"><button class="btn btn-primary profile-button" type="button">Add New User</button></div>
                        </div>
                    </div>
                </div>
                <!--                <div class="col-md-4">
                                    <div class="p-3 py-5">
                                        <div class="d-flex justify-content-between align-items-center experience"><span>Edit Experience</span><span class="border px-3 p-1 add-experience"><i class="fa fa-plus"></i>&nbsp;Experience</span></div><br>
                                        <div class="col-md-12"><label class="labels">Experience in Designing</label><input type="text" class="form-control" placeholder="experience" value=""></div> <br>
                                        <div class="col-md-12"><label class="labels">Additional Details</label><input type="text" class="form-control" placeholder="additional details" value=""></div>
                                    </div>
                                </div>-->
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

        .profile-button {
            background: #BBBF52;
            box-shadow: none;
            border: none;
            font-size: 18px;
            width: 150px;
            height:50px;
            text-align: center;

        }

        .profile-button:hover {
            background: #B0B435
        }
        .profile-button:focus {
            background: #BBBF52;
            box-shadow: none
        }

        .profile-button:active {
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


    </style>
</html>
