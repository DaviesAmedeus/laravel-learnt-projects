<?php 

    $conn=mysqli_connect('localhost','root','','shabni') or die("Failed to connect");

    if(isset($_POST['submit']))
    {

    $name=$_POST['name'];
    $gender=$_POST['gender'];
    $email=$_POST['email'];
    $phone=$_POST['phone'];


     $var="INSERT INTO `shabni1`(`id`, `name`, `gender`, `email`, `phone`) VALUES ('','$name','$gender','$email','$phone')";

    mysqli_query($conn,$var);

     if($var)
     {
     	echo " Thank your information has been submitted";     }
    
   

    else
    {
  	   echo "Data not inserted
  	   ";     }

    }
    








 ?>






<DOCTYPES.!DOCTYPE html>
<html>
<head>
	<title>Comment</title>
	<style type="text/css">
		{
			background-color: brown;
		}
		
		input
		{
			text-align: center;
		}

	</style>
</head>

<body style="background-color:brown; font-size: 20px; text-align: center;" >
	

	<h4>Please leave a comment and we will notify you soon after getting your request</h4>
	<form action="" method="POST">
	Name : <input type="text" name="name"required><br><br>
	Gender :

	<input type="radio" name="gender" value="male"required>Male
	<input type="radio" name="gender" value="female"required>Female<br><br>
     Email :
     <input type ="email" name="email"required><br><br>
	Phone no :
		<select name="phoneCode"required>
			<option select hidden value="">Select Code</option>
			<option value="255">255</option>
         <option value="254">254</option>
         <option value="256">256</option>
         <option value="257">257</option>
         <option value="258">258</option>
         <option value="259">259</option>>
		</select>
		<input type="phone" name="phone"required><br><br>
		comment:
		<input type ="Request commodities" name="request o"required commodities><br><br>
	<input type="submit" name="submit" value="Submit">
</form>
</body>
</html>