$(function() {
  var $imagePopup = $(".js-image-popup");

  if($imagePopup.length < 0) {
    return;
  }

  var $img = $imagePopup.find(".js-image-popup-img");
  var $post = $(".post");

  $post.find("img").not(".emoji").on("click", function(e) {
    var $this = $(this);

    $img.css('background-image', 'url(' + $this.attr("src") + ')');
    $imagePopup.addClass("active");
    $post.addClass("post--blur");
  });

  $imagePopup.on("click", function() {
    $(this).removeClass("active");
    $post.removeClass("post--blur");
  })
});
