<?php
  include 'config.php';
  session_start();
  if(isset($_SESSION['login_user'])&&isset($_SESSION['login_komputer'])){
      header("location:user.php");
  }
  $success=false;
  $error="";
  $errorReg="";

  if($_SERVER["REQUEST_METHOD"] == "POST") {
      // username and password sent from form 
      if($_POST['action']=='login'){
        $myusername = $_POST['username'];
        $mypassword = $_POST['password'];
        //negecek apakah user ada pada database atau tidak
        $query = "SELECT COUNT(idUser) as Banyak FROM UserLab WHERE username = '$myusername' and password = '$mypassword'";
        $stmt = $dbh->prepare($query);
        $stmt->execute();
        $row = $stmt->fetch();
        $count = $row['Banyak'];
        //ngecek komputer di pake atau engga
        $query = "SELECT COUNT(idKomputer) AS banyakKomp   FROM Komputer WHERE status=0";
        $stmt = $dbh->prepare($query);
        $stmt->execute();
        $row = $stmt->fetch();
        $countPC = $row['banyakKomp'];
        //ngecek role user
        $query2="SELECT role,banned FROM UserLab WHERE username = '$myusername' and password = '$mypassword'";
        $stmt2=$dbh->prepare($query2);
        $stmt2->execute();
        $row=$stmt2->fetch();
        $role=$row['role'];
        $banned=$row['banned'];
        $_SESSION['role']=$role;

        if($count=='1'&& $role=="admin"){
          $_SESSION['login_user'] = $myusername;
          header("location: admin.php");
        }

        if($count == '1'&&$countPC!='0'&& $role=="user" &&$banned==0) {
          $_SESSION['login_user'] = $myusername;
          $query = "SELECT TOP 1 idKomputer FROM Komputer WHERE status=0";
          $stmt = $dbh->prepare($query);
          $stmt->execute();
          $res = $stmt->fetch();
          $komputer=$res['idKomputer'];
          $stmt = $dbh->prepare("EXEC spLogin '$myusername','$komputer'");
          if($stmt->execute()){
          $_SESSION['login_komputer'] = $komputer;
          header("location: user.php");  
          }
        }else if($count == '0'&&$countPC!='0') {
          $error = "Your Login Name or Password is invalid";
        }
        else if($banned==1){
          $error = "You are banned, please contact admin.";
        }
        else{
          $error = "Lab is full!";
        }
      }
      //registrasi user
      else{
        $myusername = $_POST['usernamereg'];
        $myname = $_POST['name'];
        $mypassword = $_POST['passwordreg'];
        $repasswordreg = $_POST['repasswordreg'];
        if($myusername==""){
          $errorReg="Please enter your username";
        }
        if($myname=="" ){
          $errorReg="Please enter your name";
        }
        if($mypassword==""){
          $errorReg="Please enter your password";
        }
        if($mypassword!=$repasswordreg){
          $errorReg="Password and Repeat Password are not the same!";
        }
        if($myusername!=""&&$myname!=""&&$mypassword!=""&&$mypassword==$repasswordreg){
          $checker="SELECT COUNT(idUser) as Banyak FROM UserLab WHERE username = '$myusername'";
          $stmt = $dbh->prepare($checker);
          $stmt->execute();
          $row = $stmt->fetch();
          $count = $row['Banyak'];
          if($count == '1') {
            $errorReg="Username already existed, try a different username!";
          }else {
            $success = true;
            $query = "INSERT INTO UserLab SELECT 'user','$myusername','$mypassword','$myname',0";
            $stmt = $dbh->prepare($query);
            $stmt->execute();
            $error ="Congratulations, you just registered in this lab. Continue login with your username and password!";
          }
        }
      }
  }

?>
<!DOCTYPE html>
<html lang="en" >

<head>
  <meta charset="UTF-8">
  <title>Login/Sign-In</title>
  
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">

  <link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css'>

      <link rel="stylesheet" href="css/style.css">

  
</head>

<body>

  <div class="logmod">
  <div class="logmod__wrapper">
    <span class="logmod__close">Close</span>
    <div class="logmod__container">
      <ul class="logmod__tabs">
        <li data-tabtar="lgm-2"><a href="#">Login</a></li>
        <li data-tabtar="lgm-1"><a href="#">Sign Up</a></li>
      </ul>
      <div class="logmod__tab-wrapper">
      <div class="logmod__tab lgm-1">
        <div class="logmod__heading">
          <span class="logmod__heading-subtitle">Enter your personal details <strong>to create an acount</strong></span>
        </div>
        <div class="logmod__form">
          <form accept-charset="utf-8" action="" method="post" class="simform">
            <div class="sminputs">
              <div class="input full">
                <label class="string optional" for="user-name">Username</label>
                <input class="string optional" maxlength="255" id="user-email" name="usernamereg" placeholder="Username" type="text" size="50" />
              </div>
            </div>
            <div class="sminputs">
              <div class="input full">
                <label class="string optional" for="user-name">Name</label>
                <input class="string optional" maxlength="255" id="user-email" name="name" placeholder="Name" type="text" size="50" />
              </div>
            </div>
            <div class="sminputs">
              <div class="input string optional">
                <label class="string optional" for="user-pw">Password</label>
                <input class="string optional" maxlength="255" id="user-pw" name="passwordreg" placeholder="Password" type="password" size="50" />
              </div>
              <div class="input string optional">
                <label class="string optional" for="user-pw-repeat">Repeat password</label>
                <input class="string optional" maxlength="255" id="user-pw-repeat" name="repasswordreg" placeholder="Repeat password" type="password" size="50" />
              </div>  
                <input type="hidden" name="action" value="register">
            </div>
            <div class="simform__actions">
              <input class="sumbit" type="submit" value="Create An Account" />
              <div style = "font-size:11px; color:#cc0000;margin-top:3%;margin-left:2%;"><?php 
              if(!$success){?><p style = "font-size:11px; color:#cc0000;margin-top:3%;margin-left:2%;"><?php
                echo $errorReg; ?></p>
              <?php }    
              else{?>
              <p style = "font-size:11px; color:#000000;margin-top:3%;margin-left:2%;"><?php
                echo $errorReg; 
              ?></p>
              <?php
              }
              ?></div> 
            </div> 
          </form>
        </div> 
      </div>
      <div class="logmod__tab lgm-2">
        <div class="logmod__heading">
          <span class="logmod__heading-subtitle">Enter your username and password <strong>to login</strong></span>
        </div> 
        <div class="logmod__form">
          <form accept-charset="utf-8" action="" method="post" class="simform">
            <div class="sminputs">
              <div class="input full">
                <label class="string optional" for="user-name">Username</label>
                <input class="string optional" maxlength="255" id="user-email" placeholder="Username" name="username" type="text" size="50" />
              </div>
            </div>
            <div class="sminputs">
              <div class="input full">
                <label class="string optional" for="user-pw">Password</label>
                <input class="string optional" maxlength="255" id="user-pw" placeholder="Password" type="password" name="password" size="50" />
                						<span class="hide-password">Show</span>
              </div>
            </div>
        
            <input type="hidden" name="action" value="login">
            <div class="simform__actions">
              <input class="sumbit" type="submit" value="Log In" />
              <div style = "font-size:11px; color:#cc0000;margin-top:3%;margin-left:2%;"><?php 
              if(!$success){?><p style = "font-size:11px; color:#cc0000;margin-top:3%;margin-left:2%;"><?php
                echo $error; ?></p>
              <?php }    
              else{?>
              <p style = "font-size:11px; color:#000000;margin-top:3%;margin-left:2%;"><?php
                echo $error; 
              ?></p>
              <?php
              }
              ?></div>  
            </div> 
          </form>
        </div> 
      </div>
    </div>
  </div>
</div>
  <script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>

  

    <script  src="js/index.js"></script>




</body>

</html>
