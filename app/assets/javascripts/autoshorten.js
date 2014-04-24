$(function()
{
  $('.expandable-text').expandable_text();
});

jQuery.fn.expandable_text = function()
{
  return this.each(function()
  {
    if ($(this).text().length > 100)
    {
      var words = $(this).text().substring(0,100).split(" ");
      var shortText = words.slice(0, words.length - 1).join(" ") + "... (Click to view more)";
      $(this).data('replacementText', $(this).text())
          .text(shortText)
          .css({ cursor: 'pointer' })
          .hover(function() { $(this).css({ textDecoration: 'underline' }); }, function() { $(this).css({ textDecoration: 'none' }); })
          .click(function() { var tempText = $(this).text(); $(this).text($(this).data('replacementText')); $(this).data('replacementText', tempText); });
    }
  });
};