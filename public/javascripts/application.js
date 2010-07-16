var vote_photo_count = 0;
var vote_photo_visible = 4;
var vote_photo_position = 0;
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
    // Если находимся в админке
    if (current_page=="admin"){
        // Активируем ckeditor
        $('.ckeditor').ckeditor();
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
        rooms = Array ();
        rooms[1] = {'x':200,'y':270,'title':'Тренажерный зал','link':'gym'};
        rooms[2] = {'x':470,'y':220,'title':'Кардиозал','link':'kardiozal'};
        rooms[3] = {'x':700,'y':350,'title':'Зал групповых программ','link':'groups'};
        rooms[4] = {'x':450,'y':140,'title':'Зал восточных единоборств','link':'east'};
        rooms[5] = {'x':120,'y':170,'title':'Студия сайкла','link':'cycle'};
        rooms[6] = {'x':540,'y':110,'title':'OUTDOOR - занятия','link':'outdoor'};
        rooms[7] = {'x':240,'y':150,'title':'Детская комната','link':'nursery'};
        rooms[8] = {'x':150,'y':410,'title':'Турецкая баня','link':'turkish'};
        rooms[9] = {'x':180,'y':440,'title':'Финская сауна','link':'sauna'};
        rooms[10] = {'x':160,'y':470,'title':'Инфракрасная сауна','link':'infrared'};
        rooms[11] = {'x':360,'y':620,'title':'Фитнес бар','link':false};
        rooms[12] = {'x':340,'y':500,'title':'Джакузи','link':false};
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