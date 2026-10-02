<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{$Title}</title>
    <link rel="stylesheet" href="/plugins/addons/points_mall/assets/css/points-mall.css" />
</head>
<body class="pm-body">
<div class="pm-container">

    <div class="pm-hero">
        <div class="pm-hero-top">
            <div>
                <h1 class="pm-hero-title">兑换记录</h1>
                <p class="pm-hero-sub">查看您的积分兑换与奖品发放进度</p>
            </div>
        </div>
        <div class="pm-nav">
            <span><a href="/addons?_plugin=points_mall&_controller=index&_action=index">签到中心</a></span>
            <span><a href="/addons?_plugin=points_mall&_controller=index&_action=task">积分任务</a></span>
            <span><a href="/addons?_plugin=points_mall&_controller=index&_action=exchange">积分商城</a></span>
            <span><a class="pm-nav-active" href="/addons?_plugin=points_mall&_controller=index&_action=record">兑换记录</a></span>
            {if $withdrawaldata != 0}
            <span><a href="/addons?_plugin=points_mall&_controller=index&_action=withdrawal">积分兑现</a></span>
            {/if}
        </div>
    </div>

    <div class="pm-section">
        <div class="pm-card">
            <div class="pm-table-wrap">
                <table class="pm-table">
                    <thead>
                        <tr>
                            <th>活动名称</th>
                            <th>奖品类型</th>
                            <th>消耗积分</th>
                            <th>兑换日期</th>
                            <th>发放状态</th>
                            <th>奖品详情</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                    {volist name='$data' id='info'}
                        <tr>
                            <td><b>{$info.name}</b></td>
                            <td>
                                {if $info.prize_type == '1'}<span class="pm-badge pm-badge-success">余额</span>
                                {elseif $info.prize_type == '2' /}<span class="pm-badge pm-badge-info">优惠券</span>
                                {elseif $info.prize_type == '3' /}<span class="pm-badge pm-badge-gold">实物奖品</span>
                                {elseif $info.prize_type == '4' /}<span class="pm-badge pm-badge-muted">其他奖品</span>
                                {else /}<span class="pm-badge pm-badge-muted">未知</span>{/if}
                            </td>
                            <td class="pm-num">{$info.required_points}</td>
                            <td>{:date('Y-m-d H:i:s',$info['exchange_time'])}</td>
                            <td>
                                {if $info.status == 0}<span class="pm-badge pm-badge-warning"><i class="fas fa-clock"></i> 待审核</span>
                                {elseif $info.status == 1 /}<span class="pm-badge pm-badge-success"><i class="fas fa-check-circle"></i> 已发放</span>
                                {elseif $info.status == 2 /}<span class="pm-badge pm-badge-danger"><i class="fas fa-times-circle"></i> 已拒绝</span>
                                {elseif $info.status == 3 /}<span class="pm-badge pm-badge-info"><i class="fas fa-exclamation-circle"></i> 待确认地址</span>
                                {else /}<span class="pm-badge pm-badge-muted">未知</span>{/if}
                            </td>
                            <td>
                                <?php
                                $config = json_decode($info['config'], true);
                                switch ($info['prize_type']) {
                                    case 1:
                                        echo '余额' . $config['amount'] . '元';
                                        break;
                                    case 2:
                                        echo '优惠码：' . (($info['code'] == '') ? '优惠码不存在' : $info['code']) . '<br>';
                                        echo '适用产品：' . (($config['applicable_products'] == '') ? '全部产品' : $config['applicable_products']) . '<br>';
                                        echo '优惠类型：' . (($config['discount_type'] == 'fixed') ? '固定金额' : '百分比') . '<br>';
                                        echo '优惠面值：' . $config['discount_percentage'] . (($config['discount_type'] == 'fixed') ? ' 元' : '%') . '<br>';
                                        break;
                                    case 3:
                                        $logistics = json_decode($info['logistics'], true);
                                        echo $info['name'] . '<br>';
                                        echo '物流公司：' . (($logistics['express_company'] == '') ? '待发货' : $logistics['express_company']) . '<br>';
                                        echo '快递单号：' . (($logistics['express_number'] == '') ? '待发货' : $logistics['express_number']) . '<br>';
                                        echo '发货时间：' . (($logistics['express_time'] == '') ? '待发货' : date('Y-m-d H:i:s', $logistics['express_time'])) . '<br>';
                                        break;
                                }
                                ?>
                            </td>
                            <td>
                                {if $info['status'] == 3 && $info['prize_type'] == 3}
                                <button class="pm-btn pm-btn-outline" onclick="receive('{$info.id}')">
                                    <i class="fas fa-map-marker-alt"></i> 填写收货地址
                                </button>
                                {/if}
                            </td>
                        </tr>
                    {/volist}

                    {if empty($data)}
                        <tr>
                            <td colspan="7" class="pm-empty">您还没有任何兑换记录</td>
                        </tr>
                    {/if}
                    </tbody>
                </table>
            </div>

            <div class="pm-pagination">
                当前页码：{$currentPage = $data->currentPage()}
                总页码：{$totalPages = $data->lastPage()}
                {if $currentPage > 1}
                <a href="/addons?_plugin=points_mall&_controller=index&_action=record&page={$currentPage - 1}">上一页</a>
                {/if}
                {if $currentPage < $totalPages}
                <a href="/addons?_plugin=points_mall&_controller=index&_action=record&page={$currentPage + 1}">下一页</a>
                {/if}
                <span>跳转到第</span>
                <input type="number" id="jumpToPage" min="1" max="{$totalPages}" value="{$currentPage + 1}">
                <span>页</span>
                <button onclick="jumpToPage()">跳转</button>
            </div>
        </div>
    </div>

</div>

<script src="/plugins/addons/points_mall/assets/layer.js"></script>
<script>
function jumpToPage() {
    var jumpInput = document.getElementById('jumpToPage');
    var targetPage = parseInt(jumpInput.value);
    if (targetPage >= 1 && targetPage <= <?php echo $totalPages; ?>) {
        window.location.href = "/addons?_plugin=points_mall&_controller=index&_action=record&page=" + targetPage;
    }
}

function receive(id) {
    layer.prompt({title: '填写收货地址', formType: 2}, function (address, index) {
        layer.close(index);
        layer.confirm('确认提交该收货地址？', {btn: ['确定', '取消'], icon: 3}, function () {
            var load = layer.load();
            $.ajax({
                url: '/addons?_plugin=points_mall&_controller=index&_action=confirm',
                type: 'post',
                data: {id: id, address: address},
                dataType: 'json',
                success: function (res) {
                    layer.close(load);
                    if (res.code != 200) {
                        layer.msg(res.msg, {icon: 2});
                    } else {
                        layer.msg(res.msg, {icon: 1}, function () {
                            location.reload();
                        });
                    }
                },
                error: function () {
                    layer.close(load);
                    layer.msg('请求失败，请重试');
                }
            });
        });
    });
}
</script>
</body>
</html>