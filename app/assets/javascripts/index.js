$(function(){
  $('.nav li').hover(function(){
      $(this).children('ul').show();
  }, function(){
      $(this).children('ul').hide();
  });

  $('.animate').scrolla();

  var mySwiper = new Swiper ('.swiper-container', {
    loop: true,
  pagination: {
    el: '.swiper-pagination',
  },
  navigation: {
    nextEl: '.swiper-button-next',
    prevEl: '.swiper-button-prev',
  },
  scrollbar: {
    el: '.swiper-scrollbar',
  },
  speed: 600,
  autoplay: {delay: 4000},
})
  
});


