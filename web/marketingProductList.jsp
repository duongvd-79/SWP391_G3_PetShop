<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>PetShop - Marketing Features</title>

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
        <!-- Summernote -->
        <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
        <style>
            .page-item.active .page-link {
                background-color: #b0b435;
                border-color: #b0b435;
            }
            .page-link {
                background-color: #fff;
                color: #212121;
            }
            .info-popup {
                display: none;
                position: absolute;
                top: 100%;
                left: 15px;
                padding: 5px 10px;
                background-color: #f0f0f0;
                border-radius: 5px;
                z-index: 1;
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
            .sidebar .active{
                color: #b0b435;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>
            <div class="container-fluid">
                <div class="row">
                    <!-- Sidebar Start -->
                    <div class="container col-2 position-relative" >
                        <div class="w-100 mb-1 sticky-top sidebar" style="top: 126px;z-index: 1;font-size: 18px;font-weight: bold">
                            <a href="#" class="nav-link"><i class="bi bi-clipboard-data-fill p-2 rounded-circle" style="background-color: #f2f6f9"></i> DASHBOARD</a>
                            <a href="customerlist" class="nav-link"><i class="bi bi-people-fill p-2 rounded-circle" style="background-color: #f2f6f9"></i> CUSTOMERS/<br>CONTACTS</a>
                            <a href="FeedbackManager" class="nav-link"><i class="bi bi-chat-left-text-fill p-2 rounded-circle" style="background-color: #f2f6f9"></i> FEEDBACKS</a>
                            <a href="marketingproductlist" class="nav-link active"><i class="bi bi-archive-fill p-2 rounded-circle" style="background-color: #f2f6f9"></i> PRODUCTS</a>
                            <a href="SliderManager" class="nav-link"><i class="bi bi-image p-2 rounded-circle" style="background-color: #f2f6f9"></i> SLIDERS</a>
                        </div>
                    </div>
                    <!-- Sidebar End -->

                    <!-- Content Start -->
                    <div class="col-10 container-fluid rounded bg-white mt-4 mb-5 pb-1 px-4">
                        <div clas="row">
                            <div class="row d-flex align-items-center mb-3">
                                <div class="col-md-3">
                                    <form action="marketingproductlist" method="get">
                                        <input type="text" name="search" class="w-100 form-control" placeholder="Search..." list="searchData"/>
                                        <datalist id="searchData">
                                        <c:forEach items="${allSearchList}" var="asl">
                                            <option value="${asl.title}"></option>
                                        </c:forEach>
                                    </datalist>
                                    <input type="text" name="category" value="${category}" hidden/>
                                    <input type="text" name="status" value="${status}" hidden/>
                                    <input type="text" name="sort" value="${sort}" hidden/>
                                    <button type="submit" hidden></button>
                                </form>
                            </div>
                            <div class="col-md-2">
                                <select class="form-control w-100" id="category">
                                    <option value="">All Category</option>
                                    <c:forEach items="${applicationScope.prcategory}" var="prcate">
                                        <option value="${prcate.name}" ${prcate.name eq categorySelect ? 'selected' : ''}>${prcate.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <select class="form-control" id="status">
                                    <option value="">All Status</option>
                                    <option value="Available" ${status eq 'Available' ? 'selected' : ''}>Available</option>
                                    <option value="Out of Stock" ${status eq 'Out of Stock' ? 'selected' : ''}>Out of Stock</option>
                                    <option value="Hidden" ${status eq 'Hidden' ? 'selected' : ''}>Hidden</option>
                                </select>
                            </div>
                            <div class="col-md-1 form-check">
                                <input type="checkbox" id="isFeatured" ${featured eq 'Is Featured' ? 'checked' : ''} value="${featured eq 'Is Featured' ? '' : 'Is Featured'}">
                                <label class="form-check-label" for="isFeatured">Featured</label>
                            </div>
                            <div class="col-md-2">
                                <select class="form-control" id="sort">
                                    <option value="">Sort</option>
                                    <option value="Date DESC" ${sort eq 'Date DESC' ? 'selected' : ''}>Latest/New Item(s)</option>
                                    <option value="Date ASC" ${sort eq 'Date ASC' ? 'selected' : ''}>Oldest Item(s)</option>
                                </select>
                            </div>
                            <div class="col-md-1 d-flex justify-content-end">
                                <a class="btn btn-secondary" href="marketingproductlist">Clear</a>
                            </div>
                            <div class="col-md-1 d-flex justify-content-end">
                                <button class="btn" style="text-decoration: none;color: white;background: #b0b435" type="button" data-toggle="modal" data-target="#addNewProduct">Add New</button>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12 table-responsive">
                                <table class="table text-start align-middle table-bordered table-hover mb-0" id="pTable" title="Click to see created date.">
                                    <thead style="font-size:20px;">
                                        <tr>
                                            <th>
                                                <div class="d-flex justify-content-center">ID</div>
                                            </th>
                                            <th>
                                                <div class="d-flex justify-content-center">Thumbnail</div>
                                            </th>
                                            <th class="${sort eq 'Title ASC' || sort eq 'Title DESC' ? 'table-active' : ''}">
                                                <div class="d-flex justify-content-between">
                                                    Title
                                                    <a class="d-flex align-items-center" 
                                                       href="?status=${status}&search=${search}&sort=${sort eq 'Title ASC' ? 'Title DESC' : 'Title ASC'}&page=${page}">
                                                        <i class="bi ${sort eq 'Title ASC' ? 'bi-sort-down' : 'bi-sort-up'}"></i>
                                                    </a>
                                                </div>
                                            </th>
                                            <th class="${sort eq 'Category ASC' || sort eq 'Category DESC' ? 'table-active' : ''}">
                                                <div class="d-flex justify-content-between">
                                                    Category
                                                    <a class="d-flex align-items-center" 
                                                       href="?status=${status}&search=${search}&sort=${sort eq 'Category ASC' ? 'Category DESC' : 'Category ASC'}&page=${page}">
                                                        <i class="bi ${sort eq 'Category ASC' ? 'bi-sort-down' : 'bi-sort-up'}"></i>
                                                    </a>
                                                </div>
                                            </th>
                                            <th class="${sort eq 'Import Price ASC' || sort eq 'Import Price DESC' ? 'table-active' : ''}">
                                                <div class="d-flex justify-content-between">
                                                    Import Price
                                                    <a class="d-flex align-items-center" 
                                                       href="?status=${status}&search=${search}&sort=${sort eq 'Import Price ASC' ? 'Import Price DESC' : 'Import Price ASC'}&page=${page}">
                                                        <i class="bi ${sort eq 'Gender ASC' ? 'bi-sort-down' : 'bi-sort-up'}"></i>
                                                    </a>
                                                </div>
                                            </th>
                                            <th class="${sort eq 'List Price ASC' || sort eq 'List Price DESC' ? 'table-active' : ''}">
                                                <div class="d-flex justify-content-between">
                                                    Sale Price
                                                    <a class="d-flex align-items-center" 
                                                       href="?status=${status}&search=${search}&sort=${sort eq 'List Price ASC' ? 'List Price DESC' : 'List Price ASC'}&page=${page}">
                                                        <i class="bi ${sort eq 'List Price ASC' ? 'bi-sort-down' : 'bi-sort-up'}"></i>
                                                    </a>
                                                </div>
                                            </th>
                                            <th>
                                                <div class="d-flex justify-content-start">Featured</div>
                                            </th>
                                            <th class="${sort eq 'Status ASC' || sort eq 'Status DESC' ? 'table-active' : ''}">
                                                <div class="d-flex justify-content-between">
                                                    Status
                                                    <a class="d-flex align-items-center" 
                                                       href="?status=${status}&search=${search}&sort=${sort eq 'Status ASC' ? 'Status DESC' : 'Status ASC'}&page=${page}">
                                                        <i class="bi ${sort eq 'Status ASC' ? 'bi-sort-down' : 'bi-sort-up'}"></i>
                                                    </a>
                                                </div>
                                            </th>
                                            <th>
                                                <div class="d-flex justify-content-center">
                                                    Action
                                                </div>
                                            </th>
                                            <th id="headerDate" style="display: none;max-width: 100px">
                                                <div class="d-flex justify-content-center">
                                                    Created Date
                                                </div>
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody style="font-size:20px;">
                                        <c:choose>
                                            <c:when test="${size == 0}">
                                                <tr>
                                                    <td colspan="9"><h2 class="text-center">There is nothing to show!</h2></td>
                                                </tr>
                                            </c:when>
                                            <c:otherwise>
                                                <c:forEach items="${productList}" var="p">
                                                    <tr>
                                                        <td>
                                                            <div class="d-flex justify-content-center">
                                                                ${p.id}
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <div class="d-flex justify-content-center">
                                                                <img class="rounded" src="${p.thumbnail}" onerror="this.src='images/error-product-image.jpg';this.onerror='';" style="max-width: 100px"/>
                                                            </div>
                                                        </td>
                                                        <td style="word-wrap: break-word;white-space: normal;max-width: 200px;">
                                                            ${p.title}
                                                        </td>
                                                        <td>${cateMap[p.categoryId]}</td>
                                                        <td>
                                                            <fmt:formatNumber value="${p.importPrice * 1000}" type="number" groupingUsed="true" minFractionDigits="0" maxFractionDigits="0"/> đ
                                                        </td>
                                                        <td>
                                                            <fmt:formatNumber value="${p.listPrice * 1000}" type="number" groupingUsed="true" minFractionDigits="0" maxFractionDigits="0"/> đ
                                                        </td>
                                                        <td class="text-center is-featured" style="font-size: 32px">
                                                            <a href="?id=${p.id}&pfeatured=${p.isFeatured ? 'Is Featured' : 'Not Featured'}&category=${category}&status=${status}&search=${search}&sort=${sort}&page=${page}">
                                                                ${p.isFeatured ? '<i class="bi bi-check-square-fill"></i>' : '<i class="bi bi-square"></i>'}
                                                            </a>
                                                        </td>
                                                        <td>
                                                            <span class="badge ${p.status eq 'Available' ? 'badge-success' : (p.status eq 'Hidden' ? 'badge-danger' : 'badge-secondary')}">${p.status}</span>
                                                        </td>
                                                        <td>
                                                            <div class="d-flex justify-content-between">
                                                                <a href="marketingproductdetail?id=${p.id}" title="Edit"><i class="bi bi-pencil"></i></a>
                                                                <a title="Show/Hide Product" href="?id=${p.id}&pstatus=${p.status}&category=${category}&status=${status}&search=${search}&sort=${sort}&page=${page}">
                                                                    ${p.status eq 'Hidden' ? '<i class="bi bi-eye"></i>' : '<i class="bi bi-eye-slash"></i>'}
                                                                </a>
                                                            </div>
                                                        </td>
                                                        <td class="row-date" style="word-wrap: break-word;white-space: normal;max-width: 150px;display: none">
                                                            <fmt:formatDate value="${p.createdDate}" pattern="dd-MM-yyyy hh:mm:ss"/>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </c:otherwise>
                                        </c:choose>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="px-3 pt-3">
                            <div class="row justify-content-end">
                                <nav>
                                    <ul class="pagination">
                                        <c:if test="${page > 1}">
                                            <li class="page-item">
                                                <a class="page-link" href="?search=${search}&category=${category}&status=${status}&sort=${sort}&page=${page - 1}">Previous</a>
                                            </li>
                                        </c:if>
                                        <c:set var="ellipsis" value="false" />
                                        <c:forEach begin="1" end="${totalPage}" var="i">
                                            <c:choose>
                                                <c:when test="${i <= 2 or i >= totalPage - 1 or (i >= page - 1 and i <= page + 1)}">
                                                    <li class="page-item ${page == i ? 'active' : ''}">
                                                        <a class="page-link" href="?search=${search}&category=${category}&status=${status}&sort=${sort}&page=${i}">${i}</a>
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
                                                <a class="page-link" href="?search=${search}&category=${category}&status=${status}&sort=${sort}&page=${page + 1}">Next</a>
                                            </li>
                                        </c:if>
                                    </ul>
                                </nav>
                            </div>
                        </div>
                        <div class="modal fade" id="addNewProduct" tabindex="-1" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" style="min-width: 70vw">
                                <div class="modal-content">
                                    <div class="modal-body">
                                        <form action="marketingproductlist" method="post" enctype="multipart/form-data">
                                            <div class="row">
                                                <div class="col-12">
                                                    <div class="p-3 pt-5 pb-3">
                                                        <div class="d-flex justify-content-center align-items-center mb-3">
                                                            <h2><strong>Add new Product</strong></h2>
                                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                <span aria-hidden="true">&times;</span>
                                                            </button>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-12 border-left border-right">
                                                                <div class="row">
                                                                    <div class="col-4">
                                                                        <div class="d-flex flex-column align-items-center text-center p-3">
                                                                            <img class="rounded-circle my-3" id="preview-thumbnail" width="150px" height="150px" src="" onerror="this.src='images/error-product-image.jpg';this.onerror='';">
                                                                            <h3 class="text-right"><strong>Thumbnail</strong></h3>
                                                                            <input id="thumbnail-upload" type="file" name="thumbnail" accept="image/*">
                                                                            <p id="thumbnail-size-warning" style="color: red; display: none;">File size exceeds 50MB!</p>
                                                                            <label for="thumbnail-upload" class="custom-file-upload mt-2">Upload Image</label>
                                                                            <span>or</span>
                                                                            <input class="form-control mt-2" type="text" name="thumbnailURL" placeholder="Enter Thumbnail URL" id="thumbnailURL">
                                                                            <span id="thumbnail-name"></span>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-8">
                                                                        <div class="row mt-2">
                                                                            <div class="col-md-12">
                                                                                <label class="labels"><strong>Title</strong> <span class="text-danger">(*)</span></label>
                                                                                <input type="text" class="form-control" name="title" pattern="^[A-Za-zÀ-ỹà-ỹ0-9]+( [A-Za-zÀ-ỹà-ỹ0-9]+)*$" maxlength="255" 
                                                                                       title="Alphanumeric characters only. Max 255 characters. Each word is separated by only 1 space."
                                                                                       id="newTitle" placeholder="Enter Product Title" value="${sessionScope.title}" required>
                                                                                <% request.getSession().removeAttribute("title"); %>
                                                                            </div>
                                                                        </div>
                                                                        <div class="row mt-3">
                                                                            <div class="col-md-12">
                                                                                <label class="labels"><strong>Description</strong> <span class="text-danger">(*)</span></label>
                                                                                <textarea class="form-control" name="description" id="newDescription" placeholder="Enter Description" value="${sessionScope.description}" required>${sessionScope.description}</textarea>
                                                                                <% request.getSession().removeAttribute("description"); %>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="row mt-3">
                                                                    <div class="col-md-6">
                                                                        <label class="labels"><strong>Quantity</strong> <span class="text-danger">(*)</span></label>
                                                                        <input type="number" min="0" class="form-control" name="quantity" id="newQuantity" placeholder="Enter Quantity" value="${sessionScope.quantity}" required>
                                                                        <% request.getSession().removeAttribute("quantity"); %>
                                                                    </div>
                                                                    <div class="col-md-6">
                                                                        <label class="labels"><strong>Status</strong> <span class="text-danger">(*)</span></label>
                                                                        <select type="text" class="form-control py-2 w-100" name="status" id="newStatus" placeholder="Enter Status" value="${sessionScope.status}" required>
                                                                            <option value="">Status</option>
                                                                            <option value="Available" ${sessionScope.status eq 'Available' ? 'selected' : ''}>Available</option>
                                                                            <option value="Out of Stock" ${sessionScope.status eq 'Out of Stock' ? 'selected' : ''}>Out of Stock</option>
                                                                            <option value="Hidden" ${sessionScope.status eq 'Hidden' ? 'selected' : ''}>Hidden</option>
                                                                        </select>
                                                                        <% request.getSession().removeAttribute("status"); %>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-12 border-left border-right">
                                                                <div class="row mt-1">
                                                                    <div class="col-md-6">
                                                                        <label class="labels"><strong>Import Price</strong> <span class="text-danger">(*)</span></label>
                                                                        <input class="form-control" type="number" min="0" name="importPrice" id="newImportPrice" placeholder="Enter Import Price" style="max-width: 100%;min-width:100%;" required>
                                                                        <% request.getSession().removeAttribute("importPrice"); %>
                                                                    </div>
                                                                    <div class="col-md-6">
                                                                        <label class="labels"><strong>List Price</strong> <span class="text-danger">(*)</span></label>
                                                                        <input class="form-control" type="number" min="0" name="listPrice" id="newListPrice" placeholder="Enter List Price" style="max-width: 100%;min-width:100%;" required>
                                                                        <% request.getSession().removeAttribute("listPrice"); %>
                                                                    </div>
                                                                </div>
                                                                <div class="row mt-3">
                                                                    <div class="col-md-6">
                                                                        <label class="labels"><strong>Category</strong> <span class="text-danger">(*)</span></label>
                                                                        <select class="form-control" type="number" name="category" id="newCategory" style="max-width: 100%;min-width:100%;" required>
                                                                            <option value="">Category</option>
                                                                            <c:forEach items="${applicationScope.prcategory}" var="prcate">
                                                                                <option value="${prcate.id}">${prcate.name}</option>
                                                                            </c:forEach>
                                                                        </select>
                                                                        <% request.getSession().removeAttribute("category"); %>
                                                                    </div>
                                                                    <div class="col-md-6 d-flex justify-content-start align-items-end">
                                                                        <div class="form-check">
                                                                            <input type="checkbox" class="form-check-input" name="featured" id="newFeatured" value="Is Featured">
                                                                            <label class="form-check-label" for="newFeatured"><strong>Is Featured</strong></label>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <input type="text" class="form-control text-danger" id="pathName" name="page" value="" hidden>
                                            <div class="mt-3 text-center">
                                                <button class="btn text-light" id="save-button" type="submit" style="background-color: #b0b435">Add Product</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Content End -->
            </div>
        </div>
        <jsp:include page="footer.jsp"></jsp:include>

            <!-- JavaScript Libraries -->
            <script src="js/jquery-3.2.1.min.js"></script>
            <script src="js/popper.min.js"></script>
            <script src="js/bootstrap.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>

            <!-- ALL PLUGINS -->
            <script src="js/bootstrap-select.js"></script>
            <script src="js/inewsticker.js"></script>
            <script src="js/images-loded.min.js"></script>
            <script src="js/isotope.min.js"></script>
            <script src="js/owl.carousel.min.js"></script>
            <script src="js/baguetteBox.min.js"></script>
            <script src="js/form-validator.min.js"></script>
            <script src="js/custom.js"></script>
            <script>
                const hash = window.location.hash;
                if (hash && hash.toString().includes('product')) {
                    const modal = new bootstrap.Modal(document.getElementById(hash.substring(1)));
                    modal.show();
                }
            </script>
            <script>
                document.getElementById('status').addEventListener('change', function () {
                    var selectedValue = this.value;
                    window.location.href = '?category=${category}&status=' + selectedValue
                            + '&featured=${featured}&search=${search}&sort=${sort}';
                });
                document.getElementById('category').addEventListener('change', function () {
                    var selectedValue = this.value;
                    window.location.href = '?status=${status}&category=' + encodeURIComponent(selectedValue)
                            + '&featured=${featured}&search=${search}&sort=${sort}';
                });
                document.getElementById('sort').addEventListener('change', function () {
                    var selectedValue = this.value;
                    window.location.href = '?status=${status}&category=${category}'
                            + '&featured=${featured}&search=${search}&sort=' + selectedValue;
                });
                document.getElementById('isFeatured').addEventListener('change', function () {
                    var selectedValue = this.value;
                    window.location.href = '?category=${category}&status=${status}&featured=' + selectedValue
                            + '&search=${search}&sort=${sort}';
                });
                document.getElementById('pTable').addEventListener('click', function () {
                    if (document.getElementById('headerDate').style.display === 'none') {
                        document.getElementById('headerDate').style.display = '';
                        document.querySelectorAll('.row-date').forEach(function (rowDate) {
                            rowDate.style.display = '';
                        });
                    } else {
                        document.getElementById('headerDate').style.display = 'none';
                        document.querySelectorAll('.row-date').forEach(function (rowDate) {
                            rowDate.style.display = 'none';
                        });
                    }
                });
        </script>
        <script>
            $(document).ready(function () {
                $('#newDescription').summernote({
                    height: 200,
                    toolbar: [
                        ['style', ['style']],
                        ['fontname', ['fontname']],
                        ['fontsize', ['fontsize']],
                        ['font', ['bold', 'italic', 'underline', 'clear']],
                        ['color', ['color']],
                        ['font', ['strikethrough', 'superscript', 'subscript']],
                        ['para', ['ul', 'ol', 'paragraph']],
                        ['height', ['height']]
                        ['table', ['table']],
                        ['insert', ['link', 'picture', 'video']],
                        ['view', ['fullscreen', 'codeview', 'help']]
                    ]
                });
            });
        </script>
        <script>
            // Image upload
            var file = document.getElementById('thumbnail-upload');
            var previewImage = document.getElementById('preview-thumbnail');
            var fileSizeWarning = document.getElementById('thumbnail-size-warning');
            var thumbURL = document.getElementById('thumbnailURL');

            file.addEventListener('change', function () {
                var fileName = this.files[0].name;
                document.getElementById('thumbnail-name').textContent = fileName;
            });

            // Handle image size
            file.addEventListener('change', function () {
                var reader = new FileReader();
                var file2 = this.files[0];
                const maxSize = 50 * 1024 * 1024;

                if (file2.size > maxSize) {
                    fileSizeWarning.style.display = 'block';

                    // Clear the file input
                    this.value = '';
                    document.getElementById('file-name').textContent = '';
                } else {
                    fileSizeWarning.style.display = 'none';
                    reader.onload = (event) => {
                        previewImage.src = event.target.result;
                    };
                    reader.readAsDataURL(file2);
                }
            });
            thumbURL.addEventListener('input', function () {
                fileSizeWarning.style.display = 'none';
                previewImage.src = thumbURL.value;
            });
        </script>
        <script>
            document.addEventListener('DOMContentLoaded', () => {
                const quantityInput = document.getElementById('newQuantity');
                const statusSelect = document.getElementById('newStatus');

                quantityInput.addEventListener('change', function () {
                    if (parseInt(this.value) === 0) {
                        statusSelect.value = 'Out of Stock';
                    } else if (parseInt(this.value) > 0 && statusSelect.value === 'Out of Stock') {
                        statusSelect.value = 'Available';
                    }
                });

                statusSelect.addEventListener('change', function () {
                    if (this.value === 'Out of Stock') {
                        quantityInput.value = 0;
                    } else if (parseInt(quantityInput.value) === 0) {
                        quantityInput.value = 1;
                    }
                });
            });
        </script>
    </body>
</html>
