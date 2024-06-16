<%@ page language="java" pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Manage Employees</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
    <script src="https://cdn.rawgit.com/serratus/quaggaJS/0.12.1/dist/quagga.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body ng-app="myApp" ng-controller="myCtrl">
<div>
    <form novalidate ng-submit="add()">
        <div class="row">
            <div class="col-md-6">
                <div class="mb-3">
                    <label for="full_name" class="form-label">Full Name</label>
                    <input type="text" class="form-control"  ng-model="employees.fullName" id="full_name" required/>
                    <div ng-show="errors.fullname" class="text-danger">{{ errors.fullname }}</div>
                </div>

                <div class="mb-3">
                    <label for="name_account" class="form-label">Name Account</label>
                    <input type="text" class="form-control" id="name_account"  ng-model="employees.nameAccount" required/>
                    <div ng-show="errors.nameAccount" class="text-danger">{{ errors.nameAccount }}</div>
                </div>

                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" class="form-control" id="password"  ng-model="employees.password" required/>
                    <div ng-show="errors.password" class="text-danger">{{ errors.password }}</div>
                </div>

                <div class="mb-3">
                    <label for="line" class="form-label">Line</label>
                    <input type="text" class="form-control" id="line"  ng-model="employees.line" required/>
                    <div ng-show="errors.Line" class="text-danger">{{ errors.Line }}</div>
                </div>

                <div class="mb-3">
                    <label for="city" class="form-label">City</label>
                    <input type="text" class="form-control"  ng-model="employees.city" id="city" required/>
                    <div ng-show="errors.city" class="text-danger">{{ errors.city }}</div>
                </div>

                <div class="mb-3">
                    <label class="form-label">Giới tính</label>
                    <div class="form-check">
                        <input type="radio" class="form-check-input" id="male" value="true" ng-model="employees.gender" required/>
                        <label class="form-check-label" for="male">Nam</label>
                    </div>
                    <div class="form-check">
                        <input type="radio" class="form-check-input" id="female" value="false" ng-model="employees.gender" required/>
                        <label class="form-check-label" for="female">Nữ</label>
                    </div>
                </div>
                <div ng-show="errors.gender" class="text-danger">{{ errors.gender }}</div>
            </div>

            <div class="col-md-6">
                <div class="mb-3">
                    <label for="country" class="form-label">Country</label>
                    <input type="text" class="form-control"  ng-model="employees.country" id="country" required/>
                    <div ng-show="errors.country" class="text-danger">{{ errors.country }}</div>
                </div>

                <div class="mb-3">
                    <label for="province" class="form-label">Province</label>
                    <input type="text" class="form-control" id="province"  ng-model="employees.province"required/>
                    <div ng-show="errors.provice" class="text-danger">{{ errors.province }}</div>
                </div>

                <div class="mb-3">
                    <label for="date_of_birth" class="form-label">Date of Birth</label>
                    <input type="date" class="form-control" id="date_of_birth"  ng-model="employees.dateOfBirth" required/>
                    <div ng-show="errors.dateOfBirth" class="text-danger">{{ errors.dateOfBirth}}</div>
                </div>

                <div class="mb-3">
                    <label for="phone_number" class="form-label">Phone Number</label>
                    <input type="text" class="form-control" id="phone_number" ng-model="employees.phoneNumber"  required/>
                    <div ng-show="errors.phoneNumber" class="text-danger">{{ errors.phoneNumber}}</div>
                </div>

                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" class="form-control" id="email" ng-model="employees.email" required/>
                    <div ng-show="errors.email" class="text-danger">{{ errors.email}}</div>
                </div>
                <div class="mb-3">
                    <label for="profile_picture" class="form-label">Profile Picture</label>
                    <input type="file" class="form-control" id="profile_picture" accept="image/*" onchange="previewImage(event)" required/>
                    <img id="preview" src="#" alt="Preview Image" style="display: none; max-width: 100%; max-height: 200px; margin-top: 10px;">
                </div>

            </div>

        </div>

        <button type="submit" class="btn btn-success">Save</button>
    </form>
    <table class="table table-striped table-bordered">
        <thead class="thead-dark">
        <tr>
            <th>Full Name</th>
            <th>Name Account</th>
            <th>Password</th>
            <th>City</th>
            <th>Phone</th>
            <th>Email</th>
            <th>Chức vụ</th>
            <th>Gender</th>
            <th>Trạng thái</th>
            <th colspan="2">Action</th>
        </tr>
        </thead>
        <tbody>
        <tr ng-repeat="employee in employeess">
            <td>{{employee.fullName}}</td>
            <td>{{employee.nameAccount}}</td>
            <td>{{employee.password}}</td>
            <td>{{employee.city}}</td>
            <td>{{employee.phoneNumber}}</td>
            <td>{{employee.email}}</td>
            <td>{{employee.roles}}</td>
            <td>{{employee.gender ? 'Nam' : 'Nữ'}}</td>
            <td [ngStyle]="{'color': employee.status === 0 ? 'blue' : 'red'}">
                {{ employee.status === 0 ? 'Hoạt động' : 'Nghỉ việc' }}
            </td>
            <td>
                <a ng-click="detail(employee.id)" class="btn btn-primary">Update</a>
                <a ng-click="delete(employee.id)" class="btn btn-danger">Nghỉ Việc</a>
            </td>
        </tr>
        </tbody>
    </table>

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
</div>
<!-- Modal -->
<div class="modal " id="updateModal" tabindex="-1" role="dialog" aria-labelledby="updateModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="updateModalLabel">Update Employee Information</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form novalidate ng-submit="update(employeesdetail.id)">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="full_name" class="form-label">Full Name</label>
                                <input type="text" class="form-control"  ng-model="employeesdetail.fullName"  required/>
                                <div ng-show="errors1.fullname" class="text-danger">{{ errors1.fullname }}</div>
                            </div>

                            <div class="mb-3">
                                <label for="name_account" class="form-label">Name Account</label>
                                <input type="text" class="form-control"   ng-model="employeesdetail.nameAccount" required/>
                                <div ng-show="errors1.nameAccount" class="text-danger">{{ errors1.nameAccount }}</div>
                            </div>

                            <div class="mb-3">
                                <label for="password" class="form-label">Password</label>
                                <input type="password" class="form-control"   ng-model="employeesdetail.password" required/>
                                <div ng-show="errors1.password" class="text-danger">{{ errors1.password }}</div>
                            </div>

                            <div class="mb-3">
                                <label for="line" class="form-label">Line</label>
                                <input type="text" class="form-control"  ng-model="employeesdetail.line" required/>
                                <div ng-show="errors1.Line" class="text-danger">{{ errors1.Line }}</div>
                            </div>

                            <div class="mb-3">
                                <label for="city" class="form-label">City</label>
                                <input type="text" class="form-control"  ng-model="employeesdetail.city" required/>
                                <div ng-show="errors1.city" class="text-danger">{{ errors1.city }}</div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Gender</label>
                                <div class="form-check">
                                    <input type="radio" class="form-check-input" ng-model="employeesdetail.gender" ng-value="true" required/>
                                    <label class="form-check-label" for="male">Male</label>
                                </div>
                                <div class="form-check">
                                    <input type="radio" class="form-check-input" ng-model="employeesdetail.gender" ng-value="false" required/>
                                    <label class="form-check-label" for="female">Female</label>
                                </div>

                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="country" class="form-label">Country</label>
                                <input type="text" class="form-control"  ng-model="employeesdetail.country"  required/>
                                <div ng-show="errors1.country" class="text-danger">{{ errors1.country}}</div>
                            </div>

                            <div class="mb-3">
                                <label for="province" class="form-label">Province</label>
                                <input type="text" class="form-control"  ng-model="employeesdetail.province"required/>
                                <div ng-show="errors1.province" class="text-danger">{{ errors1.province }}</div>
                            </div>

                            <div class="mb-3">
                                <label for="date_of_birth" class="form-label">Date of Birth</label>
                                <input type="date" class="form-control"   ng-model="employeesdetail.dateOfBirth" required/>
                                <div ng-show="errors1.dateOfBirth" class="text-danger">{{ errors1.dateOfBirth }}</div>
                            </div>

                            <div class="mb-3">
                                <label for="phone_number" class="form-label">Phone Number</label>
                                <input type="text" class="form-control" ng-model="employeesdetail.phoneNumber"  required/>
                                <div ng-show="errors1.phoneNumber" class="text-danger">{{ errors1.phoneNumber }}</div>
                            </div>

                            <div class="mb-3">
                                <label for="email" class="form-label">Email</label>
                                <input type="email" class="form-control" ng-model="employeesdetail.email" required/>
                                <div ng-show="errors1.email" class="text-danger">{{ errors1.email }}</div>
                            </div>

                        </div>
                    </div>

                    <button type="submit" class="btn btn-success">update</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular.min.js"></script>
<script>
    var app = angular.module('myApp', []);
    app.controller('myCtrl', function ($scope, $http) {
        $scope.currentPage = 1;
        $scope.pageSize = 3;
        $scope.totalItems = 0;
        $scope.totalPages = 0;

        $scope.getEmployeeData = function (page, size) {
            $http.get('http://localhost:8080/staff/getListNhanVien', {
                params: {
                    page: page - 1,
                    size: size
                }
            }).then(function (response) {
                console.log(response.data);
                $scope.employeess = response.data.content;
                $scope.totalItems = response.data.totalElements;
                $scope.totalPages = response.data.totalPages;
            });
        };
        $scope.setPage = function (page) {
            if (page >= 1 && page <= $scope.totalPages) {
                $scope.currentPage = page;
                $scope.getEmployeeData($scope.currentPage, $scope.pageSize);
            }
        };

        $scope.getEmployeeData($scope.currentPage, $scope.pageSize);

        $scope.employees = {}; // Khởi tạo đối tượng employees

        $scope.errors ={}
        $scope.add = function () {
            // Dữ liệu từ các trường input sẽ nằm trong $scope.employees
            // Lấy file ảnh từ trường input file
            var profilePictureFile = document.getElementById('profile_picture').files[0];

            // Kiểm tra xem có file ảnh được chọn hay không
            if (profilePictureFile) {
                var reader = new FileReader();
                reader.onload = function (event) {
                    // Đường dẫn của ảnh sẽ nằm trong event.target.result
                    $scope.employees.img = event.target.result;

                    // Gọi API để thêm mới
                    $http.post('http://localhost:8080/staff/addNhanVien', $scope.employees)
                        .then(function (response) {
                            // Xử lý kết quả từ API nếu cần
                            console.log(response.data);
                            console.log($scope.employees);
                            $scope.getEmployeeData($scope.currentPage, $scope.pageSize);
                            showTimedSuccessMessage('Thêm Thành Công');
                            $scope.employees = {};
                            // Sau khi thêm mới, bạn có thể làm một số công việc khác, ví dụ: làm mới dữ liệu, chuyển trang, ...
                        })
                        .catch(function (error) {
                            // Xử lý lỗi nếu có
                            $scope.errors = error.data;
                            console.error('Error adding employee:', error);
                        });
                };
                // Đọc file ảnh dưới dạng URL dữ liệu
                reader.readAsDataURL(profilePictureFile);
            } else {
                // Nếu không có file ảnh được chọn, tiếp tục gọi API mà không có đường dẫn ảnh
                $http.post('http://localhost:8080/staff/addNhanVien', $scope.employees)
                    .then(function (response) {
                        // Xử lý kết quả từ API nếu cần
                        console.log(response.data);
                        console.log(response.data);
                        console.log($scope.employees);
                        $scope.getEmployeeData($scope.currentPage, $scope.pageSize);
                        showTimedSuccessMessage('Thêm Thành Công');
                        $scope.employees = {};
                        // Sau khi thêm mới, bạn có thể làm một số công việc khác, ví dụ: làm mới dữ liệu, chuyển trang, ...
                    })
                    .catch(function (error) {
                        // Xử lý lỗi nếu có
                        $scope.errors = error.data;
                        console.error('Error adding employee:', error);
                    });
            }
        };

        $scope.detail = function (id) {
            var modal = document.getElementById('updateModal');
            modal.style.display = 'block';
            $http.get('http://localhost:8080/staff/getNhanvienByid/'+ id)
                .then(function (response) {
                    // Xử lý kết quả từ API nếu cần
                    $scope.employeesdetail = response.data;
                    console.log($scope.employeesdetail.gender);
                    // Sau khi thêm mới, bạn có thể làm một số công việc khác, ví dụ: làm mới dữ liệu, chuyển trang, ...
                })
                .catch(function (error) {
                    // Xử lý lỗi nếu có
                    console.error('Error adding employee:', error);
                });
        };
        $scope.errors1= {};
        $scope.update = function (employeeId) {

            $http.put('http://localhost:8080/staff/update/' + employeeId, $scope.employeesdetail)
                .then(function (response) {
                    // Xử lý kết quả sau khi cập nhật thành công
                    console.log('Update successful:', response.data);
                    showTimedSuccessMessage('Update Thành Công');
                    $scope.getEmployeeData($scope.currentPage, $scope.pageSize);
                    var modal = document.getElementById('updateModal');
                    modal.style.display = 'none';
                })
                .catch(function (error) {
                    $scope.errors1 = error.data;
                    // Xử lý lỗi khi gặp vấn đề trong quá trình cập nhật
                    console.error('Error updating employee:', error);
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
        $scope.delete = function(id) {
            // Gọi API DELETE với ID được truyền vào
            $http.delete('http://localhost:8080/staff/delete/' + id)
                .then(function(response) {
                    showTimedSuccessMessage('Update Thành Công');
                    $scope.getEmployeeData($scope.currentPage, $scope.pageSize);
                })
                .catch(function(error) {
                    // Xử lý lỗi
                    console.error('Lỗi khi xóa bản ghi:', error);
                    // Hiển thị thông báo hoặc thực hiện các hành động khác nếu cần
                });
        };


    });

</script>

</body>
</html>
