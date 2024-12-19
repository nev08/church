<?php
$conn=new mysqli("localhost","root","","iccc");
if(!$conn){
    echo mysqli_error($conn);
}
else{
    //echo "connected successfull";
}

?>