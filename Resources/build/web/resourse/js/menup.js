$(document).ready(function (){
    $('#mylist-tab ul li a').on('click', function (e) {
        e.preventDefault()
        $(this).tab('show')
    });
});
