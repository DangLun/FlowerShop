$(function () {

    const resetForm = () => {
        $('#deliveryName').val("");
        $('#EditPhone').val("");
        $('#EditFullName').val("");
        $('#deliveryMain').prop('checked', false);
        $('#deliveryID').val(null);
    }

    $('.btnAddDelivery').click(function () {
        $('#exampleModalLabel').html("Thêm địa chỉ")
        $('.showMainDelivery').show();
        resetForm();
    })

    $('.btnEditAddress').click(function () {
        $('#exampleModalLabel').html("Sửa địa chỉ giao hàng")
        var deliveryID = $(this).data('delivery-id');
        var deliveryName = $(this).data('delivery-name');
        var deliveryMain = $(this).data('delivery-main');
        var fullname = $(this).data('fullname');
        var phone = $(this).data("phone")

        // Đưa dữ liệu vào modal
        $('#deliveryID').val(deliveryID);
        $('#deliveryName').val(deliveryName);
        $('#EditPhone').val(phone);
        $('#EditFullName').val(fullname);
        if (deliveryMain == 'True') {
            $('.showMainDelivery').hide();
        } else {
            $('.showMainDelivery').show();
            $('#deliveryMain').prop('checked', false);
        }
        

        // Hiển thị modal
        $('#exampleModal').modal('show');
    });

    const UpdateTabs = () => {
        const local = window.localStorage.getItem("tab")
        var addressInterface = document.querySelector("#address")
        var orderInterface = document.querySelector('#order')
        var btnAddress = document.querySelector('#address-tab')
        var btnOrder = document.querySelector('#order-tab')

        if (local == "address") {
            addressInterface.classList.add("show", "active")
            orderInterface.classList.remove("show", "active")
            btnAddress.classList.add("active")
            btnOrder.classList.remove("active")
        } else {
            orderInterface.classList.add("show", "active")
            addressInterface.classList.remove("show", "active")
            btnOrder.classList.add("active")
            btnAddress.classList.remove("active")
        }
        btnAddress.addEventListener("click", function () {
            window.localStorage.setItem("tab", "address")
        })
        btnOrder.addEventListener("click", function () {
            window.localStorage.setItem("tab", "order")
        })
    }
    UpdateTabs();
    const HandleUploadAvatar = () => {
        const form = document.querySelector('.formUploadAvatar')
        const inputAvatar = document.querySelector('#inputAvatar')
        inputAvatar.addEventListener('input', () => {
            form.submit()
        })
    }
    HandleUploadAvatar();

})