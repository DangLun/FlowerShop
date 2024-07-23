$(function () {
	var owlCrouselFeatureSlide = function () {
		var owl1 = $('.owl-carousel1');
		owl1.owlCarousel({
			items: 1,
			loop: true,
			margin: 0,
			responsiveClass: true,
			nav: true,
			dots: true,
			smartSpeed: 500,
			navText: [
				"<i class='fa-solid fa-chevron-left owl-direction'></i>",
				"<i class='fa-solid fa-chevron-right owl-direction'></i>"
			]
		});
	};
	owlCrouselFeatureSlide();
	var menu = document.querySelector('.menu-main');

	var menuPosition = menu.offsetTop;

	window.addEventListener('scroll', function () {
		var scrollY = window.scrollY || window.pageYOffset;

		if (scrollY >= menuPosition) {
			menu.classList.add('sticky-lg-top');
		} else {
			menu.classList.remove('sticky-lg-top');
		}
	});
});