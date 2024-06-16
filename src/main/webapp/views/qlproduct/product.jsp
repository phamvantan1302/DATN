<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<html>
<head>
    <title>Title</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
</head>
<body>
<div class="row">
    <div class="col-10"><br>
        <h2 style="text-align: center">QUẢN LÝ SẢN PHẨM</h2><br>
        <form action="/productdetail/add" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
            <div class="row">
                <div class="col-2">Chọn ảnh:</div>
                <div class="col-10">
                    <input type="file" id="imageInput" name="anhsp">
                </div>
            </div>

    <%--        <input type="text" id="imageName" placeholder="Image Name" name="anhsp" readonly style="width: 300px">--%>
            <div class="row">
                <div class="col-6">
                    <label class="form-label">Category </label>
                    <select name="category" class="form-select">
                        <c:forEach items="${category }" var="category">
                            <option value="${category.id}" ${category.id == sp.category.id ? 'selected="selected"' : ''}>${category.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-6">
                    <label class="form-label">Size </label>
                    <select name="size" class="form-select">
                        <c:forEach items="${size }" var="size">
                            <option value="${size.id}" ${size.id == sp.size.id ? 'selected="selected"' : ''}>${size.name}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="row">
                <div class="col-6">
                    <label class="form-label">Product </label>
                    <select name="product" class="form-select">
                        <c:forEach items="${product }" var="product">
                            <option value="${product.id}" ${product.id == sp.product.id ? 'selected="selected"' : ''}>${product.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-6">
                    <label class="form-label">Material </label>
                    <select name="material" class="form-select">
                        <c:forEach items="${material }" var="material">
                            <option value="${material.id}" ${material.id == sp.material.id ? 'selected="selected"' : ''}>${material.name}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="row">
                <div class="col-6">
                    <label class="form-label">Brand </label>
                    <select name="brand" class="form-select">
                        <c:forEach items="${brand }" var="brand">
                            <option value="${brand.id}" ${brand.id == sp.brand.id ? 'selected="selected"' : ''}>${brand.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-6">
                    <label class="form-label">Color </label>
                    <select name="color" class="form-select">
                        <c:forEach items="${color }" var="color">
                            <option value="${color.id}" ${color.id == sp.color.id ? 'selected="selected"' : ''}>${color.name}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="row">
                <div class="col-6">
                    <label class="form-label">Sole </label>
                    <select name="sole" class="form-select">
                        <c:forEach items="${sole }" var="s">
                            <option value="${s.id}" ${s.id == sp.sockliner.id ? 'selected="selected"' : ''}>${s.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-6">
                    <label class="form-label">Lace </label>
                    <select name="lace" class="form-select">
                        <c:forEach items="${lace }" var="lace">
                            <option value="${lace.id}" ${lace.id == sp.lace.id ? 'selected="selected"' : ''}>${lace.name}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="row">
                <div class="col-6">
                    <label class="form-label">Sockliner </label>
                    <select name="sockliner" class="form-select">
                        <c:forEach items="${sockliner }" var="sockliner">
                            <option value="${sockliner.id}" ${sockliner.id == sp.sockliner.id ? 'selected="selected"' : ''}>${sockliner.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-6">
                    <label class="form-label">Quantity</label>
                    <input type="text" id="idQuantity" class="form-control" name="quantity" value="${sp.quantity}" oninput="validateQuantity()">
                    <span id="messageQuantity" style="color: red;"></span>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label">gender</label><br>
                <input type="radio" name="gender" value="true" ${sp.gender == "true" ? "checked" : ""} checked>Giày Nam
                <input type="radio" name="gender" value="false" ${sp.gender == "false" ? "checked" : ""}>Giày Nữ
            </div>
            <div class="row">
                <div class="col-6">
                    <label class="form-label">describe</label>
                    <input type="text" class="form-control" name="describe" value="${sp.describe}">
                </div>
                <div class="col-6">
                    <label class="form-label">Price</label>
                    <span id="messagePrice" style="color: red;"></span>
                    <input type="text" id="idPrice" class="form-control" name="price" value="${sp.price}" oninput="validatePrice()">
                </div>
            </div><br>
            <div class="row">
                <div class="col-1">
                    <form action="/productdetail/add" method="post" >
                        <button class="btn btn-success" type="submit">Add</button>
                    </form>
                </div>

                <div class="col-4">
                </div>

                <div class="col-4" style="text-align: end">
                    <form action="/productdetail/search" method="get">
                        <div class="input-group">
                            <div class="form-outline" >
                                <input type="search" name="keySearch" class="form-control" placeholder="Nhập tên cần tìm"/>
                            </div>
                            <button type="submit" class="btn btn-success" >
                                Search
                            </button>
                        </div>
                    </form>
                </div>
                <div class="col-3">
                    <form action="/productdetail/filter" method="get">
                        <div class="input-group">
                            <div class="form-outline" >
                                <select name="keyLoc" id="keyLoc" onchange="filterList()" class="form-select">
                                    <option value="0">Đang Bán</option>
                                    <option value="1">Dừng bán</option>
                                </select>
                            </div>
                            <button type="submit" class="btn btn-success" >
                                Lọc
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </form>
    <%--    JS--%>
        <script>
            function filterList() {
                var keyLoc = document.getElementById("keyLoc").value;
                var xmlhttp = new XMLHttpRequest();
                xmlhttp.onreadystatechange = function() {
                    if (this.readyState == 4 && this.status == 200) {
                        document.getElementById("filteredContent").innerHTML = this.responseText;
                    }
                };
                xmlhttp.open("GET", "/productdetail/filter?keyLoc=" + keyLoc, true);
                xmlhttp.send();
            }
            function validateForm() {
                var idQuantity = document.getElementById("idQuantity").value;
                var idPrice = document.getElementById("idPrice").value;
                if (idQuantity === "") {
                    alert("Vui lòng không để Quantity bị trống");
                    return false;
                }if (idPrice === "") {
                    alert("Vui lòng không để Price bị trống");
                    return false;
                }
                return true;
            }
            function validateQuantity() {
                var idQuantity = document.getElementById("idQuantity").value;
                var messageQuantity = document.getElementById("messageQuantity");
                if (isNaN(idQuantity)) {
                    messageQuantity.innerHTML = "Vui lòng chỉ nhập số vào ô Quantity.";
                } else {
                    messageQuantity.innerHTML = "";
                }
            }
            function validatePrice() {
                var idPrice = document.getElementById("idPrice").value;
                var messagePrice = document.getElementById("messagePrice");
                if (isNaN(idPrice)) {
                    messagePrice.innerHTML = "Vui lòng chỉ nhập số vào ô Price.";
                } else {
                    messagePrice.innerHTML = "";
                }
            }
        </script>
        <table class="table table-borderted mt-2">
            <thead>
            <tr>
    <%--            <td>image</td>--%>
                <td>Category</td>
                <td>Size</td>
                <td>Product</td>
                <td>Material</td>
                <td>Brand</td>
                <td>Color</td>
                <td>Sole</td>
                <td>Lace</td>
                <td>Sockliner</td>
                <td>Quantity</td>
                <td>Gender</td>
                <td>price</td>
                <td colspan="2">Action</td>
            </tr>
            </thead>
            <tbody>
                <c:forEach items="${listprd.content}" var="ls">
                    <tr>
        <%--                <td><img src="/iamgesp/${ls.image.name}"></td>--%>
                        <td>${ls.category.name}</td>
                        <td>${ls.size.name}</td>
                        <td>${ls.product.name}</td>
                        <td>${ls.material.name}</td>
                        <td>${ls.brand.name}</td>
                        <td>${ls.color.name}</td>
                        <td>${ls.sole.name}</td>
                        <td>${ls.lace.name}</td>
                        <td>${ls.sockliner.name}</td>
                        <td>${ls.quantity}</td>
                        <td>${ls.gender == true? "Nam":"Nữ"}</td>
                        <td>${ls.price}</td>
                        <td>${ls.status == 0 ? "Đang bán":"Ngừng bán"}</td>
                        <td><a class="btn btn-info" href="/productdetail/detail/${ls.id}">Chi tiết</a></td>
                        <td><a class="btn btn-danger" href="/productdetail/updatett/${ls.id}/${ls.status}">Đổi trạng thái</a></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <nav aria-label="Page navigation example" style="margin-left: 600px">
            <ul class="pagination">
                <c:if test="${listprd.totalPages > 1}">
                    <c:forEach begin="0" end="${ listprd.totalPages -1}" varStatus="loop">
                        <li class="page-item">
                            <a class="page-link" href="/productdetail/hienthictsp?page=${loop.begin + loop.count - 1}">
                                    ${loop.begin + loop.count }
                            </a>
                        </li>
                    </c:forEach>
                </c:if>
            </ul>
        </nav>
    </div>
</div>
</body>
</html>