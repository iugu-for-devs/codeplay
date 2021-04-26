import AOS from './aos'
import 'owl.carousel/dist/assets/owl.carousel.css';
import 'owl.carousel';

AOS.init({
  duration: 800,
  easing: 'slide',
  once: false
});

document.addEventListener('DOMContentLoaded', function(event) {

 "use strict";
 
 var siteCarousel = function () {
   if ( $('.nonloop-block-13').length > 0 ) {
     $('.nonloop-block-13').owlCarousel({
       center: false,
       items: 1,
       loop: true,
       stagePadding: 0,
       margin: 0,
       autoplay: true,
       nav: true,
       navText: ['<span class="icon-arrow_back">', '<span class="icon-arrow_forward">'],
       responsive:{
         600:{
           margin: 0,
           nav: true,
           items: 2
         },
         1000:{
           margin: 0,
           stagePadding: 0,
           nav: true,
           items: 3
         },
         1200:{
           margin: 0,
           stagePadding: 0,
           nav: true,
           items: 4
         }
       }
     });
   }

   if ( $('.nonloop-block-14').length > 0 ) {
     $('.nonloop-block-14').owlCarousel({
       center: false,
       items: 1,
       loop: true,
       stagePadding: 0,
       margin: 0,
       autoplay: true,
       dots: false,
       nav: false,
       navText: ['<span class="icon-arrow_back">', '<span class="icon-arrow_forward">'],
       responsive:{
         600:{
           margin: 20,
           nav: true,
           items: 2
         },
         1000:{
           margin: 30,
           stagePadding: 20,
           nav: true,
           items: 2
         },
         1200:{
           margin: 30,
           stagePadding: 20,
           nav: true,
           items: 3
         }
       }
     });

     $('.customNextBtn').click(function() {
       $('.nonloop-block-14').trigger('next.owl.carousel');
     })
     $('.customPrevBtn').click(function() {
       $('.nonloop-block-14').trigger('prev.owl.carousel');
     })
   }

   $('.slide-one-item').owlCarousel({
     center: false,
     items: 1,
     loop: true,
     smartSpeed: 900,
     autoplayTimeout: 7000,
     stagePadding: 0,
     margin: 0,
     autoplay: true,
     nav: true,
     navText: ['<span class="icon-keyboard_arrow_left">', '<span class="icon-keyboard_arrow_right">'],
   });

   $('.slide-one-item').on('translated.owl.carousel', function(event) {
     console.log('translated');
     $('.owl-item.active').find('.js-slide-text').addClass('active');
   });
   $('.slide-one-item').on('translate.owl.carousel', function(event) {
     console.log('translate');
     $('.owl-item.active').find('.js-slide-text').removeClass('active');
   });
   
   $('.owl-item.active').find('.js-slide-text').addClass('active');

   
 };
 siteCarousel();

});