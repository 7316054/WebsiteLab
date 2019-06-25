<?php
  try {
    $hostname = "Samuel\SQLEXPRESS";
    $dbname = "LoginLab";
    $username = "testtbd";
    $pw = "123456";
    $opt = array(PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION);
    $dbh = new PDO ("sqlsrv:Server=$hostname;Database=$dbname");
  } 
  catch (PDOException $e) {
    echo "Failed to get DB handle: " . $e->getMessage() . "\n";
    exit; 
  }
  // $query = $dbh->prepare("EXEC agregasikanTabelKomputer");
  // if($query->execute()) echo 'True';
  // else echo 'False';
  
  // while ($row = $query->fetch()) {
  //       echo 'idUser : '.$row['idUser'].'<br/>';
  //       echo 'idKomputer : '.$row['idKomputer'].'<br/>';
  //       echo 'start : '.$row['start'].'<br/>';
  //       echo 'finish : '.$row['finish'].'<br/>';
  //       echo 'durasi : '.$row['durasi'].'<br/>';
  // }
?>