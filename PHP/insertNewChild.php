<?php
session_start();
$con = mysqli_connect('localhost','root','ITC4602016');
if(!$con) //if connection not established
{
	die('Could not connect: '.mysqli_error($con));
}
$username = mysqli_real_escape_string($con,$_GET['childUser']);
$password = mysqli_real_escape_string($con,$_GET['childPass']);
$name = mysqli_real_escape_string($con,$_GET['cName']);
$grade = mysqli_real_escape_string($con,$_GET['cGrade']);
$EI = mysqli_real_escape_string($con,$_GET['EI']);
$OS = mysqli_real_escape_string($con,$_GET['OS']);
$LF = mysqli_real_escape_string($con,$_GET['LF']);
$AC = mysqli_real_escape_string($con,$_GET['AC']);
$PI = mysqli_real_escape_string($con,$_GET['PI']);
$CU = mysqli_real_escape_string($con,$_GET['CU']);
$PNotes = mysqli_real_escape_string($con,$_GET['PNotes']);
$Strengths = mysqli_real_escape_string($con,$_GET['Strengths']);
$Weaknesses = mysqli_real_escape_string($con,$_GET['Weaknesses']);
$MLevel = mysqli_real_escape_string($con,$_GET['MLevel']);
$Interests = mysqli_real_escape_string($con,$_GET['Interests']);
$DWorked = mysqli_real_escape_string($con,$_GET['DWorked']);
$DNWorked = mysqli_real_escape_string($con,$_GET['DNWorked']);

mysqli_select_db($con,'IDP')or die('cannot select db');

$finduser = "select * from users where username='$username' and password='$password';";
$results = mysqli_query($con,$finduser);
$count = mysqli_num_rows($results);
if($count == 1)
{
	mysqli_close($con);
	$array = ["Logged in"=>"Not Logged in","session_id"=>NULL];
	echo json_encode($array);
	session_destroy();
}
else
{
$newChild = "insert into child (username,password,name,age,grade,ExtrovertIntrovert,OutgoingShy,LeaderFollower,ActiveCalm,PlannerImpulsive,CaringUncaring,PersonalityNotes,Strengths,Weaknesses,MaturityLevel,Interests,DisciplineWorked,DisciplineNotWorked) values('$username','$password','$name','$grade','$EI','$OS','$LF','$AC','$PI','$CU','$PNotes','$Strengths','$Weaknesses','$MLevel','$Interests','$DWorked','$DNWorked');";
mysqli_query($con,$newChild)or die('error submitting to database: '.mysqli_error($con));

$latestChild = mysqli_insert_id($con);

$newBehavior = "insert into behaviors (childID,desiredBehavior,problemBehavior) values ('$latestChild',)";

mysqli_query($con,$newChild)or die('error submitting to database: '.mysqli_error($con));


mysqli_close($con);
}



?>