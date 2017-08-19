$(document).ready(function(){
    $(".dropdown").hover(            
        function() {
            $('.dropdown-menu', this).not('.in .dropdown-menu').stop(true,true);
            $(this).toggleClass('open');        
        },
        function() {
            $('.dropdown-menu', this).not('.in .dropdown-menu').stop(true,true);
            $(this).toggleClass('open');       
        }
    );
});

function openNav() {
    document.getElementById("mySidenav").style.width = "250px";
}

function closeNav() {
    document.getElementById("mySidenav").style.width = "0";
}

//home page owl carosole
 $(document).ready(function() {
              var owl = $('.carousel1');
              owl.owlCarousel({
                margin: 10,
                nav: false,
                autoplay:true,
                loop: true,
                responsive: {
                  0: {
                    items: 2
                  },
                  600: {
                    items: 3
                  },
                  1000: {
                    items: 5
                  }
                }
              })
            })
 
 
 
 //home page owl carosole
 $(document).ready(function() {
              var owl = $('.carousel2');
              owl.owlCarousel({
                margin: 10,
                nav: true,
                autoplay:true,
                loop: true,
                responsive: {
                  0: {
                    items: 1
                  },
                  600: {
                    items: 3
                  },
                  1000: {
                    items: 4
                  }
                }
              })
            })
 $(document).ready(function() {
 $('.carousel3').owlCarousel({
    loop:true,
    margin:10,
    nav:false,
    autoplay: true,
    responsive:{
        0:{
            items:3
        },
        600:{
            items:3
        },
        1000:{
            items:8
        }
    }
})
});
 $(document).ready(function() {
  $('.carousel4').owlCarousel({
    loop:false,
    margin:10,
    nav:false,
    autoplay: true,
    responsive:{
        0:{
            items:3
        },
        600:{
            items:3
        },
        1000:{
            items:6
        }
    }
});
});
 
 //sticky menu
$(document).ready(function(){
 $(window).scroll(function() {
                if ($(this).scrollTop() > 530){  
                    $('.background-gy').addClass("sticky1");
                }
                else{
                    $('.background-gy').removeClass("sticky1");
                }
            });
});
$(document).ready(function(){
  $(window).scroll(function() {
                if ($(this).scrollTop() > 300){  
                    $('.bg-green1').addClass("sticky1");
                }
                else{
                    $('.bg-green1').removeClass("sticky1");
                }
            });
});
 //login model
   $(document).ready(function(){
                
                 $(".hide-login").click(function(){
                     $('#lostpass').modal('hide');
                    $('#login').modal('hide');
                       $("#signin").show();   
                  
                     
                    
                });
                $(".hide-signin").click(function(){
                     $('#lostpass').modal('hide');
                     $('#signin').modal('hide');                     
                      $("#login").show();            
                    
                     
                });
                $(".hide-loss").click(function(){
                     $("#login").show();     
                     $('#signin').modal('hide');  
                     $('#lostpass').modal('hide');                     
                            
                    
                     
                });
               
            });
   
   
   //product detail slider
   
     $(document).ready(function() {
              $('.product-details').owlCarousel({
                items: 1,
                loop: false,
                center: true,
                margin: 10,
                 nav: true,
                callbacks: true,
                URLhashListener: true,
                autoplayHoverPause: true,
                startPosition: 'URLHash'
              });
            })
     //zooming function
     
      $('.imgBox').imgZoom({
            boxWidth: 400,
            boxHeight: 400,
            marginLeft: 5,
            
            origin: 'data-origin'
        });
      
      //billing address
        $(function () {
                $("#chkPassport").click(function () {
                   if ($(this).is(":checked")) {
                        $("#shipping-address").hide();
                     } else {
                             $("#shipping-address").show();
                      }
               });
               });
        //cart + - js
        //checkout slider and zoom
        
        
        
        
 
 