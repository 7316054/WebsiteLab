<?php include('header.php');
include('session.php');function secToHR($seconds) {
    $hours = floor($seconds / 3600);
    $minutes = floor(($seconds / 60) % 60);
    $seconds = $seconds % 60;
    return "$hours jam : $minutes menit : $seconds detik";
  }
?>

<div class="w3-container w3-white w3-center adminContainer w3-padding">
<form action="" method="POST">
<div class="w3-container w3-padding-24">
            <div class="w3-card-4" style="width:100%">
            <header class="w3-container w3-red">
            <h1> Generate Laporan  </h1>
            </header>

            <div class="w3-container">
                <p>Fungsi yang berperan untuk mencari user yang menggunakan lab lebih dari 7 jam per minggu, pada bulan tertentu
                </p>
            </div>

            
            <input style="width:95%;margin-left:2%;"class="w3-input w3-center" name="date"  type="date" >
             <button type="submit" class="w3-panel w3-card w3-blue-grey ubl w3-btn" name="btn_rekap" style="width:95%;margin-left:2%" >
                <p style="height:100%;">CARI</p>
            </button>
                
             </div>
        </div>
</form>


<?php
    if(isset($_POST['date']) && $_POST['date']!=""){
        $togg=false;
        $tanggal = $_POST['date'];
        $query = "exec agregasikanApplikasiPerEvent exec agregasikanApplikasiHarian '".$_POST['date']."' exec agregasikanTabelApplikasiBulanan '".$_POST['date']."'";
            
        $stmt = $dbh->prepare($query);
        if($stmt->execute()){
        }
        echo '<h2>User Yang Menggunakan Lab Lebih dari 7 jam per minggu pada bulan : '.date('F, Y', strtotime($_POST['date'])).'</h2>';
        $query = "select  nama,sum(durasi)
        from AgregasiKomputerBulanan JOIN UserLab ON AgregasiKomputerBulanan.idUser = UserLab.idUser
        WHEre bulan=DATEPART(MONTH,'$tanggal') AND tahun=DATEPART(YEAR,'$tanggal')
        GROUP BY nama
        HAVING sum(durasi)>3600*28
        ";
    $stmt = $dbh->prepare($query);
    if($stmt->execute()){
    }

    ?>
    <table class="w3-table-all w3-hoverable w3-centered">
    <thead>
    <tr class="w3-red">
        <th>Nama User</th>
        <th>Durasi</th>
    </tr>
    </thead>
    <?php 
    $stmt->setFetchMode(PDO::FETCH_NUM);
    while($row = $stmt->fetch()) {
        $waktu = $row[1]/4;
        echo "<tr>
        <td>".$row[0]."</td>
        <td>".secToHR($waktu)."</td>
      </tr>";
    }?>
    </table>
    <?php
        $query = "select COUNT(*)
from AgregasiKomputerHarian JOIN UserLab ON AgregasiKomputerHarian.idUser = UserLab.idUser
WHEre AgregasiKomputerHarian.idUser iS NOT NULL and tanggal='$tanggal'
GROUP BY nama,tanggal
        ";
        $stmt = $dbh->prepare($query);
        if($stmt->execute()){
        }
    if($stmt->fetchColumn()>0){?>
    <?php
        
    }
    else{
        echo '<hr>
        <br>
        <br>
        <br>
        <br>';
        ?>
        <div class="w3-card-4" style="width:100%">
            <header class="w3-container w3-red">
        <?php
        echo '<h2>Tidak ada aktivitas pada tanggal : '.date('l d F, Y', strtotime($_POST['date'])).'</h2>';
        ?>
        
        </header>
        </div>
        <?php
        $togg = true;
        echo '
        <br>
        <br>
        <br>
        <br>
        <hr>
        <br>';
    }
    if(!$togg){
        echo '<h2>Penggunaan Lab Oleh User Pada Tanggal : '.date('l d F, Y', strtotime($_POST['date'])).'</h2>';
        $tanggal = $_POST['date'];
        
        $query = "select nama,sum(durasi)
        from AgregasiKomputerHarian JOIN UserLab ON AgregasiKomputerHarian.idUser = UserLab.idUser
        WHEre AgregasiKomputerHarian.idUser iS NOT NULL and tanggal='$tanggal'
        GROUP BY nama,tanggal";
    $stmt = $dbh->prepare($query);
    
    if($stmt->execute()){
    }
    ?>
    <table class="w3-table-all w3-hoverable w3-centered">
    <thead>
    <tr class="w3-red">
        <th>Nama User</th>
        <th>Durasi</th>
    </tr>
    </thead>
    <?php 
    $stmt->setFetchMode(PDO::FETCH_NUM);
    while($row = $stmt->fetch()) {
        $waktu = $row[1];
        echo "<tr>
        <td>".$row[0]."</td>
        <td>".secToHR($waktu)."</td>
      </tr>";
    }
?>
</table>

<?php
    }

        
        $query = "select COUNT(*)
        from AgregasiKomputerBulanan JOIN UserLab ON AgregasiKomputerBulanan.idUser = UserLab.idUser
        WHEre bulan=DATEPART(MONTH,'$tanggal') AND tahun=DATEPART(YEAR,'$tanggal')
        GROUP BY nama,AgregasiKomputerBulanan.idKomputer";
        $stmt = $dbh->prepare($query);
        if($stmt->execute()){
        }
        if($stmt->fetchColumn()>0){
            
        echo '<h2>Penggunaan Lab oleh User Pada Bulan : '.date('F, Y', strtotime($_POST['date'])).'</h2>';
        echo '<br>';
        $tanggal = $_POST['date'];
        $query = "select nama,sum(durasi)
        from AgregasiKomputerBulanan JOIN UserLab ON AgregasiKomputerBulanan.idUser = UserLab.idUser
        WHEre bulan=DATEPART(MONTH,'$tanggal') AND tahun=DATEPART(YEAR,'$tanggal')
        GROUP BY nama";
        $stmt = $dbh->prepare($query);
        if($stmt->execute()){
        }

        ?>
        <table class="w3-table-all w3-hoverable w3-centered">
        <thead>
        <tr class="w3-red">
        <th>Nama User</th>
        <th>Durasi</th>
        </tr>
        </thead>
        <?php 
        $stmt->setFetchMode(PDO::FETCH_NUM);
        while($row = $stmt->fetch()) {
            $waktu = $row[1];
            echo "<tr>
            <td>".$row[0]."</td>
            <td>".secToHR($waktu)."</td>
            </tr>";
            
        }
    }
    else{
        echo '
        <br>
        <br>
        <br>
        <br>';
        ?>
        <div class="w3-card-4" style="width:100%">
            <header class="w3-container w3-red">
        <?php
        echo '<h2>Tidak ada aktivitas pada Bulan : '.date('F, Y', strtotime($_POST['date'])).'</h2>';
        ?>
        
        </header>
        </div>
        <?php
        $togg = true;
        echo '
        <br>
        <br>
        <br>
        <br>
        <hr>
        <br>';
    }
}
?>
</table>

</div>
    <br>
    <br>
    <br>
    <br>
<div class="w3-bottom w3-padding" style="width:10%">
<a href="report.php"> <button class="w3-btn w3-border w3-large w3-teal" href><i class="fa fa-arrow-left" style="float:left"></i> Back</button></a>
</div>
<?php 
    include('footer.php'); 
?>