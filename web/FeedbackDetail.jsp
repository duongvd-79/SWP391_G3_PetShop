<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>PetShop - Feedback Details</title>

        <link rel="shortcut icon" href="images/icon.ico" type="image/x-icon">
        <link rel="apple-touch-icon" href="images/apple-touch-icon.png">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
        <!-- Icon CSS -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <!-- Site CSS -->
        <link rel="stylesheet" href="css/style.css">
        <!-- Responsive CSS -->
        <link rel="stylesheet" href="css/responsive.css">

        <style>
            a:hover{
                color:white;
            }
            .status{
                width:15%;
                font-size: 16px;
                font-weight: 700;
            }
            .active {
                border-radius: 5px;
                border-bottom-width:3px !important;
            }
            .page-link.active{
                color: white;
                background-color: rgb(176, 180, 53) !important;
            }
            .page-item.active .page-link {
                background-color: #b0b435;
                border-color: #b0b435;
            }
            .page-link {
                color: #212121;
            }
            .page-link:hover{
                color: #212121;
            }
            #clearSearchInput {
                display: none;
            }
            #toast-container > .toast {
                opacity: 1 !important;
            }
            .card-header {
                background-color: #f8f9fa;
                font-size: 18px;
                font-weight: bold;
            }
            .card-body {
                font-size: 16px;
            }
            .star-rating .bi-star-fill {
                color: #ffc107;
                cursor: pointer;
            }
            .star-rating .bi-star {
                color: #e4e5e9;
                cursor: pointer;
            }
            .img-circle {
                border-radius: 50%;
            }
        </style>

    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>
        <div class="container-fluid">
            <div class="row">
                <!-- Sidebar Start -->
                <div class="container col-2 position-relative">
                    <div class="w-100 mb-1 sticky-top" style="top: 126px; z-index: 1; font-size: 18px">
                        <a href="marketingdashboard" class="nav-link"><i class="bi bi-clipboard-data-fill p-2 rounded-circle" style="background-color: lightgray"></i> DASHBOARD</a>
                        <a href="customerlist" class="nav-link"><i class="bi bi-people-fill p-2 rounded-circle" style="background-color: lightgray"></i> CUSTOMERS/<br>CONTACTS</a>
                        <a href="FeedbackManager" class="nav-link active"><i class="bi bi-chat-left-text-fill p-2 rounded-circle" style="background-color: lightgray"></i> FEEDBACKS</a>
                        <a href="marketingproductlist" class="nav-link"><i class="bi bi-archive-fill p-2 rounded-circle" style="background-color: lightgray"></i> PRODUCTS</a>
                        <a href="SliderManager" class="nav-link"><i class="bi bi-image p-2 rounded-circle" style="background-color: lightgray"></i> SLIDERS</a>
                    </div>
                </div>
                <!-- Sidebar End -->

                <!-- Main Content Start -->
                <div class="col-sm-10">
                    <div class="row">
                        <div style="margin-top: 41px;margin-bottom: 35px;" class="col-9 d-flex align-items-baseline flex-column ms-4">
                            <div style="color:black;" class="h4 font-weight-bold">Feedback ID : ${feedback.id} - <span style="color: #28a745">${feedback.status}</span></div>
                            <div class="h6">${feedback.createdDate}</div>
                        </div>
                        <div style="margin-top: 41px;margin-bottom: 35px;" class="col-3 d-flex align-items-center">
                            <button id="cancel-order-btn" class="btn btn-danger btn-apply" onclick="window.location.href = 'changestatusfeedback?id=${feedback.id}'">Change Status</button>
                        </div>
                        <div class="col-6 d-flex flex-column align-items-start">
                            <div class="h5" style="margin-bottom: 15px;">User Information</div>
                            <div style="border-left:#b0b435 4px solid;" class="w-100 d-flex align-items-center">
                                <img src="images/userpfp/default.jpg" class="img-fluid img-thumbnail img-circle mr-3" alt="User Image" style="max-width: 100px; margin-left: 5px;">
                                <div>
                                    <div style="margin-bottom: 10px;">Information : ${sessionScope.user.name},&emsp; ${sessionScope.user.gender}</div>
                                    <div style="margin-bottom: 10px;">Contact : ${sessionScope.user.email},&emsp;${sessionScope.user.phone}</div>
                                    <div style="margin-bottom: 10px;">Address : ${address.detail}, ${address.district}, ${address.city}</div>
                                </div>
                            </div>
                        </div>
                        <div class="col-6 d-flex flex-column align-items-start">
                            <div class="h5" style="margin-bottom: 15px;">Product Information</div>
                            <div style="border-left:#b0b435 4px solid;" class="w-100 d-flex align-items-center">
                                <img src="${product.thumbnail}" class="img-fluid img-thumbnail mr-3" alt="Product Image" style="max-width: 100px; margin-left: 5px;">
                                <div>
                                    <div style="margin-bottom: 10px;">Title: ${product.title}</div>
                                    <div style="margin-bottom: 10px;">Price: ${product.listPrice}</div>
                                </div>
                            </div>
                        </div>
                        <div style="background-color: #f9f9f9;color:black;font-size: 20px;border: #dadada solid 1px;" class="col-12 mt-3">
                            <div class="row">
                                <div class="card-body">
                                    <div class="form-group">
                                        <label for="productQuality">Rated Star:</label>
                                        <c:if test="${feedback.star == 1}">
                                            <span class="product-rating">
                                                <i class="bi bi-star-fill text-warning"></i>
                                                <i class="bi bi-star"></i>
                                                <i class="bi bi-star"></i>
                                                <i class="bi bi-star"></i>
                                                <i class="bi bi-star"></i>
                                            </span>
                                        </c:if>
                                        <c:if test="${feedback.star == 2}">
                                            <span class="product-rating">
                                                <i class="bi bi-star-fill text-warning"></i>
                                                <i class="bi bi-star-fill text-warning"></i>
                                                <i class="bi bi-star"></i>
                                                <i class="bi bi-star"></i>
                                                <i class="bi bi-star"></i>
                                            </span>
                                        </c:if>
                                        <c:if test="${feedback.star == 3}">
                                            <span class="product-rating">
                                                <i class="bi bi-star-fill text-warning"></i>
                                                <i class="bi bi-star-fill text-warning"></i>
                                                <i class="bi bi-star-fill text-warning"></i>
                                                <i class="bi bi-star"></i>
                                                <i class="bi bi-star"></i>
                                            </span>
                                        </c:if>
                                        <c:if test="${feedback.star == 4}">
                                            <span class="product-rating">
                                                <i class="bi bi-star-fill text-warning"></i>
                                                <i class="bi bi-star-fill text-warning"></i>
                                                <i class="bi bi-star-fill text-warning"></i>
                                                <i class="bi bi-star-fill text-warning"></i>
                                                <i class="bi bi-star"></i>
                                            </span>
                                        </c:if>
                                        <c:if test="${feedback.star == 5}">
                                            <span class="product-rating">
                                                <i class="bi bi-star-fill text-warning"></i>
                                                <i class="bi bi-star-fill text-warning"></i>
                                                <i class="bi bi-star-fill text-warning"></i>
                                                <i class="bi bi-star-fill text-warning"></i>
                                                <i class="bi bi-star-fill text-warning"></i>
                                            </span>
                                        </c:if>
                                        <input type="hidden" name="productQuality" id="productQuality" value="0">
                                    </div>
                                    <div class="form-group">
                                        <label for="reviewFeedback">Review Feedback:</label>
                                        <textarea class="form-control" id="reviewFeedback" name="reviewFeedback" rows="3" value="${feedback.detail}" readonly>${feedback.detail}</textarea>
                                    </div>
                                    <div class="form-group">
                                        <label for="feebackImage">Feedback Image:</label>
                                        <div class="row">
                                            <c:forEach items="${imageList}" var="i">
                                                <div class="col-sm-1">
                                                    <img src="${i.feedback_image}" class="img-fluid img-thumbnail" alt="Feedback Image 1">
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Main Content End -->
            </div>
        </div>
        <jsp:include page="footer.jsp"></jsp:include>

        <!-- JavaScript Libraries -->
        <script src="js/jquery-3.2.1.min.js"></script>
        <script src="js/popper.min.js"></script>
        <script src="js/bootstrap.min.js"></script>

        <!-- ALL PLUGINS -->
        <script src="js/bootstrap-select.js"></script>
        <script src="js/inewsticker.js"></script>
        <script src="js/images-loded.min.js"></script>
        <script src="js/isotope.min.js"></script>
        <script src="js/owl.carousel.min.js"></script>
        <script src="js/baguetteBox.min.js"></script>
        <script src="js/form-validator.min.js"></script>
        <script src="js/custom.js"></script>

    </body>
</html>
