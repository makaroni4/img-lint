$(function() {
  $(".post__content a").on("mouseenter", function() {
    $(this).animate({
      "padding-bottom": "2px"
    }, 300, "easeInOutBack");
  }).on("mouseleave", function() {
    $(this).animate({
      "padding-bottom": "0"
    }, 300, "easeInOutBack");
  });
});
