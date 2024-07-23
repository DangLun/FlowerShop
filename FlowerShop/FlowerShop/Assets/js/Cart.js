document.querySelectorAll('.decrement').forEach(item => {
    item.addEventListener('click', function () {
        const input = item.parentElement.querySelector('.quantity-input');
        let value = parseInt(input.value, 10);
        if (value > 1) {
            input.value = value - 1;
        }
    })
})

document.querySelectorAll('.increment').forEach(item => {
    item.addEventListener('click', function () {
        const input = item.parentElement.querySelector('.quantity-input');
        let value = parseInt(input.value, 10);
        input.value = value + 1;
    })
})

// handle checked all cart items

const form = document.querySelector(".cart-detail");

function convertCurrencyFormat(currencyString) {
    // Loại bỏ tất cả các dấu phẩy khỏi chuỗi
    let numericString = currencyString.replace(/,/g, '');
    // Chuyển chuỗi thành số nguyên
    let number = parseInt(numericString, 10);
    return number;
}

const ListCheckedItemCart = document.querySelectorAll('.checkedItem')
const CheckedAll = document.querySelector(".checkedAll")
let checks = 0
ListCheckedItemCart.forEach(item => {
    if (item.checked) checks++;
})
if (checks == ListCheckedItemCart.length ) CheckedAll.checked = true

let sumPrice = convertCurrencyFormat(document.querySelector('.sumPrice').innerHTML.trim())
let sumPriceDiscount = convertCurrencyFormat(document.querySelector('.sumPriceDiscount').innerHTML.trim())
let totalPrice = convertCurrencyFormat(document.querySelector('.totalPrice').innerHTML.trim())



CheckedAll.addEventListener("input", function (e) {

    if (e.target.checked) {
        checks = ListCheckedItemCart.length
    }
    else {
        checks = 0
    }
    ListCheckedItemCart.forEach(item => {
        item.checked = e.target.checked
    })

    form.submit();
})
ListCheckedItemCart.forEach(item => {
    item.addEventListener('input', function () {
        if (!item.checked) {
            CheckedAll.checked = false
            checks--
        } else checks++
        if (checks == ListCheckedItemCart.length) CheckedAll.checked = true

        form.submit();
    })
})

// Chuyển hướng sang HandlePay
document.querySelector('.btnPay').addEventListener('click', function () {
    form.action = "/ActionUser/HandleCart"
})


$('.btnDeleteItemCart').click(function () {
    form.action = "/ActionUser/HandleDeleteCartItem"
    let index = $(this).data('index')
    var ele = this.parentElement.querySelector(`.ischoose`).value = true
    console.log(ele)
    form.submit();
})

