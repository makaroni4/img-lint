$(function() {
  var $jobAd = $(".post__job-ad");

  var createCookie = function(name, value, days) {
    var expires = "";
    if (days) {
        var date = new Date();
        date.setTime(date.getTime() + (days*24*60*60*1000));
        expires = "; expires=" + date.toUTCString();
    }
    document.cookie = name + "=" + value + expires + "; path=/";
  }

  var readCookie = function(name) {
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for(var i=0;i < ca.length;i++) {
        var c = ca[i];
        while (c.charAt(0)==' ') c = c.substring(1,c.length);
        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
    }
    return null;
  }

  if($jobAd.length === 0 || readCookie("seen-job-ad")) {
    return;
  }

  $jobAd.addClass("post__job-ad--active");

  $jobAd.on("click", ".job-ad__not-interested-link", function(e) {
    e.preventDefault();

    $jobAd.addClass("post__job-ad--fade-out").delay(1000).queue(function(next){
      $(this).remove();
      next();
    });

    createCookie("seen-job-ad", true, 30);

    ga("send", "event", "job-ad", "close");
  })
});
