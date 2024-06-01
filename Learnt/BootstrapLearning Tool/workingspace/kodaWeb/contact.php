
<?php  ?

     $conn=mysqli_connect('localhost','root','','shabn') or die("Failed to connect");

   if(isset($_POST['submit']))
   {
     
     $name=$_POST['name'];
     $email=$_POST['email'];
     $number=$_POST['number'];
     $location=$_POST['location'];
     $product_orders =$_POST['product orders'];
     
    
     

     $var=" INSERT INTO `shabn1`(`id`, `name`, `email`, `number`, `location`, `product orders`) VALUES ('','$name','$email','$number','$location','$product orders')";

     $nam=mysqli_query($conn,$var);

  


   }



 ?>


 <!DOCTYPE html>
<html>
<head>
	<title>muhib</title>
	<meta charset="utf-8">
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <!-- mobile metas -->
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <meta name="viewport" content="initial-scale=1, maximum-scale=1">
      <!-- bootstrap css -->
      <link rel="stylesheet" href="css/bootstrap.min.css">
      <!-- style css -->
      <link rel="stylesheet" href="css/style.css">
      <!-- Responsive-->
      <link rel="stylesheet" href="css/responsive.css">
      <!-- fevicon -->
      <link rel="icon" href="images/fevicon.png" type="image/gif" />
      <!-- Scrollbar Custom CSS -->
      <link rel="stylesheet" href="css/jquery.mCustomScrollbar.min.css">
      <!-- Tweaks for older IEs-->
      <link rel="stylesheet" href="https://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css">
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fancybox/2.1.5/jquery.fancybox.min.css" media="screen">

</head>
<body>
	<div>
 		<h2 style="color: white">enter your details</h2><br>

 	</div><br>


 	<form method="POST" action="">

 		<input type="name" name="name" placeholder="Enter Your name" required=""><br><br>
 		 <input type="name" name="email" placeholder="Enter Your Email" required=""><br><br>
 	 	 <input type="name" name="number" placeholder="Enter Your phone number" required=""><br><br>
	 	<input type="name" name="location" placeholder="Enter Your Location" required=""><br><br>
 		<textarea style=" width:340px; height: 130px " name="product_orders" placeholder="product_orders " ></textarea><br><br>
 		<input type="submit" name="submit" value="submit"><br><br>
 		<a href="index.html">Click to return home</a>

 		

 	</form><br><br><br><br>
 		


              <div style="background-color: gray; text-align: center">

                <h4 style="padding-top: 50px; color: white">For more info Check us via</h4><br>
                <table>
                <td style="padding-left: 370px"><img src="image/fb.png" height="30px"><a href="https://facebook.com" style="color: white; padding-left: 10px">muhib house company</a> </td>
                 <td><img src="image/insta.jpeg" height="30px" style="padding-left: 70px"> 
                 <a href="https://instagram.com" style="color: white; padding-left: 20px">muhib house company</a></td>\
                </table>
                <br> <h5 style="color: white; padding-bottom: 50px"> +255 620749409</h5>
          </div>

</body>
</html>

