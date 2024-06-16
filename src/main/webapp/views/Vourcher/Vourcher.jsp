<%@ page language="java" pageEncoding="utf-8" %>
<html lang="en" ng-app="voucherApp">
<head>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
    <script src="https://cdn.rawgit.com/serratus/quaggaJS/0.12.1/dist/quagga.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<style>
    .error-message{
        color: red;
    }
    .loading-overlay {
        position: fixed;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        background: rgba(255, 255, 255, 0.8); /* Một màu nền mờ */
        padding: 20px;
        border-radius: 10px;
        text-align: center;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* Đổ bóng để làm nổi bật */
    }
    .loading-spinner {
        border: 4px solid rgba(0, 0, 0, 0.1);
        border-left: 4px solid #3498db;
        border-radius: 50%;
        width: 20px;
        height: 20px;
        animation: spin 1s linear infinite;
    }

    @keyframes spin {
        0% { transform: rotate(0deg); }
        100% { transform: rotate(360deg); }
    }
</style>
<body ng-controller="VoucherController">
<div >
    <div class="loading-overlay" ng-show="showLoading">
        <div class="loading-spinner"></div>
        <p>Đang xử lý...</p>
    </div>
    <form novalidate ng-submit="createVoucher()">
        <div class="row">
            <div class="col-md-6">
                <div class="mb-3">
                    <label for="" class="form-label"> Hạn Sử Dụng :</label>
                    <input class="form-control" ng-model="voucher.endDate" type="date" required>
                    <div class="error-message" ng-show="errors.endDate">{{errors.endDate}}</div>
                </div>
                <div class="mb-3">
                    <label for="">Hóa Đơn Tối Thiểu :</label>
                    <input class="form-control" ng-model="voucher.dieukienbatdau"  min="1" value="1" type="number" required>
                    <div class="error-message" ng-show="errors.dieukienbatdau">{{errors.dieukienbatdau}}</div>
                </div>

            </div>

            <div class="col-md-6">
                <div class="mb-3">
                    <label for="">Số Lượng :</label>
                    <input class="form-control" ng-model="voucher.quantity"  min="1" value="1" type="number" required>
                    <div class="error-message" ng-show="errors.quantity">{{errors.quantity}}</div>
                </div>
                <div class="mb-3">
                    <label for="">Mệnh Giá :</label>
                    <input class="form-control" ng-model="voucher.menhGia"  min="1" value="1" type="number" required>
                    <div class="error-message" ng-show="errors.menhgia">{{errors.menhgia}}</div>
                </div>
            </div>


            <div class="col-md-6">

                <div class="mb-3">
                    <label for="">Áp dụng nhiều voucher</label>
                    <input type="checkbox" value="1" ng-model="voucher.apdungvoucherkhac" />
                </div>
            </div>
            <div class="col-md-12">
                <div class="d-flex justify-content-center">
                    <button class="btn btn-primary" type="submit" style="align-items:center">Thêm</button>
                </div>
            </div>
        </div>
    </form>
        <div class="mt-3">
            <div class="mb-3">
                <label for="searchInput">Tìm kiếm:</label>
                <input class="form-control" ng-model="searchText" id="searchInput" placeholder="Nhập mã voucher...">
                <button class="btn btn-primary"  ng-click="performSearch()">Tìm kiếm</button>
            </div>
            <div class="mb-3">
                <label>Trạng thái:</label>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" name="statusFilter" id="allStatus" ng-model="statusFilter" ng-click="showAll()"  value=" " >
                    <label class="form-check-label" for="allStatus">Tất cả</label>
                </div>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" name="statusFilter" id="activeStatus" ng-model="statusFilter"  ng-click="filterByStatus(0)" value="0">
                    <label class="form-check-label" for="activeStatus">Đang hoạt động</label>
                </div>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" name="statusFilter" id="expiredStatus" ng-model="statusFilter"  ng-click="filterByStatus(2)" value="2">
                    <label class="form-check-label" for="expiredStatus">Đã hết hạn</label>
                </div>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" name="statusFilter" id="outOfStockStatus" ng-model="statusFilter"  ng-click="filterByStatus(1)" value="1">
                    <label class="form-check-label" for="outOfStockStatus">Đã được sử dụng</label>
                </div>
            </div>
            <table class="table">
                <!-- Thêm cột và hàng của bảng dựa trên cấu trúc của danh sách voucher -->
                <thead>
                <tr>
                    <th>STT</th>
                    <th scope="col">Mã Voucher</th>
                    <th scope="col">Hạn Sử Dụng</th>
                    <th scope="col">Số Lượng</th>
                    <th scope="col">Mệnh Giá</th>
                    <th scope="col">Trạng thái</th>
                    <th scope="col" colspan="2">Action</th>
                    <!-- Thêm các cột khác nếu cần -->
                </tr>
                </thead>
                <tbody>
                <!-- Dùng ng-repeat để lặp qua danh sách voucher và hiển thị thông tin -->
                <tr ng-repeat="item in voucherList">
                    <td>{{ calculateIndex($index) }}</td>
                    <td>{{item.code}}</td>
                    <td>{{item.endDate}}</td>
                    <td>{{item.quantity}}</td>
                    <td>{{item.menhGia}}</td>
                    <td>
                        {{ item.status === 0 ? 'Đang hoạt động' : (item.status === 1 ? 'đã sử dụng' : 'Đã hết hạn') }}
                    </td>
                    <td>
                    <button class="btn btn-warning"
                            data-toggle="modal"
                            data-target="#updateModal"
                            ng-click="openUpdateModal(item)"
                            ng-disabled="item.status === 1">
                        Update
                    </button>
                </td>
                    <td>
                        <button class="btn btn-danger"
                                ng-click="deleteItem(item)"
                                ng-disabled="item.status === 1">
                            Delete
                        </button>
                    </td>

                </tbody>
            </table>
            <!-- Phân trang -->
            <div class="pagination-container">
                <!-- Nút và thông tin phân trang -->
                <button class="btn btn-primary" ng-click="setPage(currentPage - 1,statusFilter)" ng-disabled="currentPage === 1">
                    Previous
                </button>
                <span class="pagination-info">Trang {{ currentPage }} / {{ totalPages }}</span>
                <button class="btn btn-primary" ng-click="setPage(currentPage + 1,statusFilter)" ng-disabled="currentPage === totalPages">
                    Next
                </button>
            </div>
        </div>

</div>
<!-- Thêm modal -->
<div class="modal" id="updateModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="updateModalLabel">Cập Nhật Thông Tin Voucher</h5>
            </div>
            <div class="modal-body">
                <form ng-submit="updateVoucher()">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="" class="form-label"> Hạn Sử Dụng :</label>
                                <input class="form-control" ng-model="voucherdetail.endDate" type="date" >
                                <div class="error-message" ng-show="errorsupdate.endDate">{{errorsupdate.endDate}}</div>
                            </div>
                            <div class="mb-3">
                                <label for="">Mã Voucher :</label>
                                <input class="form-control" ng-model="voucherdetail.code" name="name" disabled>
                                <div class="error-message" ng-show="errorsupdate.code">{{errorsupdate.code}}</div>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="">Số Lượng :</label>
                                <input class="form-control" ng-model="voucherdetail.quantity"  min="1" value="1" type="number" >
                                <div class="error-message" ng-show="errorsupdate.quantity">{{errorsupdate.quantity}}</div>
                            </div>
                            <div class="mb-3">
                                <label for="">Mệnh Giá :</label>
                                <input class="form-control" ng-model="voucherdetail.menhGia "   type="number" >
                                <div class="error-message" ng-show="errorsupdate.menhgia">{{errorsupdate.menhgia}}</div>
                            </div>
                        </div>


                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="">Hóa Đơn Tối Thiểu :</label>
                                <input class="form-control" ng-model="voucherdetail.dieukienbatdau"  min="1" value="1" type="number" >
                                <div class="error-message" ng-show="errorsupdate.dieukienbatdau">{{errorsupdate.dieukienbatdau}}</div>
                            </div>
                            <div class="mb-3">
                                <label for="">Áp dụng nhiều voucher</label>
                                <input type="checkbox" value="1" ng-model="voucherdetail.apdungvoucherkhac" />
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="d-flex justify-content-center">
                                <button class="btn btn-primary"style="align-items:center">Update</button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal" ng-click="closeUpdateModal()">OK</button>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    angular.module('voucherApp', [])
        .controller('VoucherController', ['$scope', '$http','$interval', function($scope, $http, $interval) {



            $scope.createVoucher = function() {
                $scope.showLoading = true;
                $http.post('http://localhost:8080/admin/addvoucher', $scope.voucher)
                    .then(function(response) {
                        // Xử lý khi tạo voucher thành công
                        showTimedSuccessMessage('Thêm voucher Thành Công');
                        $scope.voucher = {};
                        $scope.errors = {};
                        $scope.showLoading = false;
                    })
                    .catch(function(error) {
                        // Xử lý khi có lỗi tạo voucher
                        console.error('Lỗi khi tạo voucher: ', error);
                        // Hiển thị lỗi trên frontend
                        $scope.errors = error.data;
                        $scope.showLoading = false;
                    });
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
            // Khởi tạo các biến
            $scope.currentPage = 1;
            $scope.pageSize = 5;
            $scope.totalItems = 0;
            $scope.vouchers = []; // Danh sách voucher
            $scope.statusFilter = null; // Bộ lọc theo trạng t


            function loadVouchers(page, size) {
                $http.get('http://localhost:8080/admin/getvoucherbystatus', { params: { page: page - 1, size: size } })
                    .then(function(response) {
                        // Lưu trữ dữ liệu vào biến tạm thời filteredVoucherList
                        $scope.filteredVoucherList = response.data.content;

                        // Cập nhật các biến theo thông tin từ response
                        $scope.totalItems = response.data.totalElements;
                        $scope.totalPages = response.data.totalPages;

                        // Cập nhật danh sách hiển thị
                        $scope.voucherList = $scope.filteredVoucherList;
                    })
                    .catch(function(error) {
                        console.error('Lỗi khi lấy danh sách voucher: ', error);
                    });
            }



            // Hàm chuyển đến trang
            $scope.setPage = function(page, status) {
                if (page >= 1 && page <= $scope.totalPages) {
                    $scope.currentPage = page;
                    if (status === undefined) {
                        $scope.filterStatus1 = false;
                        $scope.statusFilter = null; // Cập nhật giá trị của statusFilter
                        $scope.getPagedVouchers($scope.currentPage, $scope.pageSize);
                    } else {
                        $scope.filterStatus1 = true;
                        $scope.statusFilter = status; // Cập nhật giá trị của statusFilter
                        var apiUrl = 'http://localhost:8080/admin/getvoucherbystatus';
                        $scope.getPagedVouchers($scope.currentPage, $scope.pageSize, status, apiUrl);
                    }
                }
            };

            $scope.calculateIndex = function(index) {
                return ($scope.currentPage - 1) * $scope.pageSize + index + 1;
            };
            // Hàm kiểm tra và cập nhật voucher mỗi 12 giờ
            function checkAndUpdateExpiry() {
                $http.get('http://localhost:8080/admin/checkAndUpdateExpiry')
                    .then(function(response) {
                        console.log(response.data); // Hiển thị kết quả từ server
                    })
                    .catch(function(error) {
                        console.error('Lỗi khi kiểm tra và cập nhật voucher: ', error);
                    });
            }

            // Thiết lập kiểm tra định kỳ mỗi 12 giờ
            $interval(checkAndUpdateExpiry, 12 * 60 * 60 * 1000);

            $scope.voucherdetail={};
            $scope.openUpdateModal = function(item) {
                $http.get('http://localhost:8080/admin/voucherDetail/' + item.id)
                    .then(function(response) {
                        // Chuyển đổi định dạng ngày
                        response.data.endDate = new Date(response.data.endDate);

                        // Gán giá trị vào $scope.voucherdetail
                        $scope.voucherdetail = response.data;
                    })
                    .catch(function(error) {
                        console.error('Lỗi khi kiểm tra và cập nhật voucher: ', error);
                    });
                var modal = document.getElementById('updateModal');
                modal.style.display = 'block';
            };

            $scope.closeUpdateModal = function() {
                $scope.voucherdetail={};
                var modal = document.getElementById('updateModal');
                modal.style.display = 'none';
            };


            $scope.errorsupdate = {};
            $scope.updateVoucher = function() {
                $http.put('http://localhost:8080/admin/updatevoucher/' + $scope.voucherdetail.id, $scope.voucherdetail)
                    .then(function(response) {
                        // Xử lý khi cập nhật voucher thành công
                        showTimedSuccessMessage('Cập nhật voucher thành công');
                        $scope.voucherdetail={};
                        $scope.errorsupdate = {};
                        var modal = document.getElementById('updateModal');
                        modal.style.display = 'none';
                        $scope.getPagedVouchers($scope.currentPage, $scope.pageSize);
                    })
                    .catch(function(error) {
                        $scope.errorsupdate = error.data;
                        console.log(error.data);
                    });
            };

            function searchVouchers(searchText, page, size) {
                $http.get('http://localhost:8080/admin/vouchersearch', {
                    params: { searchText: searchText, page: page - 1, size: size }
                })
                    .then(function(response) {
                        // Gán dữ liệu voucher từ response vào danh sách
                        $scope.voucherList = response.data.content;
                        // Cập nhật các biến theo thông tin từ response
                        $scope.totalItems = response.data.totalElements;
                        $scope.totalPages = response.data.totalPages;
                        console.log(response.data.content);
                    })
                    .catch(function(error) {
                        console.error('Lỗi khi tìm kiếm voucher: ', error);
                    });
            }
            $scope.performSearch = function() {
                searchVouchers($scope.searchText, $scope.currentPage, $scope.pageSize);
            }

            // Hàm load dữ liệu dựa trên trạng thái
            $scope.filterByStatus = function(status) {
                $scope.currentPage = 1;
                $scope.getPagedVouchers($scope.currentPage, $scope.pageSize, status); };
            $scope.getPagedVouchers = function(page, size, status, apiUrl) {
                apiUrl = apiUrl || 'http://localhost:8080/admin/getvoucherbystatus'; // Đường dẫn API mặc định
                if (status !== null && status !== undefined) {
                    apiUrl += '/' + status;
                }
                // Kiểm tra và loại bỏ dấu gạch chéo cuối cùng "/"
                if (apiUrl.slice(-1) === '/') {
                    apiUrl = apiUrl.slice(0, -1);
                }
                $http.get(apiUrl, { params: { page: page - 1, size: size } })
                    .then(function(response) {
                        console.log('Dữ liệu phản hồi:', response.data);
                        $scope.filteredVoucherList = response.data.content;
                        $scope.vouchers = response.data.content; // Lưu danh sách voucher từ API
                        $scope.totalItems = response.data.totalElements;
                        $scope.voucherList = $scope.filteredVoucherList;

                        // Tính toán tổng số trang
                        $scope.totalPages = Math.ceil($scope.totalItems / $scope.pageSize);
                    })
                    .catch(function(error) {
                        console.error('Lỗi:', error);
                    });
            };
            $scope.getPagedVouchers($scope.currentPage, $scope.pageSize, $scope.statusFilter);
            // Hàm để chọn/bỏ chọn tất cả voucher
            $scope.toggleAll = function() {
                angular.forEach($scope.voucherList, function(voucher) {
                    voucher.selected = $scope.selectAllHeader;
                });
            };
            $scope.getPagedVouchers($scope.currentPage, $scope.pageSize);

            $scope.showAll = function() {
                $scope.currentPage = 1;
                var apiUrl = 'http://localhost:8080/admin/getvoucherbystatus';
                $scope.getPagedVouchers($scope.currentPage, $scope.pageSize, null, apiUrl);
            };
            $scope.deleteItem = function(item) {
                var url = 'http://localhost:8080/admin/deletevoucher/' + item.id;
                $http.delete(url)
                    .then(function(response) {
                        // Xử lý khi xóa voucher thành công
                        console.log('Voucher deleted successfully');
                        $scope.showAll();
                        showTimedSuccessMessage('Xóa voucher thành công');
                        // Thực hiện cập nhật danh sách voucher hoặc các thao tác khác nếu cần
                    })
                    .catch(function(error) {
                        // Xử lý khi gặp lỗi
                        console.error('Error deleting voucher:', error);
                    });
            };

        }]);

</script>
</html>