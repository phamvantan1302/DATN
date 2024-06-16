<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" pageEncoding="utf-8" %>
<html>
<head>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
    <script src="https://cdn.rawgit.com/serratus/quaggaJS/0.12.1/dist/quagga.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/angular-ui-bootstrap/3.4.0/ui-bootstrap-tpls.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
</head>
<style>
    .tabs{
        display:flex;
    }
    .tablinks {
        border: none;
        outline: none;
        cursor: pointer;
        width: 100%;
        padding: 1rem;
        font-size: 13px;
        text-transform: uppercase;
        font-weight:600;
        transition: 0.2s ease;
    }
    .tablinks:hover{
        background:pink;
        color:#fff;
    }
    /* Tab active */
    .tablinks.active {
        background:rgb(77,77,77);
        color:#fff;
    }

    /* tab content */
    .tabcontent {
        display: none;
    }
    /* Text*/
    .tabcontent p {
        color: #333;
        font-size: 16px;
    }
    /* tab content active */
    .tabcontent.active {
        display: block;
    }
    .scrollable-table {
        max-height: 200px;
        width: 1200px;
        overflow-y: auto;
        border: 1px solid #ccc;
        padding: 10px;
        background-color: white;
    }
    table{
        background-color: white;
    }
    img{
        height: 50px;
        width: 50px;
    }
</style>
<body ng-app="myApp" ng-controller="myController">
<div class="tabs">
    <button class="tablinks" data-electronic="tab1">Tạo Trương trình giảm giá</button>
    <button class="tablinks" data-electronic="tab2">Danh Sách Chương Trình Giảm Giá</button>
</div>

<!-- Tab content -->
<div class="wrapper_tabcontent">
    <div id="tab1" class="tabcontent">
        <h2 class="text-center">Quản Lý Đợt Giảm Giá</h2>
        <div>
            <form ng-submit="savediscountperiod()" novalidate>
                <div class="row">
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label for="" class="form-label">Ngày Bắt Đầu :</label>
                            <input class="form-control" ng-model="newdiscountperiod.startDate" name="startDate" type="date" required>
                            <div ng-show="serverErrors.startDate">
                                <span class="text-danger">{{ serverErrors.startDate }}</span>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="">Ngày Kết Thúc :</label>
                            <input class="form-control" ng-model="newdiscountperiod.endDate" name="endDate" type="date" required>
                            <div ng-show="serverErrors.endDate">
                                <span class="text-danger">{{ serverErrors.endDate }}</span>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="mb-3">
                            <label for="">Tên Trương Trình :</label>
                            <input class="form-control" ng-model="newdiscountperiod.name" name="name" required>
                            <div ng-show="serverErrors.name">
                                <span class="text-danger">{{ serverErrors.name }}</span>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="">Số Lượng</label>
                            <input class="form-control" ng-model="newdiscountperiod.quantity" min="1" value="1" type="number" required>
                            <div ng-show="serverErrors.quantity">
                                <span class="text-danger">{{ serverErrors.quantity }}</span>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="mb-3">
                            <label for="">Giá Từ</label>
                            <input class="form-control" ng-model="newdiscountperiod.starPrice" value="1" min="1" type="number" required>
                            <div ng-show="serverErrors.starPrice">
                                <span class="text-danger">{{ serverErrors.starPrice }}</span>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="mb-3">
                            <label for="">Đến</label>
                            <input class="form-control" ng-model="newdiscountperiod.endPrice" value="1" min="1" type="number" required>
                            <div ng-show="serverErrors.endPrice">
                                <span class="text-danger">{{ serverErrors.endPrice }}</span>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="mb-3">
                            <label for="">Loại Khuyến Mãi:</label>
                            <select class="form-select" ng-model="newdiscountperiod.category">
                                <option value="0">Giảm Giá Hóa Đơn</option>
                                <option value="1">Tặng Sản Phẩm</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="mb-3">
                            Áp dụng trương trình km khác : <input type="checkbox" value="1" ng-model="newdiscountperiod.apDungCTKMKhac" />
                        </div>
                    </div>

                    <div class="col-md-6" ng-show="newdiscountperiod.category === '0'">
                        <div class="mb-3">
                            <label for="">Giảm (%) :</label>
                            <input class="form-control" ng-model="newdiscountperiod.value" type="number">
                            <div ng-show="serverErrors.value">
                                <span class="text-danger">{{ serverErrors.value}}</span>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="">Tổng tiền giảm TCKM :</label>
                            <input class="form-control" ng-model="newdiscountperiod.tonggiatritckm" type="number">
                            <div ng-show="serverErrors.tonggiatritckm">
                                <span class="text-danger">{{ serverErrors.tonggiatritckm}}</span>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6" ng-show="newdiscountperiod.category === '0'">
                        <div class="mb-3">
                            <label for="">Tổng tiền giảm tối đa trên 1 hóa đơn :</label>
                            <input class="form-control" ng-model="newdiscountperiod.giamToiDa" type="number">
                            <div ng-show="serverErrors.giamToiDa">
                                <span class="text-danger">{{ serverErrors.giamToiDa}}</span>
                            </div>
                        </div>


                    </div>

                    <div class="col-md-12" ng-show="newdiscountperiod.category === '1'">
                        <label for="">Sản Phẩm :</label>
                        <div class="table-responsive scrollable-table">
                            <div class="table-responsive scrollable-table">
                                <table class="table table-striped table-bordered">
                                    <thead>
                                    <tr>
                                        <!-- Checkbox để chọn/bỏ chọn tất cả discount periods -->
                                        <th>
                                            <input type="checkbox" ng-model="selectAllHeader" ng-change="toggleAll()" />
                                        </th>
                                        <th>STT</th>
                                        <th>IMG</th>
                                        <th>Tên SP</th>
                                        <th>giá</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <!-- Dùng ng-repeat để lặp qua danh sách discount periods -->
                                    <tr ng-repeat="productdetail in productdetails">
                                        <td>
                                            <!-- Checkbox cho từng discount period -->
                                            <input type="checkbox" ng-model="productdetail.selected" ng-change="logSelectedProducts(productdetail)" />
                                        </td>
                                        <td>{{$index+1}}</td>
                                        <td><img src="/views/giay-20.jpg"></td>
                                        <td>{{productdetail.product.name}}</td>
                                        <td>{{productdetail.price }}VND</td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-12">
                        <div class="d-flex justify-content-center">
                            <button class="btn btn-primary" style="align-items:center">Thêm</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <div id="tab2" class="tabcontent active" >
        <div class="container mt-3">
            <!-- Thẻ div chứa form tìm kiếm riêng và radio buttons -->
            <div class="mb-3">
                <form class="form-inline" ng-submit="searchDiscountPeriods()">
                    <div class="form-group">
                        <label class="mr-2">Tìm kiếm:</label>
                        <input type="text" ng-model="keyword" class="form-control" placeholder="Nhập từ khóa">
                    </div>
                    <button type="submit"  class="btn btn-primary ml-2">Tìm kiếm</button>
                </form>

                <!-- Radio buttons để lọc theo trạng thái -->
                <div class="mt-3">
                    <label class="mr-2">Trạng thái:</label>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="statusFilter" id="allStatus" ng-click="showall()" value="" checked>
                        <label class="form-check-label" for="allStatus">Tất cả</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="statusFilter" id="applying" ng-model="statusFilter" ng-value="'0'" ng-change="filterData(statusFilter)">
                        <label class="form-check-label" for="applying">Áp dụng</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="statusFilter" id="waiting" ng-model="statusFilter" ng-value="'1'" ng-change="filterData(statusFilter)">
                        <label class="form-check-label" for="waiting">Chờ áp dụng</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="statusFilter" id="ended" ng-model="statusFilter" ng-value="'2'" ng-change="filterData(statusFilter)">
                        <label class="form-check-label" for="ended">Kết thúc</label>
                    </div>
                </div>
            </div>

                <table class="table table-borderted mt-2">
                    <thead>
                    <tr>
                        <th>STT</th>
                        <th>Name</th>
                        <th>Ngày Bắt Đầu</th>
                        <th>Ngày Kết Thúc</th>
                        <th>Giảm(%)</th>
                        <th>Số Lượng</th>
                        <th>Số tiền bắt đầu</th>
                        <th>Số tiền kết thúc</th>
                        <th>Loại</th>
                        <th>Tổng tiền giảm </th>
                        <th>Đã Giảm</th>
                        <th>Trạng thái</th>
                        <th colspan="2">Action</th>
                    </tr>
                    </thead>
                    <tbody ng-repeat="discountperiod in discountperiods" >
                    <tr>
                        <td>{{$index+1}}</td>
                        <td>{{discountperiod.name}}</td>
                        <td>{{discountperiod.startDate}}</td>
                        <td>{{discountperiod.endDate}}</td>
                        <td>{{discountperiod.value}}</td>
                        <td>{{discountperiod.quantity}}</td>
                        <td>{{discountperiod.starPrice}}</td>
                        <td>{{discountperiod.endPrice}}</td>
                        <td>
                            <span ng-if="discountperiod.category === 0">Giảm % Hóa Đơn</span>
                            <span ng-if="discountperiod.category === 1">Tặng Sản Phẩm</span>
                        </td>
                        <td>
                          {{discountperiod.tonggiatritckm}}
                        </td>
                        <td>{{discountperiod.tonggiatritckmdagiam}}</td>
                        <td>
                            <span ng-if="discountperiod.status === 0">Áp dụng</span>
                            <span ng-if="discountperiod.status === 1">Chờ áp dụng</span>
                            <span ng-if="discountperiod.status === 2">Kết thúc</span>
                        </td>
                        <td><a class="btn btn-info" ng-click="detailDiscountDetail(discountperiod.id)">Update</a></td>
                        <td> <a class="btn btn-danger" ng-click="deletedDiscountPeriod(discountperiod.id)">Kết Thúc</a></td>
                    </tr>
                    </tbody>
                </table>
            <!-- Thêm nút Prev -->
            <div>
                <!-- Nút và thông tin phân trang -->
                <button ng-click="setPage(currentPage - 1, statusFilter)" ng-disabled="currentPage == 1">Previous</button>
                <span>Trang {{ currentPage }}</span>
                <button ng-click="setPage(currentPage + 1, statusFilter)" ng-disabled="currentPage == totalPages">Next</button>
            </div>
        </div>

        <div id="module" class="tabcontent">
            <img src="//bizweb.dktcdn.net/thumb/large/100/228/168/products/sp1-96b83938-650f-4f51-8b0a-61ee9f8f9039.jpg?v=1580721383000" width="100%"/>
        </div>
    </div>

    <div id="tab3" class="tabcontent">
        <h2 class="text-center">Quản Lý Đợt Giảm Giá</h2>
        <div class="container mt-5">
            <form ng-submit="updatediscountperiod()">
                <div class="row">
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label for="" class="form-label">Ngày Bắt Đầu :</label>
                            <input class="form-control"  ng-model="discountDetail.startDate"  name="startDate" required>
                            <div ng-show="serverErrors.startDate">
                                <span class="text-danger">{{ serverErrors.startDate}}</span>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="">Ngày Kết Thúc :</label>
                            <input class="form-control"  ng-model="discountDetail.endDate " name="endDate" required>
                            <div ng-show="serverErrors.endDate">
                                <span class="text-danger">{{ serverErrors.endDate}}</span>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="mb-3">
                            <label for="">Tên Trương Trình :</label>
                            <input class="form-control" ng-model="discountDetail.name" name="name" required>
                            <div ng-show="serverErrors.name">
                                <span class="text-danger">{{ serverErrors.name}}</span>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="">Số Lượng</label>
                            <input class="form-control" ng-model="discountDetail.quantity" type="number" name="quantity" required>
                            <div ng-show="serverErrors.quantity">
                                <span class="text-danger">{{ serverErrors.quantity}}</span>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="mb-3">
                            <label for="">Giá Từ</label>
                            <input class="form-control" ng-model="discountDetail.starPrice" type="number" name="starPrice" required>
                            <div ng-show="serverErrors.startPrice">
                                <span class="text-danger">{{ serverErrors.startPrice}}</span>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="mb-3">
                            <label for="">Đến</label>
                            <input class="form-control" ng-model="discountDetail.endPrice" type="number" name="endPrice" required>
                            <div ng-show="serverErrors.endPrice">
                                <span class="text-danger">{{ serverErrors.endPrice}}</span>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="mb-3" >
                            <label for="">Loại Khuyến Mãi:</label>
                            <select class="form-select" ng-model="discountDetail.category">
                                <option ng-value="0">Giảm Giá Hóa Đơn</option>
                                <option ng-value="1">Tặng Sản Phẩm</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="mb-3">
                            Áp dụng trương trình km khác : <input type="checkbox" value="1" ng-model="discountDetail.apDungCTKMKhac" />
                        </div>
                    </div>

                    <div class="col-md-6" ng-show="discountDetail.category === 0">
                        <div class="mb-3">
                            <label for="">Giảm (%) :</label>
                            <input class="form-control" ng-model="discountDetail.value" type="number">
                        </div>
                    </div>

                    <div class="col-md-6" ng-show="discountDetail.category === 0">
                        <div class="mb-3">
                            <label for="">Tổng tiền giảm tối đa trên 1 hóa đơn :</label>
                            <input class="form-control" ng-model="discountDetail.giamToiDa" type="number">
                        </div>
                    </div>

                    <div class="col-md-6" ng-show="discountDetail.category === 1">
                        <label for="">Sản Phẩm :</label>
                        <div class="table-responsive scrollable-table">
                            <div class="table-responsive scrollable-table">
                                <table class="table table-striped table-bordered">
                                    <thead>
                                    <tr>
                                        <!-- Checkbox để chọn/bỏ chọn tất cả discount periods -->
                                        <th>
                                            <input type="checkbox" ng-model="selectAllHeader" ng-change="toggleAll()" />
                                        </th>
                                        <th>STT</th>
                                        <th>IMG</th>
                                        <th>Tên SP</th>
                                        <th>giá</th>
                                        <th>Số lượng</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <!-- Dùng ng-repeat để lặp qua danh sách discount periods -->
                                    <tr ng-repeat="productdetail in productdetails">
                                        <td>
                                            <!-- Checkbox cho từng discount period -->
                                            <input type="checkbox" ng-model="productdetail.selected" ng-change="logSelectedProducts(productdetail)" />
                                        </td>
                                        <td>{{$index+1}}</td>
                                        <td><img src="/views/giay-20.jpg"></td>
                                        <td>{{productdetail.product.name}}</td>
                                        <td>{{productdetail.price }}VND</td>
                                        <td><input type="number" ng-model="quantityInputs[productdetail.id]" value="1" min="1"></td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-12">
                        <div class="d-flex justify-content-center">
                            <button class="btn btn-primary" style="align-items:center">Update</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
    </body>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>


        var app = angular.module('myApp', []);

        app.controller('myController', function($scope, $http) {
            // Cuộc gọi API để lấy danh sách sản phẩm
            $scope.currentPage = 1;
            $scope.pageSize = 5;
            $scope.totalItems = 0;
            //list discountperiod
            $scope.discountperiods = [];
            //new đối tượng
            $scope.newdiscountperiod = {};
            //set mặc định select loại km
            $scope.newdiscountperiod.category='0';
            //set radio button trạng thái
            $scope.newdiscountperiod.status='0';
            //list productdetail
            $scope.productdetails = [];
            // Thêm biến filterStatus vào $scope và đặt giá trị ban đầu là false
            $scope.filterStatus = false;

            $scope.loadDataStatus = function (status) {
                $scope.currentPage = 1;
                $scope.filterStatus = true;
                $scope.getPagedDiscountperiods($scope.currentPage, $scope.pageSize, status);
            };

            // Hàm chuyển đến trang
            $scope.setPage = function (page, status) {
                if (page >= 1 && page <= $scope.totalPages) {
                    $scope.currentPage = page;
                    if (status === undefined) {
                        $scope.filterStatus = false;
                        $scope.getPagedDiscountperiods($scope.currentPage, $scope.pageSize);
                    } else {
                        $scope.filterStatus = true;
                        $scope.getPagedDiscountperiods($scope.currentPage, $scope.pageSize, status);
                    }
                }
            };

            // Hàm lọc dữ liệu
            $scope.filterData = function (status) {
                $scope.currentPage = 1;
                $scope.filterStatus = true;  // Đánh dấu đang áp dụng bộ lọc
                $scope.getPagedDiscountperiods($scope.currentPage, $scope.pageSize, status);
            };

            // Hàm chung để gọi API và phân trang
            $scope.getPagedDiscountperiods = function (page, size, status) {
                var apiUrl = 'http://localhost:8080/admin/DiscountPeriods';
                if (status !== null && status !== undefined) {
                    apiUrl += '/' + status;
                }
                $http.get(apiUrl, { params: { page: page - 1, size: size } })
                    .then(function(response) {
                        console.log('Dữ liệu phản hồi:', response.data);
                        $scope.discountperiods = response.data.content;
                        $scope.totalItems = response.data.totalElements;

                        // Tính toán tổng số trang
                        $scope.totalPages = Math.ceil($scope.totalItems / $scope.pageSize);
                    })
                    .catch(function(error) {
                        console.error('Lỗi:', error);
                    });
            };
            $scope.showall = function () {
                $scope.currentPage = 1;
                $scope.filterStatus = false;
                $scope.getPagedDiscountperiods($scope.currentPage, $scope.pageSize);
            };

            //load page
            $scope.loadDataStatus();

            //save listproduct checkbox
            // Save new
            $scope.discountPeriodForm = {};

            $scope.savediscountperiod = function() {
                $scope.serverErrors = {};
                var tempData = angular.copy($scope.newdiscountperiod);
                // Kiểm tra giá trị của newdiscountperiod.category
                if ($scope.newdiscountperiod.category === '0') {
                    // Nếu là option 1, gọi API 1
                    $http.post('http://localhost:8080/admin/DiscountPeriod', $scope.newdiscountperiod)
                        .then(function(response) {
                            // Xử lý kết quả nếu cần
                            $scope.discountperiods.push(response.data);
                            $scope.getPagedDiscountperiods($scope.currentPage, $scope.pageSize);
                            $scope.newdiscountperiod.category = '0';
                            $scope.newdiscountperiod.status = '0';
                            showTimedSuccessMessage('Thêm Thành Công');
                            console.log('API Option 1 response:', response.data);
                            $scope.resetSelectedProducts();
                            // Đặt lại trạng thái của form
                        })
                        .catch(function(error) {
                            $scope.newdiscountperiod = angular.copy(tempData);
                            angular.forEach(error.data, function(message, field) {
                                $scope.serverErrors[field] = message;
                            });
                            console.error('Error calling API Option 1:', error);
                        });
                } else if ($scope.newdiscountperiod.category === '1') {
                    // Nếu là option 2, gọi API 2
                    $http.post('http://localhost:8080/admin/listSelectedProducts', $scope.selectedproductdetails)
                        .then(function(response) {
                            // Xử lý kết quả nếu cần
                            console.log('API Option 2 response:', response.data);
                            showTimedSuccessMessage('Thêm Thành Công');

                            $scope.resetSelectedProducts();

                        })
                        .catch(function(error) {
                            console.error('Error calling API Option 2:', error);
                        });

                    // Gọi API 1 sau khi gọi API 2
                    $http.post('http://localhost:8080/admin/DiscountPeriod', $scope.newdiscountperiod)
                        .then(function(response) {
                            // Xử lý kết quả nếu cần
                            $scope.discountperiods.push(response.data);
                            $scope.getPagedDiscountperiods($scope.currentPage, $scope.pageSize);
                            $scope.newdiscountperiod.category = '0';
                            $scope.newdiscountperiod.status = '0';
                            console.log('API Option 1 response:', response.data);
                        })
                        .catch(function(error) {
                            $scope.newdiscountperiod = angular.copy(tempData);
                            angular.forEach(error.data, function(message, field) {
                                $scope.serverErrors[field] = message;
                            });
                            console.error('Error calling API Option 1:', error);

                        });
                } else {
                    // Xử lý trường hợp khác nếu cần
                }

                // Đặt lại giá trị cho các biến
                $scope.newdiscountperiod = {};
                $scope.selectedproductdetails = [];

            };


            // Updatediscount
            $scope.updatediscountperiod = function() {
                $scope.serverErrors = {};
                var tempData = angular.copy($scope.discountDetail);
                // Kiểm tra giá trị của category
                if ($scope.discountDetail.category === 0) {
                    // Nếu là option 1, gọi API 1
                    $http.put('http://localhost:8080/admin/UpdateDiscountPeriod/'+$scope.discountDetail.id,$scope.discountDetail)
                        .then(function(response) {
                            // Xử lý kết quả nếu cần
                            $scope.getPagedDiscountperiods($scope.currentPage, $scope.pageSize);
                            $scope.discountDetail.category='0';
                            $scope.discountDetail.status='0';
                            console.log('API Option 1 response:', response.data);
                            showTimedSuccessMessage('Update Thành Công');
                            document.getElementById('tab3').classList.remove('active');
                            document.getElementById('tab2').classList.add('active');

                        })
                        .catch(function(error) {
                            $scope.newdiscountperiod = angular.copy(tempData);
                            angular.forEach(error.data, function(message, field) {
                                $scope.serverErrors[field] = message;
                            });
                            console.error('Error calling API Option 1:', error);
                        });
                } else if ($scope.discountDetail.category === 1) {
                    $http.post('http://localhost:8080/admin/listSelectedProducts',$scope.selectedproductdetails)
                        .then(function(response) {
                            // Xử lý kết quả nếu cần
                            $scope.selectedproductdetails.push(response.data);
                            console.log('API Option 2 response:', response.data);
                            showTimedSuccessMessage('Update Thành Công');
                            document.getElementById('tab3').classList.remove('active');
                            document.getElementById('tab2').classList.add('active');

                        })
                        .catch(function(error) {
                            console.error('Error calling API Option 2:', error);
                        });
                    $http.put('http://localhost:8080/admin/UpdateDiscountPeriod/'+$scope.discountDetail.id,$scope.discountDetail)
                        .then(function(response) {
                            console.log('API Option 1 response:', response.data);
                        })
                        .catch(function(error) {
                            $scope.newdiscountperiod = angular.copy(tempData);
                            angular.forEach(error.data, function(message, field) {
                                $scope.serverErrors[field] = message;
                            });
                            console.error('Error calling API Option 1:', error);
                        });
                } else {
                    // Xử lý trường hợp khác nếu cần
                }
                $scope.selectedproductdetails = [];
            };

            //delete discount
            $scope.deletedDiscountPeriod = function(DiscountPeriodId) {
                $http.get('http://localhost:8080/admin/DeleteDiscountPeriod/' + DiscountPeriodId)
                    .then(function() {
                        // Handle success
                        $scope.getPagedDiscountperiods($scope.currentPage, $scope.pageSize);
                    })
                    .catch(function(error) {
                        console.error('Error deleting book:', error);
                    });
            };

            // Hàm để kiểm tra sản phẩm và cập nhật trạng thái checkbox
            $scope.checkSelectedProducts = function() {
                angular.forEach($scope.productdetails, function(productdetail) {
                    // Kiểm tra xem sản phẩm có trong danh sách sản phẩm đã lấy không
                    var isSelected = $scope.productdetailsDiscountPeriod.some(function(selectedProduct) {
                        return selectedProduct.id === productdetail.id;
                    });

                    // Cập nhật trạng thái checkbox
                    productdetail.selected = isSelected;

                    $scope.selectAllHeader = $scope.productdetails.every(function(productdetail) {
                        return productdetail.selected;
                    });
                });
            };

            $scope.discountDetail={};
            //detail discount
            $scope.detailDiscountDetail = function(discountPeriodId) {
                $http.get('http://localhost:8080/admin/DetailDiscountPeriod/' + discountPeriodId)
                    .then(function(response) {
                        // Xử lý dữ liệu chi tiết đợt giảm giá từ server (response.data)
                        $scope.discountDetail = response.data;
                        console.log('Chi tiết đợt giảm giá:', $scope.discountDetail);
                        document.getElementById('tab2').classList.remove('active');
                        document.getElementById('tab3').classList.add('active');
                        if ($scope.discountDetail.category === 1) {
                            $http.get('http://localhost:8080/admin/ProductDetailsByDiscountPeriod/'+discountPeriodId)
                                .then(function(response) {
                                    // Xử lý kết quả nếu cần
                                    $scope.productdetailsDiscountPeriod = response.data;
                                    $scope.checkSelectedProducts();
                                    console.log('sản phẩm', $scope.productdetailsDiscountPeriod);

                                })
                                .catch(function(error) {
                                    console.error('Error calling API Option 2:', error);
                                });
                        }

                    })

                    .catch(function(error) {
                        console.error('Error getting discount detail:', error);
                    });
                $scope.selectedproductdetails = [];
            };

// Function để hiển thị chi tiết đợt giảm giá trên giao diện người dùng
            $scope.showDiscountDetail = function(discountDetail) {
                // Gán dữ liệu chi tiết đợt giảm giá vào $scope để sử dụng trong giao diện
                $scope.discountDetail = discountDetail;
            };

            //call api list product detail
            $http.get('http://localhost:8080/admin/ProductDetails')
                .then(function(response) {
                    // Log dữ liệu phản hồi vào console (nếu cần)
                    console.log('Dữ liệu phản hồi:', response.data);
                    // Lưu danh sách sản phẩm vào $scope
                    $scope.productdetails = response.data;
                })
                .catch(function(error) {
                    // Xử lý lỗi nếu có
                    console.error('Lỗi:', error);
                });
            $scope.selectedproductdetails = [];

            // Hàm để chọn/bỏ chọn tất cả discount periods
            $scope.toggleAll = function() {
                angular.forEach($scope.productdetails , function(productdetail) {
                    productdetail.selected = $scope.selectAllHeader;
                });

                // Cập nhật danh sách discount periods đã chọn
                $scope.updateSelectedDiscountPeriods();
            };

            // Hàm để cập nhật danh sách sản phẩm đã chọn
            $scope.updateSelectedDiscountPeriods = function() {
                // Lọc danh sách discount periods đã chọn và cập nhật mảng $scope.selectedDiscountPeriods
                $scope.selectedproductdetails = $scope.productdetails.filter(function(productdetail) {
                    return productdetail.selected;
                });
            };

            $scope.logSelectedProducts = function() {
                $scope.selectedproductdetails = $scope.productdetails.filter(function(productdetail) {
                    return productdetail.selected;
                });
                console.log('Selected Products:',$scope.selectedproductdetails);
            };

            $scope.resetSelectedProducts = function() {
                angular.forEach($scope.productdetails, function(productdetail) {
                    productdetail.selected = null;
                });

                // Cập nhật danh sách discount periods đã chọn
                $scope.updateSelectedDiscountPeriods();
            };

            //tìm kiếm
            $scope.keyword ='';

            $scope.searchDiscountPeriods = function () {
                if ($scope.keyword) {
                    $http.get('http://localhost:8080/admin/DiscountPeriods/search', { params: { keyword: $scope.keyword,page: $scope.currentPage -1, size:$scope.pageSize } })
                        .then(function (response) {
                            $scope.discountperiods = response.data.content;
                            $scope.totalItems = response.data.totalElements;

                            // Tính toán tổng số trang
                            $scope.totalPages = Math.ceil($scope.totalItems / $scope.pageSize);
                        })
                        .catch(function (error) {
                            console.error('Error:', error);
                        });
                }
            };
            function showTimedSuccessMessage(message, time) {
                Swal.fire({
                    title: 'Thông báo',
                    text: message,
                    icon: 'success',
                    timer: time || 1200,
                    showConfirmButton: false
                });
            }

        });

        var tabLinks = document.querySelectorAll(".tablinks");
        var tabContent =document.querySelectorAll(".tabcontent");

        tabLinks.forEach(function(el) {
            el.addEventListener("click", openTabs);
        });


        function openTabs(el) {
            var btn = el.currentTarget; // lắng nghe sự kiện và hiển thị các element
            var electronic = btn.dataset.electronic; // lấy giá trị trong data-electronic

            tabContent.forEach(function(el) {
                el.classList.remove("active");
            }); //lặp qua các tab content để remove class active

            tabLinks.forEach(function(el) {
                el.classList.remove("active");
            }); //lặp qua các tab links để remove class active

            document.querySelector("#" + electronic).classList.add("active");
            // trả về phần tử đầu tiên có id="" được add class active

            btn.classList.add("active");
            // các button mà chúng ta click vào sẽ được add class active
        }

    </script>
    </html>