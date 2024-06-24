$(document).ready(function(){
    $(".list_tab a").click(function(){
        if( !$(this).hasClass("active") ) {
            $(".list_tab a").removeClass("active");
            $(this).addClass("active");
        }
    });

    /* 모바일 사이드 메뉴 */
    $(".ham_ico").click(function(){
        $(".mo_menu").fadeIn("fast");
        $("body").css("overflow", "hidden");
    });
    $(".close_btn img").click(function(){
        $(".mo_menu").fadeOut("fast");
        $("body").css("overflow", "visible");
    });

    /* 모바일 2차카테고리 */
    // $(".dep2_btn").click(function(){
    //     $(".dep2").slideDown("fast");
    // });

    $(".nav-item .dep2_btn").click(function(){
        if( $(this).hasClass("active") ){
            $(this).removeClass("active");
            $(this).parents(".nav-item").children(".dep2").slideUp("fast");
            $(this).find(".dep_ico").attr("src", "assets/img/down_btn.png");
        } else {
            $(this).addClass("active");
            $(this).parents(".nav-item").children(".dep2").slideDown("fast");
            $(this).find(".dep_ico").attr("src", "assets/img/up_btn.png");
        }
        
    });
});

$(document).scroll(function(){
    var top=$(this).scrollTop();
    if (top > 0) {
    $(".fixed-top").addClass("active");
    }
    if(top == 0) {
        $(".fixed-top").removeClass("active");
    }
    });