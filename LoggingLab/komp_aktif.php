<?php include('header.php');
include('session.php');
?>

<div class="w3-container w3-white w3-center adminContainer w3-padding">
    <br>
    <br>
    <br>
    <br>
<?php  
$query = "SELECT namaKomputer,status
FROM Komputer
        ";
    $stmt = $dbh->prepare($query);
    if($stmt->execute()){
    }

    ?>
    <table class="w3-table-all w3-hoverable w3-centered">
    <thead>
    <tr class="w3-red">
        <th>Nama Komputer</th>
        <th>Status</th>
    </tr>
    </thead>
    <?php 
    $stmt->setFetchMode(PDO::FETCH_NUM);
    while($row = $stmt->fetch()) {
        $stat = $row[1];
        if($stat==0){
            $stat="Tidak Aktif";
        }
        else{
            $stat="Aktif";
        }
        echo "<tr>
        <td>".$row[0]."</td>
        <td>".$stat."</td>
      </tr>";
    }?>
    </table>
</div>
<div class="w3-bottom w3-padding" style="width:10%">
<a href="report.php"> <button class="w3-btn w3-border w3-large w3-teal" href><i class="fa fa-arrow-left" style="float:left"></i> Back</button></a>
</div>
<?php 
    include('footer.php'); 
?>