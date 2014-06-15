// Video texts creation, removal, updating
jQuery.fn.outerHTML = function(s)
{
  return s
    ? this.before(s).remove()
    : jQuery("<p>").append(this.eq(0).clone()).html();
};

// Keeps track of the numbering of the video texts
numberManager = function(_selector)
{
  return {
    ping: function() {
      $(_selector).each(function(index) {
        $(this).html(index + 1);
      });
    }
  };
}

$(document).ready(function()
{
  var $videoTextCreate = $("#video-text-create");
  var $videoTexts = $videoTextCreate.find("#video-texts");

  if($videoTextCreate.length > 0)
  {
    // Get a copy of a blank problem, used to create new problems
    var blankVideoText = $(".video-text.new").outerHTML();

    // We don't need to display a blank problem if some already exist
    if ($(".video-text").length > 1)
    {
      $(".video-text.new").remove();
    }

    // Use numberManager to show "Problem #" titles (see number_manager.js, it's dead simple)
    var nm = numberManager(".video-text-number");
    nm.ping();

    function removeVideoText(e)
    {
      // Make sure nothing is submitted
      e.preventDefault();

      var deleteMessage = "Are you sure that you want to delete this video " +
                          "annotation?\n\nOnce deleted, it CANNOT be recovered!";

      // Confirm deletion
      if (!confirm(deleteMessage)) return;

      // Figure out the video text that needs to be updated
      var $target = $(e.currentTarget);
      var $videoText = $target.parents(".video-text");

      if ($videoText.hasClass("new"))
      {
        // Has not been saved to the DB so no need to send an AJAX request
        $videoText.remove();
        nm.ping();
      }
      else
      {
        $target.html('Removing...');

        // returns the id of the video text
        var id = $videoText.attr('id').replace('video-text-', '');

        var base_path = document.URL.replace("/edit", "");
        var path = base_path + "/" + id;

        $.post(path,
        {
          "_method": "DELETE"
        },
        function(data)
        {
          $videoText.remove();
          nm.ping();
        }, "json");
      }
    }

    // Bind remove event to any existing video texts
    $(".video-text .remove").click(function(e) { removeVideoText(e); });

    function updateVideoText(e)
    {
      // Make sure nothing is submitted
      e.preventDefault();

      // Figure out the video text that needs to be updated
      var $target = $(e.currentTarget);
      var $videoText = $target.parents(".video-text");

      $target.html("Saving...");

      var $content = $videoText.find("#video_text_content");
      var $time = $videoText.find("#video_text_time");

      var path = document.URL;

      if ($videoText.hasClass("new"))
      {
        var method = "POST";
      }
      else
      {
        var id = $videoText.attr('id').replace('video-text-', '');
        var path = path + "/" + id;
        var method = "PUT";
      }

      $.post(path,
        {
          "_method": method,
          "video_text[content]": $content.val(),
          "video_text[time]": $time.val()
        },
        function(data)
        {
          if (data.status == "success")
          {
            $target.html("Saved!");
            setTimeout(function() { $target.html("Update"); }, 3000);
          }
          else
          {
            $target.html("Oops!").addClass("alert");
          }
        }, "json");
    }

    $(".video-text .update").click(function(e) { updateVideoText(e); });

    $("#add-video-text").click(function()
    {
      $videoTexts.append(blankVideoText);
      $videoText = $videoTexts.find(".video-text").last();

      // Bind the buttons to the new video annotation
      $videoText.find(".remove").click(function(e) { removeVideoText(e); });
      $videoText.find(".update").click(function(e) { updateVideoText(e); });

      nm.ping();
    });
  }
});

// Video text displaying
setupYoutube();
var player, YTReady;
var playbackTime;
var players = new Array();

function setupYoutube(){
  var tag = document.createElement('script');
  tag.src = "//www.youtube.com/iframe_api";
  var firstScriptTag = document.getElementsByTagName('script')[0];
  firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
}

function addPlayers() {
  $('.video-wrapper iframe').each(function() {
    $(this).attr('id', 'player');
    player = new YT.Player('player', {
      events: {
        'onStateChange': onPlayerStateChange
      }
    });
    players.push(player);
    $(this).removeAttr('id', 'player');
  });
}

function onYouTubeIframeAPIReady() {
  addPlayers();
}

function onPlayerStateChange(event) {
  var state = event.target.getPlayerState();
  playerNumber = players.indexOf(event.target);
  if (state == YT.PlayerState.PLAYING){
    playbackTime = setInterval(function() {
      if ($('.video-texts').eq(playerNumber).children('li.show').length > 0){
        if (event.target.getCurrentTime() >= $('.video-texts').eq(playerNumber).children('li.show').next().attr('timestart')){
          tmp = $('.video-texts').eq(playerNumber).children('li.show');
          tmp.next().addClass('show');
          tmp.removeClass('show');
        }
      }
      else {
        if (event.target.getCurrentTime() >= $('.video-texts').eq(playerNumber).children('li').first().attr('timestart')){
          $('.video-texts').eq(playerNumber).children('li').first().addClass('show');
        }
      }
    }, 100);
  }
  else if (state == YT.PlayerState.PAUSED){
    clearInterval(playbackTime);
  }
}

$('.video-button.replay').click(function() {
  $(this).closest('.row').find('.show').removeClass('show');
  playerNumber = $(this).closest('.row').parent().index();
  players[playerNumber].seekTo(0);
});