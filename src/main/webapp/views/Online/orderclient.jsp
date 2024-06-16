<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
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
    #headerIcon1{
        color: black;
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
    .pagination {
        display: inline-block;
        padding-left: 0;
        margin: 20px 0;
        border-radius: 4px;
    }

    .pagination li {
        display: inline;
    }

    .pagination li a {
        color: white;
        float: left;
        padding: 8px 16px;
        text-decoration: none;
        transition: background-color 0.3s;
        border: 1px solid #ddd;
        margin: 0 4px;
        border-radius: 4px;
    }

    .pagination li a:hover {
        background-color: #ddd;
    }

    .pagination li.active a {
        background-color: #007bff;
        color: white;
        border: 1px solid #007bff;
    }

    nav {
        text-align: center;
    }
    /*css login */


</style>
<body ng-app="myApp" ng-controller="myController">
<div>
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
                        <a href="/AdidasSporst/home">
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
    <article id="listproduct" style="max-width:75%;display: block;  margin-left: auto;
    margin-right: auto; text-align: center;margin-top: 5px">
        <h1>Lịch Sử Mua Hàng</h1>
        <br>
        <hr>
        <br>
        <table class="table">
            <thead>
            <tr>
                <th>STT</th>
                <th>Mã Hóa Đơn</th>
                <th>Ngày Mua</th>
                <th>SDT Nhận Hàng</th>
                <th>Người Nhận</th>
                <th>Tổng</th>
                <th>Ship</th>
                <th>Chiết Khấu</th>
                <th>Phải Trả</th>
                <th>Trạng Thái</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="order" items="${orderPage.content}" varStatus="status">
                <tr>
                    <td>${status.index + 1 + currentPage * 10}</td>
                    <td>${order.code}</td>
                    <td>${order.createDate}</td>
                    <td>${order.sdtnhanhang}</td>
                    <td>${order.nguoinhan}</td>
                    <td>${order.totalMoney}</td>
                    <td>${order.moneyShip}</td>
                    <td>${order.chietkhau}</td>
                    <td>${order.tongtienhang}</td>
                    <td style="color:
    ${ order.status == 10 ? 'blue' :
    (order.status == 5 ? 'green' :
    (order.status == 6 ? 'yellow' : 'black')) }">
                        ${ order.status == 10 ? 'Chờ xác nhận' :
                        (order.status == 5 ? 'Thành công' :
                        (order.status == 6 ? 'Đang giao hàng' : order.status)) }
                    </td>
                    <td>
                        <a href="#" ng-click="getProductByOrder(${order.id})">
                            <i class="fas fa-eye" id="headerIcon1"></i>
                        </a>
                    </td>

                </tr>
            </c:forEach>
            </tbody>
        </table>
        <nav aria-label="Page navigation">
            <ul class="pagination">
                <c:if test="${currentPage > 0}">
                    <li class="page-item">
                        <a class="btn btn-primary me-2" href="?page=${currentPage - 1}" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>
                </c:if>
                <c:forEach var="i" begin="0" end="${totalPages - 1}">
                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                        <a class="btn btn-primary me-2" href="?page=${i}">${i + 1}</a>
                    </li>
                </c:forEach>
                <c:if test="${currentPage < totalPages - 1}">
                    <li class="page-item">
                        <a class="btn btn-primary me-2" href="?page=${currentPage + 1}" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                </c:if>
            </ul>
        </nav>
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
                <h2 style="text-align: center">Thông Tin Đơn Hàng</h2>
                <table class="table">
                    <thead>
                    <tr>
                        <th>STT</th>
                        <th>Sản phẩm</th>
                        <th>Giá</th>
                        <th>Số lượng</th>
                        <th>Tổng</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr ng-repeat="cartDetail in cartDetails">
                        <td>{{calculateIndex($index)}}</td>
                        <td>{{cartDetail.productDetail.product.name}}</td>
                        <td>{{cartDetail.price | number:'0':'0'}}</td>
                        <td>
                            {{ cartDetail.quantity }}
                        </td>
                        <td>{{(cartDetail.price * cartDetail.quantity) | number:'0':'0'}}</td>
                    </tr>
                    </tbody>
                </table>
                <div class="text-center" style="text-align: center">
                    <button class="btn btn-primary me-2" ng-click="setPage1(currentPage1 - 1)"><</button>
                    <span>Page {{currentPage1}} /{{totalPages1}}</span>
                    <button class="btn btn-primary me-2"  ng-click="setPage1(currentPage1 + 1)">></button>
                </div>

                <div class="text-center" >
                    <!-- Thông tin đơn hàng sẽ được hiển thị ở đây -->
                    <h2>Thông tin đơn hàng</h2>
                    <p>Mã đơn hàng: {{ selectedOrder.code }}</p>
                    <p>SDT Đặt Hàng: {{ selectedOrder.phoneNumber }}</p>
                    <p>SDT Nhận Hàng: {{ selectedOrder.sdtnhanhang }}</p>
                    <!-- Các thông tin khác về đơn hàng -->
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
    var app = angular.module('myApp', []);
    app.controller('myController', function($scope, $http) {
        $scope.currentPage1 = 1;
        $scope.pageSize1 = 3;
        $scope.totalItems1 = 0;
        $scope.totalPages1 = 0;

        $scope.getProductByOrder = function(orderId) {
            $http.get('http://localhost:8080/AdidasSporst/listProdyctByOrder/' + orderId,{
                params: {
                    page: $scope.currentPage1 - 1,
                    size: $scope.pageSize1
                }
            })
                .then(function(response) {
                    // Xử lý phản hồi từ API ở đây
                    console.log(orderId);
                    console.log(response.data); // In ra dữ liệu nhận được từ API
                    // Ví dụ: gán dữ liệu nhận được từ API vào một biến trong $scope
                    $scope.cartDetails = response.data.content;
                    var modal = document.getElementById('paymentModal');
                    modal.style.display = 'block';
                })
                .catch(function(error) {
                    // Xử lý lỗi nếu có
                    console.error('Error fetching product by order:', error);
                });
        };

        $scope.setPage1 = function(pageNumber) {
            // Kiểm tra trang yêu cầu có hợp lệ không
            if (pageNumber >= 1 && pageNumber <= $scope.totalPages1) {
                // Gọi API để lấy dữ liệu của trang mới
                $scope.currentPage1 = pageNumber;
                $scope.getProductByOrder();
            }
        };
        $scope.calculateIndex = function(index) {
            return ($scope.currentPage1 - 1) * $scope.pageSize1 + index + 1;
        };
    });
</script>
</html>