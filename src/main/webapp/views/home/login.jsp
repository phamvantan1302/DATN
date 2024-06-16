<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href='https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css' rel='stylesheet'>
  <title>Form Đăng Nhập</title>
  <style>

    #wrapper{

      min-height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
    }
    body{
      background: url("/logo/giay-20.jpg");
      background-size: cover;
      font-family: -apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,Oxygen,Ubuntu, Cantarell, " Open Sans", "Helvetica Neue",sans-serif;
      position: relative;
      min-height: 100vh;
      width: 100%;
    }
    #form-login{
      border-radius: 30px;
      overflow: hidden;
      max-width: 400px;
      background: rgba(0, 0, 0 , 0.8);
      flex-grow: 1;
      padding: 30px 30px 40px;
      box-shadow: 0px 0px 17px 2px rgba(255, 255, 255, 0.8);
    }
    .form-heading{
      font-size: 25px;
      color: #f5f5f5;
      font-family: Impact Charcoal;
      text-align: center;
      margin-bottom: 30px;
    }
    .form-group{
      border-bottom: 1px solid #fff;
      margin-top: 15px;
      margin-bottom: 20px;
      display: flex;
    }
    .form-group i{
      color: #fff;
      font-size: 14px;
      padding-top: 5px;
      padding-right: 10px;
    }
    .form-input{
      background: transparent;
      border: 0;
      outline: 0;
      color: #f5f5f5;
      flex-grow: 1;
    }
    .form-input::placeholder{
      color: #999;
      font-style: italic;
    }
    #eye i{
      padding-right: 0;
      cursor: pointer;
    }
    .form-submit{
      border-radius: 30px;
      background: transparent;
      border: 1px solid #f5f5f5;
      color: #fff;
      width: 100%;
      text-transform: uppercase;
      padding: 6px 10px;
      transition: 0.25s ease-in-out;
      margin-top: 30px;
    }
    .form-submit:hover{
      border: 1px solid #54a0ff;
    }

    /*!
* Bootstrap Reboot v4.3.1 (https://getbootstrap.com/)
* Copyright 2011-2019 The Bootstrap Authors
* Copyright 2011-2019 Twitter, Inc.
* Licensed under MIT (https://github.com/twbs/bootstrap/blob/master/LICENSE)
* Forked from Normalize.css, licensed MIT (https://github.com/necolas/normalize.css/blob/master/LICENSE.md)
*/

    a {
      color: #007bff;
      text-decoration: none;
      background-color: transparent;
    }

    a:hover {
      color: #0056b3;
      text-decoration: underline;
    }

    a:not([href]):not([tabindex]) {
      color: inherit;
      text-decoration: none;
    }

    a:not([href]):not([tabindex]):hover,
    a:not([href]):not([tabindex]):focus {
      color: inherit;
      text-decoration: none;
    }

    a:not([href]):not([tabindex]):focus {
      outline: 0;
    }

    pre,
    code,
    kbd,
    samp {
      font-family: SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono", "Courier New", monospace;
      font-size: 1em;
    }

    pre {
      margin-top: 0;
      margin-bottom: 1rem;
      overflow: auto;
    }

    figure {
      margin: 0 0 1rem;
    }

    img {
      vertical-align: middle;
      border-style: none;
    }

    svg {
      overflow: hidden;
      vertical-align: middle;
    }

    table {
      border-collapse: collapse;
    }

    caption {
      padding-top: 0.75rem;
      padding-bottom: 0.75rem;
      color: #6c757d;
      text-align: left;
      caption-side: bottom;
    }

    th {
      text-align: inherit;
    }

    label {
      display: inline-block;
      margin-bottom: 0.5rem;
    }

    button {
      border-radius: 0;
    }

    button:focus {
      outline: 1px dotted;
      outline: 5px auto -webkit-focus-ring-color;
    }

    input,
    button,
    select,
    optgroup,
    textarea {
      margin: 0;
      font-family: inherit;
      font-size: inherit;
      line-height: inherit;
    }

    button,
    input {
      overflow: visible;
    }

    button,
    select {
      text-transform: none;
    }

    select {
      word-wrap: normal;
    }

    button,
    [type="button"],
    [type="reset"],
    [type="submit"] {
      -webkit-appearance: button;
    }

    button:not(:disabled),
    [type="button"]:not(:disabled),
    [type="reset"]:not(:disabled),
    [type="submit"]:not(:disabled) {
      cursor: pointer;
    }

    button::-moz-focus-inner,
    [type="button"]::-moz-focus-inner,
    [type="reset"]::-moz-focus-inner,
    [type="submit"]::-moz-focus-inner {
      padding: 0;
      border-style: none;
    }

    input[type="radio"],
    input[type="checkbox"] {
      box-sizing: border-box;
      padding: 0;
    }

    input[type="date"],
    input[type="time"],
    input[type="datetime-local"],
    input[type="month"] {
      -webkit-appearance: listbox;
    }

    textarea {
      overflow: auto;
      resize: vertical;
    }

    fieldset {
      min-width: 0;
      padding: 0;
      margin: 0;
      border: 0;
    }

    legend {
      display: block;
      width: 100%;
      max-width: 100%;
      padding: 0;
      margin-bottom: .5rem;
      font-size: 1.5rem;
      line-height: inherit;
      color: inherit;
      white-space: normal;
    }

    progress {
      vertical-align: baseline;
    }

    [type="number"]::-webkit-inner-spin-button,
    [type="number"]::-webkit-outer-spin-button {
      height: auto;
    }

    [type="search"] {
      outline-offset: -2px;
      -webkit-appearance: none;
    }

    [type="search"]::-webkit-search-decoration {
      -webkit-appearance: none;
    }

    ::-webkit-file-upload-button {
      font: inherit;
      -webkit-appearance: button;
    }

    output {
      display: inline-block;
    }

    summary {
      display: list-item;
      cursor: pointer;
    }

    template {
      display: none;
    }

    [hidden] {
      display: none !important;
    }
    .remember-me{
      color: white;
    }
    .register-link{
      text-align: center;
    }
    #error_tk{
      color: red;
    }
    #error_mk{
      color: red;
    }



  </style>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
<div id="wrapper" class="home_content">
  <form action="" id="form-login">
    <h2 class="form-heading">Adidas Sport</h2>
    <div class="form-group">
      <i class="far fa-user"></i>
      <input type="text" id="loginUsername" name="loginUsername" class="form-input" placeholder="Account Name">

    </div>
    <div id="error_tk"><span id="login-error-message-tk"></span></div>
    <div class="form-group">
      <i class="fas fa-key"></i>
      <input type="password" id="loginPassword" name="loginPassword" class="form-input" placeholder="Password">
      <div id="eye">
        <i class="far fa-eye"></i>
      </div>

    </div>
    <div id="error_mk"><span id="login-error-message-mk"></span></div>
    <div class="remember-me">
      <input type="checkbox" id="rememberPassword" name="rememberPassword">
      <label for="rememberPassword">Remember Password</label>
    </div>
    <input type="button" onclick="validateLogin()" value="Login"  class="form-submit">
    <div class="register-link">
      <a href="/Register">register right now</a>
    </div>
  </form>
</div>


</body>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
  $(document).ready(function(){
    $('#eye').click(function(){
      $(this).toggleClass('open');
      $(this).children('i').toggleClass('fa-eye-slash fa-eye');
      if($(this).hasClass('open')){
        $(this).prev().attr('type', 'text');
      }else{
        $(this).prev().attr('type', 'password');
      }
    });
  });
  function validateLogin() {
    var loginUsername = $("#loginUsername").val().trim();
    var loginPassword = $("#loginPassword").val().trim();
    var errorMessagetk = $("#login-error-message-tk");
    var errorMessagemk = $("#login-error-message-mk");

    errorMessagetk.html("");
    errorMessagemk.html("");

    if (loginPassword === "" && loginUsername === ""){
      errorMessagetk.html("Username cannot be blank.");
      errorMessagemk.html("Password can not be blank.");
      $("#loginUsername").focus();
      $("#loginPassword").focus();
      return;
    }
    if (loginUsername === "") {
      errorMessagetk.html("Username cannot be blank.");
      console.log("a")
      $("#loginUsername").focus();
      return;
    }

    if (loginPassword === "") {
      errorMessagemk.html("Password can not be blank.");
      $("#loginPassword").focus();
      return;
    }


    // Thực hiện xử lý đăng nhập (ở đây chỉ là alert)
    alert("Đăng Nhập Thành Công!");
  }
  let btn = document.querySelector("#btn");
  let sidebar = document.querySelector(".sidebar");
  let searchBtn = document.querySelector(".bx-search");

  btn.onclick = function(){
    sidebar.classList.toggle("active");
  }
  searchBtn.onclick = function(){
    sidebar.classList.toggle("active");
  }

</script>

</html>