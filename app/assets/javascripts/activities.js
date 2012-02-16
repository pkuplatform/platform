$(document).ready(function() {
    /*
    $('.description p').jTruncate({
        length: 400,
        minTrail: 0,
        moreText: "查看更多",
        lessText: "收起",
        ellipsisText: " ...",
        moreAni: "fast",
    });
*/
    $(".carousel-items").carouFredSel({
    auto : false,
    prev : ".prev,left",
    next : ".next,right",
    width: "98%"
    });

    $("a.gallery_pics").fancybox({
        helpers: {
            title: {
                type: "over"
            }

        }
    });
    $(".tags_input").tagsInput({
        'defaultText':'添加标签',
        'height': '50px',
        'width': '400px',
    });

});