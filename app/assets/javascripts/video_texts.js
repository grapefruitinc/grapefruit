// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var tag = document.createElement('script');
tag.src = "//www.youtube.com/iframe_api";
var firstScriptTag = document.getElementsByTagName('script')[0];
firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
var player, YTReady;
var playbackTime;
var players = new Array();

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

$('.video-button').click(function() {
  console.log($(this).closest('.video-texts'));
});