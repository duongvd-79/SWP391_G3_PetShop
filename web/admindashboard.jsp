<%-- 
    Document   : admindashboard
    Created on : Jun 11, 2024, 12:27:50 AM
    Author     : ACER
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
        <style>
            #search-form{
                display:none !important;
            }
        </style>
        <title>ADMIN DASHBOARD</title>
    </head>
    <jsp:include page="header.jsp"></jsp:include>
        <body>
            <div class="container-fluid position-relative bg-white d-flex p-0 ">
                <div class="row">

                    <!-- Sidebar Start -->
                    <div style="z-index: 2;background-color: transparent;position: relative;" class="col-2 sidebar pe pb-3 shadow-sm">
                        <div style="top:130px;" class="w-100 mb-1 sticky-top">
                            <a href="#" class="nav-link active"><i class="fa fa-tachometer-alt me-2"></i>DASHBOARD</a>
                            <a href="setting" class="nav-link"><i class="bi bi-gear-fill me-2"></i>SETTING</a>
                            <a href="userlist" class="nav-link"><i class="bi bi-people-fill me-2"></i>USER LIST</a>
                        </div>
                    </div>
                    <!-- Sidebar End -->


                    <!-- Content Start -->
                    <div class="col-10 container-fluid rounded bg-white mt-4 mb-5 px-3">
                        <div class="row px-3">
                            <div class="row">
                                <div class="col-3 mb-3">
                                <c:set var="compareinterval" value="${requestScope.start} - ${requestScope.end}" />
                                <select id="date-range" class="form-select">
                                    <option value="ALL TIME" ${interval == 'ALL TIME'? 'selected':''}>All Time</option>
                                    <option value="LAST 7 DAYS" ${interval == 'LAST 7 DAYS'? 'selected':''}>Last 7 Days</option>
                                    <option value="LAST 30 DAYS" ${interval == 'LAST 30 DAYS'? 'selected':''}>Last 30 Days</option>
                                    <option value="others" ${interval == compareinterval? 'selected':''}>Others</option>
                                </select>
                            </div>
                            <div class="col-3 mb-3">
                                <select id="product-category" class="form-select">
                                    <option value="">All Category</option>
                                    <c:forEach var="category" items="${pCategoryList}">
                                        <c:if test="${pcategory == category.getId()}">
                                            <c:set var="pname" value="${category.getName()}"></c:set>
                                        </c:if>
                                        <option ${pcategory == category.getId()? 'selected':''} value="${category.getId()}">${category.getName()}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-1 mb-3">
                                <a href="admindashboard" style="height:47px;color:white;width: 76.75px;" class="btn btn-primary d-flex justify-content-center align-items-center">Clear</a>
                            </div>

                            <form style="display:none;" id="custom-date-range" class="row float-right" action="admindashboard" method="get">
                                <div style="padding-right: 5px;" class="col-3 mb-3">
                                    <label for="start-date" class="form-label ms-1">Start Date</label>
                                    <input type="date" name="start" id="start-date" class="form-control" required="">
                                </div>
                                <div style="padding-right: 5px;margin-left: 7px;" class="col-3 mb-3">
                                    <label for="end-date" class="form-label ms-1">End Date</label>
                                    <input type="date" name="end" id="end-date" class="form-control" required="">
                                </div>
                                <div class="col-2 position-relative mb-3">
                                    <button type="submit" style="height:47px;margin-left: 6px;" id="submit-button" class=" btn btn-primary position-absolute bottom-0">Submit</button>
                                </div>
                            </form>
                        </div>
                        <div class="card col-sm-3 p-0">
                            <div class="bg-danger rounded-top" style="height: 12px;"></div> 
                            <div class="card-body">
                                <div class="row">
                                    <div class="col mt-0">
                                        <h3 class="card-title fw-bolder">REVENUES</h3>
                                    </div>
                                </div>
                                <c:set var="formattedPrice">
                                    <fmt:formatNumber value="${revenues * 1000}" type="number" groupingUsed="true" minFractionDigits="0" maxFractionDigits="0"/>
                                </c:set>
                                <h1 class="mt-1 mb-3">${formattedPrice} đ</h1>
                                <span class="h6 text-uppercase">${interval}&emsp;${pname}</span>
                            </div>

                        </div>
                        <div class="card col-sm-3 p-0">
                            <div class="bg-info rounded-top" style="height: 12px;"></div> 
                            <div class="card-body">
                                <div class="row">
                                    <div class="col mt-0">
                                        <h3 class="card-title fw-bolder">ORDERS</h3>
                                    </div>
                                </div>
                                <h1 class="mt-1 mb-3">${numOfOrders}</h1>
                                <span class="h6">${interval}</span>
                            </div>
                        </div>

                        <div class="card col-sm-3 p-0">
                            <div class="bg-warning rounded-top" style="height: 12px;"></div> 
                            <div class="card-body">
                                <div class="row">
                                    <div class="col mt-0">
                                        <h3 class="card-title fw-bolder">CUSTOMERS</h3>
                                    </div>
                                </div>
                                <h1 class="mt-1 mb-3">${numOfCustomers}</h1>
                                <span class="h6">${interval}</span>
                            </div>
                        </div>
                        <div class="card col-sm-3 p-0">
                            <div style="background-color: #ff00ff;height: 12px;" class="rounded-top"></div> 
                            <div class="card-body">
                                <div class="row">
                                    <div class="col mt-0">
                                        <h3 class="card-title fw-bolder">FEEKBACKS</h3>
                                    </div> 
                                </div>
                                <h1 class="mt-1 mb-3">${numOfFb} &emsp;&emsp;Rating:${avgRating}</h1>
                                <span class="h6 text-uppercase d-block">${interval}&emsp;${pname}</span>

                            </div>
                        </div>
                        <!--customer--> 
                        <div class="col-12 col-lg-6 d-flex p-0 mt-3">
                            <div class="card w-100">
                                <div class="card-header d-flex justify-content-between align-items-center bg-warning text-white">
                                    <span class="card-title ms-2 h5 mb-0">New Customer</span>
                                </div>
                                <c:forEach items="${newCustomers}" var="c">
                                    <a href="userdetails?id=${c.getId()}" style="height: 97px;" class="d-flex align-items-center mb-2">
                                        <div class="ms-4">
                                            <img src="https://upload.wikimedia.org/wikipedia/commons/2/2c/Default_pfp.svg" class="rounded-circle" alt="User Image" style="width: 40px; height: 40px;">
                                        </div>
                                        <div class=" ms-3">
                                            <p class="mb-0">${c.getName()}</p>
                                            <p>Recently online: ${c.getLastLog()}</p>
                                        </div>
                                    </a>
                                </c:forEach>

                            </div>
                            <div class="card w-100">
                                <div class="card-header d-flex justify-content-between align-items-center bg-warning text-white">
                                    <span class="card-title ms-2 h5 mb-0">Newly Buy Customer</span>
                                </div>
                                <c:forEach items="${newlyBuyCustomers}" var="c">
                                    <a href="userdetails?id=${c.getId()}" style="height: 97px;" class="d-flex align-items-center mb-2">
                                        <div class="ms-4">
                                            <img src="https://upload.wikimedia.org/wikipedia/commons/2/2c/Default_pfp.svg" class="rounded-circle" alt="User Image" style="width: 40px; height: 40px;">
                                        </div>
                                        <div class=" ms-3">
                                            <p class="mb-0">${c.getName()}</p>
                                            <p>Recently online: ${c.getLastLog()}</p>
                                        </div>
                                    </a>
                                </c:forEach>

                            </div>
                        </div>
                        <div class="col-12 col-lg-6 d-flex py-0">
                            <div class="align-self-center w-100">
                                <div class="py-3">
                                    <div class="chart">
                                        <canvas id="orderstatuschart"></canvas>
                                    </div>
                                </div>
                                <table class="table mb-0">
                                    <tbody>
                                        <tr>
                                            <td><i class="fas fa-circle text-success fa-fw"></i> Success</td>
                                            <td class="text-end ">${orderList.get(0)}</td>
                                        </tr>
                                        <tr>
                                            <td><i style="color:#17a2b8;" class="fas fa-circle fa-fw"></i> Confirmed</td>
                                            <td class="text-end ">${orderList.get(1)}</td>
                                        </tr>
                                        <tr>
                                            <td><i style="color:#ffc107;" class="fas fa-circle fa-fw"></i> Shipping</td>
                                            <td class="text-end ">${orderList.get(2)}</td>
                                        </tr>
                                        <tr>
                                            <td><i class="fas fa-circle text-primary fa-fw"></i> Submitted</td>
                                            <td class="text-end">${orderList.get(3)}</td>
                                        </tr>
                                        <tr>
                                            <td><i class="fas fa-circle text-danger fa-fw"></i> Cancelled</td>
                                            <td class="text-end">${orderList.get(4)}</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="col-lg-12 mt-3 ps-0">
                            <div class="card">
                                <div class="position-relative w-25 right-0 mt-2 ms-2">
                                    <select id="year-choose" class="form-select">
                                        <c:forEach begin="2024" end="${2024+(curyear-2024)}" step="1" var="y">
                                            <option value="${y}" ${(requestScope.year == y) ? 'selected':''}>${y}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="card-body">
                                    <div class="chart">
                                        <canvas height="400" id="chartjs-bar"></canvas>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div> 
                <jsp:include page="footer.jsp"></jsp:include>  
                </div>
            </div>

            <!-- Content End -->

            <!-- JavaScript Libraries -->
            <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
            <!--<script src="lib/chart/chart.min.js"></script>-->
            <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
            <script src="lib/easing/easing.min.js"></script>
            <script src="lib/owlcarousel/owl.carousel.min.js"></script>
            <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>
            <!-- Template Javascript -->
            <script src="js/admin.js"></script>
            <script>
                var data = [];
            <c:forEach items="${requestScope.orderList}" var="val" varStatus="loop">
                data.push(${val});
            </c:forEach>
                document.addEventListener("DOMContentLoaded", function () {
                    // Doughnut chart
                    new Chart(document.getElementById("orderstatuschart"), {
                        type: "doughnut",
                        data: {
                            labels: ["Success", "Confirmed", "Shipping", "Submitted", "Cancelled"],
                            datasets: [{
                                    data: data,
                                    backgroundColor: [
                                        '#28a745', // Success color
                                        '#17a2b8',
                                        '#ffc107',
                                        '#007bff', // Primary color
                                        '#dc3545', // Danger color
                                    ],
                                    borderWidth: 5,
                                    borderColor: '#ffffff' // Use white color directly
                                }]
                        },
                        options: {
                            responsive: true,
                            maintainAspectRatio: false,
                            plugins: {
                                legend: {
                                    display: false
                                },
                                title: {
                                    display: true,
                                    text: 'ORDER STATUS FOR ${interval}',

                                    font: {
                                        size: 18
                                    },
                                    color: '#5bc0de'
                                }
                            },
                            cutout: '70%' // Cutout percentage for doughnut chart
                        }
                    });
                });


        </script>
        <script>
            var revenues = [];
            var profits = [];
            <c:forEach items="${requestScope.monthlyRevenueList}" var="val" varStatus="loop">
            revenues.push(${val});
            </c:forEach>
            <c:forEach items="${requestScope.monthlyProfitList}" var="val" varStatus="loop">
            profits.push(${val});
            </c:forEach>
            document.addEventListener("DOMContentLoaded", function () {
                // Define window.theme if not already defined
                window.theme = window.theme || {};
                window.theme.color = window.theme.color || 'rgba(75, 192, 192, 1)';

                // Bar chart
                new Chart(document.getElementById("chartjs-bar"), {
                    type: "bar",
                    data: {
                        labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
                        datasets: [{
                                label: "Revenue",
                                backgroundColor: '#007bff',
                                borderColor: '#007bff',
                                hoverBackgroundColor: '#007bff',
                                hoverBorderColor: '#007bff',
                                data: revenues,
                                barPercentage: .75,
                                categoryPercentage: .5
                            }, {
                                label: "Profit",
                                backgroundColor: '#28a745',
                                borderColor: '#28a745',
                                hoverBackgroundColor: '#28a745',
                                hoverBorderColor: '#28a745',
                                data: profits,
                                barPercentage: .75,
                                categoryPercentage: .5
                            }]
                    },
                    options: {
                        maintainAspectRatio: false,
                        legend: {
                            display: true
                        },
                        scales: {
                            yAxes: [{
                                    gridLines: {
                                        display: false
                                    },
                                    stacked: false,
                                    ticks: {
                                        stepSize: 0
                                    }
                                }],
                            xAxes: [{
                                    barPercentage: 1.0,
                                    stacked: false,
                                    gridLines: {
                                        color: "transparent"
                                    }
                                }]
                        }
                    }
                });
            });
        </script>
        <script>
            document.getElementById('date-range').addEventListener('change', function () {
                const customDateRange = document.getElementById('custom-date-range');
                if (this.value === 'others') {
                    customDateRange.style.display = 'flex';
                } else {
                    customDateRange.style.display = 'none';
                    window.location = "admindashboard?interval=" + this.value + "&pcategory=" + '${pcategory}';
                }
            });
            document.getElementById('date-range').addEventListener('click', function () {
                const customDateRange = document.getElementById('custom-date-range');
                if (this.value === 'others') {
                    customDateRange.style.display = 'flex';
                }
            });

        </script>
        <script>
            document.getElementById('product-category').addEventListener('change', function () {
                if ('${start}' === 'null' || '${start}' === '') {
                    window.location = "admindashboard?interval=" + '${interval}' + "&pcategory=" + this.value;
                } else {
                    window.location = "admindashboard?start=" + '${start}' + "&end=" + '${end}' + "&pcategory=" + this.value;
                }

            });
        </script>

        <script>
            document.getElementById('custom-date-range').addEventListener('submit', function (event) {
                const startDate = document.getElementById('start-date').value;
                const endDate = document.getElementById('end-date').value;

                if (startDate >= endDate) {
                    event.preventDefault();
                    toastr.options.progressBar = true;
                    toastr.warning('Start date must be before end date');
                }
            });
        </script>
        <script>
            document.getElementById('year-choose').addEventListener('change', function () {
                const customDateRange = document.getElementById('custom-date-range');
                customDateRange.style.display = 'none';
                window.location = "admindashboard?interval=" + '${interval}' + "&pcategory=" + '${pcategory}' + "&year=" + this.value;
            });
        </script>
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
