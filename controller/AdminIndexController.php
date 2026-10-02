<?php
namespace addons\points_mall\controller;

class AdminIndexController extends \app\admin\controller\PluginAdminBaseController
{
    public function setting()
    {
        $configData = \Think\Db::name("points_mall_config")->find();
        $authorize = \Think\Db::name("points_mall_config")->where("id", 1)->value("authorize");
        $system_license = \Think\Db::name("configuration")->where("setting", "system_license")->value("value");
        $isMismatch = false;
        $mismatchMessage = "恭喜您，授权成功";
        $this->assign("Title", "功能设置");
        $this->assign("Data", $configData);
        $this->assign("IsMismatch", $isMismatch);
        $this->assign("MismatchMessage", $mismatchMessage);
        return $this->fetch("/setting");
    }
    public function submit()
    {
        $data = $this->request->post();
        $apiid = isset($data["apiid"]) ? $data["apiid"] : NULL;
        $apikey = isset($data["apikey"]) ? $data["apikey"] : NULL;
        $webmasteremail = isset($data["webmasteremail"]) ? $data["webmasteremail"] : NULL;
        $webmasterqq = isset($data["webmasterqq"]) ? $data["webmasterqq"] : NULL;
        $authorize = isset($data["authorize"]) ? $data["authorize"] : NULL;
        $sitename = isset($data["sitename"]) ? $data["sitename"] : NULL;
        $open = isset($data["open"]) ? $data["open"] : NULL;
        $exchange = isset($data["exchange"]) ? $data["exchange"] : NULL;
        $realname = isset($data["realname"]) ? $data["realname"] : NULL;
        $min = isset($data["min"]) ? $data["min"] : NULL;
        $max = isset($data["max"]) ? $data["max"] : NULL;
        $withdrawal = isset($data["withdrawal"]) ? $data["withdrawal"] : NULL;
        $proportion = isset($data["proportion"]) ? $data["proportion"] : NULL;
        $minimum = isset($data["minimum"]) ? $data["minimum"] : NULL;
        $payment_method = isset($data["payment_method"]) ? $data["payment_method"] : [];
        $cyclesString = implode(",", $payment_method);
        $payment_method = trim($cyclesString);
        if (empty($data["min"]) || empty($data["max"])) {
            $response = ["code" => 400, "msg" => "请输入积分范围最小和最大值。"];
            return json($response);
        }
        if ($data["max"] < $data["min"]) {
            $response = ["code" => 400, "msg" => "最小积分不能大于最,大积分。"];
            return json($response);
        }
        $dbConfig = ["apiid" => $apiid, "apikey" => $apikey, "open" => $open, "exchange" => $exchange, "realname" => $realname, "sitename" => $sitename, "webmasteremail" => $webmasteremail, "webmasterqq" => $webmasterqq, "withdrawal" => $withdrawal, "proportion" => $proportion, "payment_method" => $payment_method, "minimum" => $minimum, "min" => $min, "max" => $max, "authorize" => $authorize, "weburl" => $_SERVER["HTTP_HOST"]];
        $result = \Think\Db::name("points_mall_config")->where("id", 1)->find();
        if ($result) {
            $updateResult = \Think\Db::name("points_mall_config")->where("id", 1)->update($dbConfig);
            if ($updateResult !== false) {
                $response = ["code" => 200, "msg" => "设置更新成功。"];
            } else {
                $response = ["code" => 500, "msg" => "设置更新出错。"];
            }
        } else {
            $dbConfig["id"] = 1;
            $insertResult = \Think\Db::name("points_mall_config")->insert($dbConfig);
            if ($insertResult !== false) {
                $response = ["code" => 200, "msg" => "设置首次配置已成功。"];
            } else {
                $response = ["code" => 500, "msg" => "设置首次配置时出错。"];
            }
        }
        return json($response);
    }
    public function add()
    {
        $keproducts = \Think\Db::name("products")->alias("p")->field("p.id, p.gid, p.name, g.name as group_name")->join("product_groups g", "p.gid = g.id", "LEFT")->order("p.gid ASC")->order("p.id ASC")->select();
        $resultWithNames = [];
        foreach ($keproducts as $record) {
            $productid = $record["id"];
            $name = \Think\Db::name("products")->where("id", $productid)->find();
            $name1 = \Think\Db::name("products")->where(["id" => $productid, "api_type" => "zjmf_api"])->find();
            $zjmf_finance_api = \Think\Db::name("zjmf_finance_api")->where(["id" => $name1["server_group"]])->find();
            if ($name !== NULL) {
                $record["name"] = $name["name"];
                $record["hosttype"] = $name["type"];
                $record["hidden"] = $name["hidden"];
                $record["api_name"] = $zjmf_finance_api["name"];
                $resultWithNames[] = $record;
            }
        }
        $this->assign("keproducts", $resultWithNames);
        $this->assign("Title", "添加奖品");
        return $this->fetch("/add");
    }
    public function addPrize()
    {
        $data = $this->request->post();
        $prizeType = input("post.prizeType");
        $name = input("post.name");
        $description = input("post.description");
        $requiredPoints = input("post.requiredPoints");
        $quantity = input("post.quantity");
        $starttime = input("post.starttime");
        $starttime = empty($starttime) ? "" : strtotime($starttime);
        $endtime = input("post.endtime");
        $endtime = empty($endtime) ? "" : strtotime($endtime);
        if (empty($prizeType)) {
            $response = ["code" => 400, "msg" => "奖品类型不能为空。"];
            return json($response);
        }
        if (empty($name)) {
            $response = ["code" => 400, "msg" => "奖品名称不能为空。"];
            return json($response);
        }
        if (empty($requiredPoints)) {
            $response = ["code" => 400, "msg" => "兑换奖品所需积分不能为空。"];
            return json($response);
        }
        if ($requiredPoints <= 0) {
            $response = ["code" => 400, "msg" => "兑换奖品所需积分不能小于或等于 0。"];
            return json($response);
        }
        if (empty($quantity)) {
            $response = ["code" => 400, "msg" => "奖品总数量不能为空。"];
            return json($response);
        }
        if ($quantity <= 0) {
            $response = ["code" => 400, "msg" => "奖品总数量不能小于或等于 0。"];
            return json($response);
        }
        switch ($prizeType) {
            case 1:
                $amount = input("post.amount");
                if (empty($amount)) {
                    $response = ["code" => 400, "msg" => "金额不能为空。"];
                    return json($response);
                }
                $prizeConfig = ["amount" => $amount];
                break;
            case 2:
                $validityPeriod = input("post.validityPeriod");
                $recurring = input("post.recurring");
                $one_time = input("post.one_time");
                $lifelong = input("post.lifelong");
                $is_discount = input("post.is_discount");
                $applicableProducts = isset($data["applicableProducts"]) ? $data["applicableProducts"] : [];
                $applicableProductsIdsString = implode(",", $applicableProducts);
                $applicableProducts_id = trim($applicableProductsIdsString);
                $cycles = isset($data["cycles"]) ? $data["cycles"] : [];
                $cyclesString = implode(",", $cycles);
                $cyclesString_id = trim($cyclesString);
                $discountPercentage = input("post.discountPercentage");
                $discounttype = input("post.discounttype");
                if (empty($validityPeriod)) {
                    $response = ["code" => 400, "msg" => "优惠券有效期不能为空。"];
                    return json($response);
                }
                if (empty($discountPercentage) || $discountPercentage <= 0) {
                    $response = ["code" => 400, "msg" => "优惠面值不能为空且不能小于0。"];
                    return json($response);
                }
                $prizeConfig = ["validity_period" => $validityPeriod, "applicable_products" => $applicableProducts_id, "discount_percentage" => $discountPercentage, "discount_type" => $discounttype, "recurring" => $recurring, "one_time" => $one_time, "lifelong" => $lifelong, "cycles" => $cyclesString_id, "is_discount" => $is_discount];
                break;
            case 3:
                $shiwu = input("post.shiwu");
                if (empty($quantity)) {
                    $response = ["code" => 400, "msg" => "奖品总数量不能为空。"];
                    return json($response);
                }
                $prizeConfig = ["shiwu" => $shiwu];
                break;
            case 4:
                $customField = input("post.customField");
                if (empty($quantity)) {
                    $response = ["code" => 400, "msg" => "奖品总数量不能为空。"];
                    return json($response);
                }
                $prizeConfig = ["custom_field" => $customField];
                break;
            default:
                return json(["code" => 400, "msg" => "未知奖品类型"]);
        }
        $prizeData = ["name" => $name, "prize_type" => $prizeType, "starttime" => $starttime, "endtime" => $endtime, "description" => $description, "required_points" => $requiredPoints, "quantity" => $quantity, "used" => 0, "config" => json_encode($prizeConfig), "add_time" => time()];
        $insertResult = \Think\Db::name("points_mall_prizes")->insert($prizeData);
        if (!$insertResult) {
            return json(["code" => 500, "msg" => "奖品添加失败"]);
        }
        return json(["code" => 200, "msg" => "奖品添加成功"]);
    }
    public function showprizes()
    {
        $page = input("page", 1);
        $pageSize = 10;
        $prizes = \Think\Db::name("points_mall_prizes")->order("id", "desc")->paginate($pageSize, false, ["page" => $page]);
        $url = $_SERVER["REQUEST_URI"];
        $domain = dirname($url);
        $this->assign("Title", "奖品列表");
        $this->assign("domain", $domain);
        return $this->fetch("/showprizes", ["data" => $prizes]);
    }
    public function logs()
    {
        $page = input("page", 1);
        $pageSize = 10;
        $lists = \Think\Db::name("points_mall_records")->alias("pmr")->field("pmr.*, c.username")->join("clients c", "pmr.user_id = c.id", "LEFT")->order("pmr.id", "desc")->paginate($pageSize, false, ["page" => $page]);
        $url = $_SERVER["REQUEST_URI"];
        $domain = dirname($url);
        $this->assign("domain", $domain);
        $this->assign("lists", $lists);
        $this->assign("Title", "积分日志");
        return $this->fetch("/logs");
    }
    public function exchange()
    {
        $page = input("page", 1);
        $pageSize = 10;
        $lists = \Think\Db::name("points_mall_exchange")->order("id", "desc")->paginate($pageSize, false, ["page" => $page]);
        $url = $_SERVER["REQUEST_URI"];
        $domain = dirname($url);
        $this->assign("domain", $domain);
        $this->assign("data", $lists);
        $this->assign("Title", "兑换列表");
        return $this->fetch("/exchange");
    }
    public function task()
    {
        $configData = \Think\Db::name("points_mall_config")->find();
        $this->assign("Data", $configData);
        $this->assign("Title", "积分任务");
        return $this->fetch("/task");
    }
    public function tasksubmit()
    {
        $data = $this->request->post();
        $loginday = input("post.loginday");
        $logindayrate = input("post.logindayrate");
        $password = input("post.password");
        $minintegral = input("post.minintegral");
        $maxintegral = input("post.maxintegral");
        $invite = input("post.invite");
        $inviterate = input("post.inviterate");
        $purchase = input("post.purchase");
        $purchaserate = input("post.purchaserate");
        $renew = input("post.renew");
        $renewrate = input("post.renewrate");
        $Introductionbuy = input("post.Introductionbuy");
        $Introductionbuyrate = input("post.Introductionbuyrate");
        $Introductionrenew = input("post.Introductionrenew");
        $Introductionrenewrate = input("post.Introductionrenewrate");
        if (empty($logindayrate) || $logindayrate < 0) {
            $response = ["code" => 400, "msg" => "请输入每天首次登陆可获得的积分且不能小于0。"];
            return json($response);
        }
        if (empty($inviterate) || $inviterate < 0) {
            $response = ["code" => 400, "msg" => "请输入邀请注册积分且不能为0。"];
            return json($response);
        }
        if (empty($purchaserate) || $purchaserate < 0) {
            $response = ["code" => 400, "msg" => "请输入新购产品积分比例且不能为0。"];
            return json($response);
        }
        if (empty($renewrate) || $renewrate < 0) {
            $response = ["code" => 400, "msg" => "请输入续费产品积分比例且不能为0。"];
            return json($response);
        }
        if (empty($Introductionbuyrate) || $Introductionbuyrate < 0) {
            $response = ["code" => 400, "msg" => "请输入推介新购积分比例且不能为0。"];
            return json($response);
        }
        if (empty($Introductionrenewrate) || $Introductionrenewrate < 0) {
            $response = ["code" => 400, "msg" => "请输入推介续费积分比例且不能为0。"];
            return json($response);
        }
        if (empty($minintegral) || empty($maxintegral)) {
            $response = ["code" => 400, "msg" => "请输入口令红包积分范围最小积分和最大积分值。"];
            return json($response);
        }
        if ($maxintegral < $minintegral) {
            $response = ["code" => 400, "msg" => "最小积分不能大于最大积分。"];
            return json($response);
        }
        $dbConfig = ["loginday" => $loginday, "logindayrate" => $logindayrate, "password" => $password, "minintegral" => $minintegral, "maxintegral" => $maxintegral, "invite" => $invite, "inviterate" => $inviterate, "purchase" => $purchase, "purchaserate" => $purchaserate, "renew" => $renew, "renewrate" => $renewrate, "Introductionbuy" => $Introductionbuy, "Introductionbuyrate" => $Introductionbuyrate, "Introductionrenew" => $Introductionrenew, "Introductionrenewrate" => $Introductionrenewrate, "weburl" => $_SERVER["HTTP_HOST"]];
        $result = \Think\Db::name("points_mall_config")->where("id", 1)->find();
        if ($result) {
            $updateResult = \Think\Db::name("points_mall_config")->where("id", 1)->update($dbConfig);
            if ($updateResult !== false) {
                $response = ["code" => 200, "msg" => "设置更新成功。"];
            } else {
                $response = ["code" => 500, "msg" => "设置更新出错。"];
            }
        } else {
            $dbConfig["id"] = 1;
            $insertResult = \Think\Db::name("points_mall_config")->insert($dbConfig);
            if ($insertResult !== false) {
                $response = ["code" => 200, "msg" => "设置首次配置已成功。"];
            } else {
                $response = ["code" => 500, "msg" => "设置首次配置时出错。"];
            }
        }
        return json($response);
    }
    public function express()
    {
        $prizeId = input("post.id");
        $express_company = input("post.express_company");
        $express_number = input("post.express_number");
        $result = \Think\Db::name("points_mall_exchange")->where("id", $prizeId)->find();
        if ($result["status"] == 0) {
            $prizeConfig = ["express_company" => $express_company, "express_number" => $express_number, "express_time" => time()];
            $prizeData = ["status" => "1", "logistics" => json_encode($prizeConfig)];
            $faresult = \Think\Db::name("points_mall_exchange")->where("id", $prizeId)->update($prizeData);
        }
        if ($faresult) {
            return json(["code" => 200, "msg" => "发货成功"]);
        }
        return json(["code" => 400, "msg" => "订单状态不正确，请刷新页面"]);
    }
    public function passPrize()
    {
        $prizeId = input("post.id");
        $result = \Think\Db::name("points_mall_exchange")->where("id", $prizeId)->find();
        $exchangeid = $result['id'];
        $config = json_decode($result["config"], true);
        $clients = \Think\Db::name("clients")->where("id", $result["uid"])->find();
        if ($result["status"] == 0) {
            if ($result["prize_type"] == 1) {
                $newcredit = $clients["credit"] + $config["amount"];
                $creditresult = \Think\Db::name("clients")->where("id", $result["uid"])->update(["credit" => $newcredit]);
                if ($creditresult) {
                    $data = ["status" => "1"];
                    \Think\Db::name("points_mall_exchange")->where("id", $prizeId)->update($data);
                    $datainvoices = ["uid" => $result["uid"], "create_time" => time(), "due_time" => time(), "paid_time" => time(), "update_time" => time(), "subtotal" => $config["amount"], "total" => $config["amount"], "payment" => "UserCustom", "status" => "Paid", "type" => "recharge"];
                    $insertedId = \Think\Db::name("invoices")->insertGetId($datainvoices);
                    $datainvoice_items = ["invoice_id" => $insertedId, "uid" => $result["uid"], "type" => "recharge", "due_time" => time(), "description" => "用户" . $clients["username"] . " - [UID:" . $result["uid"] . "]在积分商城（活动名称：" . $result["name"] . "，活动ID：" . $prizeId . "）兑换成功充值" . $config["amount"] . "元，兑换记录ID：" . $exchangeid . "，充值时间：" . date("Y-m-d H:i:s", time()) . "", "description2" => "用户" . $clients["username"] . " - [UID:" . $result["uid"] . "]在积分商城（活动名称：" . $result["name"] . "，活动ID：" . $prizeId . "）兑换成功充值" . $config["amount"] . "元，充值时间：" . date("Y-m-d H:i:s", time()) . "", "amount" => $config["amount"]];
                    \Think\Db::name("invoice_items")->insert($datainvoice_items);
                    $data = ["uid" => $result["uid"], "create_time" => time(), "description" => "用户" . $clients["username"] . " - [UID:" . $result["uid"] . "]在积分商城（活动名称：" . $result["name"] . "，活动ID：" . $prizeId . "）兑换成功充值" . $config["amount"] . "元，兑换记录ID：" . $exchangeid . "，对应充值账单号：" . $insertedId, "amount" => $config["amount"], "balance" => $newcredit];
                    \Think\Db::name("credit")->insert($data);
                }
                if ($creditresult) {
                    return json(["code" => 200, "msg" => "余额兑换发放成功"]);
                }
                return json(["code" => 400, "msg" => "余额兑换发放失败"]);
            }
            if ($result["prize_type"] == 2) {
                $couponCode = $this->generateRandomCouponCode();
                $bTableData = ["code" => $couponCode, "type" => $config["discount_type"], "recurring" => $config["recurring"], "value" => $config["discount_percentage"], "cycles" => $config["cycles"], "appliesto" => $config["applicable_products"], "start_time" => time(), "expiration_time" => time() + $config["validity_period"] * 3600, "max_times" => 1, "lifelong" => $config["lifelong"], "one_time" => $config["one_time"], "only_new_client" => 0, "only_old_client" => 0, "once_per_client" => 1, "notes" => "【人工发放】来源：积分商城兑换，用户ID：" . $result["uid"] . "在积分商城使用积分兑换，活动名称：" . $result["name"] . " (活动ID：" . $prizeId . ")，发放时间：" . date("Y-m-d H:i:s", time()) . "", "is_discount" => $config["is_discount"]];
                $update = \Think\Db::name("promo_code")->insert($bTableData);
                $data = ["status" => "1", "code" => $couponCode];
                \Think\Db::name("points_mall_exchange")->where("id", $prizeId)->update($data);
                if ($update) {
                    return json(["code" => 200, "msg" => "优惠码发放成功"]);
                }
                return json(["code" => 400, "msg" => "优惠码发放失败"]);
            }
            if ($result["prize_type"] == 4) {
                $data = ["status" => "1"];
                $update = \Think\Db::name("points_mall_exchange")->where("id", $prizeId)->update($data);
                if ($update) {
                    return json(["code" => 200, "msg" => "发放成功--自定义商品，请自行操作发放"]);
                }
                return json(["code" => 400, "msg" => "发放失败"]);
            }
        } else {
            return json(["code" => 400, "msg" => "兑换状态不正确，请刷新"]);
        }
    }
    public function rejectPrize()
    {
        $prizeId = input("post.id");
        $result = \Think\Db::name("points_mall_exchange")->where("id", $prizeId)->find();
        if ($result["status"] == 0) {
            $userPoints = \Think\Db::name("points_mall_records")->where("user_id", $result["uid"])->order("id", "desc")->value("total_points");
            $newPoints = $userPoints + $result["required_points"];
            $data = ["user_id" => $result["uid"], "sign_date" => date("Y-m-d"), "points" => $result["required_points"], "total_points" => $newPoints, "type" => "1", "source" => "9", "sign_time" => time(), "note" => "" . date("Y-m-d") . "兑换奖品（" . $result["name"] . "）失败退回" . $result["required_points"] . "积分"];
            $update = \Think\Db::name("points_mall_records")->insert($data);
            $data = ["status" => "2"];
            $exchangeid = \Think\Db::name("points_mall_exchange")->where("id", $prizeId)->update($data);
            if ($update) {
                return json(["code" => 200, "msg" => "拒绝成功，退回" . $result["required_points"] . "积分"]);
            }
            return json(["code" => 400, "msg" => "拒绝失败"]);
        }
        return json(["code" => 400, "msg" => "兑换状态不正确，请刷新"]);
    }
    public function submitgive()
    {
        $uid = input("post.uid");
        $number = input("post.number");
        $note = input("post.note");
        $userExists = \Think\Db::name("clients")->where("id", $uid)->find();
        if (!$userExists) {
            return json(["code" => 400, "msg" => "ID为 " . $uid . " 的用户不存在，请检查"]);
        }
        $clientsname = \Think\Db::name("clients")->where("id", $uid)->value("username");
        $userPoints = \Think\Db::name("points_mall_records")->where("user_id", $uid)->order("id", "desc")->value("total_points");
        $newPoints = $userPoints + $number;
        $data = ["user_id" => $uid, "sign_date" => date("Y-m-d"), "points" => $number, "total_points" => $newPoints, "type" => "1", "source" => "10", "sign_time" => time(), "note" => "赠送" . $number . "积分，原因：" . $note . ""];
        $update = \Think\Db::name("points_mall_records")->insert($data);
        if ($update) {
            return json(["code" => 200, "msg" => "向用户" . $clientsname . "( " . $uid . " ) 赠送" . $number . "积分成功"]);
        }
        return json(["code" => 400, "msg" => "积分赠送失败"]);
    }
    public function deduct()
    {
        $uid = input("post.uid");
        $number = input("post.number");
        $note = input("post.note");
        $userExists = \Think\Db::name("clients")->where("id", $uid)->find();
        if (!$userExists) {
            return json(["code" => 400, "msg" => "ID为 " . $uid . " 的用户不存在，请检查"]);
        }
        $clientsname = \Think\Db::name("clients")->where("id", $uid)->value("username");
        $userPoints = \Think\Db::name("points_mall_records")->where("user_id", $uid)->order("id", "desc")->value("total_points");
        $newPoints = $userPoints - $number;
        $data = ["user_id" => $uid, "sign_date" => date("Y-m-d"), "points" => $number, "total_points" => $newPoints, "type" => "0", "source" => "12", "sign_time" => time(), "note" => "扣除" . $number . "积分，原因：" . $note . ""];
        $update = \Think\Db::name("points_mall_records")->insert($data);
        if ($update) {
            return json(["code" => 200, "msg" => "扣除用户" . $clientsname . "( " . $uid . " ) " . $number . "积分成功"]);
        }
        return json(["code" => 400, "msg" => "积分扣除失败"]);
    }
    public function withdrawal()
    {
        $page = input("page", 1);
        $pageSize = 10;
        $lists = \Think\Db::name("points_mall_cash")->order("id", "desc")->paginate($pageSize, false, ["page" => $page]);
        $url = $_SERVER["REQUEST_URI"];
        $domain = dirname($url);
        $this->assign("domain", $domain);
        $this->assign("data", $lists);
        $this->assign("Title", "兑现列表");
        return $this->fetch("/withdrawal");
    }
    public function withdrawals()
    {
        $id = input("post.id");
        $type = input("post.type");
        $reason = input("post.reason");
        $remark = input("post.remark");
        $result = \Think\Db::name("points_mall_cash")->where("id", $id)->find();
        if ($type == 1) {
            $data = ["status" => "1", "remittancetime" => time(), "reason" => $remark];
            $update = \Think\Db::name("points_mall_cash")->where("id", $id)->where("status", "0")->update($data);
            if ($update) {
                return json(["code" => 200, "msg" => "兑现审核-通过成功"]);
            }
            return json(["code" => 400, "msg" => "兑现审核失败，状态不正确，请刷新页面"]);
        }
        if ($type == 2) {
            $data = ["status" => "2", "remittancetime" => time(), "reason" => $reason];
            $update = \Think\Db::name("points_mall_cash")->where("id", $id)->where("status", "0")->update($data);
            if ($update) {
                $userPoints = \Think\Db::name("points_mall_records")->where("user_id", $result["uid"])->order("id", "desc")->value("total_points");
                $newPoints = $userPoints + $result["integral"];
                $tuidata = ["user_id" => $result["uid"], "sign_date" => date("Y-m-d"), "points" => $result["integral"], "total_points" => $newPoints, "type" => "1", "source" => "9", "sign_time" => time(), "note" => "兑现失败退回" . $result["integral"] . "积分【兑现ID：" . $id . "】"];
                \Think\Db::name("points_mall_records")->insert($tuidata);
                return json(["code" => 200, "msg" => "兑现审核-拒绝成功，退回 " . $result["integral"] . " 积分"]);
            }
            return json(["code" => 400, "msg" => "兑现审核拒绝失败，状态不正确，请刷新页面"]);
        }
        return json(["code" => 400, "msg" => "请求类型不存在"]);
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
    public function deleteandexpire()
    {
        $id = input("post.id");
        $type = input("post.type");
        if ($type == 1) {
            $currentTime = time();
            $result = \Think\Db::name("points_mall_prizes")->where("id", $id)->whereRaw("endtime > ? OR endtime IS NULL OR endtime = ''", [$currentTime])->update(["endtime" => $currentTime]);
            if ($result) {
                return json(["code" => 200, "msg" => "活动结束成功"]);
            }
            return json(["code" => 500, "msg" => "活动结束失败（当前活动已结束）"]);
        }
        if ($type == 2) {
            $result = \Think\Db::name("points_mall_prizes")->where("id", $id)->delete();
            if ($result) {
                return json(["code" => 200, "msg" => "活动删除成功"]);
            }
            return json(["code" => 500, "msg" => "活动删除失败（当前活动不存在）"]);
        }
        $this->assign("Title", "Demo样式2");
        return $this->fetch("/customerdetail1");
    }
    public function customerdetail2()
    {
        $this->assign("Title", "Demo样式3");
        return $this->fetch("/customerdetail2");
    }
    public function customerdetail3()
    {
        $this->assign("Title", "Demo样式4");
        return $this->fetch("/customerdetail3");
    }
    public function customerdetail4()
    {
        $this->assign("Title", "Demo样式5");
        return $this->fetch("/customerdetail4");
    }
}

?>