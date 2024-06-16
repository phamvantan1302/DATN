<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" pageEncoding="utf-8" %>
<html>
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
</head>
<style>
    form{
        text-align: center;
    }
    .scrollable-table {
        max-height: 200px;
        width: 500px;
        overflow-y: auto;
        border: 1px solid #ccc;
        padding: 10px;
    }
</style>
<body ng-app="myApp">
    <div class="modal" id="paymentModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-body">
                    <h2 style="text-align: center">Giỏ hàng</h2>
                    <table class="table">
                        <thead>
                        <tr>
                            <th><input type="checkbox" ng-model="selectAll" ng-change="toggleSelectAll()"></th>
                            <th>STT</th>
                            <th>Sản phẩm</th>
                            <th>Giá</th>
                            <th>Số lượng</th>
                            <th>Tổng</th>
                            <th>Action</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr ng-repeat="cartDetail in cartDetails">
                            <td><input type="checkbox" ng-model="cartDetail.selected" ng-change="updateSelectAll(cartDetail)"></td>
                            <td>{{calculateIndex($index)}}</td>
                            <td>{{cartDetail.productDetail.product.name}}</td>
                            <td>{{cartDetail.price | number:'0':'0'}}</td>
                            <td>
                                <i class="fas fa-minus" ng-click="giamSoLuong(cartDetail.id)"></i>
                                {{ cartDetail.quantity }}
                                <i class="fas fa-plus" ng-click="tangSoLuong(cartDetail.id)"></i>
                            </td>
                            <td>{{(cartDetail.price * cartDetail.quantity) | number:'0':'0'}}</td>
                            <td>
                                <a ng-click="deleteCartDetail(cartDetail.id)">
                                    <i class="fas fa-trash"></i>
                                </a>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <p class="total-price">Tổng tiền: {{ getTotalPrice() | number:'0':'0' }}</p>
                    <div class="text-center" style="text-align: center">
                        <button ng-click="setPage1(currentPage1 - 1)">Prev</button>
                        <span>Page {{currentPage1}} /{{totalPages1}}</span>
                        <button ng-click="setPage1(currentPage1 + 1)">Next</button>
                    </div>
                    <div ng-if="cartDetails.length === 0">
                        <p>Bạn chưa có sản phẩm nào trong giỏ hàng.</p>
                    </div>
                    <div class="text-center">
                        <button style="text-align: center" class="btn btn-primary" ng-click="checkProductQuantity()" type="submit">MUA NGAY</button>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" ng-click="closeModal1()">Close</button>
                </div>
            </div>
        </div>
    </div>

</body>
<script>
    $scope.selectedProducts = {};
    $scope.selectAll = false;

    $scope.toggleSelectAll = function() {
        if ($scope.selectAll) {
            // Chọn tất cả các sản phẩm trên trang hiện tại
            $scope.cartDetails.forEach(cartDetail => {
                cartDetail.selected = true;
                $scope.selectedProducts[cartDetail.id] = cartDetail;
            });

            // Cập nhật trạng thái của tất cả các sản phẩm trong các trang
            $scope.allCartDetails.forEach(cartDetail => {
                cartDetail.selected = true;
                $scope.selectedProducts[cartDetail.id] = cartDetail;
            });
        } else {
            // Bỏ chọn tất cả các sản phẩm trên trang hiện tại
            $scope.cartDetails.forEach(cartDetail => {
                cartDetail.selected = false;
                delete $scope.selectedProducts[cartDetail.id];
            });

            // Cập nhật trạng thái của tất cả các sản phẩm trong các trang
            $scope.allCartDetails.forEach(cartDetail => {
                cartDetail.selected = false;
                delete $scope.selectedProducts[cartDetail.id];
            });
        }
        $scope.updateTotalPrice();
    };

    $scope.getCartDetails = function() {
        $http.get('http://localhost:8080/AdidasSporst/GetCart', {
            params: {
                page: $scope.currentPage1 - 1,
                size: $scope.pageSize1
            }
        })
            .then(function(response) {
                // Xử lý dữ liệu trả về từ API ở đây
                $scope.cartDetails = response.data.content;
                $scope.totalItems1 = response.data.totalElements;
                $scope.totalPages1 = Math.ceil($scope.totalItems1 / $scope.pageSize1);

                // Cập nhật dữ liệu cho trang hiện tại
                $scope.cartDetails.forEach(cartDetail => {
                    if ($scope.selectedProducts[cartDetail.id]) {
                        cartDetail.selected = true;
                    } else {
                        cartDetail.selected = false;
                    }
                });

                // Cập nhật dữ liệu cho tất cả các trang
                $scope.allCartDetails = response.data.content;

                // Cập nhật trạng thái của checkbox "Chọn Tất Cả"
                $scope.selectAll = Object.keys($scope.selectedProducts).length === $scope.totalItems1;

                if ($scope.currentPage1 > $scope.totalPages1) {
                    $scope.currentPage1 = $scope.totalPages1;
                }
            })
            .catch(function(error) {
                console.error('Error fetching cart details:', error);
            });
    };



    // Cập nhật trạng thái của checkbox khi thay đổi
    $scope.updateSelectAll = function(cartDetail) {
        if (cartDetail.selected) {
            $scope.selectedProducts[cartDetail.id] = cartDetail;
        } else {
            delete $scope.selectedProducts[cartDetail.id];
        }
        $scope.selectAll = Object.keys($scope.selectedProducts).length === $scope.totalItems1;
        $scope.updateTotalPrice();
    };

    // Tính tổng tiền của các sản phẩm được chọn
    $scope.getTotalPrice = function() {
        return Object.values($scope.selectedProducts).reduce((total, cartDetail) => {
            return total + (cartDetail.price * cartDetail.quantity);
        }, 0);
    };




    // Chuyển trang
    $scope.setPage1 = function(page) {
        if (page > 0 && page <= $scope.totalPages1) {
            $scope.currentPage1 = page;
            $scope.getCartDetails();
        }
    };

    // Cập nhật tổng tiền khi các sản phẩm được chọn hoặc bỏ chọn
    $scope.updateTotalPrice = function() {
        $scope.totalPrice = $scope.getTotalPrice();
    };

    // Khởi tạo trang ban đầu
    $scope.init = function() {
        $scope.getCartDetails();
    };

    // Gọi hàm khởi tạo khi controller được tải
    $scope.init();








</script>
</html>