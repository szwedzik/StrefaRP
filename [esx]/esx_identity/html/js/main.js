$(document).ready(function() {

  var maxTime = 5000;
  var time = 0;

  var interval = setInterval(function () {
    if($('body').is(':visible')) {
      particlesJS.load('particles-js', 'js/particles.json', function() {
            console.log('callback - particles.js config loaded');
        });
      clearInterval(interval);
    } else {
      if (time > maxTime) {
        clearInterval(interval);
        return;
      }
      time += 100;
    }
  }, 200);


    $.fn.extend({
        animateCss: function(animationName, callback) {
            var animationEnd = (function(el) {
                var animations = {
                    animation: 'animationend',
                    OAnimation: 'oAnimationEnd',
                    MozAnimation: 'mozAnimationEnd',
                    WebkitAnimation: 'webkitAnimationEnd',
                };

                for (var t in animations) {
                    if (el.style[t] !== undefined) {
                        return animations[t];
                    }
                }
            })(document.createElement('div'));

            this.addClass('animated ' + animationName).one(animationEnd, function() {
                $(this).removeClass('animated ' + animationName);

                if (typeof callback === 'function') callback();
            });

            return this;
        },
    });
    $('form').animateCss('rubberBand');
    $('.d-flex').animateCss('bounceInLeft');
    $("input").focus(function() {
        $(this).parent().addClass('is-focused');
    });
    $("input").focusout(function() {
        $(this).parent().removeClass('is-focused');
    });
    $("input").keyup(function() {
        var val = this.value;
        if (val) {
            $(this).parent().removeClass('is-empty');
        } else {
            $(this).parent().addClass('is-empty');
        }
    });


    $("#dateofbirth").inputmask("date", {
        "placeholder": "DD/MM/YYYY"
    });
    $("#height").inputmask({
        regex: '(1[2-8][0-9]|19[0-9]|20[0-9]|210) cm'
    });

    $('#firstname').keyup(function() {
        if (this.value.length < 3 || this.value.length > 15) {
            $(this).attr("data-valid", false);
            $('#firstnameHelp').css("display", 'block');
        } else {
            $(this).attr("data-valid", true);
            $('#firstnameHelp').css("display", 'none');
        }
    });

    $('#lastname').keyup(function() {
        if (this.value.length < 3 || this.value.length > 15) {
            $(this).attr("data-valid", false);
            $('#lastnameHelp').css("display", 'block');
        } else {
            $(this).attr("data-valid", true);
            $('#lastnameHelp').css("display", 'none');
        }
    });


    $('#height').keyup(function() {
        if (this.value < 120 || this.value > 210 || !$(this).inputmask("isComplete")) {
            $(this).attr("data-valid", false);
            $('#heightHelp').css("display", 'block');
        } else {
            $(this).attr("data-valid", true);
            $('#heightHelp').css("display", 'none');
        }
    });

    $('#dateofbirth').keyup(function() {
        if (!$(this).inputmask("isComplete")) {
            $(this).attr("data-valid", false);
            $('#dateofbirthHelp').css("display", 'block');
        } else {
            $(this).attr("data-valid", true);
            $('#dateofbirthHelp').css("display", 'none');
        }
    });

    $('input').keyup(function() {
        if ($("input[data-valid='false']").length > 0 || $("input[data-valid='unset']").length > 0) {
          $("button").attr("id", 'cantsubmit');
            $("button").attr("disabled", true);
        } else {
            $("button").attr("id", 'submit');
            $("button").attr("disabled", false);
        }
    });


    function getCords(number) {
        switch (number) {
            case 1:
                var cords = [$('#firstname').position(), 'firstname'];
                break;
            case 2:
                var cords = [$('#lastname').position(), 'lastname'];
                break;
            case 3:
                var cords = [$('#height').position(), 'height'];
                break;
            case 4:
                var cords = [$('#dateofbirth').position(), 'dateofbirth'];
                break;
            case 5:
                var cords = [$('#sex').position(), 'sex'];
                break;
        };

        return cords;
    }

    $(window).click(function(e) {
        var relativeX = (e.pageX - $(e.target).offset().left),
            relativeY = (e.pageY - $(e.target).offset().top);
        for (i = 1; i <= 5; i++) {
            var cords = getCords(i)[0];
            if (cords.left < relativeX && cords.left + 350 > relativeX && cords.top < relativeY && cords.top + 40 > relativeY) {
                $('#' + getCords(i)[1]).focus();
                if (getCords(i)[1] == 'sex') {
                    $.notify({
                        message: 'Aby zmienić płeć użyj strzałek (⇅)',
                    }, {
                        animate: {
                            enter: 'animated fadeInDown',
                            exit: 'animated fadeOutUp'
                        },
                        placement: {
                            from: "bottom",
                            align: "center"
                        },

                    });
                }
                break;
            }
        }

    });
});
