<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<%@ include file="header.jsp" %>

<div id="carouselExampleCaptions" class="carousel slide">
    <div class="carousel-indicators">
        <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="0" class="active" aria-current="true"></button>
    </div>
    <div class="carousel-inner">
        <div class="carousel-item active">
            <img src="/views/imagesp/banner-bg.png" class="d-block w-100" alt="...">
            <div class="carousel-caption d-none d-md-block" style="width: 500px; text-align: center">
                <form class="input-group" action="/adidas/searchname" method="get">&nbsp;
                    <input type="search" name="keySearch" class="form-control" placeholder="Nhập tên cần tìm">
                    <button type="submit" class="btn btn-success" >Search
<%--                        <img src="/logo/search-icon.png" class="card-img-top" alt="">--%>
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<div class="container mt-5">
    <h2 style="text-align: center">Tất cả sản phẩm </h2><br>
    <div class="row">
        <div class="col-10"></div>
        <div class="col-2">
            <form action="/adidas/locmoney" method="get">
                <div class="input-group">
                    <div class="form-outline" >
                        <select name="locmoney" class="form-select">
                            <option value="0">Dưới 300K</option>
                            <option value="1">300K-600K</option>
                            <option value="2">600k-1tr</option>
                            <option value="3">Trên 1tr</option>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-info" style="">Lọc</button>
                </div>
            </form>
        </div>
    </div><br>
    <div class="row">
        <c:forEach items="${listprd.content}" var="ls">
            <div class="col-3">
                <c:forEach items="${ls.image}" var="image">
                    <div class="card" style="width: 18rem;">
                        <img src="/views/imagesp/${image.name}" class="card-img-top" alt="">
                        <div class="card-body">
                            <p style="text-align: center"> ${ls.product.name}</p>
                            <p style="text-align: center;color: red">${ls.price} VND</p>
                            <div class="row">
                                <div class="col-6" style="text-align: start">
                                    <a href="/adidas/addcart/${ls.id}" type="button" class="btn btn-info">Thêm giỏ</a>
                                </div>
                                <div class="col-6" style="text-align: end">
                                    <a href="/adidas/detailsp/${ls.id}" type="button" class="btn btn-info" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-title="Thông tin chi tiết sản phẩm">Chi tiết</a>
                                </div>
                            </div>
                        </div>
                    </div><br>
                </c:forEach><br>
            </div>
        </c:forEach><br>
    </div>

    <nav aria-label="Page navigation example" style="margin-left: 600px">
        <ul class="pagination">
            <c:if test="${listprd.totalPages > 1}">
                <c:forEach begin="0" end="${ listprd.totalPages -1}" varStatus="loop">
                    <li class="page-item">
                        <a class="page-link" href="/adidas/hien-thi?page=${loop.begin + loop.count - 1}">
                                ${loop.begin + loop.count }
                        </a>
                    </li>
                </c:forEach>
            </c:if>
        </ul>
    </nav>

</div>
<%@ include file="footer.jsp" %>