<html>
<body>

<?php 
$video = $_GET['vid'];
$dir = "movies/";

if( $video != '' )
{
    echo "<video controls=\"controls\">\n";
    echo "\t<source src=\"" . $dir . $video . "\"";

    if( strpos($video, ".mp4") == TRUE )
    {
        echo " type=\"video/mp4\" />\n";
    }
    else
    {
        echo " type=\"video/webm\" />\n";
    }

    
    
    #. ".mp4\" type=\"video/mp4\" />\n";
    #echo "\t<source src=\"movies/" . $video
    #     . ".webm\" type=\"video/webm\" />\n";
    echo "Your Browser does not support video streaming html5 tags\n";
    echo "</video>";
}
?>

</body>
</html>
