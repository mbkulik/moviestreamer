<html>

<?php
    require_once('Browser.php');
    $browser = new Browser();
    $dir = "movies";

    if( ($browser->getBrowser() == Browser::BROWSER_CHROME &&
         $browser->getVersion() <= 11 ) ||
	($browser->getBrowser() == Browser::BROWSER_IE &&
	 $browser->getVersion() >= 9 )  ||
         $browser->getBrowser() == Browser::BROWSER_SAFARI ||
	 $browser->getBrowser() == Browser::BROWSER_IPAD   ||
	 $browser->getBrowser() == Browser::BROWSER_IPHONE ||
	 $browser->getBrowser() == Browser::BROWSER_IPOD   ||
	 $browser->getBrowser() == Browser::BROWSER_ANDROID )
    {
        $videotype = "mp4";
    }
    elseif( ($browser->getBrowser() == Browser::BROWSER_CHROME &&
             $browser->getVersion() > 11) ||
             $browser->getBrowser() == Browser::BROWSER_OPERA ||
             $browser->getBrowser() == Browser::BROWSER_FIREFOX )
    {
        $videotype = "webm";
    }
    else
    {
        echo $browser . " Not Supported!";
	exit(1);
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
        
            echo "<a href=\"video.php?vid=" . $file . "\">" . 
	    $no_extension . "</a><br />";
        }
    }
?>

</html>
