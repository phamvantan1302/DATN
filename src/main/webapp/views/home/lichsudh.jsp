<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>

<div class="container">
    <h2>LỊCH SỬ ĐƠN HÀNG</h2><br>
    <table class="table table-borderted mt-2">
        <thead>
        <tr>
            <td>Phone number</td>
            <td>Address</td>
            <td>Username</td>
            <td>email</td>
            <td>Item Discount</td>
            <td>Total Money</td>
            <td>Create Date</td>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${order.content}" var="ls">
            <tr>
                <td>${ls.phoneNumber}</td>
                <td>${ls.address}</td>
                <td>${ls.useName}</td>
                <td>${ls.email}</td>
                <td>${ls.itemDiscount}</td>
                <td>${ls.totalMoney}</td>
                <td>${ls.createDate}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<%@ include file="footer.jsp" %>