<?php include('header.php');
include('session.php');

if(isset($_POST['btn_ban'])){
    $query=$_POST['btn_ban'];
    $stmt = $dbh->prepare($query);
    if($stmt->execute()){
    }
}
if(isset($_POST['btn_unban'])){
    $query=$_POST['btn_unban'];
    $stmt = $dbh->prepare($query);
    if($stmt->execute()){
    }
}
?>

<div class="w3-container w3-white w3-center adminContainer w3-padding">
    <br>
    <br>
    <br>
    <br>
<?php  
$query = "SELECT idUser,nama,banned
FROM UserLab
WHERE role!='admin'
        ";
    $stmt = $dbh->prepare($query);
    if($stmt->execute()){
    }

    ?>
    
<form action="" method="POST">
    <table class="w3-table-all w3-hoverable w3-centered">
    <thead>
    <tr class="w3-red">
        <th>Nama Komputer</th>
        <th>Banned</th>
        <th>Aksi</th>
    </tr>
    </thead>
    <?php 
    $stmt->setFetchMode(PDO::FETCH_NUM);
    while($row = $stmt->fetch()) {
        $stat = $row[2];
        if($stat==0){
            $stat="Tidak";
        }
        else{
            $stat="Ya";
        }
        echo "<tr>
        <td>".$row[1]."</td>
        <td>".$stat."</td>";
        if($row[2]==0){
        echo "<td>"?><button title="Ban user ini" type="submit" name="btn_ban" value="<?php echo "UPDATE UserLab SET banned=1 WHERE idUser=".$row[0] ?>" style="width:15%;border:none;background:none;" >
        <i class="fa fa-ban"></i> </button><?php "</td>";
        }
        else{
            echo "<td>"?><button type="submit" title="Unban user ini" name="btn_unban" value="<?php echo "UPDATE UserLab SET banned=0 WHERE idUser=".$row[0] ?>" style="width:15%;border:none;background:none;" >
        <i class="fa fa-unlock"></i> </button><?php "</td>";
        }
      echo "</tr>";
    }?>
    </table>
    
    </form>
</div>
<div class="w3-bottom w3-padding" style="width:10%">
<a href="report.php"> <button class="w3-btn w3-border w3-large w3-teal" href><i class="fa fa-arrow-left" style="float:left"></i> Back</button></a>
</div>
<?php 
    include('footer.php'); 
?>