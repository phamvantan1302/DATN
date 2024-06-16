<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.jsdelivr.net/npm/file-saver"></script>
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link href='https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css' rel='stylesheet'>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
    <script src="https://cdn.rawgit.com/serratus/quaggaJS/0.12.1/dist/quagga.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/angular-ui-bootstrap/3.4.0/ui-bootstrap-tpls.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>Order Form</title>
</head>
<style>
    .custom-modal2 {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.5);
    }

    .modal-container2 {
        max-width: 500px; /* Điều chỉnh chiều rộng tối đa theo ý muốn */
        margin: 30px auto; /* Căn giữa modal */
    }

    .modal-content2 {
        background-color: #fff;
        padding: 20px;
        border-radius: 5px;
    }
    .form-check-input:checked {
        background-color: #4CAF50; /* Màu nền khi checkbox được chọn */
        border-color: #4CAF50; /* Màu viền khi checkbox được chọn */
    }

    .invoice-notification {
        border: 1px solid #ccc;
        border-radius: 8px;
        padding: 20px;
        margin: 20px;
        background-color: #fff;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        position: relative;
    }

    .close {
        position: absolute;
        top: 10px;
        right: 10px;
        font-size: 20px;
        cursor: pointer;
    }

    .invoice-header h3 {
        margin-bottom: 10px;
    }

    .invoice-details {
        margin-bottom: 20px;
    }

    .invoice-label {
        font-weight: bold;
    }

    .invoice-value {
        margin-bottom: 10px;
    }

    .invoice-table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 20px;
    }

    .invoice-table th, .invoice-table td {
        border: 1px solid #ddd;
        padding: 8px;
        text-align: left;
    }

    .total-section {
        font-size: 14px; /* Điều chỉnh kích thước chữ trong total section */
    }

    .total-label, .total-value {
        font-size: 12px; /* Điều chỉnh kích thước chữ trong total label và value */
    }


    .pagination li {
        display: inline;
    }

    .pagination li a,
    .pagination li span {
        position: relative;
        float: left;
        padding: 6px 12px;
        margin-left: -1px;
        line-height: 1.42857143;
        color: #428bca;
        text-decoration: none;
        background-color: #fff;
        border: 1px solid #ddd;
    }

    .pagination li:first-child a,
    .pagination li:first-child span {
        margin-left: 0;
        border-bottom-left-radius: 4px;
        border-top-left-radius: 4px;
    }

    .pagination li:last-child a,
    .pagination li:last-child span {
        border-bottom-right-radius: 4px;
        border-top-right-radius: 4px;
    }

    .pagination li.active span,
    .pagination li.active a,
    .pagination li.active:hover a,
    .pagination li.active:hover span {
        z-index: 2;
        color: #fff;
        cursor: default;
        background-color: #428bca;
        border-color: #428bca;
    }

    .pagination li.disabled span,
    .pagination li.disabled a,
    .pagination li.disabled:hover a,
    .pagination li.disabled:hover span {
        color: #777;
        cursor: not-allowed;
        background-color: #fff;
        border-color: #ddd;
    }
    /* style.css */
    .modal {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.5);
    }
    .full-width {
        width: 100%;
    }

    .modal-content {
        background-color: #fff;
        margin: 5% auto;
        padding: 20px;
        border: 1px solid #ddd;
        width: 70%;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        border-radius: 10px;
        overflow-y: auto;
    }

    .close {
        float: right;
        font-size: 24px;
        font-weight: bold;
        cursor: pointer;
        color: #555;
    }

    .invoice-header {
        text-align: center;
        margin-bottom: 20px;
    }

    .invoice-details {
        margin-top: 10px;
    }

    .invoice-section {
        display: flex;
        justify-content: space-between;
        margin-bottom: 10px;
    }

    .invoice-label {
        font-weight: bold;
        color: #555;
    }

    .invoice-table {
        width: 100%;
        margin-top: 20px;
        border-collapse: collapse;
    }

    .invoice-table th, .invoice-table td {
        border: 1px solid #ddd;
        padding: 12px;
        text-align: left;
        color: #555;
    }

    .total-section {
        display: flex;
        justify-content: flex-end;
        margin-top: 20px;
    }

    .total-label {
        font-weight: bold;
        margin-right: 10px;
        color: #555;
    }

    /* Đặt margin-top: auto để nút thanh toán chạm đáy modal */
    #paymentModal .mt-auto {
        margin-top: auto;
    }
    .total-value {
        font-weight: bold;
        color: #333;
    }
    .scrollable-table {
        height: 150px;
        overflow-y: auto;
        border: 1px solid #ccc;
        padding: 10px;
        background-color: white;
    }
    .scrollable-table1 {
        height: 250px;
        overflow-y: auto;
        border: 1px solid #ccc;
        padding: 10px;
        background-color: white;
    }
    .custom-modal2 .modal-body {
        height: 400px;
        overflow-y: auto; /* Cho phép cuộn dọc khi cần */
        padding-right: 20px;
    }
</style>
<body ng-app="myApp" ng-controller="myController">
<div>
    <div class="row">
        <!-- Cột bên trái -->
        <div class="col-4">
            <form ng-submit="updateOrder()">
                <div class="row">
                    <div class="mb-6">
                        <video class="text-center" id="video" width="300px" height="200" autoplay></video>
                    </div>

                    <div class="mb-6">
                        <label for="phoneNumber" class="form-label">Số Điện Thoại:</label>
                        <input type="text" ng-model="selectedOrderInfo.phoneNumber" class="form-control" id="phoneNumber">
                    </div>

                    <div class="mb-3">
                        <label for="fullname" class="form-label">Tên:</label>
                        <input type="text" ng-model="selectedOrderInfo.useName" class="form-control" id="fullname">
                    </div>

                    <div class="mb-3">
                        <label class="form-check-label" for="deliveryCheckbox">Giao hàng</label>
                        <input type="checkbox" class="form-check-input" id="deliveryCheckbox" ng-model="isDeliveryChecked" ng-checked="isDeliveryChecked || (selectedOrderInfo.address && selectedOrderInfo.address.trim() !== '')" ng-change="toggleDeliveryForm()">
                    </div>

                    <!-- Phần nhập địa chỉ giao hàng, chỉ hiển thị khi checkbox được chọn -->
                    <div class="mb-3" ng-if="isDeliveryChecked || selectedOrderInfo.address">
                        <label for="deliveryInput">Nhập địa chỉ giao hàng:</label>
                        <input type="text" class="form-control" id="deliveryInput" ng-model="selectedOrderInfo.address">
                    </div>

                    <div class="mb-3" ng-if="isDeliveryChecked || selectedOrderInfo.address">
                        <label for="deliveryInput">Sđt Nhận Hàng:</label>
                        <input type="text" class="form-control" id="deliveryInputsdt" ng-model="selectedOrderInfo.sdtnhanhang">
                    </div>

                    <div class="mb-3" ng-if="isDeliveryChecked || selectedOrderInfo.address">
                        <label for="deliveryInput">Người Nhận:</label>
                        <input type="text" class="form-control" id="deliveryInputnguoinhan" ng-model="selectedOrderInfo.nguoinhan">
                    </div>

                    <div class="mb-6">
                        <label for="totalMoney" class="form-label">Tổng Tiền:</label>
                        <input type="text" class="form-control" ng-model="selectedOrderInfo.tongtienhang | number:'0':'0'" id="totalMoney" disabled>
                    </div>
                    <div class="my-2 d-flex justify-content-center">
                        <button class="btn btn-primary mx-2">Thanh Toán</button>
                    </div>
                </div>
            </form>
        </div>

        <div class="col-8">
        <div class="row">
            <div class="my-2 d-flex align-items-center">
                <button class="btn btn-info btn-sm mr-2" ng-click="neworder()">Tạo Hóa Đơn</button>
            </div>

            <div class="table-responsive scrollable-table">
                <table class="table table-striped table-bordered">
                    <thead class="table-danger">
                    <tr>
                        <!-- Checkbox để chọn/bỏ chọn tất cả discount periods -->
                        <th>

                        </th>
                        <th>STT</th>
                        <th>Mã Hóa Đơn</th>
                        <th>Trạng Thái</th>
                        <th>Action</th>
                    </tr>
                    </thead>
                    <tbody>
                    <!-- Dùng ng-repeat để lặp qua danh sách discount periods -->
                    <tr ng-repeat="order in ordersByStatus">
                        <td>
                            <!-- Checkbox cho từng đơn hàng -->
                            <input type="checkbox" ng-model="order.selected" ng-change="selectOnlyOne(order)" />
                        </td>
                        <td>{{$index + 1}}</td>
                        <td>{{order.code}}</td>
                        <td>{{ order.status === 4 ? 'Chờ thanh toán' : order.status }}</td>
                        <td><button class="btn btn-danger" ng-click="deleteOrder(order.id)">Xóa</button></td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="row mt-4">
            <div class="my-2 d-flex align-items-center">
            <button class="btn btn-info btn-sm mr-2" ng-click="openlistspmodal()">Thêm</button>
        </div>
            <div class="table-responsive scrollable-table1">
                <table class="table table-striped table-bordered">
                    <thead>
                    <tr class="table-danger">
                        <th>STT</th>
                        <th>Tên Sp</th>
                        <th>Số Lượng</th>
                        <th>Giá</th>
                        <th colspan="2">Action</th>
                    </tr>
                    </thead>
                    <tbody>
                    <!-- Dùng ng-repeat để lặp qua danh sách discount periods -->
                    <tr ng-repeat="orderdetail in orderdetails">
                        <td>{{$index+1}}</td>
                        <td>{{orderdetail.productDetail.product.name}}</td>
                        <td contenteditable="true" ng-bind="orderdetail.quantity" ng-blur="updateQuantity(orderdetail.id, $event.target.innerText)"></td>
                        <td>{{orderdetail.productDetail.price  }}VND</td>
                        <td><button class="btn btn-danger" ng-click="deleteOrderDetail(orderdetail.id)">Xóa</button></td>
                        <td><button class="btn btn-danger" ng-click="updateOrderDetail(orderdetail.id)">update</button></td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
        </div>
    </div>
    </div>
</div>
<div id="listspmodal" class="modal">
    <div class="modal-content">
        <form class="form-inline" ng-submit="searchDiscountPeriods()">
            <div class="form-group">
                <label class="mr-2">Tìm kiếm:</label>
                <input type="text" ng-model="keyword" class="form-control" placeholder="Nhập từ khóa">
            </div>
            <button type="submit" class="btn btn-primary ml-2">Tìm kiếm</button>
        </form>
        <table class="table table-striped table-bordered">
            <thead class="table-danger">
            <tr>
                <th>STT</th>
                <th>IMG</th>
                <th>Tên SP</th>
                <th>Đơn giá</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody>
            <!-- Dùng ng-repeat để lặp qua danh sách productdetails -->
            <tr ng-repeat="productdetail in productdetails">
                <td>{{ calculateIndex($index) }}</td>
                <td><img style="height: 100px; width: 100px;"></td>
                <td>{{productdetail.product.name}}</td>
                <td>{{productdetail.price | number:'':'0'}}VND</td>
                <td><button class="btn btn-primary" ng-click="openAddProductModal(productdetail.id)" >Thêm</button></td>
            </tr>
            </tbody>
        </table>
        <!-- Phân trang -->
        <div class="pagination-container">
            <!-- Nút và thông tin phân trang -->
            <button class="btn btn-primary" ng-click="setPage(currentPage - 1)" ng-disabled="currentPage === 1">
                Previous
            </button>
            <span class="pagination-info">Trang {{ currentPage }} / {{ totalPages }}</span>
            <button class="btn btn-primary" ng-click="setPage(currentPage + 1)" ng-disabled="currentPage === totalPages">
                Next
            </button>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-primary" data-bs-dismiss="modal" ng-click="closeModal()">OK</button>
        </div>
    </div>

</div>
<div id="addProductModal" class="modal" >
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Nhập số lượng sản phẩm</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- Nội dung modal để nhập số lượng -->
                <label for="quantityInput">Số lượng:</label>
                <input type="number" id="quantityInput" min="1" ng-model="quantity" class="form-control">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" ng-click="addProduct(Idproductdetail,quantity,selectedOrderInfo.id)">Thêm sản phẩm</button>
                <button type="button" class="btn btn-secondary" ng-click="closeModalSoluong()" data-bs-dismiss="modal">Đóng</button>
            </div>
    </div>
</div>
<div id="customModal" class="custom-modal2">
    <div class="modal-container2">
        <div class="modal-content2">
            <div class="modal-header">
                <h4 class="modal-title">Thông tin </h4>
            </div>
            <div class="modal-body">
                <div class="form-group d-flex justify-content-between mb-3">
                    <label for="totalPrice" class="mb-0">Tổng Sản Phẩm:</label>
                    <p class="mb-0">{{tongsoluong}}</p>
                </div>

                <div class="form-check form-switch">
                    <input class="form-check-input" type="checkbox" ng-model="vouchercheckbox" value="1" ng-change="toggleVoucher(selectedOrderInfo)">
                    <label class="form-check-label" for="mySwitch">Áp Dụng Voucher</label>
                </div>
                <div class="form-group" ng-show="vouchercheckbox">
                    <hr>
                    <label for="voucherCode">Voucher Code:</label>
                    <div class="input-group">
                        <input type="text" class="form-control" ng-model="voucherCode">
                        <button type="button" class="btn btn-primary" ng-click="addVoucher(selectedOrderInfo)">
                            <i class='bx bx-add-to-queue'></i>
                        </button>
                    </div>
                </div>
                <div class="voucher-info" ng-repeat="voucherDetail in voucherDetails">
                    <hr>
                    <div class="form-group d-flex justify-content-between mb-3">
                        <p class="mb-0"><strong>Voucher:</strong> {{ voucherDetail.voucher.code }}</p>
                        <p class="mb-0"><strong>Mệnh giá:</strong> {{ voucherDetail.menhgia | currency:'':0 }}</p>
                        <!-- Thêm sự kiện click -->
                        <div id="closeIconContainer" ng-click="deletevoucherdetail(voucherDetail)">
                            <!-- Bạn có thể đặt biểu tượng ở đây -->
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-x" viewBox="0 0 16 16">
                                <path d="M13.354 15.354a1 1 0 0 1-1.415 0L8 9.414 3.061 14.353a1 1 0 1 1-1.414-1.414L6.586 8 1.647 2.061a1 1 0 0 1 1.415-1.414L8 6.586l4.939-4.939a1 1 0 0 1 1.415 1.414L9.414 8l4.939 4.939a1 1 0 0 1 0 1.415z"/>
                            </svg>
                        </div>
                    </div>

                </div>
                <div  class="d-flex justify-content-between mb-3" ng-if="!selectedOrderInfo.address">
                    <div class="form-check">
                        <input class="form-check-input" ng-model="selectedOrderInfo.hinhthucthanhtoan" type="radio" name="paymentOption" id="paymentAtCounter" value="0" checked>
                        <label class="form-check-label" for="paymentAtCounter">Thanh toán tại quầy</label>
                    </div>
                </div>

                <div class="d-flex justify-content-between mb-3" ng-if="selectedOrderInfo.address">
                    <div class="form-check">
                        <input class="form-check-input" ng-model="selectedOrderInfo.hinhthucthanhtoan" type="radio" name="paymentOption" id="paymentAtCounter" value="0" checked>
                        <label class="form-check-label" for="paymentAtCounter">Thanh toán tại quầy</label>
                    </div>
                        <div class="form-check">
                            <input class="form-check-input"  ng-model="selectedOrderInfo.hinhthucthanhtoan"  type="radio" name="paymentOption" id="payment50Percent" value="2">
                            <label class="form-check-label" for="payment50Percent">Thanh toán trước 50%</label>
                        </div>

                    <!-- Nếu tổng tiền hàng dưới 10 triệu, hiển thị radio button nhận hàng thanh toán -->
                    <div ng-if="selectedOrderInfo.totalMoney <= 10000000 || isDeliveryChecked">
                        <div class="form-check">
                            <input class="form-check-input"  ng-model="selectedOrderInfo.hinhthucthanhtoan"  type="radio" name="paymentOption" id="paymentOnDelivery" value="1">
                            <label class="form-check-label" for="paymentOnDelivery">Nhận hàng thanh toán</label>
                        </div>
                    </div>
                </div>
                <div class="form-group d-flex justify-content-between mb-3">
                    <label for="totalPrice" class="mb-0">Tổng:</label>
                    <p class="mb-0">{{selectedOrderInfo.totalMoney | currency:'':0}}</p>
                </div>

                <div class="form-group d-flex justify-content-between mb-3">
                    <label for="totalPrice" class="mb-0">Chiết Khấu (Trực Tiếp):</label>
                    <p class="mb-0">-{{ selectedOrderInfo.chietkhau | currency:'':0 }} Vnd</p>
                </div>
                <div ng-if="selectedOrderInfo.address">
                    <div class="form-group d-flex justify-content-between mb-3">
                        <label for="shippingCost" class="mb-0">Tiền Ship:</label>
                        <p class="mb-0">{{ selectedOrderInfo.moneyShip | currency:'':0 }} Vnd</p>
                    </div>
                </div>
                <hr> <!-- Dòng kẻ bên trên -->
                <div class="form-group d-flex justify-content-between mb-3">
                    <label for="totalAmount" class="mb-0">Khách cần trả:</label>
                    <p class="mb-0">{{selectedOrderInfo.tongtienhang | currency:'':0 }} Vnd</p>
                </div>
            </div>
            <div class="modal-footer">
                <!-- Change ng-click to call a function that toggles showFullContent -->
                <button type="button" class="btn btn-success w-100" ng-click="xuathoadon(selectedOrderInfo)">Thanh Toán</button>
                <br>
                <button type="button" class="btn btn-danger w-100" ng-click="deleteTCKMandVoucher(selectedOrderInfo.id)">Hủy</button>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    document.addEventListener("DOMContentLoaded", function () {

    });
    var app = angular.module('myApp', []);

    app.controller('myController', function($scope, $http) {
        var video = document.getElementById('video');
        var scanning = false; // Biến flag để kiểm soát trạng thái của quét


        // Cấu hình QuaggaJS
        Quagga.init({
            inputStream: {
                name: "Live",
                type: "LiveStream",
                target: video
            },
            decoder: {
                readers: ["ean_reader", "code_128_reader"]
            }
        }, function (err) {
            if (err) {
                console.error(err);
                return;
            }
            // Bắt đầu QuaggaJS
            Quagga.start();
        });

        // Bắt sự kiện khi có kết quả từ QuaggaJS

        Quagga.onDetected(function (result) {
            if (!scanning) {
                return;
            }

            console.log('Barcode result:', result.codeResult.code);
            // Kiểm tra xem có đơn hàng đã được chọn hay không
            if ($scope.selectedOrder && $scope.selectedOrder.id) {
                // Gọi API để gửi mã vạch lên server
                $http.post('http://localhost:8080/staff/scan-barcode', { image: result.codeResult.code, id: $scope.selectedOrder.id })
                    .then(function (response) {

                        showTimedSuccessMessage('Thêm Sản Phẩm Thành Công');
                        $http.get('http://localhost:8080/staff/listProdyctByOrder/' + $scope.selectedOrder.id)
                            .then(function (response) {
                                $scope.orderdetails = response.data;
                                console.log("List products by order:", response.data);
                                $http.get('http://localhost:8080/staff/oneOrder/' + $scope.selectedOrder.id)
                                    .then(function(response) {
                                        console.log('API Response:', response.data);
                                        // Lưu thông tin của order vào biến nếu cần
                                        $scope.selectedOrderInfo = response.data;
                                    })
                                    .catch(function(error) {
                                        console.error('Error calling API:', error);
                                    });
                            })
                            .catch(function (error) {
                                console.error('Error calling API for product list:', error);
                            });



                    })
                    .catch(function (error) {
                        console.error('Error calling API:', error);
                    });
            } else {
                // Sử dụng alert để hiển thị thông báo khi không có đơn hàng được chọn
                Swal.fire('Lỗi', 'Chọn Hóa Đơn Để Quét Mã.', 'error');
            }

            // Dừng quét để tránh quét liên tục
            scanning = false;
        });

        navigator.mediaDevices.getUserMedia({ video: true })
            .then(function (stream) {
                video.srcObject = stream;
                video.play();

                // Hạn chế quét mỗi 5 giây
                setInterval(function () {
                    if (!scanning) {
                        Quagga.start();
                        scanning = true;
                    }
                }, 5000);
            })
            .catch(function (err) {
                console.error('Error accessing webcam:', err);
            });
        $scope.neworder = function (){
            $http.get('http://localhost:8080/staff/OrDerOff')
            .then(function (response){
                $scope.getOrdersByStatus(4);
                showTimedSuccessMessage('Tạo Hóa Đơn Thành Công');
                console.log('API Response:', response.data);
            }).catch(function(error){
                console.error('Error calling API Option 1:', error);
            });
        };
        $scope.getOrdersByStatus = function(status) {
            $http.get('http://localhost:8080/staff/Order/' + status)
                .then(function (response) {
                    console.log('API Response:', response.data);
                    // Gán danh sách đơn hàng vào biến $scope
                    $scope.ordersByStatus = response.data;
                })
                .catch(function (error) {
                    console.error('Error calling API:', error);
                });
        };
        $scope.getOrdersByStatus(4);

        $scope.selectedOrder = null;
        $scope.totalMoney = 0;

        $scope.selectOnlyOne = function(selectedOrder) {
            // Kiểm tra xem đã có order nào được chọn trước đó không
            if ($scope.selectedOrder !== null && $scope.selectedOrder !== selectedOrder) {
                // Nếu có, hủy chọn order trước đó
                $scope.selectedOrder.selected = false;
            }

            // Kiểm tra xem có order nào được chọn hay không
            if (!$scope.ordersByStatus.some(order => order.selected)) {
                // Nếu không có order nào được chọn, đặt selectedOrder về null
                $scope.selectedOrder = null;
                $scope.selectedOrderInfo = null;
                $scope.orderdetails = [];
            } else {
                // Lưu order hiện tại vào biến selectedOrder
                $scope.selectedOrder = selectedOrder;

                // Gọi API để lấy thông tin của order khi checkbox được chọn
                $http.get('http://localhost:8080/staff/oneOrder/' + $scope.selectedOrder.id)
                    .then(function(response) {
                        console.log('API Response:', response.data);
                        // Lưu thông tin của order vào biến nếu cần
                        $scope.selectedOrderInfo = response.data;
                    })
                    .catch(function(error) {
                        console.error('Error calling API:', error);
                    });

                // Gọi API để lấy danh sách sản phẩm của order khi checkbox được chọn
                $http.get('http://localhost:8080/staff/listProdyctByOrder/' + $scope.selectedOrder.id)
                    .then(function(response) {
                        $scope.orderdetails = response.data;
                        console.log("List products by order:", response.data);
                    })
                    .catch(function(error) {
                        $scope.orderdetails = [];
                        console.error('Error calling API:', error);
                    });
            }
        };
        //delete
        $scope.deleteOrder = function (orderId) {
            $http.delete('http://localhost:8080/staff/DeleteOrder/' + orderId)
                .then(function (response) {
                    console.log('API Response:', response.data);
                    // Gọi lại hàm getOrdersByStatus sau khi xóa để cập nhật danh sách
                    $scope.getOrdersByStatus(4);
                    $scope.orderdetails =[];
                    showTimedSuccessMessage('Xóa Hóa Đơn Thành Công');
                })
                .catch(function (error) {
                    console.error('Error calling DELETE API:', error);
                });

        };
        $scope.deleteOrderDetail = function(orderDetailId) {
            $http.delete('http://localhost:8080/staff/DeleteOrderdetail/' + orderDetailId)
                .then(function (response) {
                    console.log('API Response:', response.data);
                    showTimedSuccessMessage('Xóa Sản Phẩm Thành Công');
                    $http.get('http://localhost:8080/staff/listProdyctByOrder/' + $scope.selectedOrder.id)
                        .then(function (response) {
                            $scope.orderdetails = response.data;


                        })
                        .catch(function (error) {
                            $scope.orderdetails = [];
                        });
                    $http.get('http://localhost:8080/staff/oneOrder/' + $scope.selectedOrder.id)
                        .then(function(response) {
                            console.log('API Response:', response.data);
                            // Lưu thông tin của order vào biến nếu cần
                            $scope.selectedOrderInfo = response.data;
                        })
                        .catch(function(error) {
                            console.error('Error calling API:', error);
                        });
                })
                .catch(function (error) {
                    console.error('Error calling API:', error);
                    // Xử lý lỗi nếu cần
                });
        };
        $scope.updateOrder = function() {
            // Kiểm tra xem checkbox có được chọn không
            if ($scope.selectedOrder) {
                // Nếu checkbox đã được chọn, thực hiện các thao tác cần thiết
                $http.put('http://localhost:8080/staff/UpdateOrderdetail/' + $scope.selectedOrder.id, $scope.selectedOrderInfo,$scope.orderdetails)
                    .then(function(response) {
                        console.log('API Response:', response.data);

                        // Xử lý kết quả nếu cần
                        $scope.getOrdersByStatus(4);
                        // Hiển thị thông báo thành công
                        $scope.orderdetails =[];
                        $scope.openPaymentModal($scope.selectedOrder.id);
                    })
                    .catch(function(error) {
                        console.error('Error calling API:', error);

                        // Hiển thị thông báo lỗi
                        var errorMessage = error.data && error.data.phonenumber ? error.data.phonenumber : 'Đã xảy ra lỗi trong quá trình cập nhật.';

                        if (error.data && error.data.orderdetails) {
                            errorMessage = error.data.orderdetails;
                        }
                        Swal.fire('Lỗi', errorMessage, 'error');
                    });
            } else {
                // Nếu checkbox chưa được chọn, hiển thị thông báo lỗi
                Swal.fire('Lỗi', 'Vui lòng chọn Hóa Đơn Để Thanh Toán.', 'error');
            }
        };
        $scope.showModal = false;
        $scope.openPaymentModal = function(idordercheckbox) {
            $http.get('http://localhost:8080/staff/listproductOrder/' + idordercheckbox)
                .then(function(response) {
                    $scope.items = response.data;
                    $scope.tongsoluong = 0;
                    for (var i = 0; i < $scope.items.length; i++) {
                        $scope.tongsoluong += $scope.items[i].quantity;
                    }
                })
                .catch(function(error) {
                    console.error('Error getting product info:', error);
                });
            // Lấy tất cả các input radio trong cùng một nhóm

            $http.get('http://localhost:8080/staff/oneOrder/' + idordercheckbox)
                .then(function(response) {
                    console.log('API Response:', response.data);
                    // Lưu thông tin của order vào biến nếu cần
                    $scope.selectedOrderInfo = response.data;
                    $scope.selectedOrderInfo.hinhthucthanhtoan=0;
                })
                .catch(function(error) {
                    console.error('Error calling API:', error);
                });
            $http.get('http://localhost:8080/staff/GetDiscount/' + idordercheckbox)
                .then(function(response) {
                    console.log('discount:', response.data);
                    // Lưu thông tin của order vào biến nếu cần
                    $scope.discountbyorder = response.data;
                })
                .catch(function(error) {
                    console.error('Error calling API:', error);
                });

            $http.get('http://localhost:8080/staff/Getdiscountdetailproduct/' + idordercheckbox)
                .then(function(response) {
                    console.log('productdiscount:', response.data);
                    // Lưu thông tin của order vào biến nếu cần
                    $scope.productdiscount = response.data;
                })
                .catch(function(error) {
                    console.error('Error calling API:', error);
                });

            var modal = document.getElementById('customModal');
            modal.style.display = 'block';
        };

        $scope.confirmPayment = function() {
            // Đoạn mã xác nhận thanh toán
            if ($scope.selectedOrder) {
                // ... (như trong hàm updateOrder của bạn)
            }

            // Đóng modal sau khi xác nhận thanh toán
            $scope.cancelPayment();
        };

        $scope.cancelPayment = function() {
            $scope.selectedOrderInfo = null;
            $scope.selectedOrder = null;
            var modal = document.getElementById('paymentModal');
            modal.style.display = 'none';
        };

        $scope.checkPriceCondition = function(startPrice, endPrice) {

            return $scope.selectedOrderInfo.totalMoney >= startPrice && $scope.selectedOrderInfo.totalMoney <= endPrice;
        };

        // Trong controller của bạn
        $scope.discountperioddetail = {};
        $scope.getProductInfo = function(discountperiod) {
            // Kiểm tra xem discountperiod có tồn tại không
            if (discountperiod) {
                 $http.get('http://localhost:8080/admin/ProductDetailsByDiscountPeriod/' + discountperiod.id)
                    .then(function(response) {
                        // Xử lý kết quả và gán thông tin sản phẩm vào discountperiod
                        $scope.discountperioddetail = response.data;
                        console.log(response.data);
                    })
                    .catch(function(error) {
                        console.error('Error getting product info:', error);
                    });
            }
        };
        $scope.openlistspmodal = function () {
            if ($scope.selectedOrder) {
                $scope.getProducts($scope.currentPage, $scope.pageSize);
                var modallistsp = document.getElementById('listspmodal');
                modallistsp.style.display = 'block';
            }else {
                // Nếu checkbox chưa được chọn, hiển thị thông báo lỗi
                Swal.fire('Lỗi', 'Vui lòng chọn Hóa Đơn Để Thêm Sản Phẩm.', 'error');
            }

        };

        $scope.currentPage = 1;
        $scope.pageSize = 3;
        $scope.totalItems = 0;
        $scope.totalPages = 0;

        $scope.setPage = function (page) {
            if (page >= 1 && page <= $scope.totalPages) {
                $scope.currentPage = page;
                $scope.getProducts($scope.currentPage, $scope.pageSize);
            }
        };

        $scope.getProducts = function (page, size) {
            var url = 'http://localhost:8080/staff/listproductdetail';
            $http.get(url, { params: { page: page - 1, size: size } })
                .then(function(response) {
                    console.log('Dữ liệu phản hồi:', response.data);
                    $scope.productdetails = response.data.content;
                    $scope.totalItems = response.data.totalElements;

                    // Tính toán tổng số trang
                    $scope.totalPages = Math.ceil($scope.totalItems / $scope.pageSize);
                })
                .catch(function(error) {
                    console.error('Lỗi:', error);
                });
        };
        $scope.calculateIndex = function(index) {
            return ($scope.currentPage - 1) * $scope.pageSize + index + 1;
        };
        $scope.closeModal = function() {
            var modallistsp = document.getElementById('listspmodal');
            modallistsp.style.display = 'none';
        };
        $scope.openAddProductModal = function (idproductdetail) {
            $scope.Idproductdetail=idproductdetail;
            var modalsoluong = document.getElementById('addProductModal');
            modalsoluong.style.display = 'block';
        };
        $scope.closeModalSoluong = function() {
            var modallistsp = document.getElementById('addProductModal');
            modallistsp.style.display = 'none';
        };

        $scope.addProduct = function (Idproductdetail,quantity,idorder) {
            $scope.addProduct = function (Idproductdetail, quantity, idorder) {
                // Gọi API thông qua $http service
                $http({
                    method: 'POST',
                    url: 'http://localhost:8080/staff/addSanPham',
                    params: {
                        Idproductdetail: Idproductdetail,
                        idorder: idorder,
                        quantity: quantity
                    }
                }).then(function (response) {
                    // Xử lý kết quả từ API nếu cần
                    console.log('API Response:', response.data);
                    $scope.quantity = 0;
                    showTimedSuccessMessage('Thêm Sản Phẩm Thành Công');
                    $http.get('http://localhost:8080/staff/listProdyctByOrder/' + $scope.selectedOrder.id)
                        .then(function (response) {
                            $scope.orderdetails = response.data;
                            console.log("List products by order:", response.data);
                            $http.get('http://localhost:8080/staff/oneOrder/' + $scope.selectedOrder.id)
                                .then(function(response) {
                                    console.log('API Response:', response.data);
                                    // Lưu thông tin của order vào biến nếu cần
                                    $scope.selectedOrderInfo = response.data;
                                })
                                .catch(function(error) {
                                    console.error('Error calling API:', error);
                                });
                        })
                        .catch(function (error) {
                            console.error('Error calling API for product list:', error);
                        });
                    var modalsoluong = document.getElementById('addProductModal');
                    modalsoluong.style.display = 'none';
                }).catch(function (error) {
                    // Xử lý lỗi nếu có
                    console.error('API Error:', error);
                    if (error.data && error.data.status === "error") {
                        Swal.fire('Lỗi', error.data.message, 'error');
                    } else {
                        // Xử lý lỗi khác nếu cần
                        Swal.fire('Lỗi', 'Đã xảy ra lỗi', 'error');
                    }
                });
            };
        }
        function showTimedSuccessMessage(message, time) {
            Swal.fire({
                title: 'Thông báo',
                text: message,
                icon: 'success',
                timer: time || 1200,
                showConfirmButton: false
            });
        }
        function showTimedErrorMessage(message, time) {
            Swal.fire({
                title: 'Lỗi',
                text: message,
                icon: 'error',
                timer: time || 2000,
                showConfirmButton: false
            });
        }
        $scope.deleteTCKMandVoucher = function(orderId) {
            $http.delete('http://localhost:8080/staff/deleteTCKMandvoucherbyorder/' + orderId)
                .then(function(response) {
                    // Xử lý kết quả khi xóa thành công
                    $scope.selectedOrderInfo;
                    console.log('Order deleted successfully:', response.data);
                    $scope.updateOrderCheckedState(orderId);

                })
                .catch(function(error) {
                    console.error('Error deleting order:', error);
                });

            var modal = document.getElementById('customModal');
            modal.style.display = 'none';
        };
        $scope.updateOrderCheckedState = function(orderId) {
            // Tìm order có id tương ứng và cập nhật trạng thái checked
            var foundOrder = $scope.ordersByStatus.find(order => order.id === orderId);
            if (foundOrder) {
                foundOrder.selected = true;

                // Gọi hàm để cập nhật trạng thái checked và hiển thị thông tin của order
                $scope.selectOnlyOne(foundOrder);
            }
        };

        $scope.addVoucher = function (selectedOrderInfo) {
            console.log('Voucher Code:', $scope.voucherCode); // Kiểm tra giá trị của voucherCode

            var request = {
                voucherCode: $scope.voucherCode,
                order: selectedOrderInfo // Thêm thông tin order vào đây
            };

            $http.post('http://localhost:8080/staff/addvoucher', request)
                .then(function(response) {
                    // Kiểm tra dữ liệu trả về từ server
                    var data = response.data;
                    if (data && data.status === "success") {
                        showTimedSuccessMessage(data.message, 2000);
                    }
                    if (response.data && response.data.status === "error") {
                        Swal.fire('Lỗi', response.data.message, 'error');
                    }
                    $scope.voucherCode = null;
                    $http.get('http://localhost:8080/staff/getvoucherbyorder/' +selectedOrderInfo.id)
                        .then(function(response) {
                            // Xử lý kết quả từ server
                            $scope.voucherDetails = response.data;
                            console.log(response.data);
                        })
                        .catch(function(error) {
                            console.error('Error getting vouchers:', error);
                        });
                    $http.get('http://localhost:8080/staff/oneOrder/' + selectedOrderInfo.id)
                        .then(function(response) {
                            console.log('API Response:', response.data);
                            // Lưu thông tin của order vào biến nếu cần
                            $scope.selectedOrderInfo = response.data;
                        })
                        .catch(function(error) {
                            console.error('Error calling API:', error);
                        });
                })
                .catch(function(error) {
                    console.error('Error adding voucher:', error);
                    // Xử lý lỗi từ server và hiển thị thông báo lỗi
                    if (error.data && error.data.status === "error") {
                        Swal.fire('Lỗi', error.data.message, 'error');
                    } else {
                        // Xử lý lỗi khác nếu cần
                        Swal.fire('Lỗi', 'Đã xảy ra lỗi', 'error');
                    }
                });


        };
        $scope.toggleVoucher = function(order) {
            if (!$scope.vouchercheckbox) {
                // Gọi API để xóa voucher khi checkbox được hủy tích
                $http.delete('http://localhost:8080/staff/Deletevoucherdetail/' + order.id)
                    .then(function(response) {
                        // Xử lý kết quả từ server nếu cần
                        console.log('Voucher deleted successfully');
                        $http.get('http://localhost:8080/staff/getvoucherbyorder/' + order.id)
                            .then(function(response) {
                                // Xử lý kết quả từ server
                                $scope.voucherDetails = response.data;
                                console.log(response.data);

                            })
                            .catch(function(error) {
                                console.error('Error getting vouchers:', error);
                            });
                        $http.get('http://localhost:8080/staff/oneOrder/' + order.id)
                            .then(function(response) {
                                console.log('API Response:', response.data);
                                // Lưu thông tin của order vào biến nếu cần
                                $scope.selectedOrderInfo = response.data;
                            })
                            .catch(function(error) {
                                console.error('Error calling API:', error);
                            });
                    })
                    .catch(function(error) {
                        console.error('Error deleting voucher:', error);
                    });
            }
        };
        $scope.deletevoucherdetail = function (voucherDetail){
            $http.delete('http://localhost:8080/staff/deletevoucherdetailbyid/' + voucherDetail.id)
                .then(function(response) {
                    // Xử lý kết quả từ server nếu cần
                    console.log('Voucher deleted successfully');
                    $http.get('http://localhost:8080/staff/getvoucherbyorder/' + voucherDetail.order.id)
                        .then(function(response) {
                            // Xử lý kết quả từ server
                            $scope.voucherDetails = response.data;
                            $http.get('http://localhost:8080/staff/oneOrder/' + voucherDetail.order.id)
                                .then(function(response) {
                                    console.log('API Response:', response.data);
                                    // Lưu thông tin của order vào biến nếu cần
                                    $scope.selectedOrderInfo = response.data;
                                })
                                .catch(function(error) {
                                    console.error('Error calling API:', error);
                                });
                        })
                        .catch(function(error) {
                            console.error('Error getting vouchers:', error);
                        });

                })
                .catch(function(error) {
                    console.error('Error deleting voucher:', error);
                });
        }
        $http.get('http://localhost:8080/staff/startUpdating')
            .then(function(response) {
                console.log('API call successful');
            })
            .catch(function(error) {
                console.error('API call failed:', error);
            });

        $scope.xuathoadon = function(order) {
            // Cập nhật trạng thái của đơn hàng trước khi tạo hóa đơn
            order.hinhthucthanhtoan = $scope.selectedOrderInfo.hinhthucthanhtoan;
            $http.put('http://localhost:8080/staff/updateorder/' + order.id, order)
                .then(function(response) {
                    var radioButtons = document.getElementsByName("paymentOption");
                    var isChecked = false;
                    for (var i = 0; i < radioButtons.length; i++) {
                        if (radioButtons[i].checked) {
                            isChecked = true;
                            break;
                        }
                    }
                    if (!isChecked) {
                        showTimedErrorMessage('Vui lòng chọn hình thức thanh toán.', 2000); // Thông báo lỗi nếu không có input radio nào được chọn
                        return;
                    }
                    // Nếu cập nhật trạng thái thành công, tiếp tục tạo hóa đơn PDF
                    $http.get('http://localhost:8080/staff/generate-invoice/' + order.id, { responseType: 'arraybuffer' })
                        .then(function(response) {
                            // Tạo một Blob từ dữ liệu trả về
                            var blob = new Blob([response.data], { type: 'application/pdf' });

                            // Tạo một URL đối với Blob
                            var url = URL.createObjectURL(blob);

                            // Tạo một thẻ a để tải xuống tệp PDF
                            var link = document.createElement('a');
                            link.href = url;
                            link.download = order.code+'.pdf';
                            link.click();
                            showTimedSuccessMessage('Thanh Toán Hóa Đơn Thành Công');
                            $scope.selectedOrderInfo = {};
                            $scope.getOrdersByStatus(4);
                            var modal = document.getElementById('customModal');
                            modal.style.display = 'none';
                        })
                        .catch(function(error) {
                            console.error('Error generating invoice:', error);
                        });
                })
                .catch(function(error) {
                    console.error('Error updating order status:', error);
                });
        };
        $scope.toggleDeliveryForm = function() {
            if (!$scope.isDeliveryChecked) {
                // Nếu checkbox không được chọn, gán giá trị null cho selectedOrderInfo.address và các trường khác
                $scope.selectedOrderInfo.address = null;
                $scope.selectedOrderInfo.sdtnhanhang = null;
                $scope.selectedOrderInfo.nguoinhan = null;
            }
        };
        $scope.updateQuantity = function(orderDetailId, newQuantity) {
            var url = 'http://localhost:8080/staff/updatesoluong/' + orderDetailId;
        console.log(newQuantity);
            $http.put(url, parseInt(newQuantity))
                .then(function(response) {
                    console.log('Số lượng đã được cập nhật thành công!');
                    // Thực hiện các hành động cần thiết sau khi cập nhật
                    $http.get('http://localhost:8080/staff/listProdyctByOrder/' + $scope.selectedOrder.id)
                        .then(function (response) {
                            $scope.orderdetails = response.data;
                            console.log("List products by order:", response.data);
                            $http.get('http://localhost:8080/staff/oneOrder/' + $scope.selectedOrder.id)
                                .then(function(response) {
                                    console.log('API Response:', response.data);
                                    // Lưu thông tin của order vào biến nếu cần
                                    $scope.selectedOrderInfo = response.data;
                                })
                                .catch(function(error) {
                                    console.error('Error calling API:', error);
                                });
                        })
                        .catch(function (error) {
                            console.error('Error calling API for product list:', error);
                        });
                })
                .catch(function(error) {
                    console.error('Đã xảy ra lỗi khi cập nhật số lượng:', error);
                });
        };
    });
    // /generate-invoice

</script>
</html>
