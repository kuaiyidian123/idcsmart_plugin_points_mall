<?php
namespace addons\points_mall;

class PointsMallPlugin extends \app\admin\lib\Plugin
{
    public $info = ["name" => "PointsMall", "title" => "积分商城（专业版）", "description" => "积分商城专业版支持签到，登录，购买，续费，邀请注册等任务获得积分，积分兑换，积分兑现等", "status" => 1, "author" => "陌拜QwQ", "version" => "1.0.0", "module" => "addons", "lang" => ["chinese" => "积分商城（专业版）", "chinese_tw" => "積分商城（專業版）", "english" => "Points Mall（Speciality）"]];
    public function install()
    {
        $fieldsToAddTable1 = [["name" => "id", "type" => "INT AUTO_INCREMENT PRIMARY KEY"], ["name" => "user_id", "type" => "INT NOT NULL"], ["name" => "sign_date", "type" => "DATE NOT NULL"], ["name" => "points", "type" => "INT NOT NULL"], ["name" => "total_points", "type" => "INT NOT NULL"], ["name" => "type", "type" => "INT NOT NULL"], ["name" => "source", "type" => "VARCHAR(255)"], ["name" => "billnumber", "type" => "VARCHAR(255)"], ["name" => "sign_time", "type" => "INT"], ["name" => "note", "type" => "VARCHAR(255)"], ["name" => "registerid", "type" => "VARCHAR(255)"], ["name" => "password", "type" => "VARCHAR(255)"], ["name" => "created_at", "type" => "TIMESTAMP DEFAULT CURRENT_TIMESTAMP"], ["name" => "updated_at", "type" => "TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"]];
        $fieldsToAddTable2 = [["name" => "id", "type" => "INT AUTO_INCREMENT PRIMARY KEY"], ["name" => "open", "type" => "INT"], ["name" => "exchange", "type" => "INT"], ["name" => "withdrawal", "type" => "INT"], ["name" => "realname", "type" => "INT"], ["name" => "payment_method", "type" => "VARCHAR(255)"], ["name" => "proportion", "type" => "VARCHAR(255)"], ["name" => "minimum", "type" => "VARCHAR(255)"], ["name" => "apiid", "type" => "VARCHAR(255)"], ["name" => "apikey", "type" => "VARCHAR(255)"], ["name" => "weburl", "type" => "VARCHAR(255)"], ["name" => "sitename", "type" => "VARCHAR(255)"], ["name" => "authorize", "type" => "VARCHAR(255)"], ["name" => "webmasteremail", "type" => "VARCHAR(255)"], ["name" => "webmasterqq", "type" => "VARCHAR(255)"], ["name" => "min", "type" => "INT"], ["name" => "max", "type" => "INT"], ["name" => "password", "type" => "VARCHAR(255)"], ["name" => "minintegral", "type" => "VARCHAR(255)"], ["name" => "maxintegral", "type" => "VARCHAR(255)"], ["name" => "loginday", "type" => "VARCHAR(255)"], ["name" => "logindayrate", "type" => "VARCHAR(255)"], ["name" => "invite", "type" => "VARCHAR(255)"], ["name" => "inviterate", "type" => "VARCHAR(255)"], ["name" => "purchase", "type" => "VARCHAR(255)"], ["name" => "purchaserate", "type" => "VARCHAR(255)"], ["name" => "renew", "type" => "VARCHAR(255)"], ["name" => "renewrate", "type" => "VARCHAR(255)"], ["name" => "Introductionbuy", "type" => "VARCHAR(255)"], ["name" => "Introductionbuyrate", "type" => "VARCHAR(255)"], ["name" => "Introductionrenew", "type" => "VARCHAR(255)"], ["name" => "Introductionrenewrate", "type" => "VARCHAR(255)"], ["name" => "created_at", "type" => "TIMESTAMP DEFAULT CURRENT_TIMESTAMP"], ["name" => "updated_at", "type" => "TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"]];
        $fieldsToAddTable3 = [["name" => "id", "type" => "INT AUTO_INCREMENT PRIMARY KEY"], ["name" => "prize_type", "type" => "INT"], ["name" => "name", "type" => "VARCHAR(255)"], ["name" => "description", "type" => "TEXT"], ["name" => "required_points", "type" => "INT"], ["name" => "quantity", "type" => "INT"], ["name" => "used", "type" => "INT"], ["name" => "starttime", "type" => "VARCHAR(255)"], ["name" => "endtime", "type" => "VARCHAR(255)"], ["name" => "config", "type" => "TEXT"], ["name" => "add_time", "type" => "INT"], ["name" => "created_at", "type" => "TIMESTAMP DEFAULT CURRENT_TIMESTAMP"], ["name" => "updated_at", "type" => "TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"]];
        $fieldsToAddTable4 = [["name" => "id", "type" => "INT AUTO_INCREMENT PRIMARY KEY"], ["name" => "uid", "type" => "VARCHAR(255)"], ["name" => "prizesid", "type" => "VARCHAR(255)"], ["name" => "name", "type" => "VARCHAR(255)"], ["name" => "prize_type", "type" => "INT"], ["name" => "required_points", "type" => "INT"], ["name" => "description", "type" => "TEXT"], ["name" => "status", "type" => "INT"], ["name" => "logistics", "type" => "VARCHAR(255)"], ["name" => "code", "type" => "VARCHAR(255)"], ["name" => "config", "type" => "TEXT"], ["name" => "exchange_time", "type" => "INT"], ["name" => "created_at", "type" => "TIMESTAMP DEFAULT CURRENT_TIMESTAMP"], ["name" => "updated_at", "type" => "TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"]];
        $fieldsToAddTable5 = [["name" => "id", "type" => "INT AUTO_INCREMENT PRIMARY KEY"], ["name" => "uid", "type" => "VARCHAR(255)"], ["name" => "integral", "type" => "VARCHAR(255)"], ["name" => "amount", "type" => "VARCHAR(255)"], ["name" => "exchangerate", "type" => "VARCHAR(255)"], ["name" => "paymentmethod", "type" => "VARCHAR(255)"], ["name" => "accountnumber", "type" => "VARCHAR(255)"], ["name" => "status", "type" => "VARCHAR(255)"], ["name" => "remittancetime", "type" => "VARCHAR(255)"], ["name" => "exchangetime", "type" => "VARCHAR(255)"], ["name" => "reason", "type" => "VARCHAR(255)"], ["name" => "created_at", "type" => "TIMESTAMP DEFAULT CURRENT_TIMESTAMP"], ["name" => "updated_at", "type" => "TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"]];
        $tableName1 = "shd_points_mall_records";
        $tableExists1 = \Think\Db::query("SHOW TABLES LIKE '" . $tableName1 . "'");
        if (empty($tableExists1)) {
            $sql1 = "\n            CREATE TABLE " . $tableName1 . " (\n                " . implode(",\n", array_map(function ($fieldInfo) {
                return $fieldInfo["name"] . " " . $fieldInfo["type"] . " COMMENT '" . $fieldInfo["comment"] . "'";
            }, $fieldsToAddTable1)) . "\n            );\n        ";
            \Think\Db::execute($sql1);
        } else {
            foreach ($fieldsToAddTable1 as $fieldInfo) {
                $fieldName = $fieldInfo["name"];
                $fieldExists = \Think\Db::query("SHOW COLUMNS FROM " . $tableName1 . " LIKE '" . $fieldName . "'");
                if (empty($fieldExists)) {
                    $sql1 = "\n                    ALTER TABLE " . $tableName1 . "\n                    ADD COLUMN " . $fieldInfo["name"] . " " . $fieldInfo["type"] . " COMMENT '" . $fieldInfo["comment"] . "';\n                ";
                    \Think\Db::execute($sql1);
                }
            }
        }
        $tableName2 = "shd_points_mall_config";
        $tableExists2 = \Think\Db::query("SHOW TABLES LIKE '" . $tableName2 . "'");
        if (empty($tableExists2)) {
            $sql2 = "\n            CREATE TABLE " . $tableName2 . " (\n                " . implode(",\n", array_map(function ($fieldInfo) {
                return $fieldInfo["name"] . " " . $fieldInfo["type"] . " COMMENT '" . $fieldInfo["comment"] . "'";
            }, $fieldsToAddTable2)) . "\n            );\n        ";
            \Think\Db::execute($sql2);
        } else {
            foreach ($fieldsToAddTable2 as $fieldInfo) {
                $fieldName = $fieldInfo["name"];
                $fieldExists = \Think\Db::query("SHOW COLUMNS FROM " . $tableName2 . " LIKE '" . $fieldName . "'");
                if (empty($fieldExists)) {
                    $sql2 = "\n                    ALTER TABLE " . $tableName2 . "\n                    ADD COLUMN " . $fieldInfo["name"] . " " . $fieldInfo["type"] . " COMMENT '" . $fieldInfo["comment"] . "';\n                ";
                    \Think\Db::execute($sql2);
                }
            }
        }
        $tableName3 = "shd_points_mall_prizes";
        $tableExists3 = \Think\Db::query("SHOW TABLES LIKE '" . $tableName3 . "'");
        if (empty($tableExists3)) {
            $sql3 = "\n            CREATE TABLE " . $tableName3 . " (\n                " . implode(",\n", array_map(function ($fieldInfo) {
                return $fieldInfo["name"] . " " . $fieldInfo["type"] . " COMMENT '" . $fieldInfo["comment"] . "'";
            }, $fieldsToAddTable3)) . "\n            );\n        ";
            \Think\Db::execute($sql3);
        } else {
            foreach ($fieldsToAddTable3 as $fieldInfo) {
                $fieldName = $fieldInfo["name"];
                $fieldExists = \Think\Db::query("SHOW COLUMNS FROM " . $tableName3 . " LIKE '" . $fieldName . "'");
                if (empty($fieldExists)) {
                    $sql3 = "\n                    ALTER TABLE " . $tableName3 . "\n                    ADD COLUMN " . $fieldInfo["name"] . " " . $fieldInfo["type"] . " COMMENT '" . $fieldInfo["comment"] . "';\n                ";
                    \Think\Db::execute($sql3);
                }
            }
        }
        $tableName4 = "shd_points_mall_exchange";
        $tableExists4 = \Think\Db::query("SHOW TABLES LIKE '" . $tableName4 . "'");
        if (empty($tableExists4)) {
            $sql4 = "\n            CREATE TABLE " . $tableName4 . " (\n                " . implode(",\n", array_map(function ($fieldInfo) {
                return $fieldInfo["name"] . " " . $fieldInfo["type"] . " COMMENT '" . $fieldInfo["comment"] . "'";
            }, $fieldsToAddTable4)) . "\n            );\n        ";
            \Think\Db::execute($sql4);
        } else {
            foreach ($fieldsToAddTable4 as $fieldInfo) {
                $fieldName = $fieldInfo["name"];
                $fieldExists = \Think\Db::query("SHOW COLUMNS FROM " . $tableName4 . " LIKE '" . $fieldName . "'");
                if (empty($fieldExists)) {
                    $sql4 = "\n                    ALTER TABLE " . $tableName4 . "\n                    ADD COLUMN " . $fieldInfo["name"] . " " . $fieldInfo["type"] . " COMMENT '" . $fieldInfo["comment"] . "';\n                ";
                    \Think\Db::execute($sql4);
                }
            }
        }
        $tableName5 = "shd_points_mall_cash";
        $tableExists5 = \Think\Db::query("SHOW TABLES LIKE '" . $tableName5 . "'");
        if (empty($tableExists5)) {
            $sql5 = "\n            CREATE TABLE " . $tableName5 . " (\n                " . implode(",\n", array_map(function ($fieldInfo) {
                return $fieldInfo["name"] . " " . $fieldInfo["type"] . " COMMENT '" . $fieldInfo["comment"] . "'";
            }, $fieldsToAddTable5)) . "\n            );\n        ";
            \Think\Db::execute($sql5);
        } else {
            foreach ($fieldsToAddTable5 as $fieldInfo) {
                $fieldName = $fieldInfo["name"];
                $fieldExists = \Think\Db::query("SHOW COLUMNS FROM " . $tableName5 . " LIKE '" . $fieldName . "'");
                if (empty($fieldExists)) {
                    $sql5 = "\n                    ALTER TABLE " . $tableName5 . "\n                    ADD COLUMN " . $fieldInfo["name"] . " " . $fieldInfo["type"] . " COMMENT '" . $fieldInfo["comment"] . "';\n                ";
                    \Think\Db::execute($sql5);
                }
            }
        }
        return true;
    }
    public function uninstall()
    {
        return true;
    }
    public function afterCron()
    {
        $keyword = "注册成功";
        $records = \Think\Db::name("activity_log")->where("description", "like", "%" . $keyword . "%")->whereTime("create_time", ">", strtotime("-24 hours"))->order("id", "desc")->select();
        foreach ($records as $record) {
            $exist = \Think\Db::name("points_mall_records")->where("registerid", $record["uid"])->find();
            if (!$exist) {
                $configData = \Think\Db::name("points_mall_config")->find();
                $affiliates_affid = \Think\Db::name("affiliates_user")->where("uid", $record["uid"])->value("affid");
                $affiliates_user = \Think\Db::name("affiliates")->where("id", $affiliates_affid)->value("uid");
                if ($affiliates_user && $configData["invite"] == 1) {
                    $userPoints = \Think\Db::name("points_mall_records")->where("user_id", $affiliates_user)->order("id", "desc")->value("total_points");
                    $data = ["user_id" => $affiliates_user, "sign_date" => date("Y-m-d"), "points" => $configData["inviterate"], "total_points" => $userPoints + $configData["inviterate"], "type" => "1", "source" => "7", "sign_time" => time(), "registerid" => $record["uid"], "note" => "邀请" . $record["uid"] . "注册获得" . $configData["inviterate"] . "积分"];
                    \Think\Db::name("points_mall_records")->insert($data);
                }
            }
        }
    }
    public function invoicePaid($params)
    {
        $invoiceid = $params["invoiceid"];
        if (!empty($invoiceid)) {
            $invoiceidInfo = \Think\Db::name("invoices")->where("id", $invoiceid)->find();
            $configData = \Think\Db::name("points_mall_config")->where("id", "1")->find();
            if (!empty($invoiceid) && 0 < $invoiceidInfo["subtotal"]) {
                if ($configData["purchase"] == 1 && $invoiceidInfo["type"] == "product") {
                    $points = $invoiceidInfo["subtotal"] * $configData["purchaserate"];
                    $points = round($points);
                    $previousTotalPoints = \Think\Db::name("points_mall_records")->where("user_id", $invoiceidInfo["uid"])->order("id", "desc")->value("total_points");
                    $newTotalPoints = $previousTotalPoints + $points;
                    $data = ["user_id" => $invoiceidInfo["uid"], "sign_date" => date("Y-m-d"), "points" => $points, "total_points" => $newTotalPoints, "type" => "1", "source" => "2", "billnumber" => $invoiceid, "sign_time" => time(), "note" => "" . date("Y-m-d") . "新购产品获得" . $points . "积分"];
                    \Think\Db::name("points_mall_records")->insert($data);
                }
                if ($configData["renew"] == 1 && $invoiceidInfo["type"] == "renew") {
                    $points = $invoiceidInfo["subtotal"] * $configData["renewrate"];
                    $points = round($points);
                    $previousTotalPoints = \Think\Db::name("points_mall_records")->where("user_id", $invoiceidInfo["uid"])->order("id", "desc")->value("total_points");
                    $newTotalPoints = $previousTotalPoints + $points;
                    $data = ["user_id" => $invoiceidInfo["uid"], "sign_date" => date("Y-m-d"), "points" => $points, "total_points" => $newTotalPoints, "type" => "1", "source" => "3", "billnumber" => $invoiceid, "sign_time" => time(), "note" => "" . date("Y-m-d") . "续费产品获得" . $points . "积分"];
                    \Think\Db::name("points_mall_records")->insert($data);
                }
                $affiliates_affid = \Think\Db::name("affiliates_user")->where("uid", $invoiceidInfo["uid"])->value("affid");
                $affiliates_user = \Think\Db::name("affiliates")->where("id", $affiliates_affid)->value("uid");
                if ($affiliates_user) {
                    if ($configData["Introductionbuy"] == 1 && $invoiceidInfo["type"] == "product") {
                        $points = $invoiceidInfo["subtotal"] * $configData["Introductionbuyrate"];
                        $points = round($points);
                        $previousTotalPoints = \Think\Db::name("points_mall_records")->where("user_id", $affiliates_user)->order("id", "desc")->value("total_points");
                        $newTotalPoints = $previousTotalPoints + $points;
                        $data = ["user_id" => $affiliates_user, "sign_date" => date("Y-m-d"), "points" => $points, "total_points" => $newTotalPoints, "type" => "1", "source" => "4", "billnumber" => $invoiceid, "sign_time" => time(), "note" => "用户 " . $invoiceidInfo["uid"] . " 新购产品获得 " . $points . " 积分"];
                        \Think\Db::name("points_mall_records")->insert($data);
                    }
                    if ($configData["Introductionrenew"] == 1 && $invoiceidInfo["type"] == "renew") {
                        $points = $invoiceidInfo["subtotal"] * $configData["Introductionrenewrate"];
                        $points = round($points);
                        $previousTotalPoints = \Think\Db::name("points_mall_records")->where("user_id", $affiliates_user)->order("id", "desc")->value("total_points");
                        $newTotalPoints = $previousTotalPoints + $points;
                        $data = ["user_id" => $affiliates_user, "sign_date" => date("Y-m-d"), "points" => $points, "total_points" => $newTotalPoints, "type" => "1", "source" => "5", "billnumber" => $invoiceid, "sign_time" => time(), "note" => "用户 " . $invoiceidInfo["uid"] . " 续费产品获得 " . $points . " 积分"];
                        \Think\Db::name("points_mall_records")->insert($data);
                    }
                }
            }
        }
    }
    public function clientLogin($params)
    {
        $configData = \Think\Db::name("points_mall_config")->find();
        $userId = $params["uid"];
        $username = $params["name"];
        $userip = $params["ip"];
        if ($configData["loginday"] == 1) {
            $isSigned = $this->isSignedToday($userId);
            if ($isSigned) {
                return "";
            }
            $points = $configData["logindayrate"];
            $previousTotalPoints = \Think\Db::name("points_mall_records")->where("user_id", $userId)->order("id", "desc")->value("total_points");
            $newTotalPoints = $previousTotalPoints + $points;
            $data = ["user_id" => $userId, "sign_date" => date("Y-m-d"), "points" => $points, "total_points" => $newTotalPoints, "type" => "1", "source" => "6", "sign_time" => time(), "note" => "" . date("Y-m-d") . "每天首次登陆获得" . $points . "积分"];
            \Think\Db::name("points_mall_records")->insert($data);
        }
    }
    private function isSignedToday($userId)
    {
        $today = date("Y-m-d");
        $record = \Think\Db::name("points_mall_records")->where("user_id", $userId)->where("sign_date", $today)->where("source", "6")->find();
        return !empty($record);
    }
}

?>