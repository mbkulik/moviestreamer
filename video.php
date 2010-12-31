<html>
<body>

<?php 

$video = $_GET['vid'];

if( $video != '' )
{
    echo "<video src=\"movies/" . $video . "\" controls=\"controls\">";
    echo "</video>";
}

?>

</body>
</html>
