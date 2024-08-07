<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="model.User"%>
<!DOCTYPE html>
<html>
    <head>
        <meta content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>PetShop Blog List</title>

        <link rel="shortcut icon" href="images/icon.ico" type="image/x-icon">
        <link rel="apple-touch-icon" href="images/apple-touch-icon.png">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <!-- Icon CSS -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <!-- Site CSS -->
        <link rel="stylesheet" href="css/style.css">
        <!-- Responsive CSS -->
        <link rel="stylesheet" href="css/responsive.css">
        <!-- Custom CSS -->
        <link rel="stylesheet" href="css/custom.css">
        <style>
            .ellipsis-text {
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
                max-width: 100%; /* Adjust this value to limit the width as needed */
            }
            .search-container form {
                display: flex;
                align-items: center;
            }

            .search-container label {
                margin-right: 10px;
            }

            .search-container input[type="text"] {
                margin-right: 10px;
            }

            .search-container div {
                display: flex;
                align-items: center;
                margin-right: 10px;
            }

            .search-container h4 {
                margin: 0;
                margin-right: 5px;
            }

            .search-container select {
                margin-right: 10px;
            }

            .search-container button {
                margin-left: auto;
                .search-container {
                    max-width: 600px;
                    margin-left: 15px;
                    padding: 20px;
                    background-color: #fff;
                    box-shadow: 0 0 10px rgba(0,0,0,0.1);
                    border-radius: 8px;
                }
                .search-container h2 {
                    text-align: center;
                    margin-bottom: 20px;
                }
                .search-box {
                    display: flex;
                }
                .search-box input[type="text"] {
                    flex: 1;
                    padding: 10px;
                    border: 1px solid #ccc;
                    border-radius: 4px 0 0 4px;
                    font-size: 16px;
                }
                .search-box button {
                    padding: 10px;
                    background-color: #28a745;
                    border: none;
                    border-radius: 0 4px 4px 0;
                    color: #fff;
                    font-size: 16px;
                    cursor: pointer;
                }
                .search-box button:hover {
                    background-color: #218838;
                }
                .blog-content {
                    padding: 20px;
                }
                input[type="date"] {
                padding: 10px;
                margin: 10px 0;
                border: 2px solid #ccc;
                border-radius: 5px;
                font-size: 16px;
            }
            input[type="date"]:focus {
                border-color: #66afe9;
                outline: none;
                box-shadow: 0 0 5px rgba(102, 175, 233, 0.6);
            }
            </style>
        </head>
        <body>
            <jsp:include page="header.jsp"></jsp:include>
                <!-- Start Top Search -->
                <div class="top-search">
                    <div class="container">
                        <div class="input-group">
                            <span class="input-group-addon"><i class="fa fa-search"></i></span>
                            <input type="text" class="form-control" placeholder="Search">
                            <span class="input-group-addon close-search"><i class="fa fa-times"></i></span>
                        </div>
                    </div>
                </div>

                <!-- End Top Search -->

                <div class="latest-blog">
                    <div class="container">
                        <div class="row">
                            <div class="search-container">
                                <form action="bloglist" method="GET">
                                    <label>Từ khóa</label>
                                    <input type="text" name="search" placeholder="Search...">
                                    <div>
                                        <h4>Thể loại</h4>  
                                        <select name="categoryID" id="categorySelect">
                                            <option value="">All</option>
                                        <c:forEach items="${listC}" var="category">
                                            <option value="${category.id}">${category.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div>
                                    <label for="startDate">From:</label>
                                    <input type="date" id="startDate" name="startDate">
                                    <label for="endDate">To:</label>
                                    <input type="date" id="endDate" name="endDate">
                                </div>    
                                <button type="submit">Search</button>
                            </form>
                        </div>
                        <div class="col-lg-12">
                            <div class="title-all text-center">
                                <h1>All posts</h1>
                            </div>
                        </div>
                    </div>
                    <div id="posts-container" class="row">
                        <!-- Placeholder for dynamically rendered posts -->
                    </div>
                </div>
                <nav aria-label="Page navigation example">
                    <ul class="pagination" style="margin-left: 67%;" id="pagination-controls">
                        <!-- Placeholder for pagination controls -->
                    </ul>
                </nav>
            </div>
            <script type="text/javascript">
                document.addEventListener("DOMContentLoaded", function () {
                    // Sample data from the server (Replace this with actual server data)
                    const posts = [
                <c:forEach var="p" items="${listp}">
                        {
                            id: "${p.id}",
                            thumbnail: "${p.thumbnail}",
                            title: "${p.title}",
                            user: "${p.user.name}",
                            createdDate: "${p.createdDate}"
                        },
                </c:forEach>
                    ];

                    const postsPerPage = 6; // Number of posts per page
                    let currentPage = 1;

                    function renderPosts(page) {
                        const start = (page - 1) * postsPerPage;
                        const end = start + postsPerPage;
                        const paginatedPosts = posts.slice(start, end);

                        const postsContainer = document.getElementById("posts-container");
                        postsContainer.innerHTML = "";
                        paginatedPosts.forEach((post) => {
                            let image = "";
                            if (post.thumbnail.startsWith("https")) {
                                image = post.thumbnail;
                            } else {
                                image = "./images/" + post.thumbnail;
                            }
                            const postElement = document.createElement("div");
                            postElement.className = "col-md-6 col-lg-4 col-xl-4";
                            postElement.innerHTML = `
                                <div class="blog-box">
                                    <div class="blog-img">
                                        <img height="290px" width="320px" src="` + image + `" alt="" />
                                    </div>
                                    <div class="blog-content">
                                        <div class="title-blog">
                                            <a href="blogdetail?id=` + post.id + `" title="` + post.title + `" class="image-resize ratiobox">
                                                <p class="ellipsis-text" style="font-weight: bold">` + post.title + `</p>
                                            </a>
                                        </div>
                                        <div class="mr-3 d-flex align-items-center">
                                            <p class="mb-0"><i class="bi bi-person-circle"></i> ` + post.user + `</p>
                                        </div>
                                        <div class="d-flex align-items-center">
                                            <p class="mb-0"><i class="bi bi-calendar-week"></i> ` + post.createdDate + `</p>
                                        </div>
                                        <a href="blogdetail?id=` + post.id + `" class="btn btn-secondary">Đọc tiếp</a>
                                    </div>
                                </div>
                            `;
                            postsContainer.appendChild(postElement);
                        });
                    }

                    function renderPagination() {
                        const pageCount = Math.ceil(posts.length / postsPerPage);
                        const paginationControls = document.getElementById("pagination-controls");
                        paginationControls.innerHTML = "";

                        if (currentPage > 1) {
                            const prevPageItem = document.createElement("li");
                            prevPageItem.className = "page-item";
                            prevPageItem.innerHTML = `<a class="page-link" href="#">Previous</a>`;
                            prevPageItem.addEventListener("click", function (e) {
                                e.preventDefault();
                                currentPage--;
                                renderPosts(currentPage);
                                renderPagination();
                            });
                            paginationControls.appendChild(prevPageItem);
                        }

                        for (let i = 1; i <= pageCount; i++) {
                            const pageItem = document.createElement("li");
                            let status = i === currentPage ? 'active' : '';
                            pageItem.className = `page-item ` + status;
                            pageItem.innerHTML = `<a class="page-link" href="#">` + i + `</a>`;
                            pageItem.addEventListener("click", function (e) {
                                e.preventDefault();
                                currentPage = i;
                                renderPosts(currentPage);
                                renderPagination();
                            });
                            paginationControls.appendChild(pageItem);
                        }

                        if (currentPage < pageCount) {
                            const nextPageItem = document.createElement("li");
                            nextPageItem.className = "page-item";
                            nextPageItem.innerHTML = `<a class="page-link" href="#">Next</a>`;
                            nextPageItem.addEventListener("click", function (e) {
                                e.preventDefault();
                                currentPage++;
                                renderPosts(currentPage);
                                renderPagination();
                            });
                            paginationControls.appendChild(nextPageItem);
                        }
                    }

                    // Initial render
                    renderPosts(currentPage);
                    renderPagination();
                });
                document.getElementById('categorySelect').addEventListener('change', function () {
                    if (this.value == "0") {
                        window.location.href = '/bloglist';
                    }
                });

            </script>
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
        </body>
    </html>
