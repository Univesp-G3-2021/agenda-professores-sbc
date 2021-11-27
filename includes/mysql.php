<?php
class DB{
	private $conn = null;

	public function getConn(){
		if(is_null($this->conn)){
			$servername = ini_get('mysqli.default_host');
			$username = ini_get('mysqli.default_user');
			$password = ini_get('mysqli.default_pw');
			$database = ini_get('mysqli.default_user');
			$this->conn = new mysqli($servername, $username, $password, $database);
			if ($this->conn->connect_errno) {
				error_log("Failed to connect to MySQL: ".$this->conn->connect_error, 0);
				exit();
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
