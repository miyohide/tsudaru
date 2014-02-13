$ ->
    $(document).on 'keyup change', '#tweet_message', ->
        len = 3
        len += $(this).val().length + $('#tweet_opt_speaker').val().length + $('#tweet_opt_hashtag').val().length
        $('#tweet_count').html(len)

