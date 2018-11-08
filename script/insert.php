<?php
function repartition(&$array, $column, $value)
{
	$count_a = 0;
	$count_b = 0;
	
	foreach ($array as &$e)
	{
		if ($e[$column] == $value)
		{
			++$count_a;
		}
		else
		{
			++$count_b;
		}
	}
	
	$index = 0;
	
	for ($i = $count_a; $i <= $count_b; ++$i)
	{
		$index = $index % $count_a;
		$array[] = $array[$index];
		++$index;
	}
}

$dsn = 'mysql:dbname=datawarehouse;host=localhost;charset=utf8';
$user = 'root';
$password = '';

try
{
	$pdo = new PDO($dsn, $user, $password);
	$pdo->setAttribute(PDO::ATTR_FETCH_TABLE_NAMES, true);
}
catch (PDOException $e)
{
	echo $e->getMessage();
}

$count_lines = 42;

$sql_date = "SELECT id
	FROM date_t";

$sql_time = "SELECT id
	FROM time_t";

$sql_vl = "SELECT vehicle.id, line.id, line.num_line, line.type_vehicle
	FROM vehicle, line
	WHERE line.type_vehicle = vehicle.type
	ORDER BY line.id ASC";

$sql_s = "SELECT LOWER(name), id
	FROM station";

$sql_t = "SELECT id, anonymous
	FROM traveler
	ORDER BY id ASC";

$query_date = $pdo->query($sql_date);
$query_time = $pdo->query($sql_time);
$query_vl = $pdo->query($sql_vl);
$query_s = $pdo->query($sql_s);
$query_t = $pdo->query($sql_t);

$date = $query_date->fetchAll(PDO::FETCH_ASSOC);
$time = $query_time->fetchAll(PDO::FETCH_ASSOC);
$vl = $query_vl->fetchAll(PDO::FETCH_ASSOC);
$s = $query_s->fetchAll(PDO::FETCH_KEY_PAIR);
$t = $query_t->fetchAll(PDO::FETCH_ASSOC);

$count_date = count($date);
$count_time = count($time);
$count_vl = count($vl);
$count_t = count($t);

$stations = array();

for ($i = 1; $i < $count_lines; ++$i)
{
	$stations[$i] = array();
}

$tam_json = json_decode(file_get_contents("./arrets.json"));

foreach ($tam_json as &$tam_obj)
{
	$station_name = mb_strtolower($tam_obj->libelle);
	$station_name = str_replace("(", "", $station_name);
	$station_name = str_replace(")", "", $station_name);
	$station_lines = strtolower($tam_obj->lines);
	$temp = explode("-", $station_lines);
	
	foreach ($temp as &$e)
	{
		$e = trim($e);
		$e = str_replace("(", "", $e);
		$e = str_replace(")", "", $e);
		
		if ($e == "la navette")
		{
			$e = 13;
		}
		if ($e == "la ronde")
		{
			$e = 15;
		}
		else if (!is_numeric($e) || $e > "42" || !isset($s[$station_name]))
		{
			continue;
		}
		
		$num_line = intval($e);
		$stations[$num_line][] = $station_name;
	}
}

repartition($vl, "line.type_vehicle", "tram");
repartition($t, "traveler.anonymous", "1");

array_chunk($date);
array_chunk($time);
array_chunk($vl);
array_chunk($t);

for ($i = 1; $i < 2000; ++$i)
{
	$rand_date = mt_rand(0, $count_date - 1);
	$rand_time = mt_rand(0, $count_time - 1);
	$rand_vl = mt_rand(0, $count_vl - 1);
	$rand_t = mt_rand(0, $count_t - 1);
	
	$line_num = $vl[$rand_vl]["line.num_line"];
	$associate_stations = $stations[$line_num];
	$count_s = count($associate_stations);
	$rand_s = mr_rand(0, $count_s - 1);
	
	$transaction_id = $i;
	$date_id = $date[$rand_date]["date_t.id"];
	$time_id = $date[$rand_time]["time_t.id"];
	$vehicle_id = $vl[$rand_vl]["vehicle.id"];
	$line_id = $vl[$rand_vl]["line.id"];
	$traveler_id = $vl[$rand_t]["traveler.id"];
	$station_id = $associate_stations[$rand_s];
	
	$insert = "INSERT INTO Travel VALUES(" . $transaction_id . ", " . $date_id . ", " . $time_id . ", " . $traveler_id . ", " . $line_id . ", " . $station_id . ", " . $vehicle_id . ");";
	echo $insert;
}
