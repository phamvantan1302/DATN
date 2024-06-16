<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>
<div class="container mt-5" style="color: #0b2e13">
    <h2 style="text-align: center">THANH TOÁN HÓA ĐƠN</h2> <br><br>
    <form action="/adidas/addorder" method="post" class="container" onsubmit="return validateForm()">
        <label class="form-label">Sản phẩm cần thanh toán</label>
        <%--  table sp thanh toan--%>
        <table id="idSpThanhToan" class="table">
            <thead>
                <tr>
                    <th>Tên SP</th>
                    <th>Giá</th>
                    <th>Số lượng</th>
                    <th>Tổng</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${listc}" var="ls">
                    <tr>
                        <td>${ls.productDetail.product.name}</td>
                        <td>${ls.price}</td>
                        <td>${ls.quantity}</td>
                        <td>${ls.subtotal}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <br>

        <div class="row">
            <div class="col-6">
                <label class="form-label">Phone number<span style="color: red">*</span></label>
                <span id="messagePhoneNumber" style="color: red;"></span>
                <input type="text" id="idPhoneNumber" class="form-control" name="phone_number" value="${order.phone_number}" oninput="validatePhoneNumber()">
            </div>
            <div class="col-6">
                <label class="form-label">Address<span style="color: red">*</span></label>
                <span id="messageAddress" style="color: red;"></span>
                <input type="text" id="idAddress" class="form-control" name="address" value="${order.address}">
            </div>
        </div>

        <div class="row">
            <div class="col-6">
                <label class="form-label">Name<span style="color: red">*</span></label>
                <span id="messageName" style="color: red;"></span>
                <input type="text" id="idName" class="form-control" name="name" value="${order.name}">
            </div>
            <div class="col-6">
                <label class="form-label">Email<span style="color: red">*</span></label>
                <span id="messageEmail" style="color: red;"></span>
                <input type="text" id="idEmail" class="form-control" name="email" value="${order.email}" oninput="validateEmail()">
            </div>
        </div>

        <div class="row">
            <label class="form-label">Mã Voucher</label>
            <div class="col-4">
                <input type="text" class="form-control" id="macode" name="mavoucher">
            </div>
            <div class="col-4">
                <input type="text" class="form-control" id="sotiengiam" name="giatrivoucher">
            </div>
            <div class="col-2">
                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">
                    Chọn Voucher
                </button>
            </div>
        </div>
        <div class="row">
            <div class="col-6">
                <label class="form-label">Tổng số lượng</label>
                <input type="text" id="sumsl" class="form-control" name="sumquantity" readonly>
            </div>
            <div class="col-6">
                <label class="form-label">Tổng tiền (VND)</label>
                <input type="text" id="sumvalue" class="form-control" name="summoney" readonly>
            </div>
        </div>
        <img src="/views/manh/imagenh.jpg">
        <button type="submit" class="btn btn-primary">THANH TOÁN</button>
    </form>
    <!-- Modal-->
    <div class="modal" id="myModal">
        <div class="modal-dialog">
            <div class="modal-content">
                <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title">Lựa chọn</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <!-- Modal body -->
                <div class="modal-body">
                    <div class="row">
                        <form action="/productdetail/search" method="get">
                            <div class="input-group">
                                <div class="form-outline">
                                    <input type="search" name="key" class="form-control"
                                           placeholder="Nhập tên cần tìm"/>
                                </div>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-search">Search</i>
                                </button>
                            </div>
                        </form>
                    </div>

                    <div class="row">
                        <table id="saveData" class="table">
                            <thead>
                            <tr>
                                <th>Mã Voucher</th>
                                <th>Mệnh giá (VND)</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${discountPeriods}" var="ls">
                                <tr>
                                    <td>${ls.code}</td>
                                    <td>${ls.value}</td>
                                    <td>
                                        <button type="button" class="btn btn-secondary" onclick="chonDong(this)"
                                                data-dismiss="modal">Chọn
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>

                </div>
                <!-- Modal footer -->
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
</div>
<%-- JS--%>
<script>
    window.addEventListener('DOMContentLoaded', function () {
        var table = document.getElementById('idSpThanhToan');
        var rows = table.rows;
        var sumSL = 0, sumValue = 0;

        for (var i = 1; i < rows.length; i++) {
            sumSL += parseFloat(rows[i].cells[2].innerText);
            sumValue += parseFloat(rows[i].cells[3].innerText);
        }
        document.getElementById('sumvalue').value = sumValue;
        document.getElementById('sumsl').value = sumSL;
    });
    function chonDong(button) {
        var dong = button.closest('tr');
        var oCells = dong.getElementsByTagName('td');
        var sumValue = document.getElementById('sumvalue').value;
        // Lấy dữ liệu từ modal
        var code = oCells[0].innerText;
        var value = oCells[1].innerText;
        // Đặt giá trị vào thẻ input trong form trước đó
        document.getElementById('macode').value = code;
        document.getElementById('sotiengiam').value = parseInt(value);
        var gia = parseInt(document.getElementById('sotiengiam').value);
        document.getElementById('sumvalue').value = parseInt(sumValue) - gia;
        // Đóng modal
        $('#myModal').modal('hide');
    };
    function validateForm() {
        var idPhoneNumber = document.getElementById("idPhoneNumber").value;
        var idAddress = document.getElementById("idAddress").value;
        var idName = document.getElementById("idName").value;
        var idEmail = document.getElementById("idEmail").value;

        if (idPhoneNumber === "") {
            alert("Vui lòng không để Phone Number bị trống");
            return false;
        }if (idAddress === "") {
            alert("Vui lòng không để Address bị trống");
            return false;
        }if (idName === "") {
            alert("Vui lòng không để Name bị trống");
            return false;
        }if (idEmail === "") {
            alert("Vui lòng không để Email bị trống");
            return false;
        }
        return true;
    }
    function validatePhoneNumber() {
        var idPhoneNumber = document.getElementById("idPhoneNumber").value;
        var messagePhoneNumber = document.getElementById("messagePhoneNumber");
        if (isNaN(idPhoneNumber)) {
            messagePhoneNumber.innerHTML = "Vui lòng chỉ nhập số vào ô Phone Number.";
        } else {
            messagePhoneNumber.innerHTML = "";
        }
    }
    function validateEmail() {
        var idEmail = document.getElementById("idEmail").value;
        var messageEmail = document.getElementById("messageEmail");
        var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(idEmail)) {
            messageEmail.innerHTML = "Vui lòng nhập địa chỉ email hợp lệ.";
        } else {
            messageEmail.innerHTML = "";
        }
    }
</script>
<br><br>
<%@ include file="footer.jsp" %>