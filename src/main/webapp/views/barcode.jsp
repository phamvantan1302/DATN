<!DOCTYPE html>
<html lang="en" ng-app="myApp">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Barcode Scanner</title>
    <script src="https://cdn.rawgit.com/serratus/quaggaJS/0.12.1/dist/quagga.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular.min.js"></script>
</head>
<body ng-controller="myController">

<video id="video" width="640" height="480" autoplay></video>

<script>
    var app = angular.module('myApp', []);

    app.controller('myController', function ($scope, $http) {
        var video = document.getElementById('video');
        var scanning = false; // Biến flag để kiểm soát trạng thái của quét

        // Cấu hình QuaggaJS
        Quagga.init({
            inputStream: {
                name: "Live",
                type: "LiveStream",
                target: video
            },
            decoder: {
                readers: ["ean_reader", "code_128_reader"]
            }
        }, function (err) {
            if (err) {
                console.error(err);
                return;
            }
            // Bắt đầu QuaggaJS
            Quagga.start();
        });

        // Bắt sự kiện khi có kết quả từ QuaggaJS
        Quagga.onDetected(function (result) {
            if (!scanning) {
                return;
            }

            console.log('Barcode result:', result.codeResult.code);

            // Gọi API để gửi mã vạch lên server
            $http.post('http://localhost:8080/staff/scan-barcode', { image: result.codeResult.code })
                .then(function (response) {
                    console.log('API Response:', response.data);
                    // Xử lý kết quả nếu cần
                })
                .catch(function (error) {
                    console.error('Error calling API:', error);
                });

            // Dừng quét để tránh quét liên tục
            scanning = false;
        });

        navigator.mediaDevices.getUserMedia({ video: true })
            .then(function (stream) {
                video.srcObject = stream;
                video.play();

                // Hạn chế quét mỗi 5 giây
                setInterval(function () {
                    if (!scanning) {
                        Quagga.start();
                        scanning = true;
                    }
                }, 5000);
            })
            .catch(function (err) {
                console.error('Error accessing webcam:', err);
            });
    });

</script>
</body>
</html>
