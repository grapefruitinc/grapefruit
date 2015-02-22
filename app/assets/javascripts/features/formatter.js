(function(gf, $, undefined){

  gf.html_escape = function(str) {
      return String(str)
              .replace(/&/g, '&amp;')
              .replace(/"/g, '&quot;')
              .replace(/'/g, '&#39;')
              .replace(/</g, '&lt;')
              .replace(/>/g, '&gt;');
  };

}( window.gf = window.gf || {}, jQuery ));
