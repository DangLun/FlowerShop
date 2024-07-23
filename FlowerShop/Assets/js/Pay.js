$(function () {
    $('#deliverySelect').on('change', function () {
        var selectedDeliveryID = $(this).val();

        $.ajax({
            url: '/ActionUser/GetDeliveryDetails',
            type: 'GET',
            data: { deliveryID: selectedDeliveryID },
            success: function (response) {
                if (response.success) {
                    $('#exampleInputName1').val(response.data.FullName);
                    $('#sdt').val(response.data.Phone);
                }
            }
        });
    }); 
})