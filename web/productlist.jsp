<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page import="java.util.Date, java.util.Calendar"%>
<%@page import="model.User"%>
<!DOCTYPE html>
<html>
    <head>
        <meta content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>PetShop Products List</title>

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
        <style>
            #clearSearchInput {
                display: none;
            }
            .type-ofs {
                position: absolute;
                top: 50%;
                left: 0;
                transform: translate(35%, -165%) rotate(45deg);
                width: 100%;
                height: 30%;
                z-index: 8;
            }
            .type-ofs .out-of-stock {
                background-color: rgba(0, 0, 0, 0.5);
                color: #ffffff;
                padding: 2px 30px;
                font-weight: 700;
                text-transform: uppercase;
                line-height: 1.2;
            }
            .out-of-stock-img {
                -webkit-filter: grayscale(100%);
                filter: grayscale(100%);
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>
            <div class="container-fluid">
                <div class="row">
                    <div class="sidebar container-fluid col-sm-3">
                        <!-- Start Sidebar  -->
                        <div class="container-fluid sticky-top" style="top: 126px;z-index: 2;">
                            <div class="row">
                                <div class="col-12 text-center mt-3">
                                    <h3 style="font-weight: 700; font-size: 32px; margin: 20px 0px;">Product Filter</h3>
                                </div>
                            </div>
                            <form action="productlist" method="get">
                                <input name="category" value="${category}" hidden>
                            <div class="row border-top pt-3">
                                <div class="col-12 input-group mb-3">
                                    <input type="text" class="form-control" id="search" name="search" placeholder="Search" value="${searchCategory}" list="searchList">
                                    <button type="button" class="input-group-text btn" id="clearSearchInput">&times;</button>
                                    <button type="submit" class="input-group-text btn"><i class="bi bi-search"></i></button>
                                    <datalist id="searchList">
                                        <c:forEach items="${allSearchList}" var="asl">
                                            <option value="${asl.title}"></option>
                                        </c:forEach>
                                        <c:forEach items="${applicationScope.prcategory}" var="cate">
                                            <option value="Category: ${cate.name}"></option>
                                        </c:forEach>
                                    </datalist>
                                </div>
                                <div class="col-12 mb-0 blog-box pt-2">
                                    <h2 style="font-weight: 700">Categories</h2>
                                </div>
                                <c:forEach items="${applicationScope.prcategory}" var="pcate">
                                    <div class="col-12 input-group product-content" title="${pcate.name}">
                                        <div class="latest-product-content">
                                            <div style="padding: 0px 5px;">
                                                <h3>
                                                    <a href="?category=${pcate.id}&priceOption=${priceOption}&minPrice=${minPrice}&maxPrice=${maxPrice}&sort=${sort.replace(" ", "%20")}">${pcate.name}</a>
                                                </h3>
                                            </div>
                                        </div>
                                        <div style="margin-top: 5px">
                                            <c:choose>
                                                <c:when test="${pcate.name == categoryName}">
                                                    <a class="input-group-text text-danger reset-button"
                                                       href="?priceOption=${priceOption}&minPrice=${minPrice}&maxPrice=${maxPrice}&sort=${sort.replace(" ", "%20")}">&times;</a>
                                                </c:when>
                                                <c:when test="${pcate.id == cateList}">
                                                    <a class="input-group-text text-danger reset-button"
                                                       href="?search=${search.replace(" ", "+")}&priceOption=${priceOption}&minPrice=${minPrice}&maxPrice=${maxPrice}&sort=${sort.replace(" ", "%20")}">&times;</a>
                                                </c:when>
                                            </c:choose>
                                        </div>
                                    </div>
                                </c:forEach>
                                <div class="col-12 mb-3 blog-box pt-2">
                                    <h2 style="font-weight: 700">Price</h2>
                                </div>
                                <div class="col-12">

                                </div>
                                <div class="col-12">
                                    <div class="form-check">
                                        <input class="form-check-input" id="price1" type="radio" name="priceOption" value="price1" ${priceOption eq "price1" ? "checked" : ""}>
                                        <label class="form-check-label" for="price1">Less than 100.000đ</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" id="price2" type="radio" name="priceOption" value="price2" ${priceOption eq "price2" ? "checked" : ""}>
                                        <label class="form-check-label" for="price2">100.000đ - 350.000đ</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" id="price3" type="radio" name="priceOption" value="price3" ${priceOption eq "price3" ? "checked" : ""}>
                                        <label class="form-check-label" for="price3">350.000đ - 600.000đ</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" id="price4" type="radio" name="priceOption" value="price4" ${priceOption eq "price4" ? "checked" : ""}>
                                        <label class="form-check-label" for="price4">More than 600.000đ</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" id="customPrice" type="radio" name="priceOption" value="customPrice" ${priceOption eq "customPrice" ? "checked" : ""}>
                                        <label class="form-check-label" for="customPrice">Custom Price:</label>
                                    </div>
                                    <div class="display row">
                                        <input type="number" class="form-control col" name="minPrice" id="min" value="${minPrice}">
                                        <span class="col-2 text-center" style="padding: 5px 2px 0  0">to</span>
                                        <input type="number" class="form-control col" name="maxPrice" id="max" value="${maxPrice}">
                                    </div>
                                </div>
                                <div class="col-12 text-center mb-4">
                                    <button type="submit" class="btn btn-apply">Apply</button>
                                    <a type="button" class="btn btn-reset" href="?category=${category}&search=${search.replace(" ", "+")}&sort=${sort.replace(" ", "%20")}">Reset</a>
                                </div>
                            </div>
                            <input name="sort" value="${sort}" hidden>
                            <input name="page" value="1" hidden>
                        </form>
                        <div class="row border-top">
                            <div class="col-12 text-center mt-3">
                                <h3 style="font-weight: 700; font-size: 32px; margin: 20px 0px;">Latest Product</h3>
                            </div>
                        </div>
                        <div class="row border-top pt-3">
                            <c:forEach items="${latestproduct}" var="lp" begin="0" end="1">
                                <div class="col-12 blog-box" title="${lp.title}"
                                     onclick="window.location.href = 'productdetail?id=${lp.id}'" style="cursor: pointer">
                                    <div>
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
                                <div class="col-md-10">
                                    <div class="title-all">
                                        <c:choose>
                                            <c:when test="${search != null && search != '' 
                                                            || minPrice != null && minPrice != '' 
                                                            || maxPrice != null && maxPrice != ''}">
                                                    <h1>Search results</h1>
                                                    <p>Product based on your reference.</p>
                                            </c:when>
                                            <c:when test="${cateList != null && cateList != ''}">
                                                <c:forEach items="${applicationScope.prcategory}" var="apr">
                                                    <c:if test="${apr.id == cateList}">
                                                        <h1>Explore products on <span style="background: #b0b435;color: white;
                                                                                      padding: 0 10px 5px;">${apr.name}</span></h1>
                                                        <p>Explore products on Pet Shop.</p>
                                                    </c:if>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <h1>All Products</h1>
                                                <p>Explore products on Pet Shop.</p>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                                <div class="col-md-2 d-flex align-items-center justify-content-end">
                                    <div class="row mb-lg-4 mr-5">
                                        <div class="col-2 mr-2 align-content-end text-right" style="font-size: 18px;padding: 0;">Sort:</div>
                                        <div class="col-xl-8 col-10 align-content-end text-left" style="padding: 0;margin-right: 10px">
                                            <select class="form-select py-2 px-1 mr-5" id="sort" title="Sort">
                                                <option>Default</option>
                                                <option value="Latest" ${sort == "Latest" ? "selected" : ""}>By Newest Arrivals</option>
                                                <option value="Oldest" ${sort == "Oldest" ? "selected" : ""}>By Oldest Products</option>
                                                <option value="Price Asc" ${sort == "Price Asc" ? "selected" : ""}>By Price (Low to High)</option>
                                                <option value="Price Desc" ${sort == "Price Desc" ? "selected" : ""}>By Price (High to Low)</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row" id="product-list">
                                <c:if test="${resultSize == 0}">
                                    <div class="col-12 text-center">
                                        <h2>No product matches your search!</h2>
                                    </div>
                                </c:if>
                                <% int i = 0; %>
                                <c:forEach items="${allproduct}" var="apr">
                                    <div class="col-lg-3 col-md-6">
                                        <div class="products-single fix" style="border: solid lightgray 1px;border-radius: 5px">
                                            <div class="box-img-hover">
                                                <c:choose>
                                                    <c:when test="${apr.status != 'Available'}">
                                                        <div class="type-ofs text-center align-items-center">
                                                            <p class="out-of-stock">Out<br>of Stock</p>
                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
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
                                                    </c:otherwise>
                                                </c:choose>
                                                <img src="${apr.thumbnail}" onerror="this.src='images/error-product-image.jpg';this.onerror='';" class="img-fluid ${apr.status != 'Available' ? 'out-of-stock-img' : ''}" alt="Image">
                                                <div class="mask-icon">
                                                    <a class="view" href="productdetail?id=${apr.id}">View</a>
                                                    <%
                                                        User user = (User) session.getAttribute("user");
                                                        if (user != null && user.getRoleId() == 5) {
                                                    %>
                                                    <c:if test="${apr.status eq 'Available'}">
                                                        <a class="cart" href="addcartproductlist?productid=${apr.id}&quantity=1">Add to Cart</a>
                                                    </c:if>
                                                    <%}%>
                                                </div>
                                            </div>
                                            <div class="why-text row" style="min-height: 150px">
                                                <div class="col-12" style="max-height: 71.9px;min-height: 71.9px;">
                                                    <h4>${apr.title}</h4>
                                                </div>
                                                <div class="col-12">
                                                    <div class="row">
                                                        <div class="col-12">
                                                            <c:set var="formattedPrice">
                                                                <fmt:formatNumber value="${apr.listPrice * 1000}" type="number" groupingUsed="true" minFractionDigits="0" maxFractionDigits="0"/>
                                                            </c:set>
                                                            <h5>${formattedPrice} đ</h5>
                                                        </div>
                                                        <c:forEach items="${starList}" var="star" begin="<%= i %>" end="<%= i++ %>">
                                                            <div class="col-12 d-flex justify-content-between">
                                                                <div>
                                                                    <span class="product-rating">
                                                                        <i class="bi ${star >= 1 ? 'bi-star-fill text-warning' : 'bi-star'}"></i>
                                                                        <i class="bi ${star >= 2 ? 'bi-star-fill text-warning' : 'bi-star'}"></i>
                                                                        <i class="bi ${star >= 3 ? 'bi-star-fill text-warning' : 'bi-star'}"></i>
                                                                        <i class="bi ${star >= 4 ? 'bi-star-fill text-warning' : 'bi-star'}"></i>
                                                                        <i class="bi ${star == 5 ? 'bi-star-fill text-warning' : 'bi-star'}"></i>
                                                                    </span>
                                                                    <span>&bull;    (${star})</span>
                                                                </div>
                                                                <div>Sold <fmt:formatNumber value="${soldMap[apr.id]}" type="number" groupingUsed="true" minFractionDigits="0" maxFractionDigits="0"/></div>
                                                            </div>
                                                        </c:forEach>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                            <div class="px-5 pt-3">
                                <div class="row justify-content-end mr-1">
                                    <nav>
                                        <ul class="pagination">
                                            <c:if test="${page > 1}">
                                                <li class="page-item">
                                                    <a class="page-link" href="?category=${category}&search=${search.replace(" ", "+")}&priceOption=${priceOption}&minPrice=${minPrice}&maxPrice=${maxPrice}&sort=${sort.replace(" ", "%20")}&page=${page - 1}">Previous</a>
                                                </li>
                                            </c:if>
                                            <c:set var="ellipsis" value="false" />
                                            <c:forEach begin="1" end="${totalPage}" var="i">
                                                <c:choose>
                                                    <c:when test="${i <= 2 or i >= totalPage - 1 or (i >= page - 1 and i <= page + 1)}">
                                                        <li class="page-item ${page == i ? 'active' : ''}">
                                                            <a class="page-link" href="?category=${category}&search=${search.replace(" ", "+")}&priceOption=${priceOption}&minPrice=${minPrice}&maxPrice=${maxPrice}&sort=${sort.replace(" ", "%20")}&page=${i}">${i}</a>
                                                        </li>
                                                        <c:set var="showEllipsis" value="true" />
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:if test="${!ellipsis}">
                                                            <li class="page-item disabled">
                                                                <a class="page-link">...</a>
                                                            </li>
                                                            <c:set var="ellipsis" value="true" />
                                                        </c:if>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                            <c:if test="${page < totalPage}">
                                                <li class="page-item">
                                                    <a class="page-link" href="?category=${category}&search=${search.replace(" ", "+")}&priceOption=${priceOption}&minPrice=${minPrice}&maxPrice=${maxPrice}&sort=${sort.replace(" ", "%20")}&page=${page + 1}">Next</a>
                                                </li>
                                            </c:if>
                                        </ul>
                                    </nav>
                                </div>
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
                                             window.location.href = '?category=${category}'
                                                     + '&search=${search.replace(" ", "+")}'
                                                     + '&priceOption=${priceOption}'
                                                     + '&minPrice=${minPrice}'
                                                     + '&maxPrice=${maxPrice}&sort=' + selectedValue
                                                     + '&page=${page}';
                                         });
        </script>
        <script>
            document.addEventListener('DOMContentLoaded', () => {
                const predefinedPrices = document.querySelectorAll('input[name="priceOption"]:not([value="customPrice"])');
                const customPriceRadio = document.querySelector('input[name="priceOption"][value="customPrice"]');
                const customPriceInputs = document.querySelectorAll('.display input');

                function updateStates() {
                    if (customPriceRadio.checked) {
                        customPriceInputs.forEach(input => input.disabled = false);
                    } else {
                        customPriceInputs.forEach(input => input.disabled = true);
                    }
                }

                // Initial state check
                updateStates();

                predefinedPrices.forEach(price => {
                    price.addEventListener('change', () => {
                        updateStates();
                    });
                });
                customPriceRadio.addEventListener('change', () => {
                    updateStates();
                });
            });
        </script>
        <script>
            document.addEventListener('DOMContentLoaded', () => {
                const selectedId = '<%= request.getParameter("category") %>'.trim();
                const selectedName = '${categoryName}'.trim();

                if (selectedName || selectedId) {
                    const cates = document.querySelectorAll('.product-content a');

                    cates.forEach(cate => {
                        const matchesName = selectedName != null && cate.innerText.trim() === selectedName;
                        const matchesId = selectedId != null && selectedId !== ''
                                && cate.getAttribute('href').includes('category=' + selectedId);

                        if (matchesName || matchesId) {
                            cate.parentElement.parentElement.parentElement.parentElement.style.transform = 'scale(1.1) translateX(20px)';
                            cate.style.fontWeight = '900';
                        }
                    });
                }
            });

        </script>
        <script>
            // Clear search button
            const searchInput = document.getElementById('search');
            const clearButton = document.getElementById('clearSearchInput');

            document.addEventListener('DOMContentLoaded', () => {
                if (searchInput.value.trim() !== '') {
                    clearButton.style.display = 'block';
                }
            });
            searchInput.addEventListener('input', () => {
                if (searchInput.value !== '') {
                    clearButton.style.display = 'block';
                } else {
                    clearButton.style.display = 'none';
                }
            });
            searchInput.addEventListener('focusout', () => {
                if (searchInput.value === '') {
                    clearButton.style.display = 'none';
                }
            });
            clearButton.addEventListener('click', () => {
                searchInput.value = '';
                clearButton.style.display = 'none';
            });
        </script>
    </body>
</html>
