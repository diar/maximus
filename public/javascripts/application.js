var vote_photo_count = 0;
var vote_photo_visible = 4;
var vote_photo_position = 0;
var admin_map_x = 0;
var admin_map_y = 0;
var admin_map_temp_x = 0;
var admin_map_temp_y = 0;
var admin_map_move = false;
$(document).ready(function() {
    // Активируем lightbox
    $('.photos .photo_link').lightBox({
        imageLoading: '/images/lightbox-ico-loading.gif',
        imageBtnClose:'/images/lightbox-btn-close.gif',
        imageBtnPrev: '/images/lightbox-btn-prev.gif',
        imageBtnNext: '/images/lightbox-btn-next.gif',
        imageBlank:   '/images/lightbox-blank.gif',
        fixedNavigation:true
    });
    $('#header .menu_item').mouseenter(function(){
        if ($(this).find('.child_menu_item').length>0)
            $(this).find('.child_menu').show();
    }).mouseleave(function(){
        $(this).find('.child_menu').hide();
    });
    // Если находимся в админке
    if (current_page=="admin"){
        // Активируем ckeditor
        $('.ckeditor').ckeditor();
        // Перемещение маркера на карте
        $('.marker').mousedown(function(e){
            e = jQuery.event.fix(e);
            admin_map_move = true;
            admin_map_x = e.pageX;
            admin_map_y = e.pageY;
        });
        $(document).mouseup(function(){
            if (admin_map_move) {
                admin_map_move = false;
                admin_map_last_x = admin_map_temp_x;
                admin_map_last_y = admin_map_temp_y;
                $('#room_coord_x').val(admin_map_temp_x+25);
                $('#room_coord_y').val(admin_map_temp_y+25);
            }
        });
        $(document).mousemove(function(e){
            if (admin_map_move) {
                admin_map_temp_x = e.pageX - admin_map_x + admin_map_last_x;
                admin_map_temp_y = e.pageY - admin_map_y + admin_map_last_y;
                if (admin_map_temp_x<-25) admin_map_temp_x=-25;
                if (admin_map_temp_x>703) admin_map_temp_x=703;
                if (admin_map_temp_y<-25) admin_map_temp_y=-25;
                if (admin_map_temp_y>560) admin_map_temp_y=560;
                $(".marker").css({
                    'left':(admin_map_temp_x),
                    'top':(admin_map_temp_y)
                });
                return false;
            }
        });
    }
    $('.prev_page').html('←');
    $('.next_page').html('→');
    // Если находимся на странице голосования
    if (current_page=="vote"){
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
            {
                'vote':{
                    'user_name':user_name,
                    'user_mail':user_mail,
                    'photo_id':vote_id
                }
            },
            function(data){
                $('#vote_message').html(data);
            })
        });
        // Считаем количество фоток
        vote_photo_count = $('.photos .photo').length;
        check_arrows_active ();
        // Нажатие на стрелку вправо
        $('.arrow_right').click(function(){
            if(vote_photo_count>vote_photo_visible+vote_photo_position) {
                vote_photo_position++;
                $('#vote_content .photos').animate({
                    scrollLeft:vote_photo_position*202
                },300);
                // Изменяем активность кнопок
                check_arrows_active ();
            }
        });
        // Нажатие на стрелку влево
        $('.arrow_left').click(function(){
            if(vote_photo_position>0) {
                vote_photo_position--;
                $('#vote_content .photos').animate({
                    scrollLeft:vote_photo_position*202
                },300);
                // Изменяем активность кнопки
                check_arrows_active ();
            }
        });
    }
    // Если находимся на странице экскурсии
    if (current_page=="tour"){
        for (r in rooms) {
            img = parseInt(Math.random()*5)+1;
            if (rooms[r]['link']) {
                link = '<a href="/tour/'+rooms[r]['link']+'">'+rooms[r]['title']+'</a>';
            } else {
                link = rooms[r]['title'];
            }
            $('<div class="sticker"><img src="/images/stickers/'+img+'.png">'+
                '<div class="number">'+r+'</div>'+
                '<div class="title">'+link+'</div>'+
                '</div>')
            .appendTo('#tour_map')
            .css({
                'left':rooms[r]['x'],
                'top':rooms[r]['y']
            });
        }
    }
});
// Показать диалог
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

function check_arrows_active () {
    if (vote_photo_position>0) {
        $('.arrow_left').addClass('active');
    } else {
        $('.arrow_left').removeClass('active');
    }
    if (vote_photo_count>vote_photo_visible+vote_photo_position) {
        $('.arrow_right').addClass('active');
    } else {
        $('.arrow_right').removeClass('active');
    }
}

function defined(constant_name)  {
    return (typeof window[constant_name] !== 'undefined');
}