<?php include('header.php');
 if(isset($_POST['btn_report'])){
    header('location:report.php');	
    }
    if(isset($_POST['btn_manage'])){
        header('location:manage.php');	
     }
?>

<form action="" method="POST">
<!-- GO TO LAPORAN  -->
<div class="w3-container w3-padding-24 w3-left">
            <div class="w3-card-4" style="width:50em;">
            <header class="w3-container w3-blue">
            <h1> REPORT </h1>
            </header>

            <div class="w3-container">
                <p>Halaman Yang berisikan Laporan-laporan mengenai Lab</p>
             </div>

             <button type="submit" class="w3-panel w3-card w3-blue-grey ubl w3-btn" name="btn_report" style="width:95%;margin-left:2%" >
                <p style="height:100%;">GO TO THIS PAGE</p>
            </button>
                
             </div>
        </div>

<!-- GO TO Manage -->
<div class="w3-container w3-padding-24 w3-left">
            <div class="w3-card-4" style="width:50em;">
            <header class="w3-container w3-red">
            <h1> MANAGE </h1>
            </header>
            <div class="w3-container">
                <p>Halaman untuk melakukan agregasi event pada lab</p>
             </div>
             <button type="submit" class="w3-panel w3-card  w3-blue-grey ubl w3-btn" name="btn_manage" style="width:95%;margin-left:2%" >
                <p style="height:100%;">GO TO THIS PAGE</p>
            </button>
                
             </div>
        </div>
</form>

<?php include('footer.php');
?>