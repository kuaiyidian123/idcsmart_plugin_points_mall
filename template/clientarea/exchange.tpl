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

{if $data['exchange'] == 0}
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
                <h1 class="pm-hero-title">积分商城</h1>
                <p class="pm-hero-sub">精选好礼，积分任性兑</p>
            </div>
        </div>
        <div class="pm-nav">
            <span><a href="/addons?_plugin=points_mall&_controller=index&_action=index">签到中心</a></span>
            <span><a href="/addons?_plugin=points_mall&_controller=index&_action=task">积分任务</a></span>
            <span><a class="pm-nav-active" href="/addons?_plugin=points_mall&_controller=index&_action=exchange">积分商城</a></span>
            <span><a href="/addons?_plugin=points_mall&_controller=index&_action=record">兑换记录</a></span>
            {if $data['withdrawal'] != 0}
            <span><a href="/addons?_plugin=points_mall&_controller=index&_action=withdrawal">积分兑现</a></span>
            {/if}
        </div>
    </div>

    <div class="pm-section">
        <div class="pm-grid">
            {volist name="List" id="v"}
            <div class="pm-prize">
                <div class="pm-prize-head">
                    <h3 class="pm-prize-name">{$v.name}</h3>
                    <?php
                    $now = time();
                    $statusLabel = '进行中';
                    $statusClass = 'pm-badge-success';
                    if (!empty($v['starttime']) && !empty($v['endtime']) && $v['endtime'] < $v['starttime']) {
                        $statusLabel = '已结束'; $statusClass = 'pm-badge-muted';
                    } elseif (empty($v['starttime']) || is_null($v['starttime'])) {
                        if (!empty($v['endtime']) && $v['endtime'] < $now) {
                            $statusLabel = '已结束'; $statusClass = 'pm-badge-muted';
                        } else {
                            $statusLabel = '进行中'; $statusClass = 'pm-badge-success';
                        }
                    } elseif ($v['starttime'] > $now) {
                        $statusLabel = '未开始'; $statusClass = 'pm-badge-gold';
                    } elseif (empty($v['endtime']) || is_null($v['endtime'])) {
                        $statusLabel = '进行中'; $statusClass = 'pm-badge-success';
                    } elseif ($v['endtime'] < $now) {
                        $statusLabel = '已结束'; $statusClass = 'pm-badge-muted';
                    } else {
                        $statusLabel = '进行中'; $statusClass = 'pm-badge-success';
                    }
                    ?>
                    <span class="pm-badge <?php echo $statusClass; ?>"><?php echo $statusLabel; ?></span>
                </div>

                <p class="pm-prize-type">
                    <?php
                    $typeLabel = '未知';
                    switch ($v['prize_type']) {
                        case 1: $typeLabel = '余额'; break;
                        case 2: $typeLabel = '优惠券'; break;
                        case 3: $typeLabel = '实物'; break;
                        case 4: $typeLabel = '其他奖品'; break;
                    }
                    ?>
                    奖品类型：<?php echo $typeLabel; ?>
                </p>

                <div class="pm-prize-points">
                    {$v.required_points} <small>积分</small>
                </div>

                <p class="pm-prize-desc">{$v.description}</p>

                <p class="pm-prize-meta">剩余数量：{$v.quantity - $v.used} 份</p>
                <p class="pm-prize-meta">
                    兑换时间：<?php if ($v['starttime']) { echo date('Y-m-d H:i:s', $v['starttime']); } else { echo '已开始'; } ?>
                    - <?php if ($v['endtime']) { echo date('Y-m-d H:i:s', $v['endtime']); } else { echo '不限时间'; } ?>
                </p>

                <div class="pm-prize-foot">
                    <button class="pm-btn pm-btn-primary pm-btn-block" onclick="change({$v.id})">
                        <i class="fas fa-gift"></i> 立即兑换
                    </button>
                </div>
            </div>
            {/volist}
        </div>

        <div class="pm-card">
            <div class="pm-pagination">
                当前页码：{$currentPage = $List->currentPage()}
                总页码：{$totalPages = $List->lastPage()}
                {if $currentPage > 1}
                <a href="/addons?_plugin=points_mall&_controller=index&_action=exchange&page={$currentPage - 1}">上一页</a>
                {/if}
                {if $currentPage < $totalPages}
                <a href="/addons?_plugin=points_mall&_controller=index&_action=exchange&page={$currentPage + 1}">下一页</a>
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
        window.location.href = "/addons?_plugin=points_mall&_controller=index&_action=exchange&page=" + targetPage;
    }
}

function change(id) {
    var load = layer.load();
    $.ajax({
        url: '/addons?_plugin=points_mall&_controller=index&_action=change',
        type: 'post',
        data: {id: id},
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
}
</script>
</body>
</html>