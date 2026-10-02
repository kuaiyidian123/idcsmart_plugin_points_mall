<?php
namespace addons\points_mall\controller\clientarea;

class IndexController extends \app\home\controller\PluginHomeBaseController
{
    public function index()
    {
        $userId = request()->uid;
        $userTotalPoints = \Think\Db::name("points_mall_records")->where("user_id", $userId)->order("id", "desc")->value("total_points");
        if ($userTotalPoints === NULL) {
            $userTotalPoints = 0;
        }
        $page = input("page", 1);
        $pageSize = 10;
        $pointsrecords = \Think\Db::name("points_mall_records")->where("user_id", $userId)->order("id", "desc")->paginate($pageSize, false, ["page" => $page]);
        $data = \Think\Db::name("points_mall_config")->where("id", "1")->find();
        $this->assign("userTotalPoints", $userTotalPoints);
        $this->assign("pointsrecords", $pointsrecords);
        $this->assign("data", $data);
        $this->assign("Title", "签到中心");
        return $this->fetch("/index");
    }
    public function sign()
    {
        $configData = \Think\Db::name("points_mall_config")->find();
        $userId = request()->uid;
        if (empty($userId)) {
            $response = ["code" => 400, "msg" => "您未登录或登录已失效，请刷新页面"];
            return json($response);
        }
        $isSigned = $this->isSignedToday($userId);
        if ($isSigned) {
            return json(["code" => 400, "msg" => "您今天" . date("Y-m-d") . "已经签到过了"]);
        }
        $points = mt_rand($configData["min"], $configData["max"]);
        $type = 1;
        $previousTotalPoints = \Think\Db::name("points_mall_records")->where("user_id", $userId)->order("id", "desc")->value("total_points");
        $newTotalPoints = $previousTotalPoints + $points;
        $enableExpiry = true;
        $data = ["user_id" => $userId, "sign_date" => date("Y-m-d"), "points" => $points, "total_points" => $newTotalPoints, "type" => $type, "source" => "1", "sign_time" => time(), "note" => "" . date("Y-m-d") . "签到获得" . $points . "积分"];
        \Think\Db::name("points_mall_records")->insert($data);
        return json(["code" => 200, "msg" => date("Y-m-d") . "签到成功，获得" . $points . "积分"]);
    }
    private function isSignedToday($userId)
    {
        $today = date("Y-m-d");
        $record = \Think\Db::name("points_mall_records")->where("user_id", $userId)->where("sign_date", $today)->where("source", "1")->find();
        return !empty($record);
    }
    public function exchange()
    {
        $userId = request()->uid;
        $page = input("page", 1);
        $pageSize = 9;
        $twoDaysAgo = time() - 172800;
        $prizes = \Think\Db::name("points_mall_prizes")->where(function ($query) use($twoDaysAgo) {
            $query->where("endtime", ">", $twoDaysAgo)->whereOr("endtime", NULL)->whereOrRaw("endtime = ''");
        })->order("id", "desc")->paginate($pageSize, false, ["page" => $page]);
        $configData = \Think\Db::name("points_mall_config")->field("withdrawal, exchange")->where("id", "1")->find();
        $this->assign("data", $configData);
        $this->assign("List", $prizes);
        $this->assign("Title", "奖品兑换");
        return $this->fetch("/exchange");
    }
    public function change()
    {
        $prizeId = input("post.id");
        $userId = input("uid");
        if (empty($userId)) {
            $response = ["code" => 400, "msg" => "您未登录或登录已失效，请刷新页面"];
            return json($response);
        }
        $prize = \Think\Db::name("points_mall_prizes")->where("id", $prizeId)->find();
        $exchange = \Think\Db::name("points_mall_config")->where("id", "1")->value("exchange");
        if ($exchange == 0) {
            return json(["code" => 400, "msg" => "未开启兑换活动"]);
        }
        if (!$prize) {
            return json(["code" => 400, "msg" => "奖品不存在"]);
        }
        if (!empty($prize["starttime"]) && !empty($prize["endtime"]) && $prize["endtime"] < $prize["starttime"]) {
            return json(["code" => 400, "msg" => "该活动兑奖已结束，请参与其他活动"]);
        }
        if (!empty($prize["starttime"]) && time() < $prize["starttime"]) {
            return json(["code" => 400, "msg" => "该活动兑奖未开始，敬请留意活动时间"]);
        }
        if (!empty($prize["endtime"]) && $prize["endtime"] < time()) {
            return json(["code" => 400, "msg" => "该活动兑奖已结束，请参与其他活动"]);
        }
        if ($prize["quantity"] <= $prize["used"]) {
            return json(["code" => 400, "msg" => "奖品已经被兑完"]);
        }
        $userPoints = \Think\Db::name("points_mall_records")->where("user_id", $userId)->order("id", "desc")->value("total_points");
        if ($userPoints < $prize["required_points"]) {
            return json(["code" => 400, "msg" => "您的积分不足，努力赚积分再来吧"]);
        }
        $result = $this->performExchange($prize["prize_type"], $prize["name"], $userId, $prizeId, $prize["required_points"]);
        return json($result);
    }
    private function performExchange($prizeType, $prizename, $userId, $prizeId, $required_points)
    {
        try {
            \Think\Db::startTrans();
            $prize = \Think\Db::name("points_mall_prizes")->where("id", $prizeId)->find();
            $clients = \Think\Db::name("clients")->where("id", $userId)->find();
            $config = json_decode($prize["config"], true);
            $userPoints = \Think\Db::name("points_mall_records")->where("user_id", $userId)->order("id", "desc")->value("total_points");
            $total_points = $userPoints - $required_points;
            $datarecords = ["user_id" => $userId, "sign_date" => date("Y-m-d"), "points" => "-" . $required_points, "total_points" => $total_points, "type" => "0", "source" => "0", "sign_time" => time(), "note" => "" . date("Y-m-d") . "积分商城兑换 " . $prizename . " (活动ID:" . $prizeId . ") 扣除" . $required_points . "积分"];
            \Think\Db::name("points_mall_records")->insert($datarecords);
            \Think\Db::commit();
            $count = \Think\Db::name("points_mall_prizes")->where("id", $prizeId)->value("used");
            if ($count === NULL) {
                \Think\Db::name("points_mall_prizes")->where("id", $prizeId)->update(["used" => 1]);
            } else {
                \Think\Db::name("points_mall_prizes")->where("id", $prizeId)->setInc("used");
            }
            switch ($prizeType) {
                case 1:
                    $newcredit = $clients["credit"] + $config["amount"];
                    $creditresult = \Think\Db::name("clients")->where("id", $userId)->update(["credit" => $newcredit]);
                    if ($creditresult) {
                        $dataexchange = ["uid" => $userId, "prizesid" => $prizeId, "name" => $prizename, "prize_type" => $prizeType, "required_points" => $required_points, "description" => $prize["description"], "status" => "1", "config" => $prize["config"], "exchange_time" => time()];
                        $exchangeid = \Think\Db::name("points_mall_exchange")->insertGetId($dataexchange);
                        $datainvoices = ["uid" => $userId, "create_time" => time(), "due_time" => time(), "paid_time" => time(), "update_time" => time(), "subtotal" => $config["amount"], "total" => $config["amount"], "payment" => "UserCustom", "status" => "Paid", "type" => "recharge"];
                        $insertedId = \Think\Db::name("invoices")->insertGetId($datainvoices);
                        $datainvoice_items = ["invoice_id" => $insertedId, "uid" => $userId, "type" => "recharge", "due_time" => time(), "description" => "用户" . $clients["username"] . " - [UID:" . $userId . "]在积分商城（活动名称：" . $prizename . "，活动ID：" . $prizeId . "）兑换成功充值" . $config["amount"] . "元，兑换记录ID：" . $exchangeid . "，充值时间：" . date("Y-m-d H:i:s", time()) . "", "description2" => "用户" . $clients["username"] . " - [UID:" . $userId . "]在积分商城（活动名称：" . $prizename . "，活动ID：" . $prizeId . "）兑换成功充值" . $config["amount"] . "元，充值时间：" . date("Y-m-d H:i:s", time()) . "", "amount" => $config["amount"]];
                        \Think\Db::name("invoice_items")->insert($datainvoice_items);
                        $data = ["uid" => $userId, "create_time" => time(), "description" => "用户" . $clients["username"] . " - [UID:" . $userId . "]在积分商城（活动名称：" . $prizename . "，活动ID：" . $prizeId . "）兑换成功充值" . $config["amount"] . "元，兑换记录ID：" . $exchangeid . "，对应充值账单号：" . $insertedId, "amount" => $config["amount"], "balance" => $newcredit];
                        \Think\Db::name("credit")->insert($data);
                        return ["code" => 200, "msg" => " 余额奖品【 " . $prizename . " 】兑换成功"];
                    }
                    break;
                case 2:
                    $couponCode = $this->generateRandomCouponCode();
                    $bTableData = ["code" => $couponCode, "type" => $config["discount_type"], "recurring" => $config["recurring"], "value" => $config["discount_percentage"], "cycles" => $config["cycles"], "appliesto" => $config["applicable_products"], "start_time" => time(), "expiration_time" => time() + $config["validity_period"] * 3600, "max_times" => 1, "lifelong" => $config["lifelong"], "one_time" => $config["one_time"], "only_new_client" => 0, "only_old_client" => 0, "once_per_client" => 1, "notes" => "来源：积分商城兑换，用户ID：" . $userId . "在积分商城使用积分兑换，活动名称：" . $prizename . " (活动ID：" . $prizeId . ")，发放时间：" . date("Y-m-d H:i:s", time()) . "", "is_discount" => $config["is_discount"]];
                    \Think\Db::name("promo_code")->insert($bTableData);
                    $data = ["uid" => $userId, "prizesid" => $prizeId, "name" => $prizename, "prize_type" => $prizeType, "required_points" => $required_points, "description" => $prize["description"], "status" => "1", "code" => $couponCode, "config" => $prize["config"], "exchange_time" => time()];
                    $exchangeid = \Think\Db::name("points_mall_exchange")->insertGetId($data);
                    return ["code" => 200, "msg" => " 优惠码奖品【 " . $prizename . " 】兑换成功"];
                    break;
                case 3:
                    $shiwudata = ["uid" => $userId, "prizesid" => $prizeId, "name" => $prizename, "prize_type" => $prizeType, "required_points" => $required_points, "description" => $prize["description"], "status" => "3", "config" => $prize["config"], "exchange_time" => time()];
                    $exchangeid = \Think\Db::name("points_mall_exchange")->insert($shiwudata);
                    return ["code" => 200, "msg" => "实物奖品兑换成功，请前往 兑奖记录 页面填写收货信息"];
                    break;
                case 4:
                    $zidingyidata = ["uid" => $userId, "prizesid" => $prizeId, "name" => $prizename, "prize_type" => $prizeType, "required_points" => $required_points, "description" => $prize["description"], "status" => "0", "config" => $prize["config"], "exchange_time" => time()];
                    $exchangeid = \Think\Db::name("points_mall_exchange")->insertGetId($zidingyidata);
                    return ["code" => 200, "msg" => " " . $prizename . " 兑换成功"];
                    break;
                default:
                    return ["code" => 200, "msg" => "兑换成功"];
            }
        } catch (\Exception $e) {
            \Think\Db::rollback();
            return ["code" => 400, "msg" => "兑换失败" . $e->getMessage()];
        }
    }
    private function generateRandomCouponCode($length = 12)
    {
        $characters = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
        $couponCode = "";
        for ($i = 0; $i < $length; $i++) {
            $couponCode .= $characters[random_int(0, strlen($characters) - 1)];
        }
        return $couponCode;
    }
    public function record()
    {
        $userId = request()->uid;
        $page = input("page", 1);
        $pageSize = 10;
        $userrecords = \Think\Db::name("points_mall_exchange")->where("uid", $userId)->order("id", "desc")->paginate($pageSize, false, ["page" => $page]);
        $withdrawaldata = \Think\Db::name("points_mall_config")->where("id", "1")->value("withdrawal");
        $this->assign("data", $userrecords);
        $this->assign("withdrawaldata", $withdrawaldata);
        $this->assign("Title", "兑换记录");
        return $this->fetch("/record");
    }
    public function confirm()
    {
        $prizeId = input("post.id");
        $address = input("post.address");
        $userId = request()->uid;
        if (empty($userId)) {
            $response = ["code" => 400, "msg" => "您未登录或登录已失效，请刷新页面"];
            return json($response);
        }
        $result = \Think\Db::name("points_mall_exchange")->where("id", $prizeId)->find();
        $exchangeresult = false;
        if ($result["status"] == 3) {
            $prizeConfig = ["address" => $address, "express_time" => time()];
            $prizeData = ["status" => "0", "code" => json_encode($prizeConfig)];
            $exchangeresult = \Think\Db::name("points_mall_exchange")->where("id", $prizeId)->update($prizeData);
        }
        if ($exchangeresult) {
            return json(["code" => 200, "msg" => "收货地址确认成功"]);
        }
        return json(["code" => 400, "msg" => "收货地址确认失败"]);
    }
    public function withdrawal()
    {
        $userId = request()->uid;
        $data = \Think\Db::name("points_mall_config")->where("id", "1")->find();
        $userIdTotalPoints = \Think\Db::name("points_mall_records")->where("user_id", $userId)->order("id", "desc")->value("total_points");
        $data["userIdTotalPoints"] = $userIdTotalPoints;
        if (0 < fmod($data["minimum"] / $data["proportion"], 1)) {
            $minimum = number_format($data["minimum"] / $data["proportion"], 2);
        } else {
            $minimum = intval($data["minimum"] / $data["proportion"]);
        }
        $page = input("page", 1);
        $pageSize = 5;
        $confirmrecords = \Think\Db::name("points_mall_cash")->where("uid", $userId)->order("id", "desc")->paginate($pageSize, false, ["page" => $page]);
        $withdrawaldata = \Think\Db::name("points_mall_config")->where("id", "1")->value("withdrawal");
        $this->assign("withdrawaldata", $withdrawaldata);
        $this->assign("confirmrecords", $confirmrecords);
        $this->assign("minimum", $minimum);
        $this->assign("data", $data);
        $this->assign("Title", "积分兑现");
        return $this->fetch("/withdrawal");
    }
    public function withdrawalconfirm()
    {
        $userId = request()->uid;
        if (empty($userId)) {
            $response = ["code" => 400, "msg" => "您未登录或登录已失效，请刷新页面"];
            return json($response);
        }
        $points = input("post.points");
        $payment_method = input("post.payment_method");
        $account_number = input("post.account_number");
        $data = \Think\Db::name("points_mall_config")->where("id", "1")->find();
        $userIdTotalPoints = \Think\Db::name("points_mall_records")->where("user_id", $userId)->order("id", "desc")->value("total_points");
        if (empty($points)) {
            $response = ["code" => 400, "msg" => "请输入需要兑换的积分数量"];
            return json($response);
        }
        if (!is_numeric($points) || intval($points) != $points) {
            $response = ["code" => 400, "msg" => "请输入有效的兑换的积分数量（整数）"];
            return json($response);
        }
        if ($points < $data["minimum"]) {
            $response = ["code" => 400, "msg" => "积分兑现最小" . $data["minimum"] . "积分起兑"];
            return json($response);
        }
        if (empty($account_number)) {
            $response = ["code" => 400, "msg" => "请输入收款账号"];
            return json($response);
        }
        if ($data["realname"] == 1) {
            $certifi_person = \Think\Db::name("certifi_person")->where("auth_user_id", $userId)->find();
            $certifi_company = \Think\Db::name("certifi_company")->where("auth_user_id", $userId)->find();
            $can_receive = false;
            if ($certifi_person) {
                $can_receive = $certifi_person["status"] == 1;
            }
            if (!$can_receive && $certifi_company) {
                $can_receive = $certifi_company["status"] == 1;
            }
            if (!$certifi_person && !$certifi_company) {
                return json(["code" => 403, "msg" => "积分兑现需要账号先进行实名认证！"]);
            }
            if (!$can_receive) {
                return json(["code" => 403, "msg" => "积分兑现需要账号先进行实名认证（您的实名认证未通过）！"]);
            }
        }
        if ($userIdTotalPoints < $points) {
            $response = ["code" => 400, "msg" => "您当前积分为" . $userIdTotalPoints . "，积分不足"];
            return json($response);
        }
        if (0 < fmod($points / $data["proportion"], 1)) {
            $amount = number_format($points / $data["proportion"], 2);
        } else {
            $amount = intval($points / $data["proportion"]);
        }
        $newPoints = $userIdTotalPoints - $points;
        $recordsdata = ["user_id" => $userId, "sign_date" => date("Y-m-d"), "points" => $points, "total_points" => $newPoints, "type" => "0", "source" => "8", "sign_time" => time(), "note" => "" . date("Y-m-d") . "兑现扣除" . $points . "积分"];
        \Think\Db::name("points_mall_records")->insert($recordsdata);
        $data = ["uid" => $userId, "integral" => $points, "amount" => $amount, "exchangerate" => $data["proportion"], "paymentmethod" => $payment_method, "accountnumber" => $account_number, "status" => "0", "exchangetime" => time()];
        $update = \Think\Db::name("points_mall_cash")->insert($data);
        if ($update) {
            return json(["code" => 200, "msg" => "兑现" . $points . "积分成功，预计到账" . $amount . "元"]);
        }
        return json(["code" => 400, "msg" => "兑现失败"]);
    }
    public function kouling()
    {
        $userId = request()->uid;
        if (empty($userId)) {
            $response = ["code" => 400, "msg" => "您未登录或登录已失效，请刷新页面"];
            return json($response);
        }
        $kouling = input("post.kouling");
        $config = \Think\Db::name("points_mall_config")->where("id", "1")->find();
        if ($config["password"] == $kouling) {
            $record = \Think\Db::name("points_mall_records")->where("user_id", $userId)->where("password", $kouling)->find();
            if ($record) {
                return json(["code" => 400, "msg" => "你已经使用过这个口令"]);
            }
            $userIdTotalPoints = \Think\Db::name("points_mall_records")->where("user_id", $userId)->order("id", "desc")->value("total_points");
            $min = $config["minintegral"];
            $max = $config["maxintegral"];
            $points = mt_rand($min, $max);
            $newPoints = $userIdTotalPoints + $points;
            $recordsdata = ["user_id" => $userId, "sign_date" => date("Y-m-d"), "points" => $points, "total_points" => $newPoints, "password" => $kouling, "type" => "1", "source" => "11", "sign_time" => time(), "note" => "使用口令【" . $kouling . "】获得" . $points . "积分"];
            $update = \Think\Db::name("points_mall_records")->insert($recordsdata);
            return json(["code" => 200, "msg" => "使用口令【" . $kouling . "】获得" . $points . "积分"]);
        }
        if (empty($config["password"])) {
            return json(["code" => 400, "msg" => "当前不存在口令红包活动"]);
        }
        return json(["code" => 400, "msg" => "您输入的口令有误"]);
    }
    public function helplist()
    {
        $this->assign("Title", "Demo样式6");
        return $this->fetch("/helplist");
    }
    public function task()
    {
        $userId = request()->uid;
        $data = \Think\Db::name("points_mall_config")->where("id", "1")->find();
        $username = \Think\Db::name("clients")->where("id", $userId)->value("username");
        $twouserpoints = [];
        $rawPoints = \Think\Db::name("points_mall_records")->where("type", "1")->field("user_id, SUM(points) as totalpoints")->group("user_id")->order("totalpoints", "desc")->limit(20)->select();
        foreach ($rawPoints as $user) {
            $clientId = $user["user_id"];
            $client = \Think\Db::name("clients")->where("id", $clientId)->find();
            $affiliatesid = \Think\Db::name("affiliates")->where("uid", $clientId)->value("id");
            $topaffiliates = \Think\Db::name("affiliates_user")->where("affid", $affiliatesid)->count();
            $toppoints = \Think\Db::name("points_mall_records")->where("user_id", $clientId)->where("type", "1")->sum("points");
            $topincome = round($toppoints / $data["proportion"], 2);
            $topmonthpoints = \Think\Db::name("points_mall_records")->where("user_id", $clientId)->where("sign_time", ">", strtotime("-30 days"))->where("type", "1")->sum("points");
            $topmonthincome = round($topmonthpoints / $data["proportion"], 2);
            $quarterpoints = \Think\Db::name("points_mall_records")->where("user_id", $clientId)->where("sign_time", ">", strtotime("-90 days"))->where("type", "1")->sum("points");
            if ($client) {
                $user["username"] = $client["username"];
                $user["topincome"] = $topincome;
                $user["topmonthincome"] = $topmonthincome;
                $user["topaffiliates"] = $topaffiliates;
                $user["quarterpoints"] = $quarterpoints;
                $twouserpoints[] = $user;
            }
        }
        $userpoints = \Think\Db::name("points_mall_records")->where("user_id", $userId)->where("type", "1")->sum("points");
        $userincome = round($userpoints / $data["proportion"], 2);
        $monthpoints = \Think\Db::name("points_mall_records")->where("user_id", $userId)->where("sign_time", ">", strtotime("-30 days"))->where("type", "1")->sum("points");
        $monthincome = round($monthpoints / $data["proportion"], 2);
        $userTotalPoints = \Think\Db::name("points_mall_records")->where("user_id", $userId)->order("id", "desc")->value("total_points");
        if ($userTotalPoints === NULL) {
            $userTotalPoints = 0;
        }
        $affiliates_user = \Think\Db::name("affiliates")->where("uid", $userId)->find();
        $domain = \Think\Db::name("configuration")->where("setting", "domain")->value("value");
        $afflink = $domain . "/aff/" . $affiliates_user["url_identy"];
        $affiliates_affid = \Think\Db::name("affiliates_user")->where("affid", $affiliates_user["id"])->count();
        $affiliates_buy = \Think\Db::name("affiliates_user")->where("affid", $affiliates_user["id"])->column("uid");
        $total_paid = \Think\Db::name("invoices")->where("uid", "in", $affiliates_buy)->where("status", "Paid")->where("paid_time", ">", strtotime("-365 days"))->where("type", "<>", "recharge")->sum("subtotal");
        $total_quarterpaid = \Think\Db::name("invoices")->where("uid", "in", $affiliates_buy)->where("status", "Paid")->where("paid_time", ">", strtotime("-90 days"))->where("type", "<>", "recharge")->sum("subtotal");
        $total_monthpaid = \Think\Db::name("invoices")->where("uid", "in", $affiliates_buy)->where("status", "Paid")->where("paid_time", ">", strtotime("-30 days"))->where("type", "<>", "recharge")->sum("subtotal");
        $total_daypaid = \Think\Db::name("invoices")->where("uid", "in", $affiliates_buy)->where("status", "Paid")->where("paid_time", ">", strtotime("-1 days"))->where("type", "<>", "recharge")->sum("subtotal");
        $monthaffiliates = \Think\Db::name("affiliates_user")->where("affid", $affiliates_user["id"])->where("create_time", ">", strtotime("-30 days"))->count();
        $monthamount = \Think\Db::name("invoices")->where("uid", $userId)->where("paid_time", ">=", strtotime("-30 days"))->where("status", "Paid")->where("type", "<>", "recharge")->sum("subtotal");
        $ninetyamount = \Think\Db::name("invoices")->where("uid", $userId)->where("paid_time", ">=", strtotime("-90 days"))->where("status", "Paid")->where("type", "<>", "recharge")->sum("subtotal");
        $data["userTotalPoints"] = $userTotalPoints;
        $data["total_paid"] = $total_paid;
        $data["total_quarterpaid"] = $total_quarterpaid;
        $data["total_monthpaid"] = $total_monthpaid;
        $data["total_daypaid"] = $total_daypaid;
        $data["userpoints"] = $userpoints;
        $data["userincome"] = $userincome;
        $data["monthincome"] = $monthincome;
        $data["monthaffiliates"] = $monthaffiliates;
        $data["registcount"] = $affiliates_affid;
        $data["monthamount"] = $monthamount;
        $data["ninetyamount"] = $ninetyamount;
        $data["username"] = $username;
        $data["afflink"] = $afflink;
        $data["url_identy"] = $affiliates_user["url_identy"];
        $this->assign("data", $data);
        $this->assign("twouserpoints", $twouserpoints);
        $this->assign("Title", "积分任务");
        return $this->fetch("/task");
    }
}

?>