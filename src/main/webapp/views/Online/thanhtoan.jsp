<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Thanh toán</title>
    <style>
        body{
            font-family: Arial;
        }
        label{
            height: 30px;
        }
        input{
            height: 30px;
            width: 400px;
            font-size: 15px;
            background-color: #dce5f5;
            border-radius: 5px; /* Độ cong của các cạnh */
            padding: 5px; /* Khoảng cách giữa nội dung và viền của input và button */
            border: 1px solid #ccc; /* Viền của input và button */
        }
        button{
            background-color: #0f7b3a;
            color: #dce5f5;
            height: 45px;
            width: 200px;
            font-size: 15px;
            cursor: pointer;
            border-radius: 5px; /* Độ cong của các cạnh */
            padding: 10px; /* Khoảng cách giữa nội dung và viền của input và button */
            border: 1px solid #ccc; /* Viền của input và button */

        }
        button:hover {
            background-color: #1E9E0E;
        }
        .container {
            display: grid;
            grid-template-columns: repeat(2, 1fr); /* Chia trang thành 3 cột có chiều rộng bằng nhau */
            grid-gap: 10px; /* Khoảng cách giữa các cột */
        }

        .column {
            padding: 20px; /* Khoảng cách lề trong cột */
        }
    </style>
</head>
<body>
<div>
    <h2 style="text-align: center">THÔNG TIN CHUYỂN KHOẢN</h2><br><br>
    <div class="container">
        <div class="column" style="text-align: center">
            <img style="max-width: 80%; height: auto;" src="/views/manh/imagenh.jpg" alt="">
        </div>
        <div class="column"><br>
            <label>Tên chủ tài khoản</label><br>
            <input type="text" value="PHAM VAN TAN" readonly><br><br>
            <label>Số tài khoản</label><br>
            <input type="text" value="60354051027" readonly><br><br>
            <label>Chi nhánh ngân hàng</label><br>
            <input type="text" value="Chi nhánh ngân hàng TPBank" readonly><br><br>
            <label>Số tiền cần thanh toán</label><br>
            <input type="text" value="${totalAmount}" readonly><br><br>
            <label>Nội dung chuyển khoản</label><br>
            <input type="text"value="Chi nhánh ngân hàng TPBank" readonly><br>
            <br>
            <button type="submit">Thanh toán</button>
        </div>
    </div>
</div>
</body>
<script>
    setTimeout(function() {
        window.location.href = '/AdidasSporst/home'; // Thay thế bằng đường dẫn tới trang tiếp theo của bạn
    }, 5000); // 5000 milliseconds = 5 seconds
</script>
</html>