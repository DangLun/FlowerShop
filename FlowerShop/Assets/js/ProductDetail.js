$(document).ready(function () {
    var owlExtendImage = $('.extend-image');
    var mainImage = $('#mainImage');
    var currentIndex = 0;

    owlExtendImage.owlCarousel({
        center: true,
        items: 1,
        loop: true,
        margin: 10,
        responsive: {
            600: {
                items: 4
            }
        },
        mouseDrag: false,
        dots: false,
        nav: true,
        smartSpeed: 500,
        navText: [
            "<i class='fa-solid fa-chevron-left owl-direction chevron-left-extendImage'></i>",
            "<i class='fa-solid fa-chevron-right owl-direction chevron-right-extendImage'></i>"
        ]
    });

    function updateMainImage(index) {
        const newSrc = $(owlExtendImage.find('.owl-item')).eq(index).find('img').attr('src');
        mainImage.attr('src', newSrc);
        $('.ImageExtendFrame').removeClass('active-image-extend');
        $(owlExtendImage.find('.owl-item')).eq(index).find('.ImageExtendFrame').addClass('active-image-extend');
        currentIndex = index;
    }

    owlExtendImage.on('click', '.owl-item', function () {
        const index = $(this).index();
        updateMainImage(index);
    });

    owlExtendImage.on('changed.owl.carousel', function (event) {
        updateMainImage(event.item.index);
    });

    $('.chevron-left-extendImage').click(function () {
        owlExtendImage.trigger('prev.owl.carousel');
    });

    $('.chevron-right-extendImage').click(function () {
        owlExtendImage.trigger('next.owl.carousel');
    });
});
