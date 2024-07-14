<%-- 
    Document   : BlogDetail
    Created on : Jun 17, 2024, 12:31:57 AM
    Author     : Acer
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Favicon -->
        <link href="img/favicon.ico" rel="icon">

        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">

        <!-- Icon Font Stylesheet -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

        <!-- Customized Bootstrap Stylesheet -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <!-- Template Stylesheet -->
        <link href="css/style.css" rel="stylesheet">
        <link rel="stylesheet" href="css/responsive.css">
        <link rel="stylesheet" href="css/admin.css">
        <!-- Toastr -->
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css">


    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>
            <div class="container rounded bg-white mt-5 mb-5 shadow-sm">
                <div class="row">
                    <nav class="mt-4 ps-5" style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                        <ol class=" h5 breadcrumb">
                            <li class="breadcrumb-item"><a class="root" href="#">Home</a></li>
                            <li class="breadcrumb-item"><a class="root" href="BlogManager">Blog List</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Blog Settings</li>
                        </ol>
                    </nav>
                    <div class="mb-3" style="padding-left:47px;">
                        <h3 class="text-right">Blog Settings</h4>
                    </div>
                </div>
                <form class="row" action="editblog" method="post" enctype="multipart/form-data">
                    <div class="row">
                        <div class="col-md-3 border-right">
                            <c:choose>
                                                        <c:when test="${fn:startsWith(u.thumbnail, 'https')}">
                                                            <img style="border: 3px dashed blanchedalmond; margin-left: 2%;margin-top: 30%" width="250px" height="250px" src="${requestScope.u.getThumbnail()}">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <img style="border: 3px dashed blanchedalmond; margin-left: 2%;margin-top: 30%" width="250px" height="250px" src="./images/${requestScope.u.getThumbnail()}">
                                                        </c:otherwise>
                                                    </c:choose>
                    </div>
                    <div class="col-md-8 border-right">
                        <div class="p-2 py-5">
                            <div class="row mt-3">
                                <div class="col-md-12 mb-2"><label class="labels">Title</label><input type="text" name="title" class="form-control" value="${requestScope.u.getTitle()}"></div>
                                <div class="col-md-12 mb-2"><label class="labels">Thumbnail</label><input type="file" name="file" class="form-control"></div>
                                <div class="col-md-12 mb-2"><label class="labels">Detail</label><textarea name="detail" class="form-control">${requestScope.u.getDetail()}</textarea></div>
                                <div class="col-md-12 mb-2">
                                    <label class="labels">Status</label><br>
                                    <div class="mt-2">
                                        <div class="form-check custom-radio form-check-inline">
                                            <input class="form-check-input" type="radio" name="status" value="1" ${"1".equals(requestScope.u.getStatus()) ? 'checked' : ''}>
                                            <label class="form-check-label" for="male">
                                                Show
                                            </label>
                                        </div>
                                        <div class="form-check custom-radio form-check-inline">
                                            <input class="form-check-input" type="radio" name="status" value="0" ${"0".equals(requestScope.u.getStatus()) ? 'checked' : ''}>
                                            <label class="form-check-label" for="female">
                                                Hide
                                            </label>
                                        </div>

                                    </div>

                                </div>

                                <input name="action" value="update" hidden>
                                <input name="id" value="${u.getId()}" hidden>
                                <div class="col-md-7"><label class="labels">Role</label>
                                    <select class="form-select" id="roles" name="category">
                                        <c:forEach items="${requestScope.sList}" var="s">
                                            <option value="${s.getId()}" ${(requestScope.u.getSetting().getName().equals(requestScope.s.getName())) ? 'selected' : ''}>${s.getName()}</option>
                                        </c:forEach>
                                    </select>
                                </div>



                                <div class="d-flex justify-content-center align-items-center mt-3">
                                    <div class="mt-3 me-3 text-center d-flex align-items-center"><button class="btn btn-primary set-button" type="submit">Save Blog</button></div>
                                </div>

                            </div>



                        </div>
                    </div>
                </div>
            </form>
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
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <!--<script src="lib/chart/chart.min.js"></script>-->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="lib/easing/easing.min.js"></script>
    <script src="lib/owlcarousel/owl.carousel.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>
    <!-- Template Javascript -->
    <script src="js/admin.js"></script>

    <script src="js/jquery-3.2.1.min.js"></script>
    <script src="js/popper.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <!-- ALL PLUGINS -->
    <script src="js/jquery.superslides.min.js"></script>
    <script src="js/bootstrap-select.js"></script>
    <script src="js/inewsticker.js"></script>
    <script src="js/bootsnav.js."></script>
    <script src="js/images-loded.min.js"></script>
    <script src="js/isotope.min.js"></script>
    <script src="js/owl.carousel.min.js"></script>
    <script src="js/baguetteBox.min.js"></script>
    <script src="js/form-validator.min.js"></script>
    <script src="js/contact-form-script.js"></script>
    <script src="js/custom.js"></script>
</html>
