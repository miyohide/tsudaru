# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
`
$(function() {
    $("#tweet_message").bind("keyup change", function() {
        var len = $(this).val().length;
        // メッセージ本文＋ハッシュタグ欄＋話手＋（"「" +"」 "）の3文字
        len += $("#tweet_opt_hashtag").val().length + $("#tweet_opt_speaker").val().length + 3;
        $("#tweet_count").html(len);
    });
});
`

