/*$(".character-box").hover(
    function() {
        $(this).css({
            "background": "rgba(42, 125, 193, 1.0)",
            "transition": "200ms",
        });
    }, function() {
        $(this).css({
            "background": "rgba(0,0,0,0.6)",
            "transition": "200ms",
        });
    }
);
*/
$(".character-box").click(function () {
    $(".character-box").removeClass('active-char');
    $(this).addClass('active-char');
    $(".character-buttons").css({"display":"block"});
    if ($(this).attr("data-ischar") === "true") {
        $("#delete").css({"display":"block"});
    } else {
        $("#delete").css({"display":"none"});
    }
});

$("#play-char").click(function () {
    $.post("http://esx_kashacters/CharacterChosen", JSON.stringify({
        charid: $('.active-char').attr("data-charid"),
        ischar: $('.active-char').attr("data-ischar"),
    }));
    Kashacter.CloseUI();
});

$("#deletechar").click(function () {
    $.post("http://esx_kashacters/DeleteCharacter", JSON.stringify({
        charid: $('.active-char').attr("data-charid"),
    }));
    Kashacter.CloseUI();
});

(() => {
    Kashacter = {};

    Kashacter.ShowUI = function(data) {
        $('.main-container').css({"display":"block"});
        if(data.characters !== null) {
            $.each(data.characters, function (index, char) {
                if (char.charid !== 0) {
                    var chartext = ""
                    if (char.sex == "m"){
                        chartext = "Mężczyzna"
                    }
                    else{
                        chartext = "Kobieta"
                    }
                    var charid = char.identifier.charAt(4);
                    $('[data-charid=' + charid + ']').html('<div class="character-fullname" style="margin-top: 245px; font-size: 15px!important;  margin-left: 110px;">'+ char.firstname +' '+ char.lastname +'</div><div class="character-info" style="margin-top: 4px"><p class="character-info-dateofbirth"><div style="margin-top: 3px;margin-left: 110px;font-size: 15px!important;">'+ char.dateofbirth +'</div></p><div class="character-info-money"><div style="margin-top: 3px;margin-left: 110px;font-size: 15px!important;">'+ chartext +'</div></div><div class="character-info-work"><div style="margin-top: 3px;margin-left: 110px;font-size: 15px!important;">'+ char.job +'</div></div><p class="character-info-dateofbirth"><div style="margin-top: 5px; margin-left: 110px;font-size: 15px!important;">'+ char.money +' $</div></p><div class="character-info-gender"><div style="margin-top: 3px;margin-left: 110px;font-size: 15px!important;">'+ char.bank +' $</div></div></div>').attr("data-ischar", "true");
                }
            });
        }
    };

    Kashacter.CloseUI = function() {
        $('.main-container').css({"display":"none"});
        $(".character-box").removeClass('active-char');
        $("#delete").css({"display":"none"});
		$(".character-box").html('<div class="character-fullname" style="margin-top: 275px;"><i class="fas fa-plus"></i></div><div class="character-info"><div class="character-info-new" style="margin-top: 100px;">Stwórz nową postać</div></div>').attr("data-ischar", "false");
    };
    window.onload = function(e) {
        window.addEventListener('message', function(event) {
            switch(event.data.action) {
                case 'openui':
                    Kashacter.ShowUI(event.data);
                    break;
            }
        })
    }

})();
