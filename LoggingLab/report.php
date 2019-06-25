<?php include('header.php');
    if(isset($_POST['sp1'])){
    header('location:jamSibukLab.php');	
    }
    if(isset($_POST['dpk'])){
        header('location:dpk.php');	
        }
     if(isset($_POST['laporan_app'])){
         header('location:laporan_app.php');	
     }
     
    if(isset($_POST['user_rajin'])){
     header('location:user_rajin.php');	
      }
      
    if(isset($_POST['komp_aktif'])){
        header('location:komp_aktif.php');	
    }
    
    if(isset($_POST['banUser'])){
        header('location:banUser.php');	
    }
    if(isset($_POST['appUser'])){
        header('location:appUser.php');	
    }
    
    if(isset($_POST['kompUser'])){
        header('location:kompUser.php');	
    }
?>

    <div class="w3-container w3-white w3-center adminContainer w3-padding">

    <form action="" method="POST">
        <!-- Jam Sibuk -->
        <div class="w3-container w3-padding-24 w3-left">
            <div class="w3-card-4" style="width:50em;">
                <header class="w3-container w3-blue">
                <h1>Jam-Jam Sibuk Lab</h1>
                </header>

                <div class="w3-container">
                <p>Berisikan Laporan mengenai Jam-jam berapa Lab banyak digunakan</p>
                </div>

                <button type="submit" class="w3-panel w3-card w3-blue-grey ubl w3-btn" name="sp1" style="width:100%;" >
                    <p style="height:100%;">SEE RESULT</p>
                </button>
                
            </div>
        </div>

         <!-- Tingkat Penggunaan Masing-masing komputer -->
         <div class="w3-container w3-padding-24 w3-left">
            <div class="w3-card-4" style="width:50em;">
                <header class="w3-container w3-blue">
                 <h1> Detail penggunaan komputer </h1>
                </header>

                <div class="w3-container">
                 <p>Berisikan Laporan mengenai tingkat penggunaan komputer</p>
                </div>

                <button type="submit" class="w3-panel w3-card w3-blue-grey ubl w3-btn" name="dpk" style="width:100%;" >
                    <p style="height:100%;">SEE RESULT</p>
                </button>
                
            </div>
        </div>

        <!-- Aplikasi yang sering digunakan -->
        <div class="w3-container w3-padding-24 w3-left">
            <div class="w3-card-4" style="width:50em;">
                <header class="w3-container w3-blue">
                    <h1> Statistik Applikasi </h1>
                </header>

                <div class="w3-container">
                 <p>Berisikan laporan penggunaan applikasi dan applikasi yang paling sering dan jarang digunakan</p>
                </div>

                <button type="submit" class="w3-panel w3-card w3-blue-grey ubl w3-btn" name="laporan_app" style="width:100%;" >
                    <p style="height:100%;">SEE RESULT</p>
                </button>
                
            </div>
        </div>

        <!-- Pengguna-pengguna yang pengunaan labnya diatas X jam per minggu -->
        <div class="w3-container w3-padding-24 w3-left">
            <div class="w3-card-4" style="width:50em;">
            <header class="w3-container w3-blue">
            <h1> User Rajin </h1>
            </header>

            <div class="w3-container">
                <p>Berisikan laporan mengenai statistik penggunaan lab oleh user, dan laporan mengenai user yang menggunakan lab diatas 6 jam per minggu </p>
             </div>

             <button type="submit" class="w3-panel w3-card w3-blue-grey ubl w3-btn" name="user_rajin" style="width:100%;" >
                <p style="height:100%;">SEE RESULT</p>
            </button>
                
             </div>
        </div>

        <div class="w3-container w3-padding-24 w3-left">
            <div class="w3-card-4" style="width:50em;">
            <header class="w3-container w3-blue">
            <h1> Pantau Live Lab </h1>
            </header>

            <div class="w3-container">
                <p>Berisikan laporan mengenai komputer di lab yang sedang aktif dan tidak aktif pada saat ini.</p>
             </div>

             <button type="submit" class="w3-panel w3-card w3-blue-grey ubl w3-btn" name="komp_aktif" style="width:100%;" >
                <p style="height:100%;">SEE RESULT</p>
            </button>
                
             </div>
        </div>
        
        <div class="w3-container w3-padding-24 w3-left">
            <div class="w3-card-4" style="width:50em;">
            <header class="w3-container w3-blue">
            <h1> Ban User </h1>
            </header>

            <div class="w3-container">
                <p>Berisikan table daftar user yang terkena banned dan tidak terkena banned.</p>
             </div>

             <button type="submit" class="w3-panel w3-card w3-blue-grey ubl w3-btn" name="banUser" style="width:100%;" >
                <p style="height:100%;">SEE RESULT</p>
            </button>
                
             </div>
        </div>

        <div class="w3-container w3-padding-24 w3-left">
            <div class="w3-card-4" style="width:50em;">
            <header class="w3-container w3-blue">
            <h1> Applikasi Yang Digunakan User </h1>
            </header>

            <div class="w3-container">
                <p>Berisikan laporan aplikasi yang digunakan user.</p>
             </div>

             <button type="submit" class="w3-panel w3-card w3-blue-grey ubl w3-btn" name="appUser" style="width:100%;" >
                <p style="height:100%;">SEE RESULT</p>
            </button>
                
             </div>
        </div>

        <div class="w3-container w3-padding-24 w3-left">
            <div class="w3-card-4" style="width:50em;">
            <header class="w3-container w3-blue">
            <h1> Komputer Yang Pernah Digunakan User </h1>
            </header>

            <div class="w3-container">
                <p>Berisikan laporan aplikasi yang pernah digunakan user.</p>
             </div>

             <button type="submit" class="w3-panel w3-card w3-blue-grey ubl w3-btn" name="kompUser" style="width:100%;" >
                <p style="height:100%;">SEE RESULT</p>
            </button>
                
             </div>
        </div>

     </form> 
    </div>
    <br>

<!-- Kembali ke menu HOME -->
<div class="w3-bottom w3-padding" style="width:10%">
 <a href="admin.php"> <button class="w3-btn w3-border w3-large w3-teal" href><i class="fa fa-arrow-left" style="float:left"></i> Back</button></a>
</div>

<?php include('footer.php')?>