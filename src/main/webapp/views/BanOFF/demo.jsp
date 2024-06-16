<!DOCTYPE html>
<html lang="en">
<head>
    <title>Invoice</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #f2f2f2; }
        .invoice { background-color: #fff; max-width: 800px; margin: 20px auto; padding: 20px; border-radius: 5px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); }
        .header { text-align: center; margin-bottom: 20px; }
        .invoice-details { margin-top: 10px; }
        .items { margin-bottom: 20px; }
        table { width: 100%; border-collapse: collapse; }
        table th, table td { border: none; padding: 8px; text-align: left; } /* Loại bỏ border */
        table th { background-color: #f2f2f2; }
        .total {
            display: flex;
        }
        .form-group {
            display: flex;
            justify-content: space-between;
        }
        label {
            font-weight: bold; /* Làm cho nhãn đậm */
            flex-basis: 66.66%; /* Chiếm 2/3 chiều rộng của hàng */
        }
        p {
            flex-basis: 33.33%; /* Chiếm 1/3 chiều rộng của hàng */
        }
    </style>
</head>
<body>
<div class="invoice">
    <div class="header">
        <h2>Invoice</h2>
    </div>
    <div class="invoice-details">
        <p>Code: {{orderCode}}</p>
        <p>Customer Name: {{customerName}}</p>
    </div>
    <div class="items">
        <table>
            <thead>
            <tr>
                <th>Name</th>
                <th>Quantity</th>
                <th>Price</th>
                <th>Total</th>
            </tr>
            </thead>
            <tbody id="productTableBody">
            <!-- This is where the list of products will be inserted -->
            {{products}}
            </tbody>
        </table>
    </div>
    <div class="total">
        <table>
            <tr>
                <td><label for="totalPrice">Total:</label></td>
                <td><p>{{ordertongtienhang}}</p></td>
            </tr>
            <tr>
                <td><label for="totalPrice">Discount (Direct):</label></td>
                <td><p>{{orderchietkhau}} Vnd</p></td>
            </tr>
            <tr ng-if="selectedOrderInfo.address">
                <td><label for="shippingCost">Shipping Cost:</label></td>
                <td><p>{{ordermoneyShip}} Vnd</p></td>
            </tr>
            <tr>
                <td><label for="totalVoucher">Total Voucher:</label></td>
                <td><p>{{totalVoucher}}</p></td>
            </tr>
            <tr>
                <td><label for="totalAmount">Total Amount to Pay:</label></td>
                <td><p>{{ordertotalMoney}} Vnd</p></td>
            </tr>
        </table>
    </div>
</div>
</body>
<script>

</script>
</html>
