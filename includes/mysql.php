<?php
class DBConn{
	private $servername = "agenda-professores-sbc-server";
	private $username = $_SERVER["APPSETTING_mysql_user"];
	private $password = $_SERVER["APPSETTING_mysql_pswd"];
	private $database = "agenda_professores_sbc";
	private $conn = null;

	public function getConn(){
		if(is_null($this->conn)){
			$this->conn = new mysqli($this->servername, $this->username, $this->password, $this->database);
			if ($this->conn->connect_errno) {
				error_log("Failed to connect to MySQL: ".$this->conn->connect_error, 0);
			}
		}
		return $this->conn;
	}

	private static function tableExists($table) {
		$db = new DBConn();
		$res = $db->getConn()->query("SHOW TABLES LIKE $table");
		return mysql_num_rows($res) > 0;
	}
}

class DB{
	private static function createTable($table) {
		$db = new DBConn();
		return $db->getConn()->query("CREATE TABLE IF NOT EXISTS $table (id VARCHAR(13), del int, jdoc TEXT, PRIMARY KEY(id))");
	}

	public static function insert($table, $obj){
		$db = new DBConn();
		self::createTable($table);
		$uid = uniqid();
		if($obj){
			$json = addslashes(json_encode($obj));
			$q = "INSERT INTO $table (id, del, jdoc) VALUES ('$uid', 0, '$json')";
			if ($db->getConn()->query($q)){
				_log($q);
				return $uid;
			}
		}
		return null;
	}

	public static function select($table, $obj, $del=0, $limit=0, $offset=0, $orderby='last_update desc'){
		$db = new DBConn();
		if(is_array($obj)){
			$qry = "";
			foreach($obj as $key=>$val){
				$jo = str_ireplace("}","",str_ireplace("{","",json_encode(array($key => $val))));
				$qry .= " AND jdoc LIKE '%$jo%'";
			}
			if($orderby!="") $qry.=" ORDER BY ".$orderby;
			if($limit>0) $qry.=" LIMIT ".$limit;
			if($offset>0) $qry.=" OFFSET ".$offset;
			$res = $db->getConn()->query("SELECT id,jdoc,last_update FROM $table WHERE del=$del $qry");
			return $res?$res->fetch_all():null;
		}
	}

	public static function selectIn($table, $arr, $del=0, $limit=0, $offset=0, $orderby='last_update desc'){
		$db = new DBConn();
		if(is_array($arr)){
			$qry = "";
			foreach($arr as $val){
				$qry .= " AND jdoc LIKE '%$val%'";
			}
			if($orderby!="") $qry.=" ORDER BY ".$orderby;
			if($limit>0) $qry.=" LIMIT ".$limit;
			if($offset>0) $qry.=" OFFSET ".$offset;
			$res = $db->getConn()->query("SELECT id,jdoc,last_update FROM $table WHERE del=$del $qry");
			return $res?$res->fetch_all():null;
		}
	}

	public static function selectId($table, $id){
		$db = new DBConn();
		$res = $db->getConn()->query("SELECT id,jdoc,last_update FROM $table WHERE id='$id'");
		return $res?$res->fetch_all():null;
	}

	public static function query($query){
		$db = new DBConn();
		$res = $db->getConn()->query($query);
		return $res?$res->fetch_all():null;
	}

	public static function update($table, $id, $obj){
		$db = new DBConn();
		if(is_array($obj)){
			$json = addslashes(json_encode($obj));
			$q = "UPDATE $table SET jdoc='$json' WHERE id='$id'";
			$db->getConn()->query($q);
			if($db->getConn()->affected_rows==1){
				_log($q);
				return true;
			}else return false;
		}
		return false;
	}

	public static function delete($table, $id){
		$db = new DBConn();
		$q = "UPDATE $table WHERE id='$id' set del=1";
		$db->getConn()->query($q);
		if($db->getConn()->affected_rows==1){
			_log($q);
			return true;
		}else return false;
	}
	
	public static function undelete($table, $id){
		$db = new DBConn();
		$q = "UPDATE $table WHERE id='$id' set del=0";
		$db->getConn()->query($q);
		if($db->getConn()->affected_rows==1){
			_log($q);
			return true;
		}else return false;
	}
}

?>
