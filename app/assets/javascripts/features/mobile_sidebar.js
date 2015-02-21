$content = $(".main-content");
$leftSidebar = $(".mobile-sidebar.left");
$rightSidebar = $(".mobile-sidebar.right");

viewportHeight = $(window).height();

$leftSidebar.height(viewportHeight);
$rightSidebar.height(viewportHeight);

function hide(side){
  $(".title-area").css("box-shadow", "none");
  $("body").css("position", "relative");
  if(side == "left"){
    $(".mobile-nav-left i").removeClass("active");
    $leftSidebar.animate({
      left: "-100%"
    }, 250);
    $content.animate({
      opacity: "1"
    }, 250);
  } else if(side == "right"){
    $(".mobile-nav-right i").removeClass("active");
    $rightSidebar.animate({
      left: "100%"
    }, 250);
    $content.animate({
      opacity: "1"
    }, 250);
  } else {
    hide("left");
    hide("right");
  }
}

function show(side){
  $(".title-area").css("box-shadow", "0px 6px 10px rgba(0, 0, 0, 0.14)");
  $("body").css("position", "fixed");
  if(side == "left"){
    $(".mobile-nav-left i").addClass("active");
    $leftSidebar.animate({
      left: "0"
    }, 300);
    $content.animate({
      opacity: "0.5"
    }, 300);
  } else if (side == "right"){
    $(".mobile-nav-right i").addClass("active");
    $rightSidebar.animate({
      left: "10%"
    }, 300);
    $content.animate({
      opacity: "0.5"
    }, 300);
  }
}

$(".mobile-nav i").click(function(e){
  $element = $(e.currentTarget);
  if($element.parent().is("[class*='-left']")){
    if($element.hasClass("active")){
      hide("left");
    } else {
      hide("right");
      show("left");
    }
  } else {
    if($element.hasClass("active")){
      hide("right");
    } else {
      hide("left");
      show("right");
    }
  }

  $content.click(function(e){
    hide("left");
    hide("right");
  });

});
