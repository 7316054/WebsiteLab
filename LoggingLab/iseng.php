<?php
$date = '2019-05-01';
$end = '2019-05-' . date('t', strtotime($date)); //get end date of month
?>
<table>
    <tr>
    <?php while(strtotime($date) <= strtotime($end)) {
        echo $date."<br>";
        $day_num = date('d', strtotime($date));
        $day_name = date('l', strtotime($date));
        $date = date("Y-m-d", strtotime("+1 day", strtotime($date)));
    }
    ?>
    </tr>
</table>