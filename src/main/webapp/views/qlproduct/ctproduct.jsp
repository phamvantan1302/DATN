<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<html>
<head>
    <title>Title</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
</head>
<body class="container">
<div><br>
    <h2 style="text-align: center">QUẢN LÝ SẢN PHẨM CHI TIẾT</h2><br>
    <form action="/productdetail/update?id=${sp.id}" method="post">

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
                <input type="text" class="form-control" name="quantity" value="${sp.quantity}">
            </div>
        </div>
        <div class="mb-3">
            <label class="form-label">describe</label>
            <input type="text" class="form-control" name="describe" value="${sp.describe}">
        </div>
        <div class="mb-3">
            <label class="form-label">gender</label><br>
            <input type="radio" name="gender" value="true" ${sp.gender == "true" ? "checked" : ""} checked>Nam
            <input type="radio" name="gender" value="false" ${sp.gender == "false" ? "checked" : ""}>Nữ
        </div>
        <div class="mb-3">
            <label class="form-label">price</label>
            <input type="text" class="form-control" name="price" value="${sp.price}">
        </div>

        <div class="row">
            <div class="col-1">
                <button class="btn btn-success" type="submit">Update</button>
            </div>

            <div class="col-1">
                <form action="/productdetail/hienthi" method="get">
                    <button class="btn btn-success" type="submit">Cancel</button>
                </form>
            </div>

            <div class="col-7">
            </div>

            <div class="col-3" style="text-align: end">

            </div>
        </div>
    </form>

</div>
</body>
</html>