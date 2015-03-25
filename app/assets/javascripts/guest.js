$(function() {

  var schools = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('name'),
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    limit: 5,
    prefetch: {
      url: '/gf_world_schools.json',
      // the json file contains an array of strings, but the Bloodhound
      // suggestion engine expects JavaScript objects so this converts all of
      // those strings
      filter: function(list) {
        return $.map(list, function(school) { return { name: school }; });
      }
    }
  });

  // kicks off the loading/processing of `local` and `prefetch`
  schools.initialize();

  // passing in `null` for the `options` arguments will result in the default
  // options being used
  $('#prefetch-schools .typeahead').typeahead(null, {
    name: 'schools',
    displayKey: 'name',
    // `ttAdapter` wraps the suggestion engine in an adapter that
    // is compatible with the typeahead jQuery plugin
    source: schools.ttAdapter()
  });

});
