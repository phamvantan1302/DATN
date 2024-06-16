<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<html>
<head>
    <title>Color</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
</head>
<body class="container">
<div><br>
    <h2 style="text-align: center">QUẢN LÝ MATERIAL</h2><br>
    <form action="/admin/add_material" method="post">
        <div class="row">
            <div class="col-6">
                <label class="form-label">Code</label>
                <input type="text" class="form-control" name="code">
            </div>
            <div class="col-6">
                <label class="form-label">name</label>
                <input type="text" class="form-control" name="name">
            </div>
        </div>
        <button class="btn btn-success" type="submit">Add</button>
    </form>
    <table class="table">
        <thead>
        <tr>
            <td>Code</td>
            <td>Name</td>
            <td>Option</td>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${material.content}" var="ls">
            <tr>
                <th>${ls.code}</th>
                <th>${ls.name}</th>
                <td>
                    <a class="btn btn-info" href="/admin/detail_material/${ls.id}">Detail</a>
                </td>
                <td>
                    <a class="btn btn-danger" href="/admin/delete_material/${ls.id}">Delete</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <nav aria-label="Page navigation example" style="margin-left: 600px">
        <ul class="pagination">
            <c:if test="${material.totalPages > 1}">
                <c:forEach begin="0" end="${ material.totalPages -1}" varStatus="loop">
                    <li class="page-item">
                        <a class="page-link" href="/admin/hienthi_material?page=${loop.begin + loop.count - 1}">
                                ${loop.begin + loop.count }
                        </a>
                    </li>
                </c:forEach>
            </c:if>
        </ul>
    </nav>
</div>
</body>