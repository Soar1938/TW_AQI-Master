<?PHP
set_time_limit(0); 
header("Content-Type:text/html; charset=utf-8");
date_default_timezone_set("Asia/Taipei");

//	http://localhost/dailyquote_xpath.php

$htmlStr = "https://tw.appledaily.com/index/dailyquote/";
$url_page = file_get_contents($htmlStr);


$dom = new DOMDocument();
@$dom->loadHTML($url_page);

$xpath = new DOMXPath($dom);

$nodeTxt	= $xpath->query('//*[@id="maincontent"]/div[2]/article/p');
$nodeH1		= $xpath->query('//*[@id="maincontent"]/div[2]/article/h1/text()');
$nodeTime	= $xpath->query('//*[@id="maincontent"]/div[2]/article/h1/time');

$Data = array();

foreach ($nodeTxt as $a){
	$Txt = trim($a->nodeValue);
	$Data["txt"] = $Txt;	
}

foreach ($nodeH1 as $b){
	$Title = trim($b->nodeValue);
	$Data["Title"] = $Title;	
}

foreach ($nodeTime as $c){
	$Time = trim($c->nodeValue);
	$Data["Time"] = $Time;	
}

print json_encode($Data);
?>