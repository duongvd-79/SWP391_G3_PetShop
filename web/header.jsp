<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="model.User"%>
<!-- Start Main Top -->
<header class="main-header">
    <!-- Start Navigation -->
    <nav class="shadow navbar navbar-expand-lg navbar-light bg-light navbar-default bootsnav">
        <div class="container">
            <!-- Start Header Navigation -->
            <div class="navbar-header">
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar-menu" aria-controls="navbars-rs-food" aria-expanded="false" aria-label="Toggle navigation">
                    <i class="bi bi-list"></i>
                </button>
                <a class="navbar-brand" href="home"><img src="images/logo.png" class="logo" alt=""></a>
            </div>
            <!-- End Header Navigation -->

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="navbar-menu">
                <ul class="nav navbar-nav ml-auto" data-in="fadeInDown" data-out="fadeOutUp">
                    <li class="nav-item active"><a class="nav-link" href="home">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="#about">About</a></li>
                    <li class="nav-item"><a class="nav-link" href="productlist">Product</a></li>
                    <li class="nav-item"><a class="nav-link" href="bloglist">Blog</a></li>
                        <%
                            User user = (User) session.getAttribute("user");
                            if (user == null) {
                        %>
                    <li class="dropdown">
                        <a href="" class="nav-link dropdown-toggle" data-toggle="dropdown">Account <i class="bi bi-caret-down-fill"></i></a>
                        <ul class="dropdown-menu">
                            <li><a href="#loginpopup">Login</a></li>
                            <li><a href="#registerpopup">Register</a></li>
                        </ul>
                    </li>
                    <%} else {%>
                    <li class="dropdown">
                        <a class="nav-link dropdown-toggle" data-toggle="dropdown">${user.name} <i class="bi bi-caret-down-fill"></i></a>
                        <ul class="dropdown-menu">
                            <li><a class="nav-link" href="#profilepopup">User Profile</a></li>
                            <li><a class="text-danger" href="login?logout=true">Logout</a></li>
                        </ul>
                    </li>
                    <%}%>
            </div>
            <!-- /.navbar-collapse -->

            <%
                if (user == null) {
            %>
            <!-- Login Popup -->
            <div id="loginpopup" class="overlay">
                <div class="popup">
                    <div class="form-block">
                        <div class="mb-4">
                            <h3>Sign In to <strong>PetShop</strong></h3>
                            <a class="close" href="#">&times;</a>
                        </div>
                        <form action="login" method="post">
                            <div class="form-group first">
                                <p class="text-danger">${sessionScope.error}</p>
                                <label for="email">Email</label>
                                <input type="email" class="form-control" id="email" name="email" value="${sessionScope.username}">
                            </div>
                            <div class="form-group last mb-1">
                                <label for="password">Password</label>
                                <input type="password" class="form-control" id="password" name="password">
                            </div>
                            <div class="d-flex mb-4 align-items-center">
<!--                                <label class="control control--checkbox mb-0">
                                    <span class="caption">Remember me</span>
                                    <input type="checkbox">
                                    <div class="control__indicator"></div>
                                </label>-->
                                <!--Reset password-->
                                <span class="ml-auto"><a href="#" class="forgot-pass">Forgot Password?</a></span>
                            </div>
                            <input type="submit" value="Log In" class="btn btn-pill text-white btn-block btn-primary">
                        </form>
                        <div class="social-login text-center mt-2">
                            <a href="#registerpopup">or <strong>Sign Up</strong></a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Register Popup -->
            <div id="registerpopup" class="overlay container-fluid">
                <div class="popup2">
                    <div class="form-block">
                        <div class="mb-1">
                            <h3><strong>Register</strong></h3>
                            <a class="close" href="#">&times;</a>
                        </div>
                        <form action="register" method="post">
                            <div class="form-group first mb-2">
                                <label for="email">Email</label>
                                <input type="email" class="form-control" id="email" name="email" required="" placeholder="Enter email" value="${newuser.getEmail()}">
                            </div>
                            <div class="form-group last mb-2">
                                <label for="password">Password</label>
                                <input type="password" class="form-control" id="password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" name="password" placeholder="Enter password" required="">
                            </div>
                            <div class="form-group last mb-2">
                                <label for="password">Confirm password</label>
                                <input type="password" class="form-control" id="cfpassword" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" name="cfpassword" placeholder="Confirm your password" required="">
                            </div>
                            <div class="form-group last mb-2">
                                <label for="fullname">Full Name</label>
                                <input type="text" class="form-control" id="fullname" name="name" required="" placeholder="Enter fullname" value="${newuser.getName()}">
                            </div>
                            <div class="form-group last mb-1">
                                <label for="phone">Phone</label>
                                <input type="text" class="form-control" pattern="^[0-9]{10}$" title="Phone must contain 10 number" id="phone" name="phone" placeholder="Phone number" required="" value="${newuser.getPhone()}">
                            </div>
                            <div class="row">
                                <div class="col-4 form-group mt-2 mb-1">
                                    <input type="radio" name="gender" id="male" checked>
                                    <label for="male">
                                        Male
                                    </label>
                                </div>
                                <div class="col-3 form-group mt-2 mb-0">
                                    <input type="radio" name="gender" id="female" >
                                    <label for="female">
                                        Female
                                    </label>
                                </div>
                            </div>
                            <div class="form-group last mb-3">
                                <label for="fullname">Address</label>
                                <div class="d-flex justify-content-start">
                                    <div class="mr-3">
                                        <select class="form-select form-select-sm mb-3 p-2" name="city" id="city" aria-label=".form-select-sm">
                                            <option selected>${empty address.getCity() ? 'City' : address.getCity()}</option>
                                        </select>
                                    </div>
                                    <div>
                                        <select class="form-select form-select-sm mb-3 p-2" name="district" id="district" aria-label=".form-select-sm" >
                                            <option  selected>${empty address.getDistrict() ? 'District' : address.getDistrict()}</option>
                                        </select>
                                    </div>
                                </div>
                                <input value="${address.getDetail()}" type="text" class="form-control" id="address" name="address" required="" placeholder="Your address">
                            </div>
                            <span class="text-danger">${sessionScope.alert}<span>
                                    <input type="submit" value="Sign Up" class="btn btn-pill text-white btn-block btn-primary">
                                    <div class="social-login text-center mt-2">
                                        <span>Already had an account? </span>
                                        <a href="#loginpopup"><strong>Sign In</strong></a>
                                    </div>

                                    </form>
                                    </div>
                                    </div>
                                    </div>
                            <%-- verify email popup --%>
                            <div id="verifypopup" class="overlay">
                        <div class="popup">
                            <h2 class="ms-3 mb-3">Announce</h2>
                            <a class="close" href="#">&times;</a>
                            <div class="content container-fluid">
                                <h3>Check your register email for verification!</h3>
                            </div>
                        </div>
                    </div>
                                    <%}%>

            <%
                if (user != null) {
            %>
            <!-- Start Atribute Navigation -->
            <div class="attr-nav">
                <ul>
                    <li class="side-menu">
                        <a href="#">
                            <i class="bi bi-basket3"></i>
                            <span class="badge">${requestScope.cart.size()}</span>
                            <p>My Cart</p>
                        </a>
                    </li>
                </ul>
            </div>
            <!-- End Atribute Navigation -->

            <!-- User Profile -->
            <div id="profilepopup" class="overlay container-fluid">
                <div class="container rounded bg-white mt-md-2 mt-lg-5 mb-md-2 mb-lg-5 pb-4">
                    <form action="userprofile" method="post" enctype="multipart/form-data">
                        <div class="row">
                            <div class="col-md-4 border-right">
                                <div class="d-flex flex-column align-items-center text-center p-3 py-5">
                                    <img class="rounded-circle mt-5" id="preview-img" width="150px" height="150px" src="${sessionScope.user.pfp}">
                                    <input id="file-upload" type="file" name="profilepfp" accept="image/*">
                                    <label for="file-upload" class="custom-file-upload mt-2">Upload Image</label>
                                    <span id="file-name"></span>
                                </div>
                            </div>
                            <div class="col-md-8 border-right">
                                <div class="p-3 pt-5 pb-3">
                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                        <h2 class="text-right"><strong>User Profile</strong></h2>
                                        <a class="close" href="#">&times;</a>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12 col-lg-6 border-left border-right">
                                            <div class="mb-2">
                                                <h3><strong>Information</strong></h3>
                                            </div>
                                            <div class="row mt-2">
                                                <div class="col-md-12">
                                                    <label class="labels">Name</label>
                                                    <input type="text" class="form-control" name="pfname" id="pfname" placeholder="Enter Name" value="${sessionScope.user.name}" required>
                                                </div>
                                            </div>
                                            <div class="row mt-3">
                                                <div class="col-md-12">
                                                    <label class="labels">Email</label>
                                                    <input type="text" class="form-control" value="${sessionScope.user.email}" disabled readonly>
                                                </div>
                                            </div>
                                            <div class="row mt-3">
                                                <div class="col-md-2">
                                                    <label class="labels">Gender</label>
                                                </div>
                                                <div class="col-md-3">
                                                    <input type="radio" name="pfgender" id="pfmale" value="Male" ${sessionScope.user.gender ? "checked" : ""}>
                                                    <label class="form-check-label">Male</label>
                                                </div>
                                                <div class="col-md-4">
                                                    <input type="radio" name="pfgender" id="pffemale" value="Female" ${!sessionScope.user.gender ? "checked" : ""}>
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
                                                    <select class="form-select form-select-sm mb-3 p-2" name="pfcity" id="pfcity" aria-label=".form-select-sm">
                                                        <option selected>${empty address.getCity() ? 'City' : address.getCity()}</option>
                                                    </select>
                                                </div>
                                                <div class="col-md-6">
                                                    <label class="labels">District</label>
                                                    <br>
                                                    <select class="form-select form-select-sm mb-3 p-2" name="pfdistrict" id="pfdistrict" aria-label=".form-select-sm" >
                                                        <option  selected>${empty address.getDistrict() ? 'District' : address.getDistrict()}</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="row mt-3">
                                                <div class="col-md-12">
                                                    <label class="labels">Detailed Address</label>
                                                    <input type="text" class="form-control" name="pfdetailaddress" placeholder="Enter address" value="" >
                                                </div>
                                            </div>
                                            <div class="row mt-3">
                                                <div class="col-md-3">
                                                    <label class="labels">Phone</label>
                                                </div>
                                                <div class="col-md-6">
                                                    <input type="text" class="form-control" name="pfphone" id="pfphone" pattern="^[0-9]{10}$" placeholder="Enter Phone" value="${sessionScope.user.phone}" required>
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
            <%}%>
        </div>
    </nav>

    <!-- End Navigation -->
</header>
<!-- End Main Top -->
<style>
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
    .popup,.popup2{
        margin: 150px auto;
        padding: 30px 40px;
        background: #fff;
        border-radius: 5px;
        width: 30%;
        min-width: 400px;
        position: relative;
        transition: all 5s ease-in-out;
    }
    .popup2{
        margin: 2vh auto;
    }
    .close {
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
    input[type="file"] {
        display: none;
    }

    .custom-file-upload {
        border: 1px solid #ccc;
        display: inline-block;
        padding: 6px 12px;
        cursor: pointer;
    }

</style>
<script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.21.1/axios.min.js"></script>

<script>
    var cities = document.getElementById("pfcity");
    var districts = document.getElementById("pfdistrict");

    var Parameter = {
        url: "js/data.json",
        method: "GET",
        responseType: "application/json",
    };

    var promise = axios(Parameter);
    promise.then(function (result) {
        renderCity(result.data);
    });

    function renderCity(data) {
        for (const city of data) {
            cities.options[cities.options.length] = new Option(city.Name);
        }

        cities.onchange = function () {
            districts.length = 1;

            if (this.value !== "") {
                const selectedCity = data.find(city => city.Name === this.value);

                for (const district of selectedCity.Districts) {
                    districts.options[districts.options.length] = new Option(district.Name);
                }
            }
        };
    }
</script>
<script>
    var cities2 = document.getElementById("city");
    var districts2 = document.getElementById("district");

    var Parameter2 = {
        url: "js/data.json",
        method: "GET",
        responseType: "application/json",
    };

    var promise2 = axios(Parameter2);
    promise2.then(function (result2) {
        renderCity2(result2.data);
    });

    function renderCity2(data) {
        for (const city of data) {
            cities2.options[cities2.options.length] = new Option(city.Name);
        }

        cities2.onchange = function () {
            districts2.length = 1;

            if (this.value !== "") {
                const selectedCity = data.find(city => city.Name === this.value);

                for (const district of selectedCity.Districts) {
                    districts2.options[districts2.options.length] = new Option(district.Name);
                }
            }
        };
    }
</script>
<script>
    var file = document.getElementById('file-upload');
    var previewImage = document.getElementById('preview-img');
    
    file.addEventListener('change', function() {
        var fileName = this.files[0].name;
        document.getElementById('file-name').textContent = fileName;
    });
    file.addEventListener('change', (e) => {
        var reader = new FileReader();

        reader.onload = (event) => {
        previewImage.src = event.target.result;
        };
        reader.readAsDataURL(e.target.files[0]);
    });
        document.addEventListener('DOMContentLoaded', function() {
            var name = document.getElementById('pfname');
            var phone = document.getElementById('pfphone');
            var saveButton = document.getElementById('save-button');
            var originalName = '${sessionScope.user.name}';
            var originalPhone = '${sessionScope.user.phone}';

            function toggleButton() {
                if (name.value !== originalName || phone.value !== originalPhone
                        || file.value !== "") {
                    saveButton.disabled = false;
                } else {
                    saveButton.disabled = true;
                }
            };
            
            name.addEventListener('input', toggleButton);
            phone.addEventListener('input', toggleButton);
            file.addEventListener('change', toggleButton);
        });
</script>
