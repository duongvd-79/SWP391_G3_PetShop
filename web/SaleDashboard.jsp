<%-- 
    Document   : SaleDashboard
    Created on : Jun 17, 2024, 12:32:30 AM
    Author     : Acer
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sales Dashboard</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 0;
            }

            .dashboard-container {
                width: 80%;
                margin: auto;
                padding: 20px;
                background-color: #fff;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                border-radius: 8px;
            }

            h1 {
                text-align: center;
                color: #333;
            }

            .filters {
                display: flex;
                justify-content: space-between;
                margin-bottom: 20px;
            }

            .filters label {
                margin-right: 10px;
                color: #333;
            }

            .filters .form-control {
                margin-right: 20px;
                padding: 5px;
                border-radius: 4px;
                border: 1px solid #ccc;
            }

            .filters .btn {
                padding: 10px 20px;
                background-color: #007bff;
                color: #fff;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }

            .filters .btn:hover {
                background-color: #0056b3;
            }

            .charts {
                display: flex;
                flex-wrap: wrap;
                justify-content: space-between;
            }

            .chart {
                width: 48%;
                margin-bottom: 20px;
            }

            .chart h2 {
                text-align: center;
                color: #333;
            }

        </style>
    </head>
    <body>
        <div class="dashboard-container">
            <h1>Sales Dashboard</h1>
            <div class="filters">
                <label for="start-date">Start Date:</label>
                <input type="date" id="start-date" class="form-control">

                <label for="end-date">End Date:</label>
                <input type="date" id="end-date" class="form-control">

                <label for="sales-person">Sales Person:</label>
                <select id="sales-person" class="form-control">
                    <option value="all">All</option>
                    <!-- Add options dynamically based on available salespersons -->
                </select>

                <label for="order-status">Order Status:</label>
                <select id="order-status" class="form-control">
                    <option value="all">All</option>
                    <option value="success">Success</option>
                    <option value="pending">Pending</option>
                    <option value="failed">Failed</option>
                </select>

                <button id="filter-button" class="btn">Filter</button>
            </div>

            <div class="charts">
                <div class="chart">
                    <h2>Success/Total Orders Trend</h2>
                    <canvas id="ordersTrendChart"></canvas>
                </div>
                <div class="chart">
                    <h2>Revenue Trends</h2>
                    <canvas id="revenueTrendChart"></canvas>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script>
            document.getElementById('filter-button').addEventListener('click', function () {
                const startDate = document.getElementById('start-date').value;
                const endDate = document.getElementById('end-date').value;
                const salesPerson = document.getElementById('sales-person').value;
                const orderStatus = document.getElementById('order-status').value;

                // Fetch data based on filters (startDate, endDate, salesPerson, orderStatus)
                fetchDataAndRenderCharts(startDate, endDate, salesPerson, orderStatus);
            });

            function fetchDataAndRenderCharts(startDate, endDate, salesPerson, orderStatus) {
                fetch(`dataServlet?startDate=${startDate}&endDate=${endDate}&salesPerson=${salesPerson}&orderStatus=${orderStatus}`)
                        .then(response => response.json())
                        .then(data => {
                            renderChart('ordersTrendChart', data.ordersTrend);
                            renderChart('revenueTrendChart', data.revenueTrend);
                        })
                        .catch(error => console.error('Error fetching data:', error));
            }

            function renderChart(canvasId, data) {
                const ctx = document.getElementById(canvasId).getContext('2d');
                new Chart(ctx, {
                    type: 'line',
                    data: data,
                    options: {
                        scales: {
                            y: {
                                beginAtZero: true
                            }
                        }
                    }
                });
            }

// Initial render with default data
            fetchDataAndRenderCharts(null, null, 'all', 'all');

        </script>
    </body>
</html>
