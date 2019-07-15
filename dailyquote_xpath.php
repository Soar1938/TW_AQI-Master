<?PHP
header("Content-Type:text/html; charset=utf-8");
#date_default_timezone_set("Asia/Taipei");

//	http://localhost/dailyquote_xpath.php

$htmlStr = "https://tw.appledaily.com/index/dailyquote/";
$url_page = file_get_contents($htmlStr);
$url_page = mb_convert_encoding($url_page, 'html-entities', 'utf-8');  //轉編碼


$dom = new DOMDocument();
@$dom->loadHTML($url_page);

$xpath = new DOMXPath($dom);

$nodeTxt	= $xpath->query('//*[@id="maincontent"]/div[2]/article/p');
$nodeH1		= $xpath->query('//*[@id="maincontent"]/div[2]/article/h1/text()');
$nodeTime	= $xpath->query('//*[@id="maincontent"]/div[2]/article/h1/time');

$Data = array();

foreach ($nodeTxt as $a){
	$Txt = trim($a->nodeValue);
	$Data[0]["Txt"] = $Txt;
}

foreach ($nodeH1 as $b){
	$Title = trim($b->nodeValue);
	$Data[0]["Title"] = $Title;
}

foreach ($nodeTime as $c){
	$Time = trim($c->nodeValue);
	$Data[0]["Time"] = $Time;
}

print json_encode($Data, JSON_UNESCAPED_UNICODE);
?>