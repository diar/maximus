// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
// Показать диалог
$(document).ready(function() {
    $('.do_vote').click(function(){
        vote_id = $(this).parents('.photo').find('.vote_id').html();
        $('#vote_id').val(vote_id);
        $.show_dialog('vote_dialog');
    });
    $('#vote_submit').click(function(){
        user_name = $('#vote_name').val();
        user_mail = $('#vote_mail').val();
        vote_id = $('#vote_id').val();
        $.post('/special/vote',
        {'vote':{
            'user_name':user_name,
            'user_mail':user_mail,
            'photo_id':vote_id
        }},
        function(data){
            $('#vote_message').html(data);
        })
    });
});
$.show_dialog = function (id) {
    $body_fill = $('#body_fill');
    // Показываем затемнение
    if ($('#body_fill').length==0) {
        $body_fill = $('<div id="body_fill"></div>');
        $body_fill.click(function(){
            $.hide_dialog('vote_dialog');
        });
        $('body').append($body_fill);
    }
    $body_fill.css('opacity',0).show().animate({
        'opacity':0.5
    },300);
    // Показываем диалог
    $('#'+id).css('top',200);
    $('#'+id).fadeIn(300);
};

// Показать диалог
$.hide_dialog = function (id) {
    $('#body_fill').animate({
        'opacity':0
    },300).hide();
    $('#'+id).fadeOut(300);
};