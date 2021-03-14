let czap1 = 10
let czap2 = 10
let kosz1 = 10
let kosz2 = 10
let torso1 = 10
let torso2 = 10
let ram1 = 10
let ram2 = 10
let spod1 = 10
let spod2 = 10
let but1 = 10
let but2 = 10
let deta1 = 10
let deta2 = 10

$(function() {


  $(document).ready(function() {
      window.addEventListener('message', function(event) {
          var t = event.data;
          czap1 = t.czap1
          czap2 = t.czap2
           kosz1 = t.kosz1
           kosz2 = t.kosz2
         torso1 = t.tors1
          torso2 = t.tors2
          ram1 = t.ram1
          ram2 = t.ram2
         spod1 = t.spod1
        spod2 = t.spod2
         but1 = t.but1
          but2 = t.but2
          deta1 = t.deta1
         deta2 = t.deta2
         updatenr()
          if (t.dzialaj == true) {
              $('.container-fluid').css('display', 'block');
          } else if (t.dzialaj == false) {
             $('.container-fluid').css('display', 'none');
          }
      });

      $("#1").click(function() {
          czap1 = czap1 - 1
          $.post('http://smerfikclotheshop/czapkalewo', JSON.stringify({}));
          updatenr()
          2

      });

      $("#2").click(function() {
        czap1 = czap1 + 1
        $.post('http://smerfikclotheshop/czapkaprawo', JSON.stringify({}));
        updatenr()
          2

      });

      $("#3").click(function() {
          kosz1 = kosz1 - 1
          $.post('http://smerfikclotheshop/koszlewo', JSON.stringify({}));
          updatenr()
          2

      });

      $("#4").click(function() {
          kosz1 = kosz1 + 1
          $.post('http://smerfikclotheshop/koszprawo', JSON.stringify({}));
          updatenr()
          2

      });

      $("#5").click(function() {
          torso1 = torso1 - 1
        $.post('http://smerfikclotheshop/torslewo', JSON.stringify({}));
        updatenr()
        2

    });

    $("#6").click(function() {
        torso1 = torso1 + 1
        $.post('http://smerfikclotheshop/torsprawo', JSON.stringify({}));
        updatenr()
        2

    });

    $("#7").click(function() {
        spod1 = spod1 - 1
        $.post('http://smerfikclotheshop/spodlewo', JSON.stringify({}));
        updatenr()
        2

    });

    $("#8").click(function() {
        spod1 = spod1 + 1
        $.post('http://smerfikclotheshop/spodprawo', JSON.stringify({}));
        updatenr()
        2

    });
    $("#10").click(function() {
       but1 = but1 - 1
        $.post('http://smerfikclotheshop/butlew', JSON.stringify({}));
        updatenr()
        2

    });

    $("#11").click(function() {
        but1 = but1 + 1
        $.post('http://smerfikclotheshop/butpraw', JSON.stringify({}));
        updatenr()
        2

    });

    $("#12").click(function() {
        czap2 = czap2 - 1
        $.post('http://smerfikclotheshop/czap2lew', JSON.stringify({}));
        updatenr()
        2

    });

    $("#13").click(function() {
        czap2 = czap2 + 1
        $.post('http://smerfikclotheshop/czap2praw', JSON.stringify({}));
        updatenr()
        2

    });

    $("#14").click(function() {
        kosz2 = kosz2 - 1
        $.post('http://smerfikclotheshop/kosz2lew', JSON.stringify({}));
        updatenr()
      2

  });

  $("#15").click(function() {
      kosz2 = kosz2 + 1
    $.post('http://smerfikclotheshop/kosz2praw', JSON.stringify({}));
    updatenr()
      2

  });

  $("#16").click(function() {
      torso2 = torso2 - 1
      $.post('http://smerfikclotheshop/tors2lew', JSON.stringify({}));
      updatenr()
      2

  });

  $("#17").click(function() {
      torso2 = torso2  + 1
      $.post('http://smerfikclotheshop/tors2praw', JSON.stringify({}));
      updatenr()
      2

  });
  $("#18").click(function() {
      spod2 = spod2 - 1
    $.post('http://smerfikclotheshop/spod2lew', JSON.stringify({}));
    updatenr()
    2

});

$("#19").click(function() {
    spod2 = spod2 + 1
    $.post('http://smerfikclotheshop/spod2praw', JSON.stringify({}));
    updatenr()
    2

});

$("#20").click(function() {
    but2 = but2 - 1
    $.post('http://smerfikclotheshop/but2lew', JSON.stringify({}));
    updatenr()
    2

});
$("#21").click(function() {
    but2 = but2 + 1
    $.post('http://smerfikclotheshop/but2praw', JSON.stringify({}));
    updatenr()
    2

});

$("#22").click(function() {
    deta2 = deta2 - 1
    $.post('http://smerfikclotheshop/deta2lew', JSON.stringify({}));
    updatenr()
    2

});

$("#23").click(function() {
    deta1 = deta1 - 1
    $.post('http://smerfikclotheshop/detalew', JSON.stringify({}));
    updatenr()
    2

});
$("#24").click(function() {
    deta1 = deta1 + 1
    $.post('http://smerfikclotheshop/detapraw', JSON.stringify({}));
    updatenr()
    2

});

$("#25").click(function() {
    deta2 = deta2 + 1
    $.post('http://smerfikclotheshop/deta2praw', JSON.stringify({}));
    updatenr()
    2

});

$("#26").click(function() {
    ram2 = ram2 - 1
    $.post('http://smerfikclotheshop/ram2lew', JSON.stringify({}));
    updatenr()
    2

});

$("#27").click(function() {
    ram1 = ram1 - 1
    $.post('http://smerfikclotheshop/ramlew', JSON.stringify({}));
    updatenr()
    2

});
$("#28").click(function() {
    ram1 = ram1 + 1
    $.post('http://smerfikclotheshop/rampraw', JSON.stringify({}));
    updatenr()
    2

});
$("#29").click(function() {
    ram2 = ram2 + 1
    $.post('http://smerfikclotheshop/ram2praw', JSON.stringify({}));
    updatenr()
    2

});
    $("#9").click(function() {
        $.post('http://smerfikclotheshop/zamknij', JSON.stringify({}));
        2

    });
    $("#30").click(function() {
        $.post('http://smerfikclotheshop/zapisz', JSON.stringify({}));
        2

    });
})
});

function updatenr(){
    document.getElementById("czap1").innerHTML = czap1 + ' :';;
    document.getElementById("czap2").innerHTML = czap2;;
    document.getElementById("kosz1").innerHTML = kosz1 + ' :';;
    document.getElementById("kosz2").innerHTML = kosz2;;
    document.getElementById("torso1").innerHTML = torso1 + ' :';;
    document.getElementById("torso2").innerHTML = torso2;;
    document.getElementById("ram1").innerHTML = ram1 + ' :';;
    document.getElementById("ram2").innerHTML = ram2;;
    document.getElementById("spod1").innerHTML = spod1 + ' :';;
    document.getElementById("spod2").innerHTML = spod2;;
    document.getElementById("but1").innerHTML = but1 + ' :';;
    document.getElementById("but2").innerHTML = but2;;
    document.getElementById("deta1").innerHTML = deta1 + ' :';;
    document.getElementById("deta2").innerHTML = deta2;;
    }