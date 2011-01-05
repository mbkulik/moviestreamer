<html>
<body>

<?php 

$video = $_GET['vid'];

if( $video != '' )
{
    echo "<video controls=\"controls\">\n";
    echo "\t<source src=\"movies/" . $video 
         . ".mp4\" type=\"video/mp4\" />\n";
    echo "\t<source src=\"movies/" . $video
         . ".ogg\" type=\"video/ogg\" />\n";
    echo "Your Browser does not support video streaming html5 tags\n";
    echo "</video>";
}

?>

</body>
</html>
