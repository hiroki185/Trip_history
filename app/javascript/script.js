$(document).ready(function() {
  let swiper = new Swiper('.swiper', {
    centeredSlides: true,
    loop: true,
    speed: 600,
    slidesPerView: 3,
    autoplay: {
      delay: 3000,
      disableOnInteraction: false,
    },
    pagination: {
      el: ".swiper-pagination",
      clickable: true,
    },
    navigation: {
      nextEl: ".swiper-button-next",
      prevEl: ".swiper-button-prev",
    },
  });
});

