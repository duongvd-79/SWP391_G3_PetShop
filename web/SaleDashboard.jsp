<%-- 
    Document   : admindashboard
    Created on : Jun 11, 2024, 12:27:50 AM
    Author     : ACER
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

        <!-- Customized Bootstrap Stylesheet -->
        <link href="css/bootstrap.min.css" rel="stylesheet">

        <!-- Template Stylesheet -->
        <link href="css/style.css" rel="stylesheet">
        <!-- Toastr -->
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css">
        <style>
            #search-form{
                display:none !important;
            }
        </style>
        <link href="css/admin.css" rel="stylesheet">
        <title>Sale DASHBOARD</title>
    </head>
    <jsp:include page="header.jsp"></jsp:include> 

        <body>
            <div class="container-fluid position-relative bg-white d-flex p-0 ">
                <div class="row">
                <!-- Sidebar Start -->
                <div style="z-index: 2;background-color: transparent;position: relative;" class="col-2 sidebar pe pb-3 shadow-sm">
                    <div style="top:130px;" class="w-100 mb-1 sticky-top">
                        <div class="navbar-nav w-100 mb-1">
                            <a href="SaleDashboard" class="nav-item nav-link active"><i class="fa fa-tachometer-alt me-2"></i>SALE DASHBOARD</a>
                             <a href="orderslist" class="nav-item nav-link "><i class="fas fa-file-alt me-2"></i>ORDERS LIST</a>
                        </div>
                    </div>
                </div>
                <!-- Sidebar End -->
                <!-- Content Start -->
                    <div class="col-10 container-fluid rounded bg-white mt-4 mb-5 px-3">
                        <div class="row">
                            <div class="card col-sm-3 p-0">
                                <div class="bg-danger rounded-top" style="height: 12px;"></div> 
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col mt-0">
                                            <h3 class="card-title fw-bolder">REVENUES</h3>
                                        </div>
                                    </div>
                                    <h1 class="mt-1 mb-3">${revenues}</h1>
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
                                            <td><i class="fas fa-circle text-primary fa-fw"></i> Submitted</td>
                                            <td class="text-end">${orderList.get(1)}</td>
                                        </tr>
                                        <tr>
                                            <td><i class="fas fa-circle text-danger fa-fw"></i> Cancelled</td>
                                            <td class="text-end">${orderList.get(2)}</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="col-lg-12 mt-3 ps-0">
                            <div class="card">
                                <div class="position-relative w-25 right-0 mt-2 ms-2">
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
                            labels: ["Success", "Submitted", "Cancelled"],
                            datasets: [{
                                    data: data,
                                    backgroundColor: [
                                        '#28a745', // Success color
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
                                    text: 'ORDER STATUS FOR LAST 7 DAYS',

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
                var dayReport = [];
                <c:forEach items="${requestScope.monthlyRevenueList}" var="val" varStatus="loop">
                revenues.push(${val});
                </c:forEach>
                <c:forEach items="${requestScope.dayReport}" var="val" varStatus="loop">
                dayReport.push(${val});
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
                            labels: dayReport,
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
            <script>
                document.addEventListener('DOMContentLoaded', () => {
                    const averageRating = 3.7;
                    const widthPercentage = (averageRating / 5) * 100;
                    const starRatingElement = document.getElementById('starRating');
                    ng
                    starRatingElement.style.setProperty('--rating-width', `${widthPercentage}%`);
                    starRatingElement.style.width = `${widthPercentage}%`;
                });
            </script>
    </body>
</html>
