<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <title>TODO supply a title</title>
        <meta charset="UTF-8">
        <link rel="stylesheet" type="text/css" href="style2.css">
        <meta name="viewport" content="width=device-width">
        <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"></script>
        <script type="text/javascript">
$(document).ready(function() {
// Tooltip only Text
$('.masterTooltip').hover(function(){
        // Hover over code
        var title = document.getElementById("try").innerHTML;
        //alert(title);
        //$(this).attr('title', title);
        $(this).data('tipText', title).removeAttr('title');
        $('<p class="tooltip"></p>')
        .html(title)
        .appendTo('body')
        .fadeIn('slow');
}, function() {
        // Hover out code
        $(this).attr('title', $(this).data('tipText'));
        //$(this).attr('title', title);
        $('.tooltip').remove();
}).mousemove(function(e) {
        var mousex = e.pageX + 20; //Get X coordinates
        var mousey = e.pageY + 10; //Get Y coordinates
        $('.tooltip')
        .css({ top: mousey, left: mousex })
});
});
</script>
        
    </head>
    <body>
    <p title="" class="masterTooltip">
        <% 
    String str="Mouse over the heading above to view the tooltip. hii";
    out.print(str);
    %>    
    </p>
        <div id="try" style="display:none;"><pre style='font-family: arial;'><table><tr>
<td>hello</td></tr>
<tr><td>hahaha</td></tr></table></pre></div>
        <p title="" class="masterTooltip">Mouse over the heading text above to view it's tooltip.</p>
        
    </body>
</html>
