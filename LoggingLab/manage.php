<?php include('header.php');
include('session.php');
    if(isset($_POST['btn_rekap'])){
        $date=$_POST['date'].'-01';
        $end = $_POST['date'].'-' . date('t', strtotime($date));
        $query="exec agregasikanTabelKomputerPerEvent";
        $stmt = $dbh->prepare($query);
        if($stmt->execute()){
        }
        $query="exec agregasikanApplikasiPerEvent";
        $stmt = $dbh->prepare($query);
        if($stmt->execute()){
        }
        while(strtotime($date) <= strtotime($end)) {
            $day_num = date('d', strtotime($date));
            $day_name = date('l', strtotime($date));
            $date = date("Y-m-d", strtotime("+1 day", strtotime($date)));
            $query="exec agregasikanTabelKomputer '$date'";
            $stmt = $dbh->prepare($query);
            if($stmt->execute()){
            }
            $query="exec agregasikanApplikasiHarian '$date'";
            $stmt = $dbh->prepare($query);
            if($stmt->execute()){
            }
        }
        
        $query=" exec agregasikanTabelKomputerBulanan '$date'";
        $stmt = $dbh->prepare($query);
        if($stmt->execute()){
        }

        $query=" exec agregasikanTabelApplikasiBulanan '$date'";
        $stmt = $dbh->prepare($query);
        if($stmt->execute()){
            echo '<script language="javascript">';
            echo 'alert("Berhasil direkap")';
            echo '</script>';
        }
        
    }
    
?>

<form action="" method="POST">
<!-- Rekap Data Hari ini  -->
<div class="w3-container w3-padding-24 w3-left">
            <div class="w3-card-4" style="width:50em;">
            <header class="w3-container w3-red">
            <h1> Rekap Data Seluruh Event  </h1>
            </header>

            <div class="w3-container">
                <p>Fungsi yang berperan untuk merekap data Lab (Melakukan Agregasi Event), dimana 
                Menyimpan data-data harian ke dalam Tabel Agregasi Applikasi Per Event, Agregasi Komputer Per Event,
                Agregasi Applikasi Per Hari, Agregasi Komputer Per Hari, Agregasi Komputer Per  Bulan, dan Agregasi Applikasi Per Bulan
                </p>
            </div>

            
            <input style="width:95%;margin-left:2%;"class="w3-input w3-center" name="date" type="month" >
             <button type="submit" class="w3-panel w3-card w3-blue-grey ubl w3-btn" name="btn_rekap" style="width:95%;margin-left:2%" >
                <p style="height:100%;">REKAP</p>
            </button>
                
             </div>
        </div>
</form>


<?php include('footer.php')?>