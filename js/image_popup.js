$(function() {
  var $imagePopup = $(".js-image-popup");

  if($imagePopup.length < 0) {
    return;
  }

  var $img = $imagePopup.find(".js-image-popup-img");
  var $post = $(".post");

  $post.find("img").on("click", function(e) {
    var $this = $(this);

    ga("send", "event", "image-popup", "click", "1-image-popup");

    $img.attr("src", $this.attr("src"));
    $imagePopup.addClass("active");
    $post.addClass("post--blur");
  });

  $imagePopup.on("click", function() {
    $(this).removeClass("active");
    $post.removeClass("post--blur");
  })
});
