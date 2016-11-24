$(function() {
  var $mainAvatar = $(".js-main-avatar");
  var $easterEggAvatar = $(".js-easter-egg-avatar");
  var mouseDown, coorX, coorY, shiftX, shiftY;

  $mainAvatar.mousedown(function(e) {
    $mainAvatar.removeClass("avatar__main--active")
    mouseDown = true;
    coorX = e.pageX;
    coorY = e.pageY;

    shiftX = coorX - $mainAvatar.offset().left;
    shiftY = coorY - $mainAvatar.offset().top;
  });

  $(document)
    .mouseup(function() {
      mouseDown = false;
    })
    .mousemove(function(e) {
      if(mouseDown) {
        $mainAvatar.addClass("avatar--movable");
        $easterEggAvatar.addClass("avatar--active");

        $mainAvatar.css({
          top: e.pageY - shiftY,
          left: e.pageX - shiftX
        });
      }
    });
});
