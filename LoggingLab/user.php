<?php
   include('session.php');
   $namaApp="";
   echo $namaApp;
    function openApp($app,$dbh,$id_login,$user_PC){
        $query = "SELECT idApplikasi FROM Applikasi WHERE namaApplikasi='$app'";
        $stmt = $dbh->prepare($query);
        $stmt->execute();
        $row = $stmt->fetch();
        $idApp = $row['idApplikasi'];
        $query = "DECLARE @tmp DATETIME SET @tmp = GETDATE() EXEC insertIntoEvent_roundRobin 'buka',@tmp,$id_login,$user_PC,$idApp";
        $stmt = $dbh->prepare($query);
        if($stmt->execute()){
            $namamod = "Modal".$app;
            $_SESSION[$namamod]=true;
        }
    }
    function closeApp($app,$dbh,$id_login,$user_PC){
        $query = "SELECT idApplikasi FROM Applikasi WHERE namaApplikasi='$app'";
        $stmt = $dbh->prepare($query);
        $stmt->execute();
        $row = $stmt->fetch();
        $idApp = $row['idApplikasi'];
        $query = "DECLARE @tmp DATETIME SET @tmp = GETDATE() EXEC insertIntoEvent_roundRobin 'tutup',@tmp,$id_login,$user_PC,$idApp";
        $stmt = $dbh->prepare($query);
        if($stmt->execute()){
            $namamod = "Modal".$app;
            $_SESSION[$namamod]=false;
        }
    }
   if($_SERVER["REQUEST_METHOD"] == "POST") {
    if($_POST['action']=='Lineopen'){
        $namaApp=substr($_POST['action'],0,strlen($_POST['action'])-4);
        openApp($namaApp,$dbh,$id_login,$user_PC);
    }
    else if($_POST['action']=='Lineclose'){
        $namaApp=substr($_POST['action'],0,strlen($_POST['action'])-5);
        closeApp($namaApp,$dbh,$id_login,$user_PC);
    }
    else if($_POST['action']=='NetBeansopen'){
        $namaApp=substr($_POST['action'],0,strlen($_POST['action'])-4);
        openApp($namaApp,$dbh,$id_login,$user_PC);
    }
    else if($_POST['action']=='NetBeansclose'){
        $namaApp=substr($_POST['action'],0,strlen($_POST['action'])-5);
        closeApp($namaApp,$dbh,$id_login,$user_PC);
    }
    else if($_POST['action']=='Android Studioopen'){
        $namaApp=substr($_POST['action'],0,strlen($_POST['action'])-4);
        openApp($namaApp,$dbh,$id_login,$user_PC);
    }
    else if($_POST['action']=='Android Studioclose'){
        $namaApp=substr($_POST['action'],0,strlen($_POST['action'])-5);
        closeApp($namaApp,$dbh,$id_login,$user_PC);
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <link rel="stylesheet" href="css/user.css">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
    <div class="all">
    <div class="desktop">
    <?php
    $query = "SELECT idApplikasi,namaApplikasi,directoyLogoApplikasi FROM Applikasi";
    $stmt = $dbh->prepare($query);
    $stmt->execute();
    $stmt->setFetchMode(PDO::FETCH_ASSOC);
    while($row = $stmt->fetch()) {
        ?>
    <div class="app" style="margin-left:-11px;">

    <form action="" method="post">
            <input id="<?php echo $row['namaApplikasi']?>" type="hidden" name="action" value="<?php echo $row['namaApplikasi'].'open'?>">
            <input type="image"  src="<?php echo $row['directoyLogoApplikasi'] ?>" class="butImg" alt="submit"> </br>
            <?php 
                echo $row['namaApplikasi'].'</br>';
                $nameModal="Modal".$row['namaApplikasi'];
                if(!isset($_SESSION[$nameModal])){
                    $_SESSION[$nameModal]=false;
                }
                if($_SESSION[$nameModal]){
            ?>


    <div id="Modal<?php echo $row['namaApplikasi']?>" class="modal">
        <!-- Modal content -->
        <div class="modal-content">
        <input id="<?php echo "close".$row['namaApplikasi']?>" type="hidden" name="action" value="<?php echo $row['namaApplikasi'].'close'?>">
        <input type="image" src="images/x.png" alt="submit" class="close">
        <p>this is <?php echo $row['namaApplikasi']?></p>
        </div>

    </div>



    <?php
        }
    ?>
    </form>


    </div>
    <?php
        
    }
    
    ?>
    <div style="float:right;width:18%;margin-top:-15%;margin-right:2%" class="w3-container w3-white w3-right w3-card-1 "><?php
        $query = "SELECT TOP 1 waktu FROM Event WHERE aksi='login' AND idUser =".$id_login." AND idKomputer=".$user_PC." ORDER BY waktu desc";
        $stmt = $dbh->prepare($query);
        $stmt->execute();
        $stmt->setFetchMode(PDO::FETCH_NUM);
        $row = $stmt->fetch();
        $waktu=$row[0];
        $dt = new DateTime('now', new DateTimezone('Asia/Jakarta'));
        $waktuNow =$dt->format("Y-m-d H:i:s");
    ?>
    
    <header  class="w3-container w3-red">
            <h2>Durasi Penggunaan Komputer</h2>
            </header>
            <div class="w3-container w3-centered">
    <h3 style="text-align:center"><?php 
        
        echo gmdate("H:i:s", strtotime($waktuNow)-strtotime($waktu));
    
    ?></h3>
</div>
    </div>
    </div>
    <div class="navbar" style="height:10%">
    <ul style="list-style-type: none;width:95%; height:100%;margin-bottom:5%;">
        <li style="height:100%; display:inline-block;font-size:30px"> <button style="" id="myBtn"><i class="fa fa-windows"></i></button></li>
        <li style=" display:inline-block; float :right;">
            <div id="time">
               <h5 style="color:white;"> 00 : 00  PM </h5>
            </div>
         </li>
        <li style=" display:inline-block; float:right;margin-right:-6%;margin-top:1%"><h5 style="color:white"><?php echo date('d-M-y');?></h5>"</li>
    </ul>

        <div id="windows" class="modal2">
        <!-- Modal content -->
        <div class="modal-content2" style="">
            <span class="close">&times;</span>
            <p> <li style=" display:inline-block;"><h2><i class="fa fa-sign-out"></i><a href = "logout.php" style="text-decoration:none;color:black">Sign Out</a></h2></li></p>
        </div>
        </div>
    
    </div>
    </div>
</body>

<script>
//jam
$(document).ready(function(){
    setInterval(function(){
        $('#time').load('time.php')
    }),1000});
// Get the modal
var modal = document.getElementById('windows');
// Get the button that opens the modal
var btn = document.getElementById("myBtn");
// Get the <span> element that closes the modal
var span = document.getElementsByClassName("close")[0];
// When the user clicks on the button, open the modal 
btn.onclick = function() {
  modal.style.display = "block";
}
// When the user clicks on <span> (x), close the modal
span.onclick = function() {
  modal.style.display = "none";
}
// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
  if (event.target == modal) {
    modal.style.display = "none";
  }
}

var h1 = document.getElementsByTagName('h3')[0],text =h1.innerHTML,
    seconds = parseInt(text.substring(6,text.length),10), minutes = parseInt(text.substring(3,5),10), hours = parseInt(text.substring(0,2),10),
    t;
console.log(text);
console.log(seconds);
console.log(minutes);
console.log(hours);

function add() {
    seconds++;
    if (seconds >= 60) {
        seconds = 0;
        minutes++;
        if (minutes >= 60) {
            minutes = 0;
            hours++;
        }
    }
    
    h1.textContent = (hours ? (hours > 9 ? hours : "0" + hours) : "00") + ":" + (minutes ? (minutes > 9 ? minutes : "0" + minutes) : "00") + ":" + (seconds > 9 ? seconds : "0" + seconds);

    timer();
}
function timer() {
    t = setTimeout(add, 1000);
}
timer();


/* Start button */
start.onclick = timer;

/* Stop button */
stop.onclick = function() {
    clearTimeout(t);
}

/* Clear button */
clear.onclick = function() {
    h1.textContent = "00:00:00";
    seconds = 0; minutes = 0; hours = 0;
}
</script>

</html>