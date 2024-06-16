<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />
    <link href='https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css' rel='stylesheet'>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@10/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
    <!-- Thêm AngularJS -->
    <!-- Toastr CSS -->
    <!-- jQuery (nếu cần) -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

    <!-- Toastr CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css" rel="stylesheet">

    <!-- Toastr JavaScript -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular.min.js"></script>
    <title>Document</title>
</head>
<style>
    @import url('http://fonts.googleapis.com/css?family=Open+Sans:400,700');

    *{
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: "Poppins", sans-serif;
    }
    body{
        background-size: cover;
        font-family: -apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,Oxygen,Ubuntu, Cantarell, " Open Sans", "Helvetica Neue",sans-serif;
        position:relative;
        width: 100%;
    }
    header{
        position:relative;
        pointer-events: auto;
        width: 100%;
        height: 70px;
        background: rgba(0, 0, 0 , 0.8);
        color: white;
        display: flex;
        align-items: center;
        justify-content: space-between;
    }
    .brand{
        display: flex;
        align-items: center;
        height: 100%;
        width: 30%;
        padding: 4%;

    }
    .brand h2{
        margin-left: 5%;
    }
    .navbar{
        position: relative;
        width: 100%;
        padding: 5%;
        height: 100%;
        display: flex;
        align-items: center;
        justify-content: space-evenly;
    }
    .searchBox{
        position: relative;
        width: 50%;
    }
    .searchBox input{
        margin-left: 20px;
        width: 90%;
        height: 35px;
        border: none;
        border-radius: 25px;
        padding: 1%;
        text-indent: 10px;
        font-size: 18px;
        background: linear-gradient(to right, #fce0f0, #e8fffebb);
    }
    .searchBox button{
        position: absolute;
        border-radius: 25px;
        margin-left: -80px;
        border: none;
        width:80px;
        height: 35px;
        background: #e8fffebb;
    }
    #searchIcon{
        position: absolute;
        font-size: 22px;
        margin-top: 7px;
        margin-left: -20px;
    }
    ul.ulheader {
        list-style-type: none;
        padding: 0;
    }

    ul.ulheader li {
        display: inline-block;
        margin-left: 50px; /* Thêm khoảng trống giữa các mục (tuỳ chọn) */
    }
    ul.ulheader li a{
        margin-left: 6%;
        display: block;
        font-size: 22px;
    }
    #headerIcon{
        color: white;
    }
    header ul.ulheader li .tooltip {
        color: white;
        position: absolute;
        margin-left: 20px;
        top: 120px;
        transform: translate(-50%, -50%);
        border-radius: 6px;
        height: 35px;
        width: 115px;
        background: rgba(0, 0, 0 , 0.8);
        line-height: 35px;
        text-align: center;
        box-shadow: 0 5px 10px rgba(0, 0, 0, 0.2);
        transition: 0s;
        opacity: 0;
        pointer-events: none;
        display: block;
    }
    header ul.ulheader li:hover .tooltip {
        transition: all 0.3s ease;
        opacity: 1;
    }
    header.active ul.ulheader li .tooltip {
        display: none;
    }
    article{
        margin-top: 75px;
        position: relative;
        width: 100%;
    }
    footer {
        background: rgba(0, 0, 0 , 0.8);
        float: left;
        height: 150px;
        width: 100%;
        text-align: center;
        padding: 3px;
        color: white;
        bottom: 0;
    }
    .header-visible {
        top: 0 !important;
    }
    .nav_ulli{
        position: relative;
        height: 50px;
        width: 100%;
        background: rgba(0, 0, 0 , 0.8);
        color: white;
        display: flex;
        align-items: center;
        justify-content: space-between;
    }
    .nav_ulli ul{
        margin-left: 20%;
    }
    .nav_ulli a{
        text-decoration: none;
        color: white;
        position: relative;
        display: inline-block;
    }
    .nav_ulli a::before {
        color: rgb(77,77,77);
        content: '';
        position: absolute;
        bottom: 0;
        left: 0;
        width: 0;
        height: 3px;
        background-color: rgb(77,77,77);
        transition: width 0.5s ease-out; /* Hiệu ứng chuyển động cho độ rộng */
    }

    .nav_ulli a:hover::before {
        width: 100%;
        background-color:  rgb(77,77,77);
    }
    .product-container {
        position: relative;
        float: left; /* Thêm thuộc tính float để content nằm bên cạnh sidebar */
        width: calc(100% - 300px);
    }

    .nextprev {
        position: relative;
        text-align: center;
        margin-right: 150px;
    }

    .product-list {
        display: flex;
        flex-wrap: wrap;
        text-align: center;
    }
    .product-card h3 {
        font-family: "Arial", sans-serif; /* Thay đổi font chữ thành Arial */
        font-size: 18px; /* Cỡ chữ */
        font-weight: bold; /* Độ đậm */
        color:rgb(255, 0, 0); /* Chọn một màu sắc nổi bật cho tên sản phẩm */
    }

    .container {
        display: grid;
        grid-template-columns: repeat(2, 1fr); /* Chia trang thành 3 cột có chiều rộng bằng nhau */
        grid-gap: 10px; /* Khoảng cách giữa các cột */
    }

    .column {
        padding: 20px; /* Khoảng cách lề trong cột */
    }
    label{
        height: 30px;
        width: 400px;
        font-size: 15px;
    }
    .aaa{
        background-color: #3c3c3c;
        color: #dce5f5;
        height: 45px;
        width: 300px;
        font-size: 15px;
        cursor: pointer;
        border-radius: 5px; /* Độ cong của các cạnh */
        padding: 10px; /* Khoảng cách giữa nội dung và viền của input và button */
        border: 1px solid #ccc; /* Viền của input và button */

    }
    button:hover {
        background-color: #0c1728;
    }
    .image-row {
        padding-top: 20px;
        display: flex;
        justify-content: center;
        gap: 10px;
    }

    .image-row img {
        width: 10%;
        height: auto;
    }

    .container.selected-image img {
        width: 55%;
        height: auto;
    }
    .row{
        display: flex;
        justify-content: center;
        gap: 10px;
    }
    .thongtinphu{
        border: 1px solid black; /* Viền của input và button */
        padding: 10px;
        border-radius: 5px;
    }

    .custom-button {
        background-color: #3c3c3c;
        color: #dce5f5;
        font-size: 15px;
        cursor: pointer;
        border-radius: 5px; /* Độ cong của các cạnh */
        padding: 10px; /* Khoảng cách giữa nội dung và viền của input và button */
        border: 1px solid #ccc; /* Viền của input và button */

    }

</style>
<body ng-app="myApp" ng-controller="myController">
<div  >
    <header id="header">
        <div class="brand">
            <h2>Adidas Sporst</h2>
        </div>
        <div class="navbar">
            <div class="searchBox">
                <form>
                    <span class="fas fa-search" id="searchIcon"></span>
                    <input type="text" placeholder="Search here ..." ng-model="searchKeyword" ng-change="search()">
                    <button>Search</button>
                </form>
            </div>
            <div class="ul_li">
                <ul class="ulheader">
                    <li>
                        <a ng-click="showHome()">
                            <i class="fas fa-home" id="headerIcon"></i>
                        </a>
                    </li>
                    <li>
                        <a href="#" ng-click="openModal()">
                            <i class="fas fa-shopping-cart" id="headerIcon"></i>
                        </a>
                    </li>
                    <li>
                        <a  ng-click="checkUser()">
                            <i class="fas fa-user" id="headerIcon"></i>
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <i class="fas fa-history" id="headerIcon"></i>
                        </a>
                    </li>
                    <%
                        HttpSession hiSession = request.getSession(false); // Pass false to getSession() to prevent it from creating a new session if none exists
                        if (hiSession != null && hiSession.getAttribute("Client") != null) {
                    %>
                    <li>
                        <a href="/Logout">
                            <i class="fas fa-sign-out-alt" id="headerIcon"></i>
                        </a>
                    </li>
                    <%
                    } else {
                    %>
                    <li>
                        <a href="/Login">
                            <i class="fas fa-sign-in-alt" id="headerIcon"></i>
                        </a>
                    </li>
                    <%
                        }
                    %>
                </ul>
            </div>

        </div>
    </header>
    <div class="nav_ulli">
        <ul class="ulheader">
            <li>
                <a href="/AdidasSporst/Home">
                    <span class="tooltip">Home</span>
                </a>


            </li>
            <li>
                <a href="#">
                    <span class="tooltip">Product</span>
                </a>

            </li>
            <li>
                <a href="#">
                    <span class="tooltip">Order</span>
                </a>
            </li>
            <li>
                <a href="#">
                    <span class="tooltip">Account</span>
                </a>

            </li>
            <li>
                <a href="#">
                    <span class="tooltip">Help</span>
                </a>

            </li>
            <%
                HttpSession mySession = request.getSession(false); // Pass false to getSession() to prevent it from creating a new session if none exists
                if (mySession != null && mySession.getAttribute("Client") != null) {
            %>
            <li>
                <a href="/Logout">
                    <span class="tooltip">Logout</span>
                </a>
            </li>
            <%
            } else {
            %>
            <li>
                <a href="/Login">
                    <span class="tooltip">Login</span>
                </a>
            </li>
            <%
                }
            %>
        </ul>
    </div>
    <article>
        <h2 style="text-align: center">THÔNG TIN CHI TIẾT SẢN PHẨM </h2><br>
        <div class="container">
            <div class="column" style="text-align: center">
                <div class="selected-image">
                    <!-- Hình ảnh được chọn sẽ hiển thị ở đây -->
                </div><br><br>
                <div class="image-row">
                    <c:forEach var="image" items="${img}" varStatus="loop"> <img src="/views/imagesp/${image.name}" alt="Image ${image.name}" onclick="showImage(this)" <c:if test="${loop.first}">class="selected"</c:if>> </c:forEach>   </div>
            </div>

            <div class="column" style=" font-size: 16px"><br>
                <div class="container">
                    <div class="column">
                        <h3>${res[0].productDetail.product.name}</h3><br>
                        <label class="form-label"><b>Giá bán: </b> <span style="color: red;font-size: 20px">${res[0].productDetail.price} VND</span></label><br><br>
                        <label class="form-label"><b>Loại giày: </b> <i>${res[0].productDetail.category.name}</i></label><br><br>
                        <label class="form-label"><b>Chất liệu sản phẩm: </b> <i>${res[0].productDetail.material.name}</i></label><br><br>
                        <label class="form-label"><b>Hãng sản phẩm: </b> <i>${res[0].productDetail.brand.name}</i></label><br><br>
                        <label class="form-label"><b>Chất liệu đế giày: </b> <i>${res[0].productDetail.sole.name}</i></label><br><br>

                        <div id="sizeList">
                            <label class="form-label"><b>Chọn size:</b></label><br>
                            <select id="sizeSelect" onchange="updateColorOptions()">
                                <option value="">Chọn size...</option>
                                <c:forEach var="resItem" items="${res}">
                                    <c:if test="${not fn:contains(displayedSizes, resItem.productDetail.size.name)}">
                                        <option>${resItem.productDetail.size.name}</option>
                                        <c:set var="displayedSizes" value="${displayedSizes},${resItem.productDetail.size.name}" />
                                    </c:if>
                                </c:forEach>
                            </select>
                        </div>

                        <div id="colorList" style="display: none;">
                            <label class="form-label"><b>Chọn màu sắc:</b></label><br>
                            <select id="colorSelect">
                                <!-- Color options will be populated dynamically based on selected size -->
                            </select>
                        </div>

                        <br><br>
                        <button class="aaa" type="submit" ng-click="addToCart()">Thêm vào giỏ</button>
                    </div>
                    <div class="column">
                        <div style="color: red" class="thongtinphu">
                            <h3 >Tin thời trang new</h3>
                            <label>Thông tin tham khảo</label><br><br>
                            <label>Các mẫu giày chạy bộ</label><br><br>
                            <label>CÁCH CHỌN SIZE GIÀY ONITSUKA TIGER</label><br><br>
                            <label>CÁC MẪU ULTRABOOST ĐƯỢC YÊU THÍCH NHẤT 2024</label><br><br>
                            <label>CÁC MẪU GIÀY ONITSUKA TIGER HOTTREND VÀ CÁCH PHỐI ĐỒ 2024</label><br><br>
                            <label></label>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </article>

    <footer class="footer-distributed mt-0 ">

        <div class="footer-left">
            <h3>Adidas Sporst</h3>

            <p class="footer-links">
                <a href="#">Home</a>
                |
                <a href="#">About</a>
                |
                <a href="#">Contact</a>
                |
                <a href="#">Blog</a>
            </p>

            <p class="footer-company-name">Copyright © 2023 <strong>SagarDeveloper</strong> All rights reserved</p>
        </div>

    </footer>
</div>
</body>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
    var app = angular.module('myApp', []);


    app.controller('myController', function($scope, $http,$location) {

        $scope.search = function() {
            var keyword = $scope.searchKeyword;
            // Kiểm tra đường dẫn hiện tại
            if ($location.path() !== '/AdidasSporst/home') {
                // Nếu không phải trang chủ, chuyển hướng về trang chủ
                localStorage.setItem('searchKeyword', keyword);
                window.location.href = '/AdidasSporst/home';
            }
        };
            $scope.addToCart = function() {
            // Lấy giá trị size được chọn
            var selectedSize = document.getElementById("sizeSelect").value;

            // Kiểm tra nếu size đã được chọn
            if (selectedSize) {
                // Lấy giá trị màu được chọn (nếu có)
                var selectedColor = document.getElementById("colorSelect").value;

                // Kiểm tra nếu màu cũng đã được chọn (nếu có)
                if (selectedColor) {
                    // Nếu cả size và color đều đã được chọn, tiến hành tạo đối tượng sản phẩm
                    var product = {
                        id : ${res[0].productDetail.id},
                        size: selectedSize,
                        color: selectedColor
                    };

                    console.log("Sản phẩm sẽ được thêm vào giỏ hàng:", product);

                    // Gửi yêu cầu PUT để tăng số lượng sản phẩm trong giỏ hàng
                    $http.post('http://localhost:8080/AdidasSporst/addgiohangdetailsp',  product)
                        .then(function(response) {
                            // Xử lý phản hồi nếu cần
                            toastr.success('Thêm thành công', 'Thành công', { positionClass: 'toast-top-right' });
                        })
                        .catch(function(error) {

                        });
                } else {
                    // Nếu chỉ có size được chọn nhưng chưa chọn màu
                    toastr.error("Vui lòng chọn màu sắc.", "Lỗi", { positionClass: "toast-top-right" });
                }
            } else {
                // Nếu chưa chọn size
                toastr.error("Vui lòng chọn kích cỡ giày.", "Lỗi", { positionClass: "toast-top-right" });
            }
        };




    });



    function updateColorOptions() {
        var sizeSelect = document.getElementById("sizeSelect");
        var colorList = document.getElementById("colorList");
        var colorSelect = document.getElementById("colorSelect");

        // Clear previous color options
        colorSelect.innerHTML = "";

        // Check if a size is selected
        if (sizeSelect.value !== "") {
            var selectedSize = sizeSelect.value;

            // Iterate through product details to find colors for selected size
            <c:forEach var="res" items="${res}">
            if ("${res.productDetail.size.name}" === selectedSize) {
                // Add colors to color select
                var colorOption = document.createElement("option");
                colorOption.text = "${res.productDetail.color.name}";
                colorOption.value = "${res.productDetail.color.name}";
                colorSelect.appendChild(colorOption);
            }
            </c:forEach>

            // Show color select
            colorList.style.display = "block";
        } else {
            // Hide color select if no size is selected
            colorList.style.display = "none";
        }
    }




    document.addEventListener("DOMContentLoaded", function() {
        // Lấy phần tử hình ảnh được chọn mặc định (đầu tiên)
        let defaultImage = document.querySelector('.image-row img.selected');

        // Sao chép hình ảnh được chọn mặc định vào phần tử .selected-image
        let selectedImageContainer = document.querySelector('.selected-image');
        selectedImageContainer.appendChild(defaultImage.cloneNode(true));
    });

    function showImage(img) {
        // Xóa lớp "selected" khỏi tất cả các hình ảnh
        let images = document.querySelectorAll('.image-row img');
        images.forEach(function(item) {
            item.classList.remove('selected');
        });

        // Thêm lớp "selected" cho hình ảnh được click
        img.classList.add('selected');

        // Hiển thị hình ảnh được click lên phần tử .selected-image
        let selectedImageContainer = document.querySelector('.selected-image');
        selectedImageContainer.innerHTML = '';
        selectedImageContainer.appendChild(img.cloneNode(true));
    }
</script>
</html>