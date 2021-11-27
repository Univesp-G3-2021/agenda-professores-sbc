<?php
class DB{
	//private $servername = ini_get('mysqli.default_host');
	//private $username = ini_get('mysqli.default_user');
	//private $password = ini_get('mysqli.default_pw');
	//private $database = ini_get('mysqli.default_user');
	private $conn = null;

	public function getConn(){
		if(is_null($this->conn)){
			$this->conn = new mysqli(ini_get('mysqli.default_host'), ini_get('mysqli.default_user'), ini_get('mysqli.default_pw'), ini_get('mysqli.default_user'));
			if ($this->conn->connect_errno) {
				error_log("Failed to connect to MySQL: ".$this->conn->connect_error, 0);
			}
		}
		return $this->conn;
	}

}

class MySQL{

	public static function query($query){
		$db = new DB();
		$res = $db->getConn()->query($query);
		$ret = $res ? $res->fetch_all(MYSQLI_ASSOC) : null;
		if($res!=false) try{ $res->free_result(); } catch(Exception $e){ error_log($e); }
		try{ $db->close(); } catch(Exception $e){ error_log($e); }
		return $ret;
	}

	public static function update($query){
		$db = new DB();
		$res = $db->getConn()->query($query);
		$ret = $db->affected_rows;
		try{ $db->close(); } catch(Exception $e){ error_log($e); }
		return $ret;
	}

}

?>
