<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="css/header/userProfile.css">
<div id="profile" class="overlay">
    <div class="container rounded bg-white mt-md-2 mt-lg-5 mb-md-2 mb-lg-5 pb-4" style="max-height: 100vh;overflow-y: auto">
        <form action="userprofile" method="post" enctype="multipart/form-data">
            <div class="row">
                <div class="col-md-4 border-right">
                    <div class="d-flex flex-column align-items-center text-center p-3 py-5">
                        <h2 class="text-right"><strong>Profile Picture</strong></h2>
                        <img class="rounded-circle my-3" id="preview-img" width="150px" height="150px" src="${sessionScope.user.pfp}" onerror="this.src='images/userpfp/default.png';this.onerror='';">
                        <input id="file-upload" type="file" name="profilepfp" accept="image/*">
                        <p id="file-size-warning" style="color: red; display: none;">File size exceeds 50MB</p>
                        <label for="file-upload" class="custom-file-upload mt-2">Upload Image</label>
                        <span id="file-name"></span>
                    </div>
                </div>
                <div class="col-md-8 border-right">
                    <div class="p-3 pt-5 pb-3">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h2 class="text-right"><strong>User Profile</strong></h2>
                            <a class="close" href="#!">&times;</a>
                        </div>
                        <div class="row">
                            <div class="col-md-12 col-lg-6 border-left border-right">
                                <div class="mb-2">
                                    <h3><strong>Information</strong></h3>
                                </div>
                                <div class="row mt-2">
                                    <div class="col-md-12">
                                        <label class="labels">Name</label>
                                        <input type="text" class="form-control" name="pfname" id="pfname" pattern="^[A-Za-zÀ-ỹà-ỹ]+( [A-Za-zÀ-ỹà-ỹ]+)*$" placeholder="Enter Name" value="${sessionScope.user.name}" required>
                                        <span id="name-info" class="info-popup">Letters only, max 50 characters. Each word is separated by only 1 space.</span>
                                    </div>
                                </div>
                                <div class="row mt-3">
                                    <div class="col-md-12">
                                        <label class="labels">Email</label>
                                        <input type="text" class="form-control" id="pfemail" value="${sessionScope.user.email}" disabled readonly>
                                        <span id="email-info" class="info-popup">You cannot change your email once registered</span>
                                    </div>
                                </div>
                                <div class="row mt-3">
                                    <div class="col-md-2">
                                        <label class="labels">Gender</label>
                                    </div>
                                    <div class="col-md-3">
                                        <input type="radio" name="pfgender" id="pfmale" value="Male" ${sessionScope.user.gender eq 'Male' ? "checked" : ""} required>
                                        <label class="form-check-label">Male</label>
                                    </div>
                                    <div class="col-md-4">
                                        <input type="radio" name="pfgender" id="pffemale" value="Female" ${sessionScope.user.gender eq 'Female' ? "checked" : ""} required>
                                        <label class="form-check-label">Female</label>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12 col-lg-6 border-left border-right">
                                <div class="mb-2">
                                    <h3><strong>Contact</strong></h3>
                                </div>
                                <div class="row mt-1">
                                    <div class="col-md-6">
                                        <label class="labels">City</label>
                                        <select class="form-select p-2" name="pfcity" id="pfcity" style="max-width: 100%;min-width:100%;" required>
                                            <option ${sessionScope.address.getCity() == null ? 'selected' : ''} value="">City</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="labels">District</label>
                                        <br>
                                        <select class="form-select p-2" name="pfdistrict" id="pfdistrict" style="max-width: 100%;min-width:100%;" required>
                                            <option ${sessionScope.address.getCity() == null ? 'selected' : ''} value="">District</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="row mt-3">
                                    <div class="col-md-12">
                                        <label class="labels">Detailed Address</label>
                                        <input type="text" class="form-control" name="pfdetailaddress" id="pfdetailaddress" placeholder="Enter address" value="${sessionScope.address.getDetail()}" required>
                                    </div>
                                </div>
                                <div class="row mt-3">
                                    <div class="col-md-3">
                                        <label class="labels">Phone</label>
                                    </div>
                                    <div class="col-md-6">
                                        <input type="text" class="form-control" name="pfphone" id="pfphone" pattern="^[0-9]{10}$" placeholder="Enter Phone" value="${sessionScope.user.phone}" required>
                                        <span id="phone-info" class="info-popup">Numbers only, max 10 characters</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="mt-3 text-center">
                <button class="btn btn-primary" id="save-button" type="submit" disabled>Save Profile</button>
            </div>
        </form>
    </div>
</div>
