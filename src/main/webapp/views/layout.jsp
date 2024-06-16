<%@ page contentType="text/html;charset=UTF-8" language="java" %>

!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý</title>
    <!-- Thêm link stylesheet của Bootstrap 5 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />
    <link href='https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css' rel='stylesheet'>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        /* Adjust the sidebar style */
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            height: 100%;
            width: 200px; /* Điều chỉnh width của sidebar */
            background-color: #343a40;
            padding-top: 70px;
            transition: width 0.3s ease; /* Thêm transition effect cho width */
            z-index: 999;
            overflow-y: auto;
            font-family: Arial, sans-serif;
        }

        /* Style the links inside the sidebar */
        .sidebar a {
            padding: 15px 20px;
            text-decoration: none;
            font-size: 18px;
            color: #fff;
            display: block;
            transition: background-color 0.3s ease;
        }

        /* Add a hover effect */
        .sidebar a:hover {
            background-color: #495057;
        }

        /* Adjust the margin-left of the content area to avoid overlap with the sidebar */
        .content-container {
            margin-left: 180px; /* Cũng cần điều chỉnh margin-left tương ứng */
            transition: margin-left 0.3s ease;
            padding: 20px;
            font-family: Arial, sans-serif;
        }
        /* CSS cho phần tên của shop */
        /* CSS cho hình ảnh người dùng */
        .user-profile {
            text-align: center;
        }

        .user-avatar {
            width: 100px; /* Điều chỉnh kích thước của hình ảnh */
            height: 100px;
            border-radius: 10%; /* Biến hình ảnh thành hình tròn */
            margin-top: -60px; /* Điều chỉnh khoảng cách lên trên */
        }
        .user-name {
            display: block;
            margin-top: 10px; /* Điều chỉnh khoảng cách giữa ảnh và tên */
            font-size: 18px; /* Điều chỉnh kích thước của tên */
            color: #fff; /* Điều chỉnh màu sắc của tên */
        }
        /* CSS for the submenu */
        .submenu {
            position: relative;
        }

        .submenu-toggle {
            padding: 10px;
            color: #fff;
            text-decoration: none;
            background-color: transparent;
            border: none;
            cursor: pointer;
            display: block;
        }

        .submenu-content {
            display: none;
            position: absolute;
            top: 100%;
            left: 0;
            background-color: #343a40;
            min-width: 200px; /* Adjust width as needed */
        }

        .submenu-content a {
            display: block;
            padding: 10px;
            color: #fff;
            text-decoration: none;
        }

        .submenu-content a:hover {
            background-color: #495057;
        }
        .submenu-content {
            display: none;
            position: absolute;
            top: 100%;
            left: 0;
            background-color: #343a40;
            min-width: 200px; /* Adjust width as needed */
        }

        .submenu-content.show {
            display: block;
        }

    </style>
</head>
<body>
<!-- Bao gồm cả sidebar và nội dung chính trong một div container -->
<div class="container-fluid d-flex">

    <div class="sidebar" id="sidebar">
        <!-- Tên của shop -->
        <div class="user-profile">
            <img src="${loggedInUser.img}" alt="User Avatar" class="user-avatar">
            <span class="user-name">${loggedInUser.fullName}</span>
        </div>

        <a  href="/admin/BanOff">
            <i class="fas fa-cash-register"></i> <!-- Icon cho Bán Tại Quầy -->
            Bán Tại Quầy
        </a>
        <a href="/admin/NhanVien">
            <i class="fas fa-users"></i> <!-- Icon cho Quản Lý Nhân Viên -->
            QL Nhân Viên
        </a>
        <a href="/admin/Order">
            <i class="fas fa-file-invoice"></i> <!-- Icon cho Quản Lý Hóa Đơn -->
            QL Hóa Đơn
        </a>
        <a href="/admin/DiscountPeriod">
            <i class="fas fa-tags"></i> <!-- Icon cho Khuyến Mãi -->
            Khuyến Mãi
        </a>
        <a href="/admin/Vourcher">
            <i class="fas fa-gift"></i> <!-- Icon cho Voucher -->
            Vourcher
        </a>
        <a href="/admin/activity">
            <i class="fas fa-history"></i> <!-- Icon cho Voucher -->
            Lịch Sử
        </a>
        <div class="submenu">
            <button class="submenu-toggle" onclick="toggleSubmenu(event)">
                <i class="fas fa-box"></i> <!-- Icon cho Quản Lý Chi Tiết Sản Phẩm -->
                QLSản Phẩm
            </button>
            <div class="submenu-content">
                <a href="/admin/hienthi_color"><i class="fas fa-palette"></i> Màu</a>
                <a href="/admin/hienthi_sole"><i class="fas fa-shoe-prints"></i> Sole</a>
                <a href="/admin/hienthi_size"><i class="fas fa-ruler-horizontal"></i> Size</a>
                <a href="/productdetail/hienthictsp"><i class="fas fa-cogs"></i> CTSp</a>
                <a href="/admin/hienthi_product"><i class="fas fa-cube"></i> Sản Phẩm</a>
                <a href="/admin/hienthi_sockliner"><i class="fas fa-socks"></i> Sockliner</a>
                <a href="/admin/hienthi_material"><i class="fas fa-layer-group"></i> Material</a>
                <a href="/admin/hienthi_lace"><i class="fas fa-tshirt"></i> Lace</a>
                <a href="/admin/hienthi_category"><i class="fas fa-tags"></i> Category</a>
                <a href="/admin/hienthi_brand"><i class="fas fa-building"></i> Brand</a>
            </div>
        </div>
        <a href="/logout">
            <i class="fas fa-sign-out-alt"></i> <!-- Icon cho Logout -->
            Logout
        </a>
    </div>

    <!-- Nội dung chính -->
    <div class="content-container">
        <jsp:include page="${view}"></jsp:include>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- Sử dụng script của Bootstrap 5 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>

    function toggleSubmenu(event) {
        console.log("Toggle Submenu function called"); // Check if function is called
        event.stopPropagation();
        const submenuContent = event.target.nextElementSibling;
        submenuContent.classList.toggle('show');
        console.log(submenuContent.classList.contains('show')); // Check if 'show' class is toggled
    }

    // Close submenu when clicking outside of it
    document.addEventListener('click', function(event) {
        const submenus = document.querySelectorAll('.submenu-content');
        submenus.forEach(function(submenu) {
            if (!event.target.closest('.submenu')) {
                submenu.classList.remove('show');
            }
        });
    });
</script>
</body>
</html>
