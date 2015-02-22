$(function() {

  /*
    slide reveal
  */

  function set_reveal_text(el){
    if(el.data("initial")){
      el.html((el.hasClass('revealing')) ? el.data('active') : el.data('initial'));
    }
  }

  $("a.slide-reveal").each(function(){
    set_reveal_text($(this));
  });

  // Manage AJAX requests for maintaining the state of open panels
  var management_state = {

    // Get the state from the server, open relevant panels
    // This is called when the document loads

    get: function(){
      $.post("/management_state", {open_panels: "get"}, function(response){
        management_state.open_panels(String(response));
      });
    },

    // Persist the current state to a cookie
    // This is called when it modified (i.e. a button click)
    set: function(state){
      $.post("/management_state", {open_panels: state}, function(response){});
    },

    // Open panels that should be revealed based on state
    open_panels: function(p){
        var panels = String(p).split(',');
        for(var i = 0; i < panels.length; i++){
          if(panels[i] == " ") continue;
          var panel_el = $("#" + panels[i]);
          if(panel_el.length){
            panel_el.addClass('revealed').show();
            var link_showing = $("a[data-reveal='" + panel_el.attr('id') + "']");
            link_showing.addClass('revealing').html(link_showing.data('active'));
          }
        }
    }

  };

  $("a.slide-reveal").on('click', function(e){

    e.preventDefault();

    // reveal/hide and change text if necessary
    $(this).toggleClass('revealing');
    $("#" + $(this).data('reveal')).slideToggle(200).toggleClass('revealed');
    set_reveal_text($(this));

    // send a cookie with the management state
    var open_panels = [];
    $('div.reveal-hidden').each(function(){
      if($(this).hasClass('revealed')){
        open_panels.push($(this).attr('id'));
      }
    });
    management_state.set(open_panels.join(','));

  });

  // on document load, get the state if we can
  management_state.get();

});
