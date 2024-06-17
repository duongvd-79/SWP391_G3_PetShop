<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.Date, java.util.Calendar"%>
<%@page import="model.User"%>
<!DOCTYPE html>
<html>
    <head>
        <meta content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>PetShop Home Page</title>

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
        <!-- Page CSS -->
        <link rel="stylesheet" href="css/public/productList.css">
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>
            <!-- Start Slider -->
            <div id="slides-shop" class="cover-slides">
                <ul class="slides-container">
                <c:forEach items="${slider}" var="sl">
                    <li class="text-center">
                        <img src="${sl.image}" alt="">
                        <div class="container">
                            <div class="row">
                                <div class="col-md-12">
                                    <h1 class="m-b-20"><strong>${sl.title}</strong></h1>
                                    <p><a class="btn hvr-hover" href="${sl.backLink}">${sl.backLink.contains("product") ? "To Product Details" : "To Blog Details"}</a></p>
                                </div>
                            </div>
                        </div>
                    </li>
                </c:forEach>
            </ul>
            <div class="slides-navigation">
                <a href="#" class="next"><i class="bi bi-caret-right-fill" aria-hidden="true"></i></a>
                <a href="#" class="prev"><i class="bi bi-caret-left-fill" aria-hidden="true"></i></a>
            </div>
        </div>
        <!-- End Slider -->

        <div class="container-fluid">
            <div class="row">
                <div class="sidebar container-fluid col-sm-3">
                    <!-- Start Sidebar  -->
                    <div class="container-fluid sticky-top" style="top: 111px;z-index: 2;">
                        <div class="row">
                            <div class="col-12 text-center mt-3">
                                <h3 style="font-weight: 700; font-size: 32px; margin: 20px 0px;">Product Filter</h3>
                            </div>
                        </div>
                        <form action="productlist" method="get">
                            <input name="category" value="${category}" hidden>
                            <div class="row border-top pt-3">
                                <div class="col-12 input-group mb-3">
                                    <input type="text" class="form-control" name="search" placeholder="Search" value="${search}">
                                    <button type="submit" class="input-group-text btn"><i class="bi bi-search"></i></button>
                                </div>
                                <div class="col-12 mb-3 blog-box pt-2">
                                    <h2 style="font-weight: 700">Categories</h2>
                                </div>
                                <c:forEach items="${prcategory}" var="pcate">
                                    <div class="col-12 input-group product-content" title="${pcate.name}">
                                        <div class="latest-product-content">
                                            <div style="padding: 0px 5px;">
                                                <h3>
                                                    <a href="productlist?category=${pcate.id}&search=${search.replace(" ", "+")}&minPrice=${minPrice}&maxPrice=${maxPrice}&sort=${sort.replace(" ", "%20")}">${pcate.name}</a>
                                                </h3>
                                            </div>
                                        </div>
                                        <c:if test="${pcate.id == category}">
                                            <a class="input-group-text text-danger reset-button"
                                               href="productlist?&search=${search.replace(" ", "+")}&minPrice=${minPrice}&maxPrice=${maxPrice}&sort=${sort.replace(" ", "%20")}&page=${page}">&times;</a>
                                        </c:if>
                                    </div>
                                </c:forEach>
                                <div class="col-12 mb-3 blog-box pt-2">
                                    <h2 style="font-weight: 700">Price</h2>
                                </div>
                                <div class="col-12">
                                    <div class="range-slide">
                                        <div class="slide">
                                            <div class="line" id="line" style="left: 0%; right: 0%;"></div>
                                            <span class="thumb" id="thumbMin" style="left: 0%;"></span>
                                            <span class="thumb" id="thumbMax" style="left: 100%;"></span>
                                        </div>
                                        <input class="range" id="rangeMin" type="range" max="1000000" min="50000" step="50000" value="0">
                                        <input class="range" id="rangeMax" type="range" max="1000000" min="50000" step="50000" value="100">
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="display">
                                        <input type="number" class="form-control mr-5" name="minPrice" id="min" value="${empty minPrice ? "50000" : minPrice}">
                                        <span>to</span>
                                        <input type="number" class="form-control ml-5" name="maxPrice" id="max" value="${empty maxPrice ? "1000000" : maxPrice}">
                                    </div>
                                </div>
                            </div>
                            <input name="sort" value="${sort}" hidden>
                            <input name="page" value="1" hidden>
                        </form>
                        <div class="row">
                            <div class="col-12 text-center mt-3">
                                <h3 style="font-weight: 700; font-size: 32px; margin: 20px 0px;">Latest Product</h3>
                            </div>
                        </div>
                        <div class="row border-top pt-3">
                            <c:forEach items="${requestScope.latestproduct}" var="lp" begin="0" end="1">
                                <div class="col-12 blog-box" title="${lp.title}"
                                     onclick="window.location.href = 'productdetail?id=${lp.id}'" style="cursor: pointer">
                                    <div class="blog-box">
                                        <div class="latest-blog-img">
                                            <img class="img-fluid" src="${lp.thumbnail}" alt="" />
                                        </div>
                                        <div class="latest-product-content">
                                            <div style="padding: 0px 5px;">
                                                <h3>
                                                    <a href="productdetail?id=${lp.id}">${lp.title}</a>
                                                </h3>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                    <!-- End Sidebar  -->
                </div>

                <div class="col-sm-9 border-left">
                    <!-- Start Products  -->
                    <div class="products-box">
                        <div class="container">
                            <div class="row">
                                <div class="col-lg-8">
                                    <div class="title-all">
                                        <h1>All Products</h1>
                                        <p>Explore products on Pet Shop.</p>
                                    </div>
                                </div>
                                <div class="col-lg-4 d-flex align-items-start justify-content-end">
                                    <span>
                                        <span class="mr-2" style="font-size: 18px">Sort:</span>
                                        <select class="form-select py-2 px-1 mr-5 mt-4" id="sort" title="Sort">
                                            <option>Default</option>
                                            <option value="Latest" ${sort == "Latest" ? "selected" : ""}>By Newest Arrivals</option>
                                            <option value="Oldest" ${sort == "Oldest" ? "selected" : ""}>By Oldest Products</option>
                                            <option value="Price Asc" ${sort == "Price Asc" ? "selected" : ""}>By Price (Low to High)</option>
                                            <option value="Price Desc" ${sort == "Price Desc" ? "selected" : ""}>By Price (High to Low)</option>
                                        </select>
                                    </span>
                                </div>
                            </div>

                            <div class="row" id="featured-list">
                                <c:forEach items="${allproduct}" var="apr">
                                    <div class="col-lg-3 col-md-6">
                                        <div class="products-single fix">
                                            <div class="box-img-hover">
                                                <div class="type-lb">
                                                    <c:choose>
                                                        <c:when test="${(apr.isFeatured)}">
                                                            <p class="sale">Hot</p>
                                                        </c:when>
                                                        <c:when test="${apr.createdDate >= oneMonthAgo}">
                                                            <p class="new">New</p>
                                                        </c:when>
                                                    </c:choose>
                                                </div>
                                                <img src="${apr.thumbnail}" class="img-fluid" alt="Image">
                                                <div class="mask-icon">
                                                    <a class="view" href="productdetail?id=${apr.id}">View</a>
                                                    <%
                                                        User user = (User) session.getAttribute("user");
                                                        if (user != null && user.getRoleId() == 5) {
                                                    %>
                                                    <a class="cart" href="#">Add to Cart</a>
                                                    <%}%>
                                                </div>
                                            </div>
                                            <div class="why-text row" style="min-height: 150px">
                                                <div class="col-12" style="max-height: 71.9px;">
                                                    <h4>${apr.title}</h4>
                                                </div>
                                                <div class="col-12">
                                                    <h5>${apr.listPrice}00 đ</h5>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                            <div class="row justify-content-end mr-1">
                                <nav>
                                    <ul class="pagination">
                                        <c:if test="${page - 2 >= 0}">
                                            <li class="page-item">
                                                <a class="page-link" href="productlist?category=${category}&search=${search.replace(" ", "+")}&minPrice=${minPrice}&maxPrice=${maxPrice}&sort=${sort.replace(" ", "%20")}&page=${page - 1}">Previous</a>
                                            </li>
                                        </c:if>
                                        <c:forEach begin="1" end="${totalPage}" var="i">
                                            <li class="page-item ${page == i ? "active" : ""}">
                                                <a class="page-link" href="productlist?category=${category}&search=${search.replace(" ", "+")}&minPrice=${minPrice}&maxPrice=${maxPrice}&sort=${sort.replace(" ", "%20")}&page=${i}">${i}</a>
                                            </li>
                                        </c:forEach>
                                        <c:if test="${page + 1 <= totalPage}">
                                            <li class="page-item">
                                                <a class="page-link" href="productlist?category=${category}&search=${search.replace(" ", "+")}&minPrice=${minPrice}&maxPrice=${maxPrice}&sort=${sort.replace(" ", "%20")}&page=${page + 1}">Next</a>
                                            </li>
                                        </c:if>
                                    </ul>
                                </nav>
                            </div>
                        </div>
                    </div>
                    <!-- End Products  -->
                </div>
            </div>
        </div>

        <jsp:include page="footer.jsp"></jsp:include>

            <a href="#" id="back-to-top" title="Back to top" style="display: none;">&uarr;</a>
            <!-- ALL JS FILES -->
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
            <script>
                                         document.getElementById('sort').addEventListener('change', function () {
                                             var selectedValue = this.value;
                                             window.location.href = 'productlist?category=${category}'
                                                     + '&search=${search.replace(" ", "+")}'
                                                     + '&minPrice=${minPrice}'
                                                     + '&maxPrice=${maxPrice}&sort=' + selectedValue +
                                                     '&page=${page}';
                                         });
        </script>
        <script>
            let min = 50000;
            let max = 1000000;
            const calcLeftPosition = value => 100 / (1000000 - 50000) * (value - 50000);
            const updateSliderValues = (num1, num2) => {
                document.getElementById('line').style.left = calcLeftPosition(num1) + '%';
                document.getElementById('line').style.right = (100 - calcLeftPosition(num2)) + '%';
            }

            document.getElementById('rangeMin').addEventListener('input', (e) => {
                const newValue = ${empty minPrice ? "parseInt(e.target.value)" : minPrice};
                if (newValue <= max) {
                    min = newValue;
                    document.getElementById('thumbMin').style.left = calcLeftPosition(newValue) + '%';
                    document.getElementById('min').value = newValue;
                    updateSliderValues(min, max);
                }
            });
            document.getElementById('rangeMax').addEventListener('input', (e) => {
                const newValue = ${empty maxPrice ? "parseInt(e.target.value)" : maxPrice};
                if (newValue >= min) {
                    max = newValue;
                    document.getElementById('thumbMax').style.left = calcLeftPosition(newValue) + '%';
                    document.getElementById('max').value = newValue;
                    updateSliderValues(max, min);
                }
            });

            document.getElementById('min').addEventListener('input', (e) => {
                const newValue = parseInt(e.target.value);
                if (newValue >= 50000 && newValue <= max) {
                    min = newValue;
                    document.getElementById('thumbMin').style.left = calcLeftPosition(newValue) + '%';
                    document.getElementById('min').value = newValue;
                    updateSliderValues(min, max);
                }
            });
            document.getElementById('max').addEventListener('input', (e) => {
                const newValue = parseInt(e.target.value);
                if (newValue <= 1000000 && newValue >= min) {
                    max = newValue;
                    document.getElementById('thumbMax').style.left = calcLeftPosition(newValue) + '%';
                    document.getElementById('max').value = newValue;
                    updateSliderValues(max, min);
                }
            });
        </script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const selectedCate = '<%= request.getParameter("category") %>';

                if (selectedCate && selectedCate.trim() !== "") {
                    const cates = document.querySelectorAll('.blog-content a');

                    cates.forEach(cate => {
                        if (cate.getAttribute('href').includes(selectedCate)) {
                            cate.parentElement.parentElement.parentElement.parentElement.style.transform = 'scale(1.1) translateX(20px)';
                            cate.style.fontWeight = '900';
                        }
                    });
                }
            });
        </script>
    </body>
</html>
