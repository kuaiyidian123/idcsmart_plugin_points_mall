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

{if $data['open'] == 0}
    <div class="pm-card">
        <div class="pm-disabled">
            <img src="/plugins/addons/points_mall/template/public/true200.jpg" alt="帮助指引"/>
            <p>功能未开启，请联系管理员进行设置。</p>
        </div>
    </div>
{else /}

    <div class="pm-hero">
        <div class="pm-hero-top">
            <div>
                <h1 class="pm-hero-title">签到中心</h1>
                <p class="pm-hero-sub">每日签到赚积分，口令红包领不停</p>
            </div>
            <div class="pm-points-box">
                <div class="pm-points-num">{$userTotalPoints}</div>
                <div class="pm-points-label">我的积分</div>
            </div>
        </div>
        <div class="pm-nav">
            <span><a class="pm-nav-active" href="/addons?_plugin=points_mall&_controller=index&_action=index">签到中心</a></span>
            <span><a href="/addons?_plugin=points_mall&_controller=index&_action=task">积分任务</a></span>
            <span><a href="/addons?_plugin=points_mall&_controller=index&_action=exchange">积分商城</a></span>
            <span><a href="/addons?_plugin=points_mall&_controller=index&_action=record">兑换记录</a></span>
            {if $data['withdrawal'] != 0}
            <span><a href="/addons?_plugin=points_mall&_controller=index&_action=withdrawal">积分兑现</a></span>
            {/if}
        </div>
    </div>

    <div class="pm-section">
        <div class="pm-card" style="text-align:center;">
            <button class="pm-btn pm-btn-primary pm-btn-lg" onclick="sign()" style="margin-right:12px;">
                <i class="fas fa-calendar-check"></i> 立即签到
            </button>
            <button class="pm-btn pm-btn-gold pm-btn-lg" onclick="kouling()">
                <i class="fas fa-gift"></i> 口令红包
            </button>
        </div>
    </div>

    <div class="pm-section">
        <div class="pm-card">
            <h2 class="pm-card-title">积分记录</h2>
            <div class="pm-table-wrap">
                <table class="pm-table">
                    <thead>
                        <tr>
                            <th>日期</th>
                            <th>获得/减少</th>
                            <th>剩余积分</th>
                            <th>类型</th>
                            <th>来源</th>
                            <th>获得时间</th>
                            <th>说明</th>
                        </tr>
                    </thead>
                    <tbody>
                    <?php foreach ($pointsrecords as $item): ?>
                        <tr>
                            <td>{$item.sign_date}</td>
                            <td class="pm-num">
                                {if $item.type == '1'}<span class="pm-points-plus">+{$item.points}</span>
                                {else /}<span class="pm-points-minus">{$item.points}</span>{/if}
                            </td>
                            <td class="pm-num">{$item.total_points}</td>
                            <td>
                                {if $item.type == '0'}<span class="pm-badge pm-badge-danger">减少</span>
                                {elseif $item.type == '1' /}<span class="pm-badge pm-badge-success">增加</span>
                                {else /}<span class="pm-badge pm-badge-muted">未知</span>{/if}
                            </td>
                            <td>
                                {if $item.source == '0'}<span class="pm-badge pm-badge-muted">兑换</span>
                                {elseif $item.source == '1' /}<span class="pm-badge pm-badge-info">每日签到</span>
                                {elseif $item.source == '2' /}<span class="pm-badge pm-badge-info">新购产品</span>
                                {elseif $item.source == '3' /}<span class="pm-badge pm-badge-info">产品续费</span>
                                {elseif $item.source == '4' /}<span class="pm-badge pm-badge-warning">推介购买</span>
                                {elseif $item.source == '5' /}<span class="pm-badge pm-badge-warning">推介续费</span>
                                {elseif $item.source == '6' /}<span class="pm-badge pm-badge-info">每天登陆</span>
                                {elseif $item.source == '7' /}<span class="pm-badge pm-badge-info">邀请注册</span>
                                {elseif $item.source == '8' /}<span class="pm-badge pm-badge-danger">提现</span>
                                {elseif $item.source == '9' /}<span class="pm-badge pm-badge-muted">退回</span>
                                {elseif $item.source == '10' /}<span class="pm-badge pm-badge-gold">赠送</span>
                                {elseif $item.source == '11' /}<span class="pm-badge pm-badge-gold">口令红包</span>
                                {else /}<span class="pm-badge pm-badge-muted">未知</span>{/if}
                            </td>
                            <td>{:date('Y-m-d H:i:s',$item['sign_time'])}</td>
                            <td>{$item.note}</td>
                        </tr>
                    <?php endforeach; ?>
                    </tbody>
                </table>
            </div>

            <div class="pm-pagination">
                当前页码：{$currentPage = $pointsrecords->currentPage()}
                总页码：{$totalPages = $pointsrecords->lastPage()}
                {if $currentPage > 1}
                <a href="/addons?_plugin=points_mall&_controller=index&_action=index&page={$currentPage - 1}">上一页</a>
                {/if}
                {if $currentPage < $totalPages}
                <a href="/addons?_plugin=points_mall&_controller=index&_action=index&page={$currentPage + 1}">下一页</a>
                {/if}
                <span>跳转到第</span>
                <input type="number" id="jumpToPage" min="1" max="{$totalPages}" value="{$currentPage + 1}">
                <span>页</span>
                <button onclick="jumpToPage()">跳转</button>
            </div>
        </div>
    </div>

{/if}

</div>

<script src="/plugins/addons/points_mall/assets/layer.js"></script>
<script>
function jumpToPage() {
    var jumpInput = document.getElementById('jumpToPage');
    var targetPage = parseInt(jumpInput.value);
    if (targetPage >= 1 && targetPage <= <?php echo $totalPages; ?>) {
        window.location.href = "/addons?_plugin=points_mall&_controller=index&_action=index&page=" + targetPage;
    }
}

function sign() {
    var load = layer.load();
    $.ajax({
        url: '/addons?_plugin=points_mall&_controller=index&_action=sign',
        type: 'post',
        dataType: 'json',
        success: function (res) {
            layer.close(load);
            if (res.code == 200) {
                layer.msg(res.msg, {icon: 1});
                window.location.reload();
            } else {
                layer.msg(res.msg, {icon: 2});
            }
        },
        error: function () {
            layer.close(load);
            layer.msg('请求失败，请重试');
        }
    });
}

function kouling() {
    layer.prompt({title: '请输入口令红包', formType: 0}, function (value, index) {
        layer.close(index);
        var load = layer.load();
        $.ajax({
            url: '/addons?_plugin=points_mall&_controller=index&_action=kouling',
            type: 'post',
            dataType: 'json',
            data: {kouling: value},
            success: function (res) {
                layer.close(load);
                if (res.code == 200) {
                    layer.msg(res.msg, {icon: 1});
                    window.location.reload();
                } else {
                    layer.msg(res.msg, {icon: 2});
                }
            },
            error: function () {
                layer.close(load);
                layer.msg('请求失败，请重试');
            }
        });
    });
}
</script>
</body>
</html>