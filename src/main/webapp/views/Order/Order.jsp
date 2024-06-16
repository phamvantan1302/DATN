<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="en" ng-app="myApp">
<head>
    <meta charset="UTF-8">
    <title>Quản lý hóa đơn</title>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
    <script src="https://cdn.rawgit.com/serratus/quaggaJS/0.12.1/dist/quagga.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

</head>
<body>
<div ng-controller="OrderController" >
    <h1 class="mt-5">Quản lý hóa đơn</h1>
    <!-- Bộ lọc theo trạng thái -->
    <div class="row mt-3">
        <div class="col-md-6">
            <div class="input-group">
                <label class="input-group-text" for="statusSelect">Trạng thái</label>
                <select class="form-select" id="statusSelect" ng-model="selectedStatus">
                    <option value="">Tất cả</option>
                    <option value="5">Đã thanh toán</option>
                    <option value="6">Chờ giao hàng</option>
                    <option value="7">Đã thanh toán và chờ giao hàng</option>
                    <option value="8">Đã hủy</option>
                </select>
            </div>
        </div>
        <div class="col-md-6">
            <button class="btn btn-primary" ng-click="getOrdersByStatus()">Lọc</button>
        </div>
    </div>
    <table  class="table mt-3" ng-if="orders && orders.length > 0">
        <thead>
        <tr>
            <th scope="col">ID</th>
            <th scope="col">Mã</th>
            <th scope="col">Tên khách hàng</th>
            <th scope="col">Tổng tiền</th>
            <th scope="col">Hình Thức Thanh Toán</th>
            <th scope="col">Ngày tạo</th>
            <th scope="col">Trạng thái</th>
            <th scope="col">Thao tác</th>
        </tr>
        </thead>
        <tbody>
        <tr ng-repeat="order in orders">
            <td>{{ order.id }}</td>
            <td>{{ order.code }}</td>
            <td>{{ order.useName }}</td>
            <td>{{ order.tongtienhang }}</td>
            <td>
                <span ng-if="order.hinhthucthanhtoan == 0" class="text-success">Tại Quầy</span>
                <span ng-if="order.hinhthucthanhtoan == 1" class="text-warning">Ship COD</span>
                <span ng-if="order.hinhthucthanhtoan == 2" class="text-warning">TT 50%</span>
                <span ng-if="order.hinhthucthanhtoan == 3" class="text-warning">TT Onl</span>
            </td>
            <td>{{ formatDate(order.createDate) }}</td>
            <td>
                <span ng-if="order.status == 5" class="text-success">Đã thanh toán</span>
                <span ng-if="order.status == 6" class="text-warning">Đang giao hàng</span>
                <span ng-if="order.status == 7" class="text-warning">Đã thanh toán trước 50%</span>
                <span ng-if="order.status == 8" class="text-danger">Đơn hàng bị hủy</span>
            </td>
            <td>
                <button class="btn btn-primary" ng-click="openOrderModal(order.id)">View</button>
                <!-- Modal view -->
                <div class="modal fade" id="orderModal{{ order.id }}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLabel">Thông tin hóa đơn</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body" style="max-height: 500px; overflow-y: auto;">
                                <!-- Order details -->
                                <p><strong>Mã hóa đơn:</strong> {{ order.code }}</p>
                                <p><strong>Khách Hàng:</strong> {{ order.useName }}</p>
                                <p><strong>Sđt:</strong> {{ order.phoneNumber }}</p>
                                <p><strong>Trạng Thái :</strong></p>
                                <div class="progress" ng-if="order.status == 5">
                                    <div class="progress-bar bg-success" role="progressbar" style="width: 100%;" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100">Đã thanh toán</div>
                                </div>
                                <div class="progress" ng-if="order.status == 6">
                                    <div class="progress-bar bg-warning" role="progressbar" style="width: 50%;" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100">Chờ Nhận Hàng</div>
                                </div>
                                <div class="progress" ng-if="order.status == 7">
                                    <div class="progress-bar bg-info" role="progressbar" style="width: 75%;" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100">Đã thanh toán và chờ giao hàng</div>
                                </div>
                                <div class="progress" ng-if="order.status == 8">
                                    <div class="progress-bar bg-primary" role="progressbar" style="width: 25%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">Đã thanh toán trước</div>
                                </div>

                                <hr>
                                <!-- Table of products -->
                                <table class="table">
                                    <thead>
                                    <tr>
                                        <th scope="col">STT</th>
                                        <th scope="col">Tên sản phẩm</th>
                                        <th scope="col">Số lượng</th>
                                        <th scope="col">Đơn giá</th>
                                        <th scope="col">Tổng</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr ng-repeat="product in modalOrder">
                                        <td>{{ $index + 1 }}</td>
                                        <td>{{ product.productDetail.product.name }}</td>
                                        <td contenteditable="true" ng-bind="product.quantity" ng-blur="updateQuantity(product.id, $event.target.innerText)"></td>
                                        <td>{{ product.price1 | number:'':'0'}}VND </td>
                                        <td>{{ product.price | number:'':'0'}}VND</td>
                                    </tr>
                                    </tbody>
                                </table>
                                <hr>
                                <!-- Additional information -->
                                <p ><strong>Tổng Tiền:</strong> <span style="float: right;">{{ order.tongtienhang | number:'':'0'}}VND</span></p>
                                <p ><strong>Ship:</strong> <span style="float: right;">{{ order.moneyShip }}</span></p>
                                <p ><strong>Voucher:</strong><span style="float: right;">{{- totalVoucherUsed }}</span></p>
                                <p ><strong>Chiết khấu TCKM:</strong> <span style="float: right;">{{- order.chietkhau }}</span></p>
                                <p><strong>Cần Thanh Toán:</strong> <span style="float: right;">{{ order.totalMoney | number:'':'0'}}VND</span></p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Hiển thị nút chỉnh sửa cho tất cả các trạng thái ngoại trừ 5 -->
                <button class="btn btn-warning" ng-if="order.status !== 5 && order.status !== 8" ng-click="openUpdateModal(order.id)">Edit</button>

                    <div class="modal fade" id="updateModal" tabindex="-1" aria-labelledby="updateModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="updateModalLabel">Cập nhật thông tin hóa đơn {{selectedOrderInfo.code}}</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <form name="orderForm" >
                                        <div class="mb-3">
                                            <label for="recipientName" class="form-label">Tên người nhận</label>
                                            <input type="text" class="form-control" id="recipientName" name="recipientName" ng-model="selectedOrderInfo.nguoinhan" required>
                                            <div class="text-danger" ng-show="errors && errors.nguoinhan">{{ errors.nguoinhan }}</div>
                                        </div>

                                        <div class="mb-3">
                                            <label for="recipientAddress" class="form-label">Địa chỉ nhận hàng</label>
                                            <input type="text" class="form-control" id="recipientAddress" name="recipientAddress" ng-model="selectedOrderInfo.address" required>
                                            <div class="text-danger" ng-show="errors && errors.address">{{ errors.address }}</div>
                                        </div>

                                        <div class="mb-3">
                                            <label for="recipientPhone" class="form-label">Số điện thoại người nhận</label>
                                            <input type="text" class="form-control" id="recipientPhone" name="recipientPhone" ng-model="selectedOrderInfo.sdtnhanhang" required>
                                            <div class="text-danger" ng-show="errors && errors.sdtnhanhang">{{ errors.sdtnhanhang }}</div>
                                        </div>

                                    </form>
                                    <table class="table">
                                        <thead>
                                        <tr>
                                            <th scope="col">STT</th>
                                            <th scope="col">Tên sản phẩm</th>
                                            <th scope="col">Số lượng</th>
                                            <th scope="col">Đơn giá</th>
                                            <th scope="col">Tổng</th>
                                            <th scope="col" colspan="2">Action</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <tr ng-repeat="product in listspupdate">
                                            <td>{{ $index + 1 }}</td>
                                            <td>{{ product.productDetail.product.name }}</td>
                                            <td contenteditable="true" ng-bind="product.quantity" ng-blur="updateQuantity(product.id, $event.target.innerText)"></td>
                                            <td>{{ product.price1 | number:'':'0'}}VND </td>
                                            <td>{{ product.price | number:'':'0'}}VND</td>
                                            <td>
                                                <button class="btn btn-warning">update</button>
                                                <button class="btn btn-danger" ng-click="deleteOrderDetail(product)">delete</button>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                    <!-- Tổng tiền -->
                                    <p><strong>Tổng Tiền:</strong> <span style="float: right;">{{ selectedOrderInfo.totalMoney | number:'':'0'}}VND</span></p>
                                    <!-- Số tiền khách hàng trả -->
                                    <p><strong>chiết khấu:</strong> <span style="float: right;">{{ selectedOrderInfo.chietkhau| number:'':'0'}}VND</span></p>
                                    <!-- Số tiền cần thanh toán -->
                                    <p><strong>Tiền Ship</strong> <span style="float: right;">+{{ selectedOrderInfo.moneyShip | number:'':'0'}}VND</span></p>
                                    <p><strong>Cần Thanh Toán:</strong> <span style="float: right;">{{ selectedOrderInfo.tongtienhang | number:'':'0'}}VND</span></p>

                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                    <button type="button" class="btn btn-primary" ng-click="updateOrder(selectedOrderInfo)">Lưu thay đổi</button>
                                </div>
                            </div>
                        </div>
                    </div>
                <!-- Hiển thị nút xóa cho tất cả các trạng thái ngoại trừ 5 -->
                <button class="btn btn-danger" ng-if="order.status !== 5 && order.status !== 8 || order.status==6"  ng-click="deleteOrder(order.id)">Delete</button>
            </td>
        </tr>
        </tbody>
    </table>
    <div class="alert alert-warning" role="alert" ng-if="!orders || orders.length === 0">
        Không có dữ liệu phù hợp.
    </div>
    <div class="pagination-container">
        <!-- Nút và thông tin phân trang -->
        <button class="btn btn-primary" ng-click="setPage(currentPage - 1, selectedStatus)" ng-disabled="currentPage === 1">
            Previous
        </button>
        <span class="pagination-info">Trang {{ currentPage }} / {{ totalPages }}</span>
        <button class="btn btn-primary" ng-click="setPage(currentPage + 1, selectedStatus)" ng-disabled="currentPage === totalPages">
            Next
        </button>
    </div>
</div>

<script>
    angular.module('myApp', [])
        .controller('OrderController', function($scope, $http) {
            $scope.currentPage = 1;
            $scope.pageSize = 6;
            $scope.selectedStatus = null; // Thay đổi giá trị mặc định thành null

            $scope.getOrdersByStatus = function() {
                var params = {
                    page: $scope.currentPage-1,
                    size: $scope.pageSize
                };

                // Kiểm tra nếu selectedStatus có giá trị thì thêm vào params
                if ($scope.selectedStatus !== null) {
                    params.status = $scope.selectedStatus;
                }

                $http.get('http://localhost:8080/staff/Order', {
                    params: params
                })
                    .then(function(response) {
                        $scope.orders = response.data.content;
                        $scope.totalPages = response.data.totalPages;
                    })
                    .catch(function(error) {
                        console.error('Error fetching orders:', error);
                    });
            };

            // Gọi hàm để lấy dữ liệu ban đầu
            $scope.getOrdersByStatus();
            $scope.setPage = function(page) {
                // Nếu chỉ số trang âm, đặt lại là 1 (trang đầu tiên)
                if (page < 1) {
                    page = 1;
                }
                $scope.currentPage = page;
                $scope.getOrdersByStatus();
            };
            $scope.openOrderModal = function(orderId) {
                $http.get('http://localhost:8080/staff/listproductOrder/' + orderId)
                    .then(function(response) {
                        $scope.modalOrder = response.data;

                    })
                    .catch(function(error) {
                        console.error('Error fetching order details:', error);
                    });
                $http.get('http://localhost:8080/staff/getvoucherbyorder/' + orderId)
                    .then(function(response) {
                        $scope.modalVoucher = response.data;
                        console.log($scope.modalVoucher);
                        $scope.totalVoucherUsed = 0;
                        for (var i = 0; i < $scope.modalVoucher.length; i++) {
                            $scope.totalVoucherUsed += $scope.modalVoucher[i].menhgia;
                        }

                    })
                    .catch(function(error) {
                        console.error('Error fetching order details:', error);
                    });
                $('#orderModal' + orderId).modal('show');
            };
            $scope.selectedOrderInfo = {};

            $scope.openUpdateModal = function(orderId) {
                $http.get('http://localhost:8080/staff/oneOrder/' + orderId)
                    .then(function(response) {
                        console.log('API Response:', response.data);
                        // Lưu thông tin của order vào biến nếu cần
                        $scope.selectedOrderInfo = response.data;
                    })
                    .catch(function(error) {
                        console.error('Error calling API:', error);
                    });
                $http.get('http://localhost:8080/staff/listproductOrder/' + orderId)
                    .then(function(response) {
                        $scope.listspupdate = response.data;
                        console.log($scope.listspupdate);


                    })
                    .catch(function(error) {
                        console.error('Error fetching order details:', error);
                    });
                $('#updateModal').modal('show');
            };

            $scope.deleteOrderDetail = function(orderDetailId) {
                $http.delete('http://localhost:8080/staff/DeleteOrderdetailbyqlorder/' + orderDetailId.id)
                    .then(function (response) {
                        console.log('API Response:', response.data);

                        showTimedSuccessMessage('Xóa Sản Phẩm Thành Công');
                        $http.get('http://localhost:8080/staff/listproductOrder/' + orderDetailId.order.id)
                            .then(function(response) {
                                $scope.listspupdate = response.data;
                                console.log(orderDetailId.order.id);
                                $('#updateModal').modal('show');
                            })
                            .catch(function(error) {
                                console.error('Error fetching order details:', error);
                            });
                        $scope.getOrdersByStatus();
                    })
                    .catch(function (error) {
                        console.error('Error calling API:', error);
                        // Xử lý lỗi nếu cần
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
            $scope.updateOrder = function() {

                // Gọi API để cập nhật thông tin hóa đơn
                $http.put('http://localhost:8080/staff/updateOrder/' + $scope.selectedOrderInfo.id, $scope.selectedOrderInfo)
                    .then(function(response) {
                        showTimedSuccessMessage('Cập Nhật thành công');
                        // Đóng modal sau khi cập nhật thành công
                        $('#updateModal').modal('hide');
                    })
                    .catch(function(error) {
                        if (error.data && typeof error.data === 'object') {
                            // Nếu có lỗi, lưu trữ chúng vào errors
                            $scope.errors = error.data;
                        } else {
                            // Nếu không có lỗi cụ thể, xóa tất cả các lỗi
                            $scope.errors = {};
                            // Xử lý kết quả trả về từ server
                            showTimedSuccessMessage('Cập Nhật thành công');

                            // Đóng modal sau khi cập nhật thành công
                            $('#updateModal').modal('hide');

                            // Hiển thị thông báo thành công nếu muốn
                            // Ví dụ: toastr.success("Thông tin hóa đơn đã được cập nhật thành công!");
                        }
                    });
            };

            $scope.deleteOrder = function(orderId) {
                $http.delete('http://localhost:8080/staff/deleteorder/' + orderId)
                    .then(function(response) {
                        showTimedSuccessMessage('Hủy thành công');
                        $scope.getOrdersByStatus();
                    })
                    .catch(function(error) {
                        showTimedSuccessMessage('Hủy thành công');
                    });
            };
            $scope.updateQuantity = function(orderDetailId, newQuantity) {
                var url = 'http://localhost:8080/staff/updatesoluongorder/' + orderDetailId;
                console.log(newQuantity);
                $http.put(url, parseInt(newQuantity))
                    .then(function(response) {
                        console.log('Số lượng đã được cập nhật thành công!');


                        // Thực hiện các hành động cần thiết sau khi cập nhật
                        $http.get('http://localhost:8080/staff/listProdyctByOrder1/' + $scope.selectedOrderInfo.id)
                            .then(function(response) {
                                $scope.listspupdate = response.data;
                                console.log($scope.selectedOrderInfo.id);
                                $http.get('http://localhost:8080/staff/oneOrder/' + $scope.selectedOrderInfo.id)
                                    .then(function(response) {
                                        console.log('API Response:', response.data);
                                        // Lưu thông tin của order vào biến nếu cần
                                        $scope.selectedOrderInfo = response.data;
                                    })
                                    .catch(function(error) {
                                        console.error('Error calling API:', error);
                                    });
                                $http.get('http://localhost:8080/staff/listProdyctByOrder/' + $scope.selectedOrderInfo.id)
                                    .then(function(response) {
                                        console.log('API Response:', response.data);
                                        // Lưu thông tin của order vào biến nếu cần
                                        $scope.listspupdate = response.data;

                                    })
                                    .catch(function(error) {
                                        console.error('Error calling API:', error);
                                    });


                            })
                            .catch(function(error) {
                                console.error('Error fetching order details:', error);
                            });
                    })

                    .catch(function(error) {
                        console.error('Đã xảy ra lỗi khi cập nhật số lượng:', error);
                    });
            };






        });

</script>
</body>
</html>
