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
                            <a href="marketingdashboard" class="nav-link"><i class="bi bi-clipboard-data-fill p-2 rounded-circle" style="background-color: lightgray"></i> DASHBOARD</a>
                            <a href="customerlist" class="nav-link"><i class="bi bi-people-fill p-2 rounded-circle" style="background-color: lightgray"></i> CUSTOMERS/<br>CONTACTS</a>
                            <a href="feedbacklist" class="nav-link"><i class="bi bi-chat-left-text-fill p-2 rounded-circle" style="background-color: lightgray"></i> FEEDBACKS</a>
                            <a href="marketingproductlist" class="nav-link active"><i class="bi bi-archive-fill p-2 rounded-circle" style="background-color: lightgray"></i> PRODUCTS</a>
                            <a href="sliderlist" class="nav-link"><i class="bi bi-image p-2 rounded-circle" style="background-color: lightgray"></i> SLIDERS</a>
                        </div>
                    </div>
                    <!-- Sidebar End -->

                    <!-- Content Start -->
                    <div class="col-10 container-fluid rounded pb-1 px-4" style="background-color: lightgrey">
                        <div class="container rounded bg-white mt-md-2 mt-lg-5 mb-md-2 mb-lg-5 pb-4">
                            <form action="marketingproductdetail" method="post" enctype="multipart/form-data">
                                <div class="row">
                                    <div class="col-12">
                                        <div class="p-3 pt-5 pb-3">
                                            <nav aria-label="breadcrumb">
                                                <ol class="breadcrumb">
                                                    <li class="breadcrumb-item"><a href="marketingproductlist">Product List</a></li>
                                                    <li class="breadcrumb-item active" aria-current="page">Product Details</li>
                                                </ol>
                                            </nav>
                                            <div class="d-flex justify-content-start align-items-center mb-3">
                                                <h2><strong>Product Details</strong></h2>
                                            </div>
                                            <div class="row">
                                                <div class="col-12 border-left border-right">
                                                    <div class="row">
                                                        <div class="col-4">
                                                        <c:set var="p" value="${product}"></c:set>
                                                            <div class="d-flex flex-column align-items-center text-center p-3">
                                                                <img class="rounded-circle my-3" id="preview-thumbnail" style="width: 150px;height: 150px;object-fit: cover" src="${p.thumbnail}" onerror="this.src='images/error-product-image.jpg';this.onerror='';">
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
                                                                <input type="text" class="form-control" name="title" id="title" placeholder="Enter Product Title" value="${p.title}" required>
                                                            </div>
                                                        </div>
                                                        <div class="row mt-3">
                                                            <div class="col-md-12">
                                                                <label class="labels"><strong>Description</strong> <span class="text-danger">(*)</span></label>
                                                                <textarea class="form-control" name="description" id="description" placeholder="Enter Description" required>${p.description}</textarea>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row mt-3">
                                                    <div class="col-md-6">
                                                        <label class="labels"><strong>Quantity</strong> <span class="text-danger">(*)</span></label>
                                                        <input type="number" min="0" class="form-control" name="quantity" id="quantity" placeholder="Enter Quantity" value="${p.quantity}" required>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <label class="labels"><strong>Status</strong> <span class="text-danger">(*)</span></label>
                                                        <select type="text" class="form-control w-100" name="status" id="status" placeholder="Enter Status" value="${p.status}" required>
                                                            <option value="">Status</option>
                                                            <option value="Available" ${p.status eq 'Available' ? 'selected' : ''}>Available</option>
                                                            <option value="Hidden" ${p.status eq 'Hidden' ? 'selected' : ''}>Hidden</option>
                                                            <option value="Out of Stock" ${p.status eq 'Out of Stock' ? 'selected' : ''}>Out of Stock</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-12 border-left border-right">
                                                <div class="row mt-1">
                                                    <div class="col-md-6">
                                                        <label class="labels"><strong>Import Price</strong> <span class="text-danger">(*)</span></label>
                                                        <input class="form-control" type="number" min="0" name="importPrice" value="${p.importPrice}" id="importPrice" placeholder="Enter Import Price" style="max-width: 100%;min-width:100%;" required>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <label class="labels"><strong>List Price</strong> <span class="text-danger">(*)</span></label>
                                                        <input class="form-control" type="number" min="0" name="listPrice" value="${p.listPrice}" id="listPrice" placeholder="Enter List Price" style="max-width: 100%;min-width:100%;" required>
                                                    </div>
                                                </div>
                                                <div class="row mt-3">
                                                    <div class="col-md-6">
                                                        <label class="labels"><strong>Category</strong> <span class="text-danger">(*)</span></label>
                                                        <select class="form-control" type="number" name="category" id="newCategory" style="max-width: 100%;min-width:100%;" required>
                                                            <option value="">Category</option>
                                                            <c:forEach items="${applicationScope.prcategory}" var="prcate">
                                                                <option value="${prcate.id}" ${p.categoryId == prcate.id ? 'selected' : ''}>${prcate.name}</option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                    <div class="col-md-6 d-flex justify-content-start align-items-center">
                                                        <div class="form-check">
                                                            <input type="checkbox" class="form-check-input" name="featured" id="newFeatured" value="Is Featured" ${p.isFeatured ? 'checked' : ''}>
                                                            <label class="form-check-label" for="newFeatured">Is Featured</label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <input name="id" value="${p.id}" hidden>
                            <div class="mt-3 text-center">
                                <button class="btn text-light" type="submit" style="background-color: #b0b435">Update Product</button>
                            </div>
                        </form>
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
        $(document).ready(function () {
            $('#description').summernote({
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
            const quantityInput = document.getElementById('quantity');
            const statusSelect = document.getElementById('status');

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
                    quantityInput.value = ${p.quantity};
                }
            });
        });
    </script>
</body>
</html>
