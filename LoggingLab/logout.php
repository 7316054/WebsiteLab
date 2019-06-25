<?php
   include('session.php');
   $role=$_SESSION['role'];
   if($role=='admin'){
    $query="EXEC spLogout $id_login,null";  
    if(session_destroy()) {
        $stmt = $dbh->prepare($query);
        if($stmt->execute()){
            header("Location: index.php");
        }
       }
   }
   else if($role=='user'){
    $query = "EXEC spLogout $id_login,$user_PC";  
    if(session_destroy()) {
     $stmt = $dbh->prepare($query);
     if($stmt->execute()){
         header("Location: index.php");
     }
    }
   }
?>