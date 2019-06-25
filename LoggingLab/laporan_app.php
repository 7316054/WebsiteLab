<?php include('header.php');
include('session.php');

function secToHR($seconds) {
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
            <h1> Generate Laporan </h1>
            </header>

            <div class="w3-container">
                <p>Fungsi yang berperan untuk mencari penggunaan applikasi pada tanggal tertentu dan bulan tertentu dan mencari applikasi yang paling sering dan jarang digunakan pada tanggal tertentu
                </p>
            </div>

            
            <input style="width:95%;margin-left:2%;"class="w3-input w3-center" name="date" type="date" >
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
        $query = "exec agregasikanApplikasiPerEvent  ";
        $stmt = $dbh->prepare($query);
        if($stmt->execute()){
        }
        $query ="exec agregasikanApplikasiHarian '".$_POST['date']."'";
        $stmt = $dbh->prepare($query);
        if($stmt->execute()){
        }
        $query ="exec agregasikanTabelApplikasiBulanan '".$_POST['date']."'";
        $stmt = $dbh->prepare($query);
        if($stmt->execute()){
        }
        $query = "SELECT count(*)
        FROM Applikasi LEFT JOIN AgregasiApplikasiHarian ON Applikasi.idApplikasi = AgregasiApplikasiHarian.idApplikasi
        WHERE tanggal = '$tanggal'
        GROUP BY namaApplikasi
        ORDER BY SUM(durasi) desc
        ";
        $stmt = $dbh->prepare($query);
        if($stmt->execute()){
        }
    if($stmt->fetchColumn()>0){
        echo '<h2>Applikasi Yang Paling Sering Digunakan Pada Tanggal : '.date('l d F, Y', strtotime($_POST['date'])).'</h2>';
        $query = "SELECT TOP 1 namaApplikasi,SUM(durasi)
        FROM Applikasi JOIN AgregasiApplikasiHarian ON Applikasi.idApplikasi = AgregasiApplikasiHarian.idApplikasi
        WHERE tanggal = '$tanggal'
        GROUP BY namaApplikasi
        ORDER BY SUM(durasi) desc
        ";
    $stmt = $dbh->prepare($query);
    if($stmt->execute()){
    }

    ?>
    <table class="w3-table-all w3-hoverable w3-centered">
    <thead>
    <tr class="w3-red">
        <th>Nama Aplikasi</th>
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
    }?>
    </table>
    <?php echo '<h2>Applikasi Yang Paling Jarang Digunakan Pada Tanggal : '.date('l d F, Y', strtotime($_POST['date'])).'</h2>';
        $query = "SELECT TOP 1 namaApplikasi,amount
FROM (
SELECT namaApplikasi,tanggal,sum(durasi)as amount
FROM Applikasi LEFT JOIN AgregasiApplikasiHarian ON Applikasi.idApplikasi = AgregasiApplikasiHarian.idApplikasi
GROUP BY namaApplikasi,tanggal
) AS T1
WHERE tanggal='$tanggal' OR tanggal IS NULL
ORDER BY amount asc
        ";
    $stmt = $dbh->prepare($query);
    if($stmt->execute()){
    }

    ?>
    <table class="w3-table-all w3-hoverable w3-centered">
    <thead>
    <tr class="w3-red">
        <th>Nama Aplikasi</th>
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
    }?>
    </table>
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
        echo '<h2>Penggunaan Applikasi Pada Tanggal : '.date('l d F, Y', strtotime($_POST['date'])).'</h2>';
        $tanggal = $_POST['date'];
        
        $query = "SELECT namaApplikasi,amount
FROM (
SELECT namaApplikasi,tanggal,sum(durasi)as amount
FROM Applikasi LEFT JOIN AgregasiApplikasiHarian ON Applikasi.idApplikasi = AgregasiApplikasiHarian.idApplikasi
GROUP BY namaApplikasi,tanggal
) AS T1
WHERE tanggal='$tanggal' OR tanggal IS NULL
ORDER BY amount desc";
    $stmt = $dbh->prepare($query);
    
    if($stmt->execute()){
    }
    ?>
    <table class="w3-table-all w3-hoverable w3-centered">
    <thead>
    <tr class="w3-red">
        <th>Nama Aplikasi</th>
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
        FROM Applikasi JOIN AgregasiApplikasiBulanan ON Applikasi.idApplikasi = AgregasiApplikasiBulanan.idApplikasi
        WHEre bulan=DATEPART(MONTH,'$tanggal') AND tahun=DATEPART(YEAR,'$tanggal')
        GROUP BY namaApplikasi";
        $stmt = $dbh->prepare($query);
        if($stmt->execute()){
        }
        if($stmt->fetchColumn()){
            echo '<h2>Applikasi Yang Paling Sering Digunakan  Pada Bulan : '.date('F, Y', strtotime($_POST['date'])).'</h2>';
        $query = "SELECT TOP 1 namaApplikasi,SUM(durasi)
        FROM Applikasi JOIN AgregasiApplikasiBulanan ON Applikasi.idApplikasi = AgregasiApplikasiBulanan.idApplikasi
        WHERE bulan=DATEPART(MONTH,'$tanggal') AND tahun=DATEPART(YEAR,'$tanggal')
        GROUP BY namaApplikasi
        ORDER BY SUM(durasi) desc
        ";
    $stmt = $dbh->prepare($query);
    if($stmt->execute()){
    }

    ?>
    <table class="w3-table-all w3-hoverable w3-centered">
    <thead>
    <tr class="w3-red">
        <th>Nama Aplikasi</th>
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
    }?>
    </table>
    <?php
    echo '<h2>Applikasi Yang Paling Jarang Digunakan  Pada Bulan : '.date('F, Y', strtotime($_POST['date'])).'</h2>';
    $query = "SELECT TOP 1 namaApplikasi,amount
FROM (
SELECT namaApplikasi,bulan,tahun,sum(durasi)as amount
FROM Applikasi LEFT JOIN AgregasiApplikasiBulanan ON Applikasi.idApplikasi = AgregasiApplikasiBulanan.idApplikasi
GROUP BY namaApplikasi,bulan,tahun
) AS T1
WHERE (bulan=DATEPART(MONTH,'$tanggal') AND tahun=DATEPART(YEAR,'$tanggal') ) OR (bulan is null AND tahun IS null)
ORDER BY amount asc
    ";
$stmt = $dbh->prepare($query);
if($stmt->execute()){
}

?>
<table class="w3-table-all w3-hoverable w3-centered">
<thead>
<tr class="w3-red">
    <th>Nama Aplikasi</th>
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
}?>
</table>
<?php
        echo '<h2>Penggunaan Applikasi Pada Bulan : '.date('F, Y', strtotime($_POST['date'])).'</h2>';
        echo '<br>';
        $tanggal = $_POST['date'];
        $query = "SELECT namaApplikasi,amount
        FROM (
        SELECT namaApplikasi,bulan,tahun,sum(durasi)as amount
        FROM Applikasi LEFT JOIN AgregasiApplikasiBulanan ON Applikasi.idApplikasi = AgregasiApplikasiBulanan.idApplikasi
        GROUP BY namaApplikasi,bulan,tahun
        ) AS T1
        WHERE (bulan=DATEPART(MONTH,'$tanggal') AND tahun=DATEPART(YEAR,'$tanggal') ) OR (bulan is null AND tahun IS null)
        ORDER BY amount desc";
        $stmt = $dbh->prepare($query);
        if($stmt->execute()){
        }

        ?>
        <table class="w3-table-all w3-hoverable w3-centered">
        <thead>
        <tr class="w3-red">
        <th>Applikasi</th>
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