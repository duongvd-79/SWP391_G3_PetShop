<%-- 
    Document   : BlogDetail
    Created on : Jun 17, 2024, 12:31:57 AM
    Author     : Acer
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link rel="shortcut icon" href="images/icon.ico" type="image/x-icon">
        <link rel="apple-touch-icon" href="images/apple-touch-icon.png">

        <!-- Bootstrap CSS -->
                <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
        <!-- Icon CSS -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <!-- Site CSS -->
        <link rel="stylesheet" href="css/style.css">
        <!-- Responsive CSS -->
        <link rel="stylesheet" href="css/responsive.css">
        <!-- Custom CSS -->
        <link rel="stylesheet" href="css/custom.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
    </head>
    <jsp:include page="header.jsp"></jsp:include>
    <body>
        <div class="container rounded bg-white mt-5 mb-5 shadow-sm">
            <div class="row">
                <div class="mb-3" style="padding-left:47px;">
                    <h3 class="text-right">Blog Settings</h4>
                </div>
            </div>
            <form class="row" action="editblog" method="post">
                <div class="row">
                    <div class="col-md-3 border-right">
                        <img style="border: 3px dashed blanchedalmond; margin-left: 14%;margin-top: 30%" width="250px" height="250px" src="${requestScope.u.getThumbnail()}">
                    </div>
                    <div class="col-md-8 border-right">
                        <div class="p-2 py-5">
                            <div class="row mt-3">
                                <div class="col-md-12 mb-2"><label class="labels">Title</label><input type="text" name="title" class="form-control" value="${requestScope.u.getTitle()}"></div>
                                <div class="col-md-12 mb-2"><label class="labels">Thumbnail</label><input type="text" name="thumbnail" class="form-control" value="${requestScope.u.getThumbnail()}"></div>
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
                                    <div class="mt-3 me-3 text-center d-flex align-items-center"><button class="btn btn-primary set-button" type="button submit">Save Blog</button></div>
                                </div>

                            </div>



                        </div>
                    </div>
                </div>
            </form>
        </div>
    </body>
        <jsp:include page="footer.jsp"></jsp:include>
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
