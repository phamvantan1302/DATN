<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ include file="header.jsp" %>
<div class="container mt-5">
    <h2>THÔNG TIN CHI TIẾT SP </h2><br>
    <form action="/adidas/addgioctsp?id=${sp.id}" method="get">
        <div class="row">
            <div class="col-3">
                <c:forEach items="${sp.image }" var="image">
                    <img src="/imagesp/${image.name}" class="card-img-top" alt="">
                </c:forEach>
            </div>
            <div class="col-2"></div>
            <div class="col-7">
                <h3 class="row">${sp.product.name}</h3><br>
                <label class="form-label"><b>Giá bán:</b> <span style="color: red">${sp.price} VND</span></label><br>
                <label class="form-label"><b>Số lượng trong kho:</b> <i>${sp.quantity}</i></label><br>
                <label class="form-label"><b>Loại giày:</b> <i>${sp.category.name}</i></label><br>
                <label class="form-label"><b>Chất liệu sản phẩm:</b> <i>${sp.material.name}</i></label><br>
                <label class="form-label"><b>Hãng sản phẩm:</b> <i>${sp.brand.name}</i></label><br>
                <label class="form-label"><b>Chất liệu đế giày:</b> <i>${sp.sole.name}</i></label>
                <br>
                <button class="btn btn-success" type="submit">Thêm vào giỏ</button>
            </div>
        </div>
    </form>
        <hr>

    <div>
        <h4>Mô tả sản phẩm</h4>
        <p>Giày thể thao thông dụng nam ${sp.product.name} được xem là mẫu giày "quốc dân" chưa bao giờ ngừng hot.
            Mặc dù đã ra mắt từ rất lâu nhưng đây vẫn được xem là sự lựa chọn hàng đầu cho những bạn yêu thích
            sự đơn giản. Thiết kế giày full đen hoặc trắng sẽ là điểm nhấn làm rung động biết bao nhiêu tín đồ mê phong
            cách thời trang hiện đại, trẻ trung. Để hiểu hơn về sản phẩm, cùng xem chi tiết ngay sau đây.</p><br>
        <h4>Đế giày</h4>
        <p>Đế giày thể thao Basic là chất liệu PVC có khả năng uốn dẻo và chống mài mòn vô cùng tốt. Bên cạnh đó, đế PVC còn giúp cho giày có tính cách nhiệt và chịu lực cực hiệu quả</p>
        <p>Phần đế được thiết kế đặc biệt thu hút một cách tối đa lực tiếp xúc nên khi mang hoặc lúc vận động bạn sẽ có cảm giác được nâng niu một cách nhẹ nhàng</p>
        <p>Đế giày xuyên suốt từ gót đến mũi, các đường rãnh được tạo ra giúp tăng khả năng bám đường tốt hơn khi di chuyển, hạn chế trơn trượt tối đa</p>
        <p>Lót giày OrthoLite mang đến sự êm ái và khả năng hút ẩm tốt, chống hôi chân</p><br>
        <h4>Thân giày</h4>
        <p>Thân giày được gia công từ chất liệu lưới kết hợp Si với độ ôm chân vừa phải, giúp đôi giày cố định và nâng đỡ tốt bàn chân trong quá trình di chuyển</p>
        <p>Điểm nhấn ở ${sp.product.name} có thể kể đến là sự cân bằng hoàn hảo với các đường nét chế tác vô cùng sắc sảo.</p>
        <p>Trên thân giày sẽ có những lỗ li ti, khi mang bạn sẽ cảm nhận sự thông thoáng và trao đổi khí bên trong, điều này làm giảm thiểu đi tình trạng đổ mồ hôi, hầm bí như những đôi giày thể thao truyền thống</p><br>
        <h4>Bảo hành</h4>
        <p>Sản phẩm được bảo hành trong vòng 3 tháng kể từ thời điểm mua hàng. Ngoài ra sản phẩm còn được bảo hành trọn đời với lỗi bong keo, đứt chỉ (vật tư của sản phẩm đủ điều kiện tái chế không bị rách,…)</p>
        <p>Đổi size giày trong vòng 7 ngày, đổi sản phẩm lỗi trong vòng 7 ngày, kể từ thời điểm mua hàng, nếu sản phẩm vẫn đáp ứng chính sách đổi trả. Điều kiện và quy định đổi trả, quý khách vui lòng tham khảo trên website chính thức. </p><br>
        <h4>Tính năng và lợi ích nổi bật</h4>
        <p>Giày thể thao thông dụng nam Biti's Basic đơn giản nhưng vẫn năng động, khỏe khoắn</p>
        <p>Form dáng thoải mái, chi tiết phối trẻ trung, thiết kế cài bát thuận tiện cho thao tác mang</p>
        <p>Đế chất liệu PVC được sử dụng công nghệ phun liệu đế dính vào quai, chất đế nổi trội với độ bám đường và chống sốc tốt, giày bền bỉ trước tác động của ngoại lực, va chạm mạnh.</p>
        <p>Chất liệu giày vừa đảm bảo được yếu tố thoải mái vừa đáp ứng được tính thanh lịch, thời trang, với kết cấu nhiều lỗ nhỏ hình tròn sẽ giúp khí lưu thông tốt hơn, tránh tình trạng bí chân</p>
        <p>Mẫu giày thể thao giá rẻ cho đối tượng là học sinh</p>
        <p>Giày với kiểu dáng basic có thể kết hợp cùng nhiều outfit khác nhau, thích hợp để mặc đi chơi, đi học, đi làm</p>
        <br>
        <p>Không quá cầu kỳ nhưng mang lại sự khác biệt và một đẳng cấp đầy nam tính chính là lý do mà bạn cần có một đôi giày thể thao thông dụng nam Biti's Basic trong tủ đồ của mình.
            Sư hiện đại và thanh lịch của sản phẩm chắc chắn sẽ làm bạn tự tin sải bước. Để đặt mua sản phẩm, bạn truy cập ngay vào Bitis.com.vn và làm theo các bước hướng dẫn.</p>
    </div>
</div>


<%@ include file="footer.jsp" %>