<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>History</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular.min.js"></script>
</head>
<body ng-app="myApp" ng-controller="myController">
<div class="container">
    <h2>Activity Logs</h2>
    <div class="row">
        <div class="col-md-4">
            <label for="startDate" class="form-label">From:</label>
            <input type="date" id="startDate" class="form-control" ng-model="startDate" ng-change="filterByDateRange()">
        </div>
        <div class="col-md-4">
            <label for="endDate" class="form-label">To:</label>
            <input type="date" id="endDate" class="form-control" ng-model="endDate" ng-change="filterByDateRange()">
        </div>
    </div>
    <table class="table mt-3">
        <thead>
        <tr>
            <th>Ngày Giờ</th>
            <th>Hành Động</th>
            <th>Nhân Viên</th>
            <th>Mã Nhân Viên</th>
            <th>Chi tiết</th>
            <th>Hóa Đơn Thao tác</th>
        </tr>
        </thead>
        <tbody>
        <tr ng-repeat="log in activityLogs">
            <td>{{log.timestamp }}</td>
            <td>{{log.action}}</td>
            <td>{{log.staff.fullName}}</td>
            <td>{{log.staff.code}}</td>
            <td>{{log.details}}</td>
            <td>{{log.order.id}}</td>
        </tr>
        </tbody>
    </table>
    <ul class="pagination">
        <li class="page-item" ng-class="{disabled: currentPage === 1}">
            <a class="page-link" href="#" ng-click="setPage(currentPage - 1)">Previous</a>
        </li>
        <li class="page-item">
            <span class="page-link">{{currentPage}} / {{totalPages}}</span>
        </li>
        <li class="page-item" ng-class="{disabled: currentPage === totalPages}">
            <a class="page-link" href="#" ng-click="setPage(currentPage + 1)">Next</a>
        </li>
    </ul>
</div>

<script>
    var app = angular.module('myApp', []);
    app.controller('myController', function($scope, $http) {
        $scope.currentPage = 1;
        $scope.pageSize = 5;
        $scope.totalItems = 0;
        $scope.totalPages = 0;
        $scope.activityLogs = []; // Danh sách các hoạt động

        // Hàm lấy dữ liệu hoạt động với trang và kích thước trang được chỉ định
        $scope.getActivityLogs= function (page, size) {
            $http.get('http://localhost:8080/admin/activitys', {
                params: {
                    page: page - 1,
                    size: size
                }
            })
                .then(function(response) {
                    $scope.activityLogs = response.data.content;
                    $scope.totalItems = response.data.totalElements;
                    $scope.totalPages = response.data.totalPages;
                })
                .catch(function(error) {
                    console.error('Error fetching data:', error);
                });
        }



        // Hàm đặt trang hiện tại
        $scope.setPage = function(page) {
            if (page >= 1 && page <= $scope.totalPages) {
                $scope.currentPage = page;
                $scope.getActivityLogs($scope.currentPage, $scope.pageSize);
            }
        };

        // Khởi tạo khi trang được tải
        $scope.getActivityLogs($scope.currentPage, $scope.pageSize);
    });
</script>
</body>
</html>
