
  let money = 12000
  $(function() {
    $('img').css('width', '0px');
    $('h4').css('display', 'none');
    $('.kwadrat').css('opacity', '0.0');
    $('.kwadrat2').css('opacity', '0.0');
    $('.kwadrat3').css('opacity', '0.0');
    $('h3').css('display', 'none');
    $('.container').css('width', '0em');

    $('.zamknij').css('display', 'none');

     $('.container-fluid').css('display', 'none');
      
  $('.congrat').fadeOut(0);
  document.getElementById("mon").innerHTML = money + '$';;
 //$('.container-fluid').css('display', 'none');
 //$('.container-fluid').css('display', 'block'); 

  $(document).ready(function() {
      window.addEventListener('message', function(event) {
          var item = event.data;
          $('.congrat').fadeOut();
          if (item.ativa == true) {
         money = item.pieniadze
         $('.zamknij').css('display', 'block');

              $('.container-fluid').css('display', 'block');
        $('.congrat').fadeOut();
             $('h4').css('display', 'block');
             $('.container').css('width', '80em');

              
            $('h3').css('display', 'block');
              document.getElementById("mon").innerHTML = money + '$';
             $('.kwadrat').css('opacity', '1.0');
          $('.kwadrat2').css('opacity', '1.0');

    $('.kwadrat3').css('opacity', '1.0');
    $('img').css('width', '250px');
          } else if (item.ativa == false) {
            $('.zamknij').css('display', 'none');

            $('img').css('width', '0px');
            $('h4').css('display', 'none');
            $('.kwadrat').css('opacity', '0.0');
            $('.kwadrat2').css('opacity', '0.0');
            $('.container').css('width', '0em');
            $('.kwadrat3').css('opacity', '0.0');
            $('h3').css('display', 'none');
             $('.container-fluid').css('display', 'none');
              
          }
      });

      $("#1").click(function() {
        $('.container').css('top', '340vh');
        $('img').css('width', '0px');
        $('h4').css('display', 'none');
        $('.kwadrat').css('opacity', '0.0');
        $('.kwadrat2').css('opacity', '0.0');
        $('.kwadrat3').css('opacity', '0.0');
        $('h3').css('display', 'none');
        
        $('.zamknij').css('display', 'none');
        if(money >= 1000) {
        
          setTimeout(function(){  $('.zamknij').css('display', 'block');}, 3000); 
        document.getElementById("10").innerHTML = "Kupiłeś:</br>pistolet";
        setTimeout(function(){ $('.congrat').fadeIn();;}, 100);
        setTimeout(function(){ $('img').css('width', '250px');;}, 3000); 
    setTimeout(function(){ $('.container').css('top', '34vh');;}, 3000); 
            setTimeout(function(){$.post('http://smerfiksklepbron/1', JSON.stringify({}));;; }, 100);
            setTimeout(function(){$('.congrat').fadeOut();}, 3000);
            setTimeout(function(){ $('h4').css('display', 'block');;}, 3000); 
            money = money - 1000
            setTimeout(function(){ $('h3').css('display', 'block');;}, 3000); 
            document.getElementById("mon").innerHTML = money + '$';
            setTimeout(function(){ $('.kwadrat').css('opacity', '1.0');;}, 3000); 
            setTimeout(function(){ $('.kwadrat2').css('opacity', '1.0');;}, 3000); 
            setTimeout(function(){ $('.kwadrat3').css('opacity', '1.0');;}, 3000); 
          } else {
            document.getElementById("10").innerHTML = "Nie wystarczająco pieniędzy";
            setTimeout(function(){ $('.congrat').fadeIn();;}, 100);
          
        setTimeout(function(){  $('.zamknij').css('display', 'block');}, 3000); 
            setTimeout(function(){ $('img').css('width', '250px');;}, 3000); 
        setTimeout(function(){ $('.container').css('top', '34vh');;}, 3000); 
                setTimeout(function(){$('.congrat').fadeOut();}, 3000);
                setTimeout(function(){ $('h4').css('display', 'block');;}, 3000); 
                setTimeout(function(){ $('h3').css('display', 'block');;}, 3000);  
                setTimeout(function(){ $('.kwadrat').css('opacity', '1.0');;}, 3000); 
                setTimeout(function(){ $('.kwadrat2').css('opacity', '1.0');;}, 3000); 
                setTimeout(function(){ $('.kwadrat3').css('opacity', '1.0');;}, 3000); 
          }
  });
      $("#2").click(function() {
        $('.container').css('top', '340vh');
        $('img').css('width', '0px');
        $('h4').css('display', 'none');
        $('h3').css('display', 'none');
        $('.kwadrat').css('opacity', '0.0');
        $('.kwadrat2').css('opacity', '0.0');
        $('.kwadrat3').css('opacity', '0.0');
        $('.zamknij').css('display', 'none');
        if(money >= 5000) {
        
        document.getElementById("10").innerHTML = "Kupiłeś: </br> shotguna";
        setTimeout(function(){ $('.congrat').fadeIn();;}, 100);
        setTimeout(function(){ $('img').css('width', '250px');;}, 3000); 
    setTimeout(function(){ $('.container').css('top', '34vh');;}, 3000); 
            setTimeout(function(){$.post('http://smerfiksklepbron/2', JSON.stringify({}));;; }, 100);
            setTimeout(function(){$('.congrat').fadeOut();}, 3000);
            setTimeout(function(){ $('h3').css('display', 'block');;}, 3000); 
            money = money - 5000
            setTimeout(function(){  $('.zamknij').css('display', 'block');}, 3000); 
            document.getElementById("mon").innerHTML = money + '$';;
            setTimeout(function(){ $('h4').css('display', 'block');;}, 3000);  
            setTimeout(function(){ $('.kwadrat').css('opacity', '1.0');;}, 3000); 
            setTimeout(function(){ $('.kwadrat2').css('opacity', '1.0');;}, 3000); 
            setTimeout(function(){ $('.kwadrat3').css('opacity', '1.0');;}, 3000); 
          } else {
            document.getElementById("10").innerHTML = "Nie wystarczająco pieniędzy";
            setTimeout(function(){ $('.congrat').fadeIn();;}, 100);
            setTimeout(function(){ $('img').css('width', '250px');;}, 3000); 
        setTimeout(function(){ $('.container').css('top', '34vh');;}, 3000); 
                setTimeout(function(){$('.congrat').fadeOut();}, 3000);
                setTimeout(function(){  $('.zamknij').css('display', 'block');}, 3000); 
                setTimeout(function(){ $('h4').css('display', 'block');;}, 3000); 
                setTimeout(function(){ $('h3').css('display', 'block');;}, 3000);  
                setTimeout(function(){ $('.kwadrat').css('opacity', '1.0');;}, 3000); 
                setTimeout(function(){ $('.kwadrat2').css('opacity', '1.0');;}, 3000); 
                setTimeout(function(){ $('.kwadrat3').css('opacity', '1.0');;}, 3000); 

          }
  });

  $("#3").click(function() {
    $('.container').css('top', '340vh');
    $('img').css('width', '0px');
    $('h4').css('display', 'none');
    $('h3').css('display', 'none');
    $('.kwadrat').css('opacity', '0.0');
    $('.kwadrat2').css('opacity', '0.0');
    $('.kwadrat3').css('opacity', '0.0');
    $('.zamknij').css('display', 'none');
    if(money >= 3000) {
   
    document.getElementById("10").innerHTML = "Kupiłeś: machineguna";
    setTimeout(function(){ $('img').css('width', '250px');;}, 3000); 
    setTimeout(function(){ $('.congrat').fadeIn();;}, 100);
    setTimeout(function(){ $('.container').css('top', '34vh');;}, 3000); 
    setTimeout(function(){$.post('http://smerfiksklepbron/3', JSON.stringify({}));;; }, 100);
    setTimeout(function(){$('.congrat').fadeOut();}, 3000);
        setTimeout(function(){  $('.zamknij').css('display', 'block');}, 3000); 
    setTimeout(function(){ $('h3').css('display', 'block');;}, 3000);  
    setTimeout(function(){ $('.kwadrat').css('opacity', '1.0');;}, 3000); 
    setTimeout(function(){ $('.kwadrat2').css('opacity', '1.0');;}, 3000); 
    setTimeout(function(){ $('.kwadrat3').css('opacity', '1.0');;}, 3000); 
    money = money - 3000
    document.getElementById("mon").innerHTML = money + '$';;
  } else {
    document.getElementById("10").innerHTML = "Nie wystarczająco pieniędzy";
    setTimeout(function(){ $('.congrat').fadeIn();;}, 100);
    setTimeout(function(){ $('img').css('width', '250px');;}, 3000); 
setTimeout(function(){ $('.container').css('top', '34vh');;}, 3000); 
setTimeout(function(){  $('.zamknij').css('display', 'block');}, 3000); 
        setTimeout(function(){$('.congrat').fadeOut();}, 3000);
        setTimeout(function(){ $('h4').css('display', 'block');;}, 3000); 
        setTimeout(function(){ $('h3').css('display', 'block');;}, 3000); 
        setTimeout(function(){ $('.kwadrat').css('opacity', '1.0');;}, 3000); 
        setTimeout(function(){ $('.kwadrat2').css('opacity', '1.0');;}, 3000); 
        setTimeout(function(){ $('.kwadrat3').css('opacity', '1.0');;}, 3000); 
  }

});



$("#4").click(function() {
  $('.container').css('top', '340vh');
  $('img').css('width', '0px');
  if(money >= 5500) {
  
  document.getElementById("10").innerHTML = "Kupiłeś: </br> smg";
  setTimeout(function(){ $('.congrat').fadeIn();;}, 100);
  setTimeout(function(){ $('img').css('width', '250px');;}, 3000); 
setTimeout(function(){ $('.container').css('top', '34vh');;}, 3000); 
      setTimeout(function(){$.post('http://smerfiksklepbron/4', JSON.stringify({}));;; }, 100);
      setTimeout(function(){$('.congrat').fadeOut();}, 3000);
      money = money - 5500
      document.getElementById("mon").innerHTML = money + '$';;
    } else {
      document.getElementById("10").innerHTML = "Nie wystarczająco pieniędzy";
      setTimeout(function(){ $('.congrat').fadeIn();;}, 100);
      setTimeout(function(){ $('img').css('width', '250px');;}, 3000); 
  setTimeout(function(){ $('.container').css('top', '34vh');;}, 3000); 
          setTimeout(function(){$('.congrat').fadeOut();}, 3000);
          setTimeout(function(){ $('h4').css('display', 'block');;}, 3000); 
  
    }
});
$("#5").click(function() {
  $('.container').css('top', '340vh');
  $('img').css('width', '0px');
  if(money >= 9000) {
  
  document.getElementById("10").innerHTML = "Kupiłeś: </br> uzi";
  setTimeout(function(){ $('.congrat').fadeIn();;}, 100);
  setTimeout(function(){ $('img').css('width', '250px');;}, 3000); 
setTimeout(function(){ $('.container').css('top', '34vh');;}, 3000); 
      setTimeout(function(){$.post('http://smerfiksklepbron/5', JSON.stringify({}));;; }, 100);
      setTimeout(function(){$('.congrat').fadeOut();}, 3000);
      money = money - 9000
      document.getElementById("mon").innerHTML = money + '$';;
    } else {
      document.getElementById("10").innerHTML = "Nie wystarczająco pieniędzy";
      setTimeout(function(){ $('.congrat').fadeIn();;}, 100);
      setTimeout(function(){ $('img').css('width', '250px');;}, 3000); 
  setTimeout(function(){ $('.container').css('top', '34vh');;}, 3000); 
          setTimeout(function(){$('.congrat').fadeOut();}, 3000);
  
    }
});

$("#6").click(function() {
$('.container').css('top', '340vh');
$('img').css('width', '0px');
if(money >= 8000) {

document.getElementById("10").innerHTML = "Kupiłeś: </br>latarkę";
setTimeout(function(){ $('img').css('width', '250px');;}, 3000); 
setTimeout(function(){ $('.congrat').fadeIn();;}, 100);
setTimeout(function(){ $('.container').css('top', '34vh');;}, 3000); 
setTimeout(function(){$.post('http://smerfiksklepbron/6', JSON.stringify({}));;; }, 100);
setTimeout(function(){$('.congrat').fadeOut();}, 3000);
money = money - 8000
document.getElementById("mon").innerHTML = money + '$';;
} else {
  document.getElementById("10").innerHTML = "Nie wystarczająco pieniędzy";
  setTimeout(function(){ $('.congrat').fadeIn();;}, 100);
  setTimeout(function(){ $('img').css('width', '250px');;}, 3000); 
setTimeout(function(){ $('.container').css('top', '34vh');;}, 3000); 
      setTimeout(function(){$('.congrat').fadeOut();}, 3000);

}
});

    $("#9").click(function() {
        $.post('http://smerfiksklepbron/zamknij', JSON.stringify({}));

        $('.zamknij').css('display', 'none');



        2

    });
  })
})


