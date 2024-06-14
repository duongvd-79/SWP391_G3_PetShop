<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="model.User"%>
<!-- Start Main Top -->
<header class="main-header">
    <!-- Start Navigation -->
    <nav class="shadow navbar navbar-expand-lg navbar-light bg-light navbar-default bootsnav">

        <!-- Start Header Navigation -->
        <div class="navbar-header">
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar-menu" aria-controls="navbars-rs-food" aria-expanded="false" aria-label="Toggle navigation">
                <i class="bi bi-list"></i>
            </button>
            <a class="navbar-brand" href="home"><img height="100" src="images/logo.jpg" class="logo" alt=""></a>
            <span class="h5">H2DV PETSHOP</span>
        </div>
        <!-- End Header Navigation -->

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="navbar-menu">
            <ul class="nav navbar-nav ml-auto" data-in="fadeInDown" data-out="fadeOutUp">
                <li class="nav-item"><a class="nav-link" href="home">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="#about">About</a></li>
                <li class="dropdown">
                    <a href="productlist" class="nav-link dropdown-toggle" data-toggle="dropdown">Product <i class="bi bi-caret-down-fill"></i></a>
                    <ul class="dropdown-menu">
                        <li><a href="productlist">All Products</a></li>
                            <c:forEach items="${requestScope.prcategory}" var="prcate">
                                <li><a href="#">${prcate.name}</a></li>
                            </c:forEach>
                    </ul>
                </li>
                <li class="nav-item"><a class="nav-link" href="bloglist">Blog</a></li>
                    <%
                        User user = (User) session.getAttribute("user");
                        if (user == null) {
                    %>
                <li class="dropdown">
                    <a href="" class="nav-link dropdown-toggle" data-toggle="dropdown">Account <i class="bi bi-caret-down-fill"></i></a>
                    <ul class="dropdown-menu">
                        <li><a href="#login">Login</a></li>
                        <li><a href="#register">Register</a></li>
                    </ul>
                </li>
                <%} else {%>
                <li class="dropdown">
                    <a class="nav-link dropdown-toggle" data-toggle="dropdown">${user.name} <i class="bi bi-caret-down-fill"></i></a>
                    <ul class="dropdown-menu">
                        <li><a class="nav-link" href="#profile">User Profile</a></li>
                            <c:if test="${user.getRoleId()==1}">
                            <li><a class="nav-link" href="admindashboard">Admin</a></li>
                            </c:if>
                            <c:if test="${user.getRoleId()==5}">
                            <li><a class="nav-link" href="myorders">My Orders</a></li>
                            </c:if>
                        <li><a class="text-danger" href="login?logout=true">Logout</a></li>
                    </ul>
                </li>
                <%}%>
            </ul>
        </div>
        <!-- /.navbar-collapse -->

        <%
            if (user == null) {
        %>
        <!-- Login Popup -->
        <jsp:include page="login.jsp"></jsp:include>
        <!-- End Login Popup -->
        
        <!-- Begin Register Popup -->
        <jsp:include page="register.jsp"></jsp:include>
        <!-- End Register Popup -->

        <!-- Begin Verify email popup -->
        <div id="verify" class="overlay">
            <div class="popup">
                <h2 class="ms-3 mb-3">H2DV Petshop</h2>
                <a class="close" href="#">&times;</a>
                <div class="content container-fluid">
                    <h2>A verification link had been sended to ${sessionScope.newuser.getEmail()}</h2>
                    <h3>Check your email for verification!</h3>
                </div>
            </div>
        </div>
        <!-- End Verify email popup -->

        <!-- Begin Reset Password Popup -->
        <jsp:include page="resetPassword.jsp"></jsp:include>
        <!-- End Reset Password Popup -->
        <%}%>

        <%
            if (user != null && user.getRoleId() == 5) {
        %>
        <!-- Start Atribute Navigation -->
        <div class="attr-nav">
            <ul>
                <li class="side-menu">
                    <a href="cart">
                        <i class="bi bi-basket3"></i>
                        <span class="badge">${requestScope.cartDetailList.size()}</span>
                        <p>My Cart</p>
                    </a>
                </li>
            </ul>
        </div>
        <!-- End Atribute Navigation -->
        <%}%>

        <%
            if (user != null) {
        %>
        <!-- Begin User Profile -->
        <%--<jsp:include page="userProfile.jsp"></jsp:include>--%>
        <!-- End User Profile -->
        <%}%>
    </nav>
    <!-- End Navigation -->
</header>
<!-- End Main Top -->
<style>
    #togglePassword {
        position: absolute;
        top: 55%;
        right: 10px;
        cursor: pointer;
    }
    .dropdown:hover .dropdown-menu {
        display: block;
        margin-top: 0;
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
    .dropdown-menu li:hover {
        background-color: lightgray;
    }
</style>
<script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.21.1/axios.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<script>
    $(document).ready(function () {
        var toastMessage = '${sessionScope.successnoti}';
        var toastType = '${sessionScope.toastType}';
        if (toastMessage) {
            if (toastType === 'success') {
                toastr.success(toastMessage);
            } else if (toastType === 'error') {
                toastr.error(toastMessage);
            }
            <% 
                session.removeAttribute("successnoti");
                session.removeAttribute("toastType");
            %>
        }
    });
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
    const currentPage = window.location.pathname;
    const navLinks = document.querySelectorAll('.nav-link');

    navLinks.forEach(link => {
        if (link.getAttribute('href').includes(currentPage)) {
            link.parentElement.classList.add('active');
        }
    });
</script>
