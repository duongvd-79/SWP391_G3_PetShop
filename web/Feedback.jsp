<%-- Document : Home Created on : Jun 17, 2024, 10:47:53 AM Author : Admin --%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- Mobile Metas -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Site Metas -->
    <title>ThewayShop - Ecommerce Bootstrap 4 HTML Template</title>
    <meta name="keywords" content="">
    <meta name="description" content="">
    <meta name="author" content="">
    <!-- Site Icons -->
    <link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon">
    <link rel="apple-touch-icon" href="images/apple-touch-icon.png">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <!-- Site CSS -->
    <link rel="stylesheet" href="css/style.css">
    <!-- Responsive CSS -->
    <link rel="stylesheet" href="css/responsive.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/custom.css">
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <style>
        /* General Styles */
        body {
            font-family: 'Open Sans', sans-serif;
            color: #333;
            background-color: #f8f9fa;
        }

        .container {
            max-width: 900px;
            margin: 0 auto;
            padding: 20px;
        }

        .text-center {
            text-align: center;
        }

        /* Enhanced Breadcrumb */
        .breadcrumb {
            background-color: #ffffff;
            padding: 10px 20px;
            border-radius: 50px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .breadcrumb-item a {
            color: #007bff;
            text-decoration: none;
        }

        .breadcrumb-item.active {
            color: #555;
        }

        /* Media Object */
        .media img {
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            max-width: 100px;
            height: 100px;
        }

        .media-body h5 {
            color: #007bff;
            margin-top: 0;
        }

        /* Star Rating */
        .star-rating {
            display: inline-flex;
            flex-direction: row-reverse;
        }

        .star-rating input {
            display: none;
        }

        .star-rating label {
            font-size: 2em;
            color: #ddd;
            cursor: pointer;
        }

        .star-rating input:checked~label,
        .star-rating input:checked~label~label {
            color: orange;
        }

        .star-rating label:hover,
        .star-rating label:hover~label {
            color: orange;
        }

        /* Form Styles */
        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            font-weight: bold;
        }

        .form-control {
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            border: 1px solid #ced4da;
        }

        .form-control:focus {
            border-color: #80bdff;
            box-shadow: 0 0 10px rgba(0, 123, 255, 0.25);
        }

        .form-control-file {
            display: block;
            width: 100%;
            border: none;
            padding: 5px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        /* Image Preview */
        .image-preview {
            display: flex;
            flex-wrap: wrap;
            margin-top: 15px;
            justify-content: center;
        }

        .image-preview .preview-container {
            position: relative;
            margin: 10px;
        }

        .image-preview .preview-container img {
            max-width: 100px;
            border-radius: 10px;
            border: 1px solid #ddd;
            padding: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .image-preview .remove-image {
            position: absolute;
            top: 5px;
            right: 5px;
            background-color: rgba(255, 255, 255, 0.8);
            padding: 2px 5px;
            border-radius: 50%;
            cursor: pointer;
            color: #ff0000;
            font-weight: bold;
        }

        /* Buttons */
        .submit-buttons {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 20px;
        }

        .btn {
            border-radius: 50px;
            padding: 10px 20px;
            font-size: 1rem;
            font-weight: bold;
            text-transform: uppercase;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            transition: all 0.2s;
        }

        .btn-secondary {
            background-color: #6c757d;
            border-color: #6c757d;
        }

        .btn-secondary:hover {
            background-color: #5a6268;
            border-color: #545b62;
        }

        .btn-danger {
            background-color: #dc3545;
            border-color: #dc3545;
        }

        .btn-danger:hover {
            background-color: #c82333;
            border-color: #bd2130;
        }

        .product-info {
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 15px;
            background-color: #fff;
            margin-bottom: 20px;
        }

        .product-info .media-body h5 {
            color: #000;
            margin-top: 0;
        }
    </style>
</head>

<body>
    <!-- Start Main Top -->
    <jsp:include page="header.jsp"></jsp:include>
    <!-- End Main Top -->
    <!-- Start All Title Box -->
    <div class="all-title-box">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <ul class="breadcrumb">
                        <li class="breadcrumb-item"><a href="#">My order</a></li>
                        <li class="breadcrumb-item active"> Feedback </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <!-- End All Title Box -->
    <!-- Start Feedback Form -->
    <div class="container mt-5">
        <h2 class="text-center">Product Feedback</h2>
        <form id="feedbackForm" action="addfeedback" method="post" enctype="multipart/form-data">
            <div class="media mb-3 product-info">
                <img src="${requestScope.product.thumbnail}" class="mr-3" alt="Product Image">
                <div class="media-body">
                    <h5 class="mt-0">${requestScope.product.title}</h5>
                    <p>Price: ${requestScope.product.listPrice}00vnd ${requestScope.product.id}</p>
                    <!-- Hidden field to include the title in the form submission -->
                    <input type="hidden" name="pid" value="${requestScope.product.id}"/>
                </div>
            </div>
            <div class="form-group">               
                <label>Product Quality: </label><br>
                <div class="star-rating">
                    <input type="radio" id="star5" name="rating" value="5">
                    <label for="star5" class="fa fa-star"></label>
                    <input type="radio" id="star4" name="rating" value="4">
                    <label for="star4" class="fa fa-star"></label>
                    <input type="radio" id="star3" name="rating" value="3">
                    <label for="star3" class="fa fa-star"></label>
                    <input type="radio" id="star2" name="rating" value="2">
                    <label for="star2" class="fa fa-star"></label>
                    <input type="radio" id="star1" name="rating" value="1">
                    <label for="star1" class="fa fa-star"></label>
                </div>
                <div id="rating-text"></div>
            </div>
            <div class="form-group">
                <label for="detail">Review feedback:</label>
                <textarea class="form-control" name="detail" id="detail" rows="5"
                    placeholder="Let's share something you like about our product to other customers"></textarea>
            </div>
            <div class="form-group">
                <label for="images">Upload image: </label>
                <div class="custom-file">
                    <input type="file" class="custom-file-input" id="images" name="images" multiple>
                    <label class="custom-file-label" for="images">Choose file</label>
                </div>
            </div>
            <div class="image-preview" id="imagePreview"></div>
            <div class="submit-buttons mt-3">
                <button type="button" class="btn btn-secondary">Back</button>
                <button type="submit" class="btn btn-danger" value="Submit">Submit</button>
            </div>
        </form>
    </div>
    <!-- End Feedback Form -->
    <!-- Start Footer  -->
    <jsp:include page="footer.jsp"></jsp:include>
    <!-- End Footer  -->
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
         document.getElementById('images').addEventListener('change', function () {
            const imagePreview = document.getElementById('imagePreview');

            // Loop through each selected file
            for (let file of this.files) {
                const reader = new FileReader();
                // Closure to capture the file information
                reader.onload = function (e) {
                    const img = document.createElement('img');
                    img.src = e.target.result;
                    img.classList.add('preview-image'); // Optional: Add class for styling

                    const previewContainer = document.createElement('div');
                    previewContainer.classList.add('preview-container');
                    previewContainer.appendChild(img);

                    const removeBtn = document.createElement('span');
                    removeBtn.classList.add('remove-image');
                    removeBtn.innerHTML = '&times;';
                    removeBtn.addEventListener('click', function () {
                        previewContainer.remove(); // Remove container on click
                    });
                    previewContainer.appendChild(removeBtn);

                    imagePreview.appendChild(previewContainer); // Append preview container to imagePreview
                };

                // Read the image file as a data URL
                reader.readAsDataURL(file);
            }
        });

        // Handle star rating change
        document.addEventListener('DOMContentLoaded', function () {
            const starInputs = document.querySelectorAll('.star-rating input');
            const ratingText = document.getElementById('rating-text');
            starInputs.forEach(input => {
                input.addEventListener('change', function () {
                    switch (parseInt(this.value)) {
                        case 1:
                            ratingText.textContent = 'Tệ';
                            ratingText.classList.remove('text-success', 'text-warning');
                            ratingText.classList.add('text-danger');
                            break;
                        case 2:
                            ratingText.textContent = 'Khá tệ';
                            ratingText.classList.remove('text-success', 'text-warning');
                            ratingText.classList.add('text-danger');
                            break;
                        case 3:
                            ratingText.textContent = 'Tạm ổn';
                            ratingText.classList.remove('text-success', 'text-danger');
                            ratingText.classList.add('text-warning');
                            break;
                        case 4:
                            ratingText.textContent = 'Tốt';
                            ratingText.classList.remove('text-danger', 'text-warning');
                            ratingText.classList.add('text-success');
                            break;
                        case 5:
                            ratingText.textContent = 'Tuyệt vời';
                            ratingText.classList.remove('text-danger', 'text-warning');
                            ratingText.classList.add('text-success');
                            break;
                        default:
                            ratingText.textContent = 'Chưa đánh giá';
                            ratingText.classList.remove('text-danger', 'text-warning', 'text-success');
                    }
                });
            });
        });
        document.addEventListener('DOMContentLoaded', function () {
            const form = document.getElementById('feedbackForm');
            form.addEventListener('submit', function (event) {
                event.preventDefault(); // Ngăn chặn hành động mặc định của form (tải lại trang)
                // Kiểm tra xem có input radio nào được chọn hay không
                const ratingInputs = document.querySelectorAll('.star-rating input');
                let ratingSelected = false;
                ratingInputs.forEach(input => {
                    if (input.checked) {
                        ratingSelected = true;
                    }
                });
                if (!ratingSelected) {
                    alert('Vui lòng chọn số sao đánh giá trước khi gửi!');
                    return; // Ngăn không cho form submit
                }
                // Nếu có rating được chọn, tiếp tục xử lý form (ở đây có thể gửi dữ liệu lên server)
                form.submit(); // Uncomment để gửi form thật sự sau khi validate
            });
        });
    </script>
</body>

</html>
