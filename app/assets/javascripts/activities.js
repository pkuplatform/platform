$(document).ready(function() {
    $('.description p').jTruncate({
        length: 400,
        minTrail: 0,
        moreText: "查看更多",
        lessText: "收起",
        ellipsisText: " ...",
        moreAni: "fast",
    });
});