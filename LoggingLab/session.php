<?php
   include('config.php');
   session_start();
    $role_check=$_SESSION['role'];
    $user_PC="";
    $id_login="";
    if($role_check=='user'){
      $user_check = $_SESSION['login_user'];
      $user_PC =  $_SESSION['login_komputer'];
      $query = $dbh->prepare("SELECT nama,idUser FROM UserLab WHERE username='$user_check'");
      $query->execute();
      $row = $query->fetch();
      $login_session = $row['nama'];
      $id_login = $row['idUser'];
    }
    else if($role_check=='admin'){
      $user_check = $_SESSION['login_user'];
      $query = $dbh->prepare("SELECT nama,idUser FROM UserLab WHERE username='$user_check'");
      $query->execute();
      $row = $query->fetch();
      $login_session = $row['nama'];
      $id_login = $row['idUser'];
    }
   
   if(!isset($_SESSION['login_user'])){
      header("location:index.php");
      die();
   }
?>