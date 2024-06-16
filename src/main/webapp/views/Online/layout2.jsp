<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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

    .product-card {
        border: 1px solid #ccc;
        border-radius: 8px;
        margin: 10px;
        padding: 15px;
        width: 250px;
    }

    .product-card img {
        max-width: 100%;
        height: auto;
        border-radius: 25px;
    }

    .button_cart{
        border-radius: 25px;
        margin-left: 30px;
        height: 25px;width: 25px ;
        background-color:  rgb(77,77,77); /* Đặt màu nền của button là transparent */
        border: 1px solid transparent ;
    }
    /*hover ảnh */
    .hover_img {
        width: 100%;
        height: auto;
        transition: transform 0.3s ease;
    }

    .product-card:hover .hover_img {
        transform: scale(1.1);
    }

    /* sidebar */
    .sidebar {
        float: left;
        height: 75vh;
        max-width: 25%;
        color: black;
        border-radius: 75px;
        box-sizing: border-box;
        align-items: center;
    }

    .color-section,

    .color-section h2,
    .product-section h2 {
        font-size: 18px;
        margin-bottom: 10px;
    }

    .product-section ul {
        list-style-type: none;
        padding: 0;
        margin: 0;
    }

    .product-section li {
        margin-bottom: 8px;
    }

    .product-section a {
        text-decoration: none;
        color: #fff;
        font-size: 16px;
        transition: color 0.3s ease;
    }

    .product-section a:hover {
        color: #ffd700; /* Màu khi hover */
    }
    /* Sidebar */
    .sidebar {
        background-color: #f4f4f4;
        padding: 20px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        border-radius: 10px;
        width: 300px;
    }

    .sidebar h2 {
        font-size: 20px;
        color: #333;
        margin-bottom: 15px;
    }

    /* Filter Section */
    .filter-section {
        margin-bottom: 20px;
    }

    .filter-section h3 {
        font-size: 18px;
        color: #555;
        margin-bottom: 10px;
    }

    /* Color Section */
    .color-section label {
        display: block;
        margin-bottom: 5px;
    }

    /* Price Range Section */
    .price-range-section label {
        display: block;
        margin-bottom: 5px;
    }
    .sidebar {
        padding: 20px;
        background-color: #f8f9fa;
        border-radius: 10px;
    }

    .filter-section h2 {
        margin-bottom: 10px;
    }


    .selected-color {
        margin-top: 20px;
    }

    .selected-color h3 {
        margin-bottom: 10px;
    }

    .selected-color-box {
        width: 50px;
        height: 50px;
        border: 1px solid #ddd;
        margin-top: 5px;
    }

    .color-section {
        margin-bottom: 20px;
    }

    .color-options label {
        display: block;
        margin-bottom: 10px;
    }

    .color-sample {
        display: inline-block;
        width: 20px;
        height: 20px;
        border: 1px solid #000;
        margin-right: 10px;
    }

    .red { background-color: red; }
    .green { background-color: green; }
    .blue { background-color: blue; }
    .sidebar {
        width: 200px;
        padding: 20px;
        background-color: #f0f0f0;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    .filter-section h2 {
        font-size: 18px;
        margin-bottom: 15px;
        color: #333;
    }

    .color-section h3,
    .price-range-section h3 {
        font-size: 16px;
        margin-bottom: 10px;
        color: #555;
    }

    .color-options label,
    .price-options label {
        display: block;
        margin-bottom: 10px;
        cursor: pointer;
    }

    .color-sample {
        display: inline-block;
        width: 20px;
        height: 20px;
        border: 1px solid #000;
        margin-right: 10px;
        margin-bottom: 5px; /* Thêm khoảng cách dưới cho mỗi mẫu màu */
    }

    .red {
        background-color: red;
    }

    .green {
        background-color: green;
    }

    .blue {
        background-color: blue;
    }

    /* Thêm CSS cho các màu khác tại đây */
    .yellow {
        background-color: yellow;
    }

    .orange {
        background-color: orange;
    }

    .purple {
        background-color: purple;
    }

    .pink {
        background-color: pink;
    }

    .cyan {
        background-color: cyan;
    }

    .brown {
        background-color: brown;
    }

    .grey {
        background-color: grey;
    }

    /* Style for modal */
    .modal {
        display: none; /* Ẩn modal mặc định */
        position: fixed;
        z-index: 2000;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        background-color: darkgrey;
    }

    .modal-dialog {
        width: 90%; /* Chiều rộng của modal */
        max-width: 1000px;
    }

    .modal-content {
        border-radius: 10px;
        max-width: 1000px;
    }

    .modal-header {
        background-color: #f8f9fa; /* Màu nền header */
        border-bottom: none; /* Loại bỏ viền dưới của header */
    }

    .modal-body {
        padding: 20px;
    }

    .modal-footer {
        background-color: darkgrey; /* Màu nền footer */
        border-top: none; /* Loại bỏ viền trên của footer */
    }


    /* Table */
    .table {
        width: 100%;
        border-collapse: collapse;
    }

    .table th, .table td {
        border: 1px solid #ddd;
        padding: 8px;
        text-align: center;
    }

    .table th {
        background-color: #000;
        color: #fff;
    }

    .table tbody tr:nth-child(even) {
        background-color: #f8f9fa;
    }

    /* Buttons */
    .btn-primary, .btn-secondary {
        padding: 10px 20px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }

    .btn-primary {
        background-color: #000;
        color: #fff;
    }

    .btn-primary:hover {
        background-color: #333;
    }

    .btn-secondary {
        background-color: #6c757d;
        color: #fff;
    }

    .btn-secondary:hover {
        background-color: #545b62;
    }
    .total-price {
        margin-left: 350px;
        color: red;
        font-size: 16px;
        font-weight: bold;
    }
    .total-price1 {
        margin-left: 750px;
        color: red;
        font-size: 16px;
        font-weight: bold;
    }

    #userArticle {
        height: 300px;
        width: 80%; /* Độ rộng */
        margin: 0 auto; /* Căn giữa theo chiều ngang */
        padding: 20px; /* Khoảng cách giữa các thành phần bên trong */
        background-color: #f9f9f9; /* Màu nền */
        border: 1px solid #ddd; /* Viền */
        border-radius: 8px; /* Bo tròn các góc */
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* Đổ bóng */
    }

    /* Định dạng cho các label */
    label {
        margin-right: 10px; /* Khoảng cách giữa label và input */
    }

    /* Định dạng cho các input */
    input {
        padding: 5px; /* Khoảng cách bên trong input */
        border: 1px solid #ccc; /* Đường viền của input */
        border-radius: 4px; /* Bo tròn các góc của input */
    }
    #thanhtoan{
        width: 75%;
        min-height: 350px;
        margin: auto;
    }



    /* Định dạng cho các div chứa input */
    #userArticle div {
        display: flex;
        justify-content: center;
        flex-wrap: wrap;
        margin-bottom: 20px; /* Khoảng cách giữa các div chứa input */
    }

    /* Định dạng cho mỗi div chứa input */
    #userArticle div > div {
        flex: 1; /* Chia đều không gian cho mỗi div */
        margin-right: 10px; /* Khoảng cách giữa các ô input */
    }

    /* Định dạng cho các h2 */
    h2 {
        margin-bottom: 10px; /* Khoảng cách giữa tiêu đề và nội dung */
    }
    .container3 {
        margin-top: 20px;
        display: grid;
        grid-template-columns: repeat(2, 1fr); /* Chia trang thành 3 cột có chiều rộng bằng nhau */
    }

    .column {
        padding: 20px; /* Khoảng cách lề trong cột */
    }
    .container3 >label{
        height: 30px;
    }
    .container3 >input{
        height: 30px;
        width: 400px;
        font-size: 15px;
        border-radius: 5px; /* Độ cong của các cạnh */
        padding: 5px; /* Khoảng cách giữa nội dung và viền của input và button */
        border: 1px solid #ccc; /* Viền của input và button */
    }
    #thanhtoan .tt{
        background-color: gray;
        color: #dce5f5;
        height: 45px;
        width: 200px;
        font-size: 15px;
        cursor: pointer;
        border-radius: 5px; /* Độ cong của các cạnh */
        padding: 10px; /* Khoảng cách giữa nội dung và viền của input và button */
        border: 1px solid #ccc; /* Viền của input và button */
        display: block; /* Đảm bảo nút là một block element */
        margin: 0 auto; /* Canh giữa theo chiều ngang */

    }

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

    .custom-modal2 .modal-body {
        height: 400px;
        overflow-y: auto; /* Cho phép cuộn dọc khi cần */
        padding-right: 20px;
    }
    .custom-modal2 .modal-body {
        display: flex;
        flex-direction: column;
    }

    .custom-modal2 .form-group {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .custom-modal2 .form-group label {
        flex: 1;
        margin-right: 10px;
    }

    .custom-modal2 .modal-body .form-group {
        margin-bottom: 20px; /* Đặt khoảng cách giữa các dòng là 20px */
    }

    .modal-footer1 {
        display: flex;
        justify-content: space-between; /* Các phần tử con sẽ được căn giữa và căn cách nhau */
        align-items: center; /* Căn giữa theo chiều dọc */
    }

    .modal-footer1 .btn {
        cursor: pointer;
        border-radius: 5px;
        border: none;
        padding: 10px 15px;
    }

    .modal-footer1 .btn-success {
        background-color: #28a745;
        color: #fff;
    }

    .modal-footer1 .btn-danger {
        background-color: #dc3545;
        color: #fff;
    }

    /* Hiệu ứng hover cho nút */
    .modal-footer1 .btn:hover {
        opacity: 0.8;
    }

    .container3 label {
        display: block;
        margin-bottom: 5px;
    }

    .container3 input {
        display: block;
        margin-bottom: 10px;
        width: 100%; /* Đảm bảo rằng input chiếm toàn bộ độ rộng của container */
    }


    /* Modal style */
    .modal2 {
        display: none; /* Hidden by default */
        position: fixed; /* Stay in place */
        z-index: 1; /* Sit on top */
        left: 0;
        top: 0;
        width: 100%; /* Full width */
        height: 100%; /* Full height */
        overflow: auto; /* Enable scroll if needed */
        background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
        padding-top: 60px; /* Location of the modal container */
    }

    /* Modal content */
    .modal-content2 {
        background-color: #fefefe;
        margin: auto;
        padding: 20px;
        border: 1px solid #888;
        width: 80%;
    }

    /* Close button */
    .close {
        color: #aaa;
        float: right;
        font-size: 28px;
        font-weight: bold;
    }

    .close:hover,
    .close:focus {
        color: black;
        text-decoration: none;
        cursor: pointer;
    }

    /* Product info */
    .product-info {
        display: flex;
        flex-direction: column;
        align-items: center;
    }

    #sizeColorOptions {
        display: flex;
        flex-wrap: nowrap; /* Ngăn các phần tử bọc khi quá rộng */
        align-items: center; /* Canh chỉnh các phần tử theo trục dọc */
    }

    .option-label {
        margin-right: 10px; /* Khoảng cách giữa nhãn và các phần tử radio */
    }

    .option-item {
        margin-right: 20px; /* Khoảng cách giữa các phần tử */
    }
    .error-message1 {
        background-color: #f8d7da; /* Màu nền */
        color: #721c24; /* Màu chữ */
        padding: 10px; /* Khoảng cách padding */
        margin: 10px 0; /* Khoảng cách margin */
        border: 1px solid #f5c6cb; /* Viền */
        border-radius: 4px; /* Đường viền cong */
        font-size: 14px; /* Kích thước chữ */
    }

    .error-message1::before {
        content: "\2715"; /* Ký tự Unicode của biểu tượng "x" */
        color: #721c24; /* Màu biểu tượng */
        float: right; /* Dịch chuyển về phía bên phải */
        font-weight: bold; /* Độ đậm của biểu tượng */
        margin-left: 10px; /* Khoảng cách từ biểu tượng đến nội dung */
    }

    .error-message1::after {
        clear: both; /* Xóa floating */
        content: ""; /* Nội dung giả */
        display: table; /* Hiển thị như một bảng */
    }

    /*css login */


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
                        <a href="javascript:void(0)" ng-click="checkUser1()">
                            <i class="fas fa-history" id="headerIcon"></i>
                        </a>
                        <a id="redirectLink" href="#" style="display: none;"></a>
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
                <a href="/AdidasSporst/home">
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


    <article id="userArticle" style="display: none;text-align: center;">
        <!-- Hiển thị thông tin khách hàng -->
        <h2>Thông tin</h2>
        <div style="display: flex; justify-content: center; flex-wrap: wrap;">
            <div style="flex: 1; margin-bottom: 10px;">
                <label for="fullName">Tên:</label>
                <input type="text" id="fullName" ng-model="client.fullName" readonly>
            </div>

            <div style="flex: 1; margin-bottom: 10px;">
                <label for="email">Email:</label>
                <input type="email" id="email" ng-model="client.email" readonly>
            </div>
        </div>

        <div style="display: flex; justify-content: center; flex-wrap: wrap;">
            <div style="flex: 1; margin-bottom: 10px;">
                <label for="phoneNumber">Phone:</label>
                <input type="tel" id="phoneNumber" ng-model="client.phoneNumber" readonly>
            </div>

            <div style="flex: 1; margin-bottom: 10px;">
                <label for="gender">Gender:</label>
                <input type="text" id="gender" ng-model="client.gender ? 'Nữ' : 'Nam'" readonly>
            </div>
        </div>


        <!-- Hiển thị thông tin nơi nhận hàng mặc định -->
        <h2>Địa chỉ nhận hàng mặc định</h2>
        <div style="display: flex; justify-content: center; flex-wrap: wrap;">
            <div style="flex: 1; margin-bottom: 10px;">
                <label for="line">Địa chỉ:</label>
                <input type="text" id="line" ng-model="client.line" readonly>
            </div>

            <div style="flex: 1; margin-bottom: 10px;">
                <label for="city">Thành phố:</label>
                <input type="text" id="city" ng-model="client.city" readonly>
            </div>
        </div>

        <div style="display: flex; justify-content: center; flex-wrap: wrap;">
            <div style="flex: 1; margin-bottom: 10px;">
                <label for="country">Quốc gia:</label>
                <input type="text" id="country" ng-model="client.country" readonly>
            </div>

            <div style="flex: 1; margin-bottom: 10px;">
                <label for="phoneNumber">Sdt nhận hàng:</label>
                <input type="tel" id="phoneNumber2" ng-model="client.phoneNumber" readonly>
            </div>
        </div>
    </article>


    <article id="listproduct" style="display: block;">
        <div class="sidebar">
            <div class="filter-section">
                <div class="price-section">
                    <h3>Lọc theo giá</h3>
                    <div class="price-options">
                        <label for="price-under-50">
                            <input type="radio" id="price-under-50" name="price" value="under-400" ng-click="filterByPrice('under-400')">
                            Under 400,000 VND
                        </label>
                        <label for="price-50-to-100">
                            <input type="radio" id="price-50-to-100" name="price" value="400-to-700" ng-click="filterByPrice('400-to-700')">
                            400,000 - 700,000 VND
                        </label>
                        <label for="price-100-to-200">
                            <input type="radio" id="price-100-to-200" name="price" value="700-to-1000" ng-click="filterByPrice('700-to-1000')">
                            700,000 - 1,000,000 VND
                        </label>
                        <label for="price-100-to-200">
                            <input type="radio" id="all" name="price" value="700-to-1000" ng-click="all()">
                            Tất Cả
                        </label>
                        <!-- Thêm các phần tử khác tương ứng với khoảng giá -->
                    </div>
                </div>
            </div>
        </div>

        <div class="product-container d-flex justify-content-center align-items-center">
            <div class="product-list">
                <div class="product-card" ng-repeat="product in products">
                    <img src="/views/giay-20.jpg" class="hover_img" ng-src="/views/imagesp/{{ product.imageUrls[0] }}" alt="{{ product.name }}">
                    <h3>{{ product.productDetail.product.name }}</h3>
                    <p>{{ product.productDetail.price | number:'':'0'}}VND</p>
                    <button class="button_cart" ng-click="openModal1(product.productDetail.id)"><i class="fas fa-shopping-cart" id="headerIcon"></i></button>
                    <button class="button_cart"><i class="fas fa-heart" id="headerIcon"></i></button>
                    <button class="button_cart"  ng-click="goToDetail(product.productDetail.id)"><i class="fas fa-eye" id="headerIcon"></i></button>
                </div>

            </div>
            <div class="nextprev">
                <button class="btn btn-primary me-2" ng-click="setPage(1)" ng-disabled="currentPage == 1">&lt;&lt;</button>
                <button class="btn btn-primary me-2" ng-click="setPage(currentPage - 1)" ng-disabled="currentPage == 1">&lt;</button>
                <span class="me-2">Trang{{currentPage}} / {{totalPages}}</span>
                <button class="btn btn-primary me-2" ng-click="setPage(currentPage + 1)" ng-disabled="currentPage == totalPages">&gt;</button>
                <button class="btn btn-primary me-2" ng-click="setPage(totalPages)" ng-disabled="currentPage == totalPages">&gt;&gt;</button>
            </div>

        </div>

    </article>

    <article id="thanhtoan" style="display: none">
            <div class="list-sp">
                <br>

                <h2 style="text-align: center">Sản Phẩm</h2>
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
                        <td>{{calculateIndex($index) }}</td>
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
                <p class="total-price1">Tổng tiền: {{ totalPrice | number:'0':'0' }}</p>
                <div class="text-center" style="text-align: center">
                    <button class="btn btn-primary me-2" ng-click="setPage1(currentPage1 - 1)"><</button>
                    <span>Page {{currentPage1}} /{{totalPages1}}</span>
                    <button class="btn btn-primary me-2" ng-click="setPage1(currentPage1 + 1)">></button>
                </div>

                <div ng-if="cartDetails.length === 0">
                    <p>Bạn chưa có sản phẩm nào trong giỏ hàng.</p>
                </div>
            </div>
        <div class="row">
            <br>
            <hr>
            <br>
            <h2 style="text-align: center">Giao Hàng</h2>
            <!-- Đoạn mã HTML -->
            <div ng-show=" showDeliveryError" class="error-message1">
                {{ deliveryErrorMessage }}
            </div>
            <c:choose>
                <c:when test="${not empty sessionScope.Client}">
                    <!-- Hiển thị các tùy chọn giao hàng -->
                    <div>
                        <label>
                            <input type="radio" ng-model="deliveryOption" value="default"> Giao hàng đến nơi mặc định
                        </label>
                        <label>
                            <input type="radio" ng-model="deliveryOption" value="custom"> Giao hàng tùy chọn
                        </label>
                    </div>
                    <!-- Hiển thị form tùy chọn giao hàng nếu được chọn -->
                    <div ng-show="deliveryOption == 'custom'" class="container3">
                        <label>Số điện thoại nhận hàng:</label>
                        <input type="text" ng-model="phoneNumber">
                        <label>Tên người nhận:</label>
                        <input type="text" ng-model="receiverName">
                        <label>Địa chỉ:</label>
                        <input type="text" ng-model="address">
                        <label>Huyện:</label>
                        <input type="text" ng-model="district">
                        <label>Thành phố:</label>
                        <input type="text" ng-model="city">
                    </div>
                    <button class="tt" ng-click="checkDeliveryOption()">Thanh Toán</button>
                    <br>
                </c:when>
                <c:otherwise>
                    <!-- Hiển thị form nhập thông tin nhận hàng -->
                    <div class="container3">
                        <label>Số điện thoại đặt hàng:</label>
                        <input type="text" ng-model="phoneNumber1">
                        <label>Số điện thoại nhận hàng:</label>
                        <input type="text" ng-model="phoneNumber2">
                        <label>Tên người nhận:</label>
                        <input type="text" ng-model="receiverName1">
                        <label>Địa chỉ:</label>
                        <input type="text" ng-model="address1">
                        <label>Huyện:</label>
                        <input type="text" ng-model="district1">
                        <label>Thành phố:</label>
                        <input type="text" ng-model="city1">
                    </div>
                    <button class="tt" ng-click="processOrder()">Thanh Toán</button>
                    <br>
                </c:otherwise>
            </c:choose>
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
<div class="modal" id="paymentModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <h2 style="text-align: center">Giỏ hàng</h2>
                <table class="table">
                    <thead>
                    <tr>
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
                <div class="text-center" style="text-align: center">
                    <button class="btn btn-primary me-2" ng-click="setPage1(currentPage1 - 1)"><</button>
                    <span>Page {{currentPage1}} /{{totalPages1}}</span>
                    <button class="btn btn-primary me-2"  ng-click="setPage1(currentPage1 + 1)">></button>
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



<div id="customModal" class="custom-modal2">
        <div class="modal-container2">
            <div class="modal-content2">
                <div class="modal-header">
                    <h4 class="modal-title">Thông tin  </h4>
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
                    <div class="form-group">
                        <label for="paymentMethod">Hình thức thanh toán:</label>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="paymentMethod" id="cashOnDelivery" value="1" ng-model="selectedOrderInfo.hinhthucthanhtoan">
                            <label class="form-check-label" for="cashOnDelivery">Nhận hàng thanh toán</label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="paymentMethod" id="bankTransfer" value="3" ng-model="selectedOrderInfo.hinhthucthanhtoan">
                            <label class="form-check-label" for="bankTransfer">Chuyển khoản</label>
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
                <div class="modal-footer1">
                    <button type="button" ng-if="selectedOrderInfo.hinhthucthanhtoan === '3'" class="btn btn-success w-100" ng-click="ThanhToan(selectedOrderInfo)">
                        <a href="/AdidasSporst/ThanhToan2/{{selectedOrderInfo.tongtienhang}}" style="text-decoration: none;color: white">Thanh Toán</a>
                    </button>
                    <button type="button" ng-if="selectedOrderInfo.hinhthucthanhtoan !== '3'" class="btn btn-success w-100" ng-click="ThanhToan1(selectedOrderInfo)">Thanh Toán</button>
                    <br>
                    <button type="button" class="btn btn-danger w-100" ng-click="deleteTCKMandVoucher(selectedOrderInfo.id)">Hủy</button>
                </div>
            </div>
        </div>
    </div>

<div id="productModal" class="modal2" ng-style="{'display': modalOpened ? 'block' : 'none'}">
    <!-- Modal content -->
    <div class="modal-content2">
        <span class="close" ng-click="closeModal()">&times;</span>
        <div class="product-info">
            <h2 id="productName">{{ firstProduct.product.name }}</h2>
            <div id="sizeColorOptions">
                <label class="option-label">Chọn size:</label><br>
                <!-- Select box cho kích thước -->
                <select ng-model="selectedSize" ng-change="updateColors(selectedSize)">
                    <option value="" disabled selected>Chọn màu sắc</option>
                    <option ng-repeat="size in sizes" ng-value="size" ng-if="size">{{ size }}</option>
                </select>
                <br><br>
                <br>
                <label class="option-label">Chọn màu sắc:</label><br>
                <!-- Select box cho màu sắc -->
                <select ng-model="selectedColor">
                    <option value="" disabled selected>Chọn màu sắc</option>
                    <option ng-repeat="color in filteredColors" ng-value="color" ng-if="color">{{ color }}</option>
                </select>

                <br><br>
                <!-- Button Thêm vào giỏ hàng -->

            </div>
            <button ng-click="addToCart1()">Thêm vào giỏ hàng</button>
        </div>
    </div>
</div>
</body>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
    var app = angular.module('myApp', []);


    app.controller('myController', function($scope, $http,$location) {
        $scope.currentPage = 1;
        $scope.pageSize = 9;
        $scope.totalItems = 0;
        $scope.totalPages = 0;

        $scope.getProducts = function (page, size)  {
            var url = 'http://localhost:8080/AdidasSporst/listproductdetail';
            $http.get(url, {params: {page:page -1, size: size}})
                .then(function (response) {
                    // Log dữ liệu phản hồi vào console (nếu cần)
                    console.log('Dữ liệu phản hồi:', response.data);
                    $scope.products = response.data.content;
                    $scope.totalItems = response.data.totalElements;

                    // Tính toán tổng số trang
                    $scope.totalPages = Math.ceil($scope.totalItems / $scope.pageSize);
                })
                .catch(function (error) {
                    // Xử lý lỗi nếu có
                    console.error('Lỗi:', error.message);
                });
        }

        $scope.getProducts($scope.currentPage, $scope.pageSize);
        $scope.setPage = function(pageNumber) {
            // Kiểm tra xem trang yêu cầu có nằm trong phạm vi hợp lệ không
            if (pageNumber >= 1 && pageNumber <= $scope.totalPages) {
                // Gọi API để lấy dữ liệu của trang mới
                $scope.currentPage = pageNumber;
                $scope.getProducts($scope.currentPage, $scope.pageSize);
            }
        };
        $scope.addToCart = function(productId) {
            var url = 'http://localhost:8080/AdidasSporst/addToCart/' + productId;
            $http.get(url)
                .then(function(response) {
                    console.log('Product ID:', productId);
                    console.log('Success:', response.data);
                    toastr.success('Thêm thành công', 'Thành công', { positionClass: 'toast-top-right' });
                })
                .catch(function(error) {
                    console.error('Error adding product to cart:', error);
                    toastr.success('Thêm thành công', 'Thành công', { positionClass: 'toast-top-right' });
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

        $scope.currentPage1 = 1;
        $scope.pageSize1 = 3;
        $scope.totalItems1 = 0;
        $scope.totalPages1 = 0;

        $scope.setPage1 = function(pageNumber) {
            // Kiểm tra trang yêu cầu có hợp lệ không
            if (pageNumber >= 1 && pageNumber <= $scope.totalPages1) {
                // Gọi API để lấy dữ liệu của trang mới
                $scope.currentPage1 = pageNumber;
                $scope.getCartDetails();
            }
        };

        $scope.calculateIndex = function(index) {
            return ($scope.currentPage1 - 1) * $scope.pageSize1 + index + 1;
        };

        $scope.getTotalMoney = function() {
            $http.get('http://localhost:8080/AdidasSporst/Tongtien')
                .then(function(response) {
                    // Xử lý dữ liệu trả về từ API ở đây
                    $scope.totalPrice = response.data;
                })
                .catch(function(error) {
                    console.error('Error fetching total money:', error);
                });
        };

        $scope.showModal = false;
        $scope.openModal = function() {
            var modal = document.getElementById('paymentModal');
            modal.style.display = 'block';
            $scope.getCartDetails(); // Gọi hàm để lấy chi tiết giỏ hàng khi modal được mở
        };
        $scope.closeModal1 = function() {
            var modal = document.getElementById('paymentModal');
            modal.style.display = 'none'; // Đặt biến showModal của AngularJS thành false để ẩn modal
        };

        $scope.deleteCartDetail = function(id) {
            $http.delete('http://localhost:8080/AdidasSporst/deleteProductCartdetail/' + id)
                .then(function(response) {
                    toastr.success('Xóa Thành Công', 'Thành công', { positionClass: 'toast-top-right' });
                    $scope.getCartDetails();
                })
                .catch(function(error) {
                    // Xử lý khi có lỗi xảy ra
                    console.error('Error deleting cart detail:', error);
                });
        };

        $scope.tangSoLuong = function(id) {
            $http.put('http://localhost:8080/AdidasSporst/tangsoluong/' + id)
                .then(function(response) {
                    // Xử lý phản hồi nếu cần
                    $scope.getCartDetails();
                    console.log('Số lượng đã được tăng.');
                })
                .catch(function(error) {
                    console.error('Lỗi khi tăng số lượng:', error);
                });
        };

        $scope.giamSoLuong = function(id) {
            $http.put('http://localhost:8080/AdidasSporst/giamsoluong/' + id)
                .then(function(response) {
                    // Xử lý phản hồi nếu cần
                    $scope.getCartDetails();
                    console.log('Số lượng đã được giảm.');
                })
                .catch(function(error) {
                    console.error('Lỗi khi giảm số lượng:', error);
                });
        };
        $scope.errorMessages = [];

        $scope.checkProductQuantity = function() {

            $http.get('http://localhost:8080/AdidasSporst/checksoluongproductkhitt')
                .then(function(response) {
                    // Xử lý phản hồi thành công
                    console.log(response.data); // In thông báo lỗi nếu có
                    $scope.showformtt();
                    $scope.closeModal1();
                })
                .catch(function(error) {
                    toastr.error(error.data, 'Lỗi', { positionClass: 'toast-top-right' });
                    console.error('Error checking product quantity:', error);
                });
        };


        $scope.showHome = function (){
            var userArticle = document.getElementById('userArticle');
            userArticle.style.display = 'none';
            var userArticle2 = document.getElementById('listproduct');
            userArticle2.style.display = 'block';
            var userArticle3 = document.getElementById('thanhtoan');
            userArticle3.style.display = 'none';
        }

        $scope.checkUser = function() {
            $http.get('http://localhost:8080/AdidasSporst/checkUser')
                .then(function(response) {
                    // Xử lý phản hồi thành công
                    // Hiển thị article mới khi click vào user
                    var userArticle = document.getElementById('userArticle');
                    userArticle.style.display = 'block';
                    var userArticle2 = document.getElementById('listproduct');
                    userArticle2.style.display = 'none';
                    console.log(response.data); // In thông báo lỗi nếu có
                    $scope.client = response.data;
                })
                .catch(function(error) {
                    if (error.status === 401) {
                        toastr.error(error.data.error, 'Lỗi', { positionClass: 'toast-top-right' });
                    } else {
                        toastr.error('Lỗi không xác định', 'Lỗi', { positionClass: 'toast-top-right' });
                    }
                    console.error('Error checking user:', error);
                });

        };
        $scope.showformtt = function (){
            var userArticle = document.getElementById('userArticle');
            userArticle.style.display = 'none';
            var userArticle2 = document.getElementById('listproduct');
            userArticle2.style.display = 'none';
            var userArticle3 = document.getElementById('thanhtoan');
            userArticle3.style.display = 'block';
        }


        $scope.processOrder = function() {
            if (Object.keys($scope.selectedProducts).length <= 0) {
                toastr.error('Chọn Sản Phẩm Để Thanh Toán', 'Lỗi', { positionClass: 'toast-top-right' });
                return;
            }else{
                var selectedProducts = Object.values($scope.selectedProducts);
                console.log(selectedProducts);
                return;
            }

            $scope.deliveryErrorMessage = "Vui lòng điền đầy đủ thông tin giao hàng";

            if (!$scope.phoneNumber1|| !$scope.phoneNumber2 || !$scope.receiverName1 || !$scope.address1 || !$scope.district1 || !$scope.city1) {
                $scope.showDeliveryError = true;
                $scope.deliveryErrorMessage = "Vui lòng điền đầy đủ thông tin giao hàng";
                return;
            }
            if (!$scope.phoneNumber1 || !($scope.phoneNumber1.match(/^\d{10,11}$/))) {
                $scope.showDeliveryError = true; // Hiển thị thông báo lỗi nếu số điện thoại không hợp lệ
                $scope.deliveryErrorMessage = "Số điện thoại đặt hàng không hợp lệ"; // Thay đổi thông báo
                return;
            }
            if (!$scope.phoneNumber2 || !($scope.phoneNumber2.match(/^\d{10,11}$/))) {
                $scope.showDeliveryError = true; // Hiển thị thông báo lỗi nếu số điện thoại không hợp lệ
                $scope.deliveryErrorMessage = "Số điện thoại nhận hàng không hợp lệ"; // Thay đổi thông báo
                return;
            }
            $scope.showDeliveryError = false;
            var orderData = {
                phoneNumber: $scope.phoneNumber1,
                phoneNumber2: $scope.phoneNumber2,
                receiverName: $scope.receiverName1,
                address: $scope.address1,
                district: $scope.district1,
                city: $scope.city1
            };
            $http.post('http://localhost:8080/AdidasSporst/addOrderNoClien', orderData)
                .then(function(response) {
                    $scope.getOrderNoClient();
                })
                .catch(function(error) {
                    // Xử lý lỗi nếu có
                    console.error('Lỗi khi gửi dữ liệu:', error);
                });
        };

        $scope.getOrderNoClient = function() {
            $http.get('http://localhost:8080/AdidasSporst/GetorderNoClient')
                .then(function(response) {
                    // Xử lý dữ liệu trả về từ API ở đây
                    $scope.selectedOrderInfo = response.data;
                    console.log(response.data);
                    $scope.getvoucherbyorder($scope.selectedOrderInfo.id);
                    var userArticle4 = document.getElementById('customModal');
                    userArticle4.style.display = 'block';
                })
                .catch(function(error) {
                    console.error('Lỗi khi lấy dữ liệu đơn hàng:', error);
                });
        };

        $scope.getvoucherbyorder = function (id){
            $http.get('http://localhost:8080/staff/getvoucherbyorder/' +id)
                .then(function(response) {
                    // Xử lý kết quả từ server
                    $scope.voucherDetails = response.data;
                    console.log(response.data);
                })
                .catch(function(error) {
                    console.error('Error getting vouchers:', error);
                });
        };

        $scope.addVoucher = function (selectedOrderInfo) {
            console.log('Voucher Code:', $scope.voucherCode); // Kiểm tra giá trị của voucherCode

            var request = {
                voucherCode: $scope.voucherCode,
                order: selectedOrderInfo // Thêm thông tin order vào đây
            };

            $http.post('http://localhost:8080/staff/addvoucher', request)
                .then(function(response) {
                    $scope.getvoucherbyorder($scope.selectedOrderInfo.id);
                    $http.get('http://localhost:8080/AdidasSporst/Getorder/'+selectedOrderInfo.id)
                        .then(function(response) {
                            // Xử lý dữ liệu trả về từ API ở đây
                            $scope.selectedOrderInfo = response.data;
                            console.log(response.data);
                        })
                        .catch(function(error) {
                            console.error('Lỗi khi lấy dữ liệu đơn hàng:', error);
                        });

                    // Kiểm tra dữ liệu trả về từ server
                    var data = response.data;
                    if (data && data.status === "success") {
                        showTimedSuccessMessage(data.message, 2000);
                    }
                    if (response.data && response.data.status === "error") {
                        Swal.fire('Lỗi', response.data.message, 'error');
                    }
                    $scope.voucherCode = null;

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
                        $http.get('http://localhost:8080/AdidasSporst/Getorder/'+order.id)
                            .then(function(response) {
                                // Xử lý dữ liệu trả về từ API ở đây
                                $scope.selectedOrderInfo = response.data;
                                console.log(response.data);
                            })
                            .catch(function(error) {
                                console.error('Lỗi khi lấy dữ liệu đơn hàng:', error);
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
                            $http.get('http://localhost:8080/AdidasSporst/Getorder/'+voucherDetail.order.id)
                                .then(function(response) {
                                    // Xử lý dữ liệu trả về từ API ở đây
                                    $scope.selectedOrderInfo = response.data;
                                    console.log(response.data);
                                })
                                .catch(function(error) {
                                    console.error('Lỗi khi lấy dữ liệu đơn hàng:', error);
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

        $scope.deleteTCKMandVoucher = function(orderId) {
            $http.delete('http://localhost:8080/AdidasSporst/deleteTCKMandvoucherbyorder/' + orderId)
                .then(function(response) {
                    // Xử lý kết quả khi xóa thành công
                    $scope.selectedOrderInfo;
                    console.log('Order deleted successfully:', response.data);

                })
                .catch(function(error) {
                    console.error('Error deleting order:', error);
                });

            var userArticle4 = document.getElementById('customModal');
            userArticle4.style.display = 'none';
        };

        $scope.ThanhToan = function(selectedOrderInfo) {
            $http.post('http://localhost:8080/AdidasSporst/ThanhToan', selectedOrderInfo)
                .then(function(response) {
                    console.log(response);
                }).catch(function(error) {
                    if (error.status === 401) {
                        toastr.error(error.data.error, 'Lỗi', { positionClass: 'toast-top-right' });
                    } else {
                        toastr.error('Lỗi không xác định', 'Lỗi', { positionClass: 'toast-top-right' });
                    }
                    console.error('Error checking user:', error);
                });

        };
        $scope.ThanhToan1 = function(selectedOrderInfo) {
            $http.post('http://localhost:8080/AdidasSporst/ThanhToan', selectedOrderInfo)
                .then(function(response) {
                    console.log(response);
                    toastr.success('Thanh Toán Thành Công', 'Thành công', { positionClass: 'toast-top-right' });
                    setTimeout(function() {
                        window.location.reload();
                    }, 2000); // Adjust the delay time as needed (e.g., 2000ms = 2 seconds)

                })
                .catch(function(error) {
                    if (error.status === 401) {
                        toastr.error(error.data.error, 'Lỗi', { positionClass: 'toast-top-right' });
                    } else {
                        toastr.error('Lỗi không xác định', 'Lỗi', { positionClass: 'toast-top-right' });
                    }
                    console.error('Error checking user:', error);
                });

        };


        $scope.checkDeliveryOption = function() {
            if (!$scope.deliveryOption) {
                // Nếu không có radio button nào được chọn
                toastr.error('vui lòng chọn phương thức giao hàng', 'Lỗi', { positionClass: 'toast-top-right' });
                return false;
            }
            if ($scope.deliveryOption === 'custom') {

                $http.get('http://localhost:8080/AdidasSporst/Getclient')
                    .then(function(response) {
                        // Thực hiện các hành động tương ứng ở đây với thông tin khách hàng
                        $scope.clientInfo = response.data;
                        $scope.deliveryErrorMessage = "Vui lòng điền đầy đủ thông tin giao hàng";

                        if (!$scope.phoneNumber || !$scope.receiverName || !$scope.address || !$scope.district || !$scope.city) {
                            $scope.showDeliveryError = true;
                            $scope.deliveryErrorMessage = "Vui lòng điền đầy đủ thông tin giao hàng";
                            return;
                        }
                        if ($scope.phoneNumber.length !== 10) {
                            $scope.showDeliveryError = true; // Hiển thị thông báo lỗi nếu số điện thoại không hợp lệ
                            $scope.deliveryErrorMessage = "Số điện thoại phải là 10 số"; // Thay đổi thông báo
                            return;
                        }

                        if (!$scope.phoneNumber || !($scope.phoneNumber.match(/^\d{10,11}$/))) {
                            $scope.showDeliveryError = true; // Hiển thị thông báo lỗi nếu số điện thoại không hợp lệ
                            $scope.deliveryErrorMessage = "Số điện thoại  không hợp lệ"; // Thay đổi thông báo
                            return;
                        }


                        $scope.showDeliveryError = false;
                        var orderData = {
                            phoneNumber: $scope.phoneNumber,
                            phoneNumber2: $scope.phoneNumber,
                            receiverName: $scope.receiverName,
                            address: $scope.address,
                            district: $scope.district,
                            city: $scope.city
                        };
                        $http.post('http://localhost:8080/AdidasSporst/addOrderCliendiachituychon/'+ $scope.clientInfo.id,orderData)
                            .then(function(response) {
                                $http.get('http://localhost:8080/AdidasSporst/getorderbyclient/'+ $scope.clientInfo.id )
                                    .then(function(response) {
                                        $scope.selectedOrderInfo = response.data;
                                        console.log(response.data);
                                        var userArticle4 = document.getElementById('customModal');
                                        userArticle4.style.display = 'block';
                                    })
                                    .catch(function(error) {
                                        // Xử lý lỗi nếu có
                                        console.error('Lỗi khi gửi dữ liệu:', error);
                                    });
                            })
                            .catch(function(error) {
                                // Xử lý lỗi nếu có
                                console.error('Lỗi khi gửi dữ liệu:', error);
                            });

                    })
                    .catch(function(error) {
                    });

            } else if ($scope.deliveryOption === 'default') {
                $http.get('http://localhost:8080/AdidasSporst/Getclient')
                    .then(function(response) {
                        // Thực hiện các hành động tương ứng ở đây với thông tin khách hàng
                        $scope.clientInfo = response.data;
                        $http.post('http://localhost:8080/AdidasSporst/addOrderClienDiaChimacdinh/'+ $scope.clientInfo.id )
                            .then(function(response) {
                                $http.get('http://localhost:8080/AdidasSporst/getorderbyclient/'+ $scope.clientInfo.id )
                                    .then(function(response) {
                                        $scope.selectedOrderInfo = response.data;
                                        console.log(response.data);
                                        var userArticle4 = document.getElementById('customModal');
                                        userArticle4.style.display = 'block';
                                    })
                                    .catch(function(error) {
                                        // Xử lý lỗi nếu có
                                        console.error('Lỗi khi gửi dữ liệu:', error);
                                    });
                            })
                            .catch(function(error) {
                                // Xử lý lỗi nếu có
                                console.error('Lỗi khi gửi dữ liệu:', error);
                            });

                    })
                    .catch(function(error) {
                    });
            }

            return true; // Trả về true nếu đã chọn một trong hai radio button
        };

        $scope.detail = function (id)  {
            var url = 'http://localhost:8080/AdidasSporst/detail/';
            $http.get(url+id)
                .then(function (response) {
                    // Log dữ liệu phản hồi vào console (nếu cần)
                    console.log('Dữ liệu phản hồi:', response.data);

                })
                .catch(function (error) {
                    // Xử lý lỗi nếu có
                    console.error('Lỗi:', error);
                });
        }

        $scope.modalOpened = false;

        $scope.openModal1 = function(id) {
            $scope.modalOpened = true;
            $http.get('http://localhost:8080/AdidasSporst/getproductdetailaddtocartbyhome/' + id)
                .then(function(response) {
                    // Xử lý dữ liệu nhận được từ API
                    $scope.apiProducts = response.data;
                    var firstProduct = $scope.apiProducts[0];
                    $scope.firstProduct = firstProduct;
                    var sizes = [];
                    $scope.sizes = [];

                    // Lặp qua từng sản phẩm trong mảng apiProducts
                    $scope.apiProducts.forEach(function(apiProduct) {
                        // Kiểm tra xem thuộc tính size có tồn tại không
                        if (apiProduct.size && apiProduct.size.name) {
                            // Nếu size là một chuỗi
                            if (typeof apiProduct.size.name === 'string') {
                                // Kiểm tra xem size đã tồn tại trong mảng sizes chưa
                                if (!$scope.sizes.includes(apiProduct.size.name)) {
                                    // Thêm size vào mảng sizes
                                    $scope.sizes.push(apiProduct.size.name);
                                }
                            }
                            // Nếu size là một mảng
                            else if (Array.isArray(apiProduct.size.name)) {
                                // Lặp qua từng size trong mảng
                                apiProduct.size.name.forEach(function(size) {
                                    // Kiểm tra xem size đã tồn tại trong mảng sizes chưa
                                    if (!$scope.sizes.includes(size)) {
                                        // Thêm size vào mảng sizes
                                        $scope.sizes.push(size);
                                    }
                                });
                            }
                        }
                    });

                    // Gán danh sách các kích thước vào $scope để sử dụng trong HTML

                    $scope.modalOpened = true;

                    // Xóa event listener cũ trước khi thêm event listener mới
                    $scope.colorsUpdated = false;
                })
                .catch(function(error) {
                    // Xử lý lỗi nếu có
                    console.error('Error fetching product detail:', error);
                });
        }

        $scope.updateColors = function(selectedSizeTmp) {
            $scope.selectedSize = selectedSizeTmp;
            // Khởi tạo mảng danh sách màu đã lọc
            $scope.filteredColors = [];

            // Lặp qua danh sách sản phẩm từ $scope.apiProducts
            angular.forEach($scope.apiProducts, function(product) {
                // Kiểm tra xem sản phẩm có size tương ứng với size được chọn không
                if (product.size && product.size.name === $scope.selectedSize) {
                    // Nếu có, thêm màu của sản phẩm vào mảng danh sách màu đã lọc
                    $scope.filteredColors.push(product.color.name);
                }
            });
            console.log($scope.apiProducts);
            console.log($scope.filteredColors);
        };

        $scope.closeModal = function() {
            $scope.modalOpened = false;
        }

        $scope.addToCart1 = function() {
            // Kiểm tra xem đã chọn size và màu sắc chưa
            if (!$scope.selectedSize || !$scope.selectedColor) {
                alert("Vui lòng chọn size và màu sắc trước khi thêm vào giỏ hàng!");
                return;
            }

            // Dữ liệu sản phẩm cần gửi lên server
            var data = {
                id: $scope.firstProduct.id,
                size: $scope.selectedSize,
                color: $scope.selectedColor
            };
            console.log(data);

            // Gọi API để thêm sản phẩm vào giỏ hàng
            $http.post('http://localhost:8080/AdidasSporst/addgiohangdetailsp', data)
                .then(function(response) {
                    // Xử lý kết quả trả về nếu cần
                    toastr.success('Thêm thành công', 'Thành công', { positionClass: 'toast-top-right' });
                }, function(error) {
                    // Xử lý lỗi nếu có
                    toastr.success('Thêm thành công', 'Thành công', { positionClass: 'toast-top-right' });

                });
        };

        $scope.searchKeyword = '';
    $scope.search = function() {
            // Thực hiện tìm kiếm mỗi khi có sự thay đổi trong trường input
            var keyword = $scope.searchKeyword;
        // Gửi yêu cầu tìm kiếm đến API Java
        $http.get('http://localhost:8080/AdidasSporst/search', { params: { keyword: keyword } })
            .then(function(response) {
                // Xử lý kết quả tìm kiếm ở đây
                $scope.products = response.data.content;
                $scope.totalItems = response.data.totalElements;

                // Tính toán tổng số trang
                $scope.currentPage = 1;
                $scope.totalPages = Math.ceil($scope.totalItems / $scope.pageSize);
            })
            .catch(function(error) {
                // Xử lý lỗi nếu có
                console.error('Error searching:', error);
            });
        };

        $scope.filterByPrice = function(priceRange) {
            var minPrice, maxPrice;

            // Thiết lập giá min và max tương ứng với khoảng giá được chọn
            switch (priceRange) {
                case 'under-400':
                    minPrice = 0;
                    maxPrice = 399999; // 50,000 VND
                    break;
                case '400-to-700':
                    minPrice = 400000; // 50,000 VND
                    maxPrice = 699999; // 100,000 VND
                    break;
                case '700-to-1000':
                    minPrice = 700000; // 100,000 VND
                    maxPrice = 999999; // 200,000 VND
                    break;

                // Thêm các trường hợp khác tương ứng với khoảng giá
            }
            $http.get('http://localhost:8080/AdidasSporst/getmoney', {
                params: {
                    min: minPrice,
                    max: maxPrice
                }
            }).then(function(response) {
                $scope.products = response.data.content;
                $scope.totalItems = response.data.totalElements;

                // Tính toán tổng số trang
                $scope.currentPage = 1;
                $scope.totalPages = Math.ceil($scope.totalItems / $scope.pageSize);
            }).catch(function(error) {
                // Xử lý lỗi nếu có
                console.error('Error:', error);
            });

        };

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

        $scope.checkUser1 = function() {
            $http.get('http://localhost:8080/AdidasSporst/checkUser')
                .then(function(response) {
                    $scope.client = response.data;
                    // Update the href of the anchor tag and click it
                    const anchor = document.getElementById('redirectLink');
                    anchor.href = 'http://localhost:8080/AdidasSporst/Order/' + encodeURIComponent($scope.client.id);
                    anchor.click();
                })
                .catch(function(error) {
                    if (error.status === 401) {
                        toastr.error(error.data.error, 'Lỗi', { positionClass: 'toast-top-right' });
                    } else {
                        toastr.error('Lỗi không xác định', 'Lỗi', { positionClass: 'toast-top-right' });
                    }
                    console.error('Error checking user:', error);
                });
        };

        $scope.all = function() {
            $scope.getProducts($scope.currentPage, $scope.pageSize);
        }

        $scope.goToDetail = function(productId) {
            window.location.href = 'http://localhost:8080/AdidasSporst/Detail/' + productId;
        };











// Get the modal











    });


</script>
</html>