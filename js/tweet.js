$(function() {
  $(".js-tweet").click(function(e) {
    e.preventDefault();

    ga("send", "event", "sharing", "click", "twitter");

    var width  = 575,
    height = 400,
    left   = ($(window).width()  - width)  / 2,
    top    = ($(window).height() - height) / 2,
    opts   = ",width="  + width  +
             ",height=" + height +
             ",top="    + top    +
             ",left="   + left;

    var tweet = document.title;
    var maxLength = 140 - (location.href.length + 1);
    if (tweet.length > maxLength) {
      tweet = tweet.substr(0, (maxLength - 3)) + "...";
    }

    var twitterLink = "http://twitter.com/home?status=" + encodeURIComponent(tweet + " " + location.href);

    window.open(twitterLink, "twitter", opts);
  });
});
