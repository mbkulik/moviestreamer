<html>

<?php
    $videotype = $_POST['videotype'];
    $dir = "movies";

    if( $videotype == '' )
    {
        $videotype = "mp4";
    }

    $files = scandir( $dir );

    foreach( $files as $file )
    {
        //filter out files that are not of the correct
        //videotype (mp4 or webm)
        if( strpos($file, $videotype) == TRUE )
        {
            //remove the file extension
            $no_extension = substr($file, 0, strrpos($file, '.'));
        
            echo "<a href=\"video.php?vid=" . $file . 
            "\" target=\"_blank\">" . $no_extension . "</a><br />";
        }
    }
?>

</html>
