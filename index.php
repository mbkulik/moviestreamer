<html>
<head></head>
<body>

<?php
$dir = "movies";

$files = scandir( $dir );

foreach( $files as $file )
{
    //filter out non mp4 files
    if( strpos($file, ".mp4") != FALSE )
    {
        //replace .mp4 with nothing
        $stripped_name = str_replace(".mp4", "", $file);
      
        //set up the link
        echo "<a href=\"video.php?vid=" . $stripped_name ."\">" .
        $stripped_name . "</a><br />";
    }
}
?>

</body>
</html>
