<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>

<!-- Content -->
<div class="container mt-5">
  <h2 style="text-align: center">Giỏ hàng</h2>
  <form class="container" method="post" action="/adidas/hienthiorder">
    <table class="table">
      <thead>
        <tr>
          <th>Sản phẩm</th>
          <th>Giá</th>
          <th>Số lượng</th>
          <th>Tổng</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach items="${listc}" var="ls">
          <tr>
            <td>${ls.productDetail.product.name}</td>
            <td id="price_${ls.id}">${ls.price}</td>
            <td>
              <a class="btn btn-light btn-sm" href="/adidas/truslgio/${ls.id}">-</a>
              <span id="quantity_${ls.id}">${ls.quantity}</span>
              <a class="btn btn-light btn-sm" href="/adidas/congslgio/${ls.id}">+</a>
            </td>
            <td id="total_${ls.id}">${ls.subtotal}</td>
            <td>
              <a class="btn btn-danger" href="/adidas/delete/${ls.cart.id}/${ls.id}">Delete</a>
            </td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
    <div class="text-center">
      <button class="btn btn-primary" type="submit">MUA NGAY</button>
    </div>
  </form>
  <script>
    function increaseQuantity(id) {
      var quantityElement = document.getElementById("quantity_" + id);
      var priceElement = document.getElementById("price_" + id);
      var totalElement = document.getElementById("total_" + id);
      var currentQuantity = parseInt(quantityElement.innerHTML);
      var price = parseFloat(priceElement.innerHTML);
      quantityElement.innerHTML = currentQuantity + 1;
      var quantity = parseInt(quantityElement.innerHTML);
      var total = quantity * price;
      totalElement.innerHTML = total;
    }

    function decreaseQuantity(id) {
      var quantityElement = document.getElementById("quantity_" + id);
      var priceElement = document.getElementById("price_" + id);
      var totalElement = document.getElementById("total_" + id);
      var currentQuantity = parseInt(quantityElement.innerHTML);
      var price = parseFloat(priceElement.innerHTML);
      if (currentQuantity > 1) {
        quantityElement.innerHTML = currentQuantity - 1;
        var quantity = parseInt(quantityElement.innerHTML);
        var total = quantity * price;
        totalElement.innerHTML = total;
      }
    }

  </script>

</div>

<%@ include file="footer.jsp" %>