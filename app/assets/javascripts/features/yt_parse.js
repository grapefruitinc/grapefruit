(function(gf, $, undefined){

  gf.ytparse = {

    // courtesy of https://gist.github.com/takien/4077195
    get_id: function(url){
      var youtube_id = '';
      url = url.replace(/(>|<)/gi,'').split(/(vi\/|v=|\/v\/|youtu\.be\/|\/embed\/)/);
      if(url[2] !== undefined) {
        youtube_id = url[2].split(/[^0-9a-z_]/i);
        youtube_id = youtube_id[0];
      }
      else {
        youtube_id = "false";
      }
      return youtube_id;
    },

    youtube_iframe_for_id: function(youtube_id){
      return '<iframe width="560" height="315" src="//www.youtube.com/embed/' + youtube_id + '" frameborder="0" allowfullscreen></iframe>';
    },

    get_html: function(url){
      var youtube_id = this.get_id(url);
      if(youtube_id == "false"){
        return '';
      }else{
        return this.youtube_iframe_for_id(youtube_id);
      }
    },

  };

}( window.gf = window.gf || {}, jQuery ));
