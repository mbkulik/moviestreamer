<html>
<head></head>
<body>

<br /> "*" All common browsers supported<br /><br />

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
        
        //check to see if a .webm file exists, then movie
        // plays on all browsers
        $full_support = '';
        $webm_file = './' . $dir . '/' . $stripped_name . '.webm';

        if( file_exists($webm_file) == TRUE )
        {
            $full_support = '*';
        }

        //set up the link
        echo "<a href=\"video.php?vid=" . $stripped_name ."\">" .
        $stripped_name . "</a> " . $full_support . "<br />";
    }
}
?>

</body>
</html>
