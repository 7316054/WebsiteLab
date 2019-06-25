<?php include('header.php');
include('session.php');
?>

<div class="w3-container w3-white w3-center adminContainer w3-padding">
<form action="" method="POST">
<!-- Rekap Data Hari ini  -->
<div class="w3-container w3-padding-24">
            <div class="w3-card-4" style="width:100%">
            <header class="w3-container w3-red">
            <h1> Cari Aplikasi Yang Digunakan User  </h1>
            </header>

            <div class="w3-container">
                <p>Fungsi yang berperan untuk mencari aplikasi yang digunakan user sesuai dengan tanggal yang dimasukkan.
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
        $query = "exec agregasikanApplikasiPerEvent exec agregasikanApplikasiHarian '".$_POST['date']."' exec agregasikanTabelApplikasiBulanan '".$_POST['date']."'";
        
        $stmt = $dbh->prepare($query);
        if($stmt->execute()){
        }
        $query = "exec agregasikanApplikasiHarian '".$_POST['date']."'";
        
        $stmt = $dbh->prepare($query);
        if($stmt->execute()){
        }
        $query = "exec agregasikanTabelApplikasiBulanan '".$_POST['date']."'";
        
        $stmt = $dbh->prepare($query);
        if($stmt->execute()){
        }
        $query = "SELECT COUNT(*) FROM AgregasiApplikasiHarian WHERE idUser IS NOT NULL AND tanggal='".$_POST['date']."' ";
        $stmt = $dbh->prepare($query);
        if($stmt->execute()){
        }
        
        if($stmt->fetchColumn()>0){
            echo '<h2>Aplikasi Yang Digunakan User Pada Tanggal : '.date('l d F, Y', strtotime($_POST['date'])).'</h2>';
            
        $query = "SELECT DISTINCT nama,namaApplikasi
        FROM AgregasiApplikasiHarian JOIN Applikasi ON AgregasiApplikasiHarian.IdApplikasi = Applikasi.IdApplikasi
            JOIN UserLab ON AgregasiApplikasiHarian.IdUser = UserLab.IdUser
        WHERE AgregasiApplikasiHarian.idUser IS NOT NULL AND tanggal='".$_POST['date']."'
        GROUP BY nama,namaApplikasi,AgregasiApplikasiHarian.idUser
        ORDER BY nama,namaApplikasi
        ";
        $stmt = $dbh->prepare($query);
        if($stmt->execute()){
        }
        ?>
        <table class="w3-table-all w3-hoverable w3-centered">
        <thead>
        <tr class="w3-red">
            <th>IdUser</th>
            <th>Nama Aplikasi</th>
        </tr>
        </thead>
        <?php 
        $stmt->setFetchMode(PDO::FETCH_NUM);
        while($row = $stmt->fetch()) {
            echo "<tr>
            <td>".$row[0]."</td>
            <td>".$row[1]."</td>
          </tr>";
        }
    ?>
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
}
?>
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