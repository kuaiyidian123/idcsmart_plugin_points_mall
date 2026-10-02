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

{if $data['withdrawal'] == 0}
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
                <h1 class="pm-hero-title">积分兑现</h1>
                <p class="pm-hero-sub">把积分变现，轻松提现到账</p>
            </div>
            <div class="pm-points-box">
                <div class="pm-points-num">{$data.userIdTotalPoints}</div>
                <div class="pm-points-label">我的积分</div>
            </div>
        </div>
        <div class="pm-nav">
            <span><a href="/addons?_plugin=points_mall&_controller=index&_action=index">签到中心</a></span>
            <span><a href="/addons?_plugin=points_mall&_controller=index&_action=task">积分任务</a></span>
            <span><a href="/addons?_plugin=points_mall&_controller=index&_action=exchange">积分商城</a></span>
            <span><a href="/addons?_plugin=points_mall&_controller=index&_action=record">兑换记录</a></span>
            <span><a class="pm-nav-active" href="/addons?_plugin=points_mall&_controller=index&_action=withdrawal">积分兑现</a></span>
        </div>
    </div>

    <div class="pm-section">
        <div class="pm-card">
            <h2 class="pm-card-title">申请兑现</h2>
            <form id="config" class="pm-form">
                <div class="pm-field">
                    <label for="points">请输入您要兑现的积分</label>
                    <input type="text" name="points" id="points" placeholder="当前汇率为 {$data.proportion} 积分兑换 1 元" oninput="this.value = this.value.replace(/[^\d]/g, '')" />
                </div>

                <div class="pm-row">
                    <div class="pm-field">
                        <label for="payment_method">选择收款方式</label>
                        <select name="payment_method" id="payment_method">
                            {if in_array('alipay', explode(',', $data['payment_method']))}<option value="alipay">支付宝</option>{/if}
                            {if in_array('wechat', explode(',', $data['payment_method']))}<option value="wechat">微信</option>{/if}
                            {if in_array('qqpay', explode(',', $data['payment_method']))}<option value="qqpay">QQ钱包</option>{/if}
                            {if in_array('bank', explode(',', $data['payment_method']))}<option value="bank">银行卡</option>{/if}
                        </select>
                    </div>
                    <div class="pm-field">
                        <label for="account_number">请输入收款账号</label>
                        <input type="text" name="account_number" id="account_number" placeholder="请输入收款账号" />
                    </div>
                </div>

                <button class="pm-btn pm-btn-primary pm-btn-lg pm-btn-block" type="button" onclick="confirm()">立即兑现</button>
            </form>

            <div style="margin-top:16px; font-size:14px; text-align:center; color:var(--pm-muted);">
                您的当前积分：<b style="color:var(--pm-text);">{$data.userIdTotalPoints}</b>
                <?php if ($data['userIdTotalPoints'] < $data['proportion']): ?>
                    <span class="pm-danger">（您的积分不足以兑换，继续加油哦）</span>
                <?php endif; ?>
            </div>
        </div>
    </div>

    <div class="pm-section">
        <div class="pm-card">
            <h2 class="pm-card-title">提现规则</h2>
            <div class="pm-tips">
                <ul>
                    <li>积分兑现汇率：<span class="pm-highlight">{$data.proportion} 积分 = 1 元</span>，每次最少提现 <span class="pm-danger"><b>{$data.minimum}</b></span> 积分，即 <span class="pm-highlight"><b>{$minimum}</b></span> 元</li>
                    <?php if ($data['realname'] == 1): ?>
                    <li class="pm-danger" style="font-weight:bold;">申请提现前账号需先通过实名认证，以便提现金额转入您的该账号</li>
                    <?php endif; ?>
                    <li>如您选择的微信收款，请前往钱包开启账号转入功能</li>
                    <li>提现的申请，会在3-5个工作日内由人工审核并到账</li>
                    <li>禁止使用非正常手段获取积分，若发现作弊现象将扣除所有积分，并保留封禁账号的权力</li>
                    <li>若您遇到不解的疑问，可在QQ群内提问或发起工单进行咨询</li>
                </ul>
            </div>
        </div>
    </div>

    <div class="pm-section">
        <div class="pm-card">
            <h2 class="pm-card-title">提现记录</h2>
            <div class="pm-table-wrap">
                <table class="pm-table">
                    <thead>
                        <tr>
                            <th>时间</th>
                            <th>收款方式</th>
                            <th>积分</th>
                            <th>金额</th>
                            <th>状态</th>
                        </tr>
                    </thead>
                    <tbody>
                    <?php foreach ($confirmrecords as $record): ?>
                        <tr>
                            <td><?php echo date('Y-m-d H:i:s', $record['exchangetime']); ?></td>
                            <td>
                                <?php switch ($record['paymentmethod']) { case 'alipay': echo '支付宝'; break; case 'wechat': echo '微信'; break; case 'bank': echo '银行卡'; break; default: echo $record['paymentmethod']; } ?>
                            </td>
                            <td class="pm-num"><?php echo $record['integral']; ?></td>
                            <td class="pm-num"><?php echo $record['amount']; ?> 元</td>
                            <td>
                                <?php switch ($record['status']) { case 0: echo '<span class="pm-badge pm-badge-warning">待审核</span>'; break; case 1: echo '<span class="pm-badge pm-badge-success">已通过</span>'; break; case 2: echo '<span class="pm-badge pm-badge-danger" title="' . $record['reason'] . '">已拒绝</span>'; break; default: echo '<span class="pm-badge pm-badge-muted">未知状态</span>'; } ?>
                            </td>
                        </tr>
                    <?php endforeach; ?>
                    </tbody>
                </table>
            </div>

            <div class="pm-pagination">
                当前页码：{$currentPage = $confirmrecords->currentPage()}
                总页码：{$totalPages = $confirmrecords->lastPage()}
                {if $currentPage > 1}
                <a href="/addons?_plugin=points_mall&_controller=index&_action=withdrawal&page={$currentPage - 1}">上一页</a>
                {/if}
                {if $currentPage < $totalPages}
                <a href="/addons?_plugin=points_mall&_controller=index&_action=withdrawal&page={$currentPage + 1}">下一页</a>
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
        window.location.href = "/addons?_plugin=points_mall&_controller=index&_action=withdrawal&page=" + targetPage;
    }
}

function confirm() {
    var data = $('#config').serialize();
    var load = layer.load();
    $.ajax({
        url: '/addons?_plugin=points_mall&_controller=index&_action=withdrawalconfirm',
        type: 'post',
        data: data,
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