$(function() {

  if($("#lecture-comments").length){

    var lecture_id = $("#lecture-comments").data("lecture-id");
    var list_url = $("#lecture-comments").data("url");
    var loaded_comment_ids = [];

    var get_comment_content = function(comment){
      var self = comment;
      var content = "<p class='lecture-comment'>";
      content += "<strong>" + self.author.display_identifier + "</strong>: ";
      content += Autolinker.link(gf.html_escape(self.body));
      content += "&nbsp;&nbsp;<span class='comment-date' data-time='" + self.posted_time + "'></span> ";
      content += gf.ytparse.get_html(self.body);
      content += "</p>";
      return content;
    }

    var push_comments_to_dom = function(comments){

      var $container = $("#lecture-comments");

      $container.children('p.empty').remove();

      if(comments.length == 0){
        $container.html("<p class='empty'>No comments yet! Be the first.</p>")
      }

      $.each(comments, function() {
        if($.inArray(this.id, loaded_comment_ids)!==-1)
          return true;
        loaded_comment_ids.push(this.id);
        var comment = get_comment_content(this);
        $container.prepend(comment);
      });

      // update the date for each comment
      $('p.lecture-comment').each(function(){
          $span = $(this).children('span.comment-date');
          $span.html($.timeago($span.data('time')));
      });

    }

    var download_latest_comments = function(){

      $.ajax({
        type: "GET",
        url: list_url,
        data: {lecture: lecture_id}
      }).done(function(comments) {
        push_comments_to_dom(comments);
        setTimeout(download_latest_comments, 300);
      }).fail(function(error, as){
        console.log('Getting latest comments failed!');
        push_comments_to_dom([]);
        setTimeout(download_latest_comments, 2000);
      });

    }

    download_latest_comments();

    $("#comments-submit").on("ajax:success", function(){
      $("#comment-body").val("").select();
      download_latest_comments();
    });

    $("#lecture-comments").on("mouseover", "p", function(){
      $(this).children("span.comment-date").show();
    }).on("mouseout", "p", function(){
      $(this).children("span.comment-date").hide();
    });

  }

});
