<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
        img {
            text-align: center;
            width: 35%;
            height: 35%;
        }
    </style>
</head>

<body onload="auto()">
<span id="tao">1/5</span>
<img src="img/1.jpg" id="slideshow" alt="">
<button onclick="stop()">stop</button>
<button onclick="next()">next</button>
<button onclick="prev()">prev</button>
<button onclick="auto()">auto</button>

<form action="" method="get">
    <label for="username">Username:</label><br>
    <input type="text" id="username" name="username"><br><br>
    <span style="color: red" id="index1"></span>

    <label for="email">Email:</label><br>
    <input type="text" id="email" name="email"><br><br>
    <span style="color: red;" id="index2"></span>
    <label for="phone">Phone:</label><br>
    <input type="tel" id="phone" name="phone" pattern="[0-9]{10}"><br><br>
    <span style="color: red; " id="index3"></span>

    <label for="phone">tuổi:</label><br>
    <input type="text" id="age" name="age "><br><br>
    <span style="color: red; " id="index4 "></span>

    <input type="submit" onclick="return checkform()" value="Register">
</form>

<script>
    var img = [];
    var index = 0;
    var auto;
    for (i = 0; i < 6; i++) {
        img[i] = new Image;
        img[i].src = "img/" + (i + 1) + ".jpg";
    }


    function next() {
        index++;
        if (index >= img.length) {
            index = 0;
        }
        var anh = document.getElementById("slideshow ");
        anh.src = img[index].src;
        document.getElementById("tao ").innerText = index + 1 + "/ " + img.length;
    }

    function auto() {
        auto = setInterval(next, 3000);
    }

    function prev() {
        index--;
        if (index < 0) {
            index = img.length - 1;
        }
        var anh = document.getElementById("slideshow ");
        anh.src = img[index].src;
        document.getElementById("tao ").innerText = index + 1 + "/ " + img.length;
    }

    function stop() {
        clearInterval(auto);
    }

    function checkform() {
        var username = document.getElementById("username ").value;
        var email = document.getElementById("email ").value;
        var phone = document.getElementById("phone ").value;
        var age = document.getElementById("age ").value;

        if (username.trim() === '') {
            document.getElementById("index1 ").innerText = 'Không được để trống.';
            console.log("Không được để trống ");
            return false;
        } else {
            document.getElementById("index1 ").innerText = '';
        }
        if (email.trim() === '') {
            document.getElementById("index2 ").innerText = 'mời bạn nhập email của mình.';
            return false;
        } else {
            document.getElementById("index2 ").innerText = '';
        }
        if (phone.trim() === '') {
            document.getElementById("index3 ").innerText = 'mời bạn nhập tên phone của mình';
            return false;
        } else {
            document.getElementById("index3 ").innerText = '';
        }

        if (username.length < 8) {
            document.getElementById("index1 ").innerText = 'yêu cầu 8 kí tự.';
            console.log("Không được để trống ");
            return false;
        } else {
            document.getElementById("index1 ").innerText = '';
        }
        if (age.trim() === '') {
            document.getElementById("index4 ").innerText = 'Không được để trống.';
            console.log("Không được để trống ");
            return false;
        } else {
            document.getElementById("index4 ").innerText = '';
        }
        if (!isNaN(age)) {
            document.getElementById("index4 ").innerText = 'tuoi phải la so duong';
            console.log("Không được để trống ");
            return false;
        } else {
            document.getElementById("index4 ").innerText = '';
        }
        alert("thêm thành công ");
        return true;
    };
</script>
</body>

</html>