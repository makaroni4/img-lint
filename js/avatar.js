$(function() {
  var $mainAvatar = $(".js-main-avatar");
  var $easterEggAvatar = $(".js-easter-egg-avatar");
  var mouseDown, dragX, dragY, relativeAvatarX, relativeAvatarY, avatarLeft, avatarTop;

  $mainAvatar.mousedown(function(e) {
    $mainAvatar.removeClass("avatar__main--active")
    mouseDown = true;
    dragX = e.pageX;
    dragY = e.pageY;

    avatarLeft = $mainAvatar.offset().left;
    avatarTop = $mainAvatar.offset().top;

    relativeAvatarX = dragX - avatarLeft;
    relativeAvatarY = dragY - avatarTop;
  });

  $(document)
    .mouseup(function() {
      mouseDown = false;

      $mainAvatar.animate({
        left: avatarLeft,
        top: avatarTop
      }, 500, "swing");
    })
    .mousemove(function(e) {
      if(mouseDown) {
        if(!$easterEggAvatar.data("eventSent")) {
          ga("send", "event", "easter-egg", "active", "1-homepage-avatar");
          $easterEggAvatar.data("eventSent", true);
        }

        $mainAvatar.addClass("avatar--movable");
        $easterEggAvatar.addClass("avatar--active");

        $mainAvatar.css({
          top: e.pageY - relativeAvatarY,
          left: e.pageX - relativeAvatarX
        });
      }
    });
});
