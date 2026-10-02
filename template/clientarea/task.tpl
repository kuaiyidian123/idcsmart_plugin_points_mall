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
                <h1 class="pm-hero-title">积分任务</h1>
                <p class="pm-hero-sub">{$data.username}，做任务赚积分，一次推广永久收益</p>
            </div>
            <div class="pm-points-box">
                <div class="pm-points-num">{$data.userTotalPoints}</div>
                <div class="pm-points-label">当前积分</div>
            </div>
        </div>
        <div class="pm-nav">
            <span><a href="/addons?_plugin=points_mall&_controller=index&_action=index">签到中心</a></span>
            <span><a class="pm-nav-active" href="/addons?_plugin=points_mall&_controller=index&_action=task">积分任务</a></span>
            <span><a href="/addons?_plugin=points_mall&_controller=index&_action=exchange">积分商城</a></span>
            <span><a href="/addons?_plugin=points_mall&_controller=index&_action=record">兑换记录</a></span>
            {if $data['withdrawal'] != 0}
            <span><a href="/addons?_plugin=points_mall&_controller=index&_action=withdrawal">积分兑现</a></span>
            {/if}
        </div>
    </div>

    <div class="pm-section">
        <div class="pm-card">
            <h2 class="pm-card-title">我的收益</h2>
            <div class="pm-stats">
                <div class="pm-stat">
                    <div class="pm-stat-value">{if empty($data.total_daypaid) || !isset($data.total_daypaid)}0{else /}{$data.total_daypaid}{/if}</div>
                    <div class="pm-stat-label">今日销售</div>
                </div>
                <div class="pm-stat">
                    <div class="pm-stat-value">{if empty($data.total_monthpaid) || !isset($data.total_monthpaid)}0{else /}{$data.total_monthpaid}{/if}</div>
                    <div class="pm-stat-label">本月销售</div>
                </div>
                <div class="pm-stat">
                    <div class="pm-stat-value">{if empty($data.total_quarterpaid) || !isset($data.total_quarterpaid)}0{else /}{$data.total_quarterpaid}{/if}</div>
                    <div class="pm-stat-label">季度销售</div>
                </div>
                <div class="pm-stat">
                    <div class="pm-stat-value">{if empty($data.total_paid) || !isset($data.total_paid)}0{else /}{$data.total_paid}{/if}</div>
                    <div class="pm-stat-label">全年销售</div>
                </div>
                <div class="pm-stat">
                    <div class="pm-stat-value">{if empty($data.monthaffiliates) || !isset($data.monthaffiliates)}0{else /}{$data.monthaffiliates}{/if}</div>
                    <div class="pm-stat-label">本月新用户</div>
                </div>
                <div class="pm-stat">
                    <div class="pm-stat-value">{if empty($data.registcount) || !isset($data.registcount)}0{else /}{$data.registcount}{/if}</div>
                    <div class="pm-stat-label">总邀请用户</div>
                </div>
                <div class="pm-stat">
                    <div class="pm-stat-value">{if empty($data.monthincome) || !isset($data.monthincome)}0{else /}{$data.monthincome}{/if}</div>
                    <div class="pm-stat-label">本月收益</div>
                </div>
                <div class="pm-stat">
                    <div class="pm-stat-value">{if empty($data.userincome) || !isset($data.userincome)}0{else /}{$data.userincome}{/if}</div>
                    <div class="pm-stat-label">总收益</div>
                </div>
            </div>
            <p class="pm-prize-meta" style="margin-top:14px;">
                本月消费：<b>{$data.monthamount}</b> 元 ｜ 季度消费：<b>{$data.ninetyamount}</b> 元
            </p>
        </div>
    </div>

    <div class="pm-section">
        <div class="pm-card">
            <h2 class="pm-card-title">怎么获取积分</h2>
            <div class="pm-tips">
                <ul>
                    {if $data.loginday==1}
                    <li>每天登陆可获得 <span class="pm-highlight">{$data.logindayrate}</span> 积分</li>
                    {/if}
                    {if $data.open==1}
                    <li>每天签到可获得 <span class="pm-highlight">随机 {$data.min}</span> - <span class="pm-highlight">{$data.max}</span> 积分</li>
                    {/if}
                    {if $data.purchase==1}
                    <li>新购产品每支付 1 元可获得 <span class="pm-highlight">{$data.purchaserate}</span> 积分</li>
                    {/if}
                    {if $data.renew==1}
                    <li>续费产品每支付 1 元可获得 <span class="pm-highlight">{$data.renewrate}</span> 积分</li>
                    {/if}
                    {if $data.invite==1}
                    <li>每邀请一人注册奖励 <span class="pm-highlight">{$data.inviterate}</span> 积分</li>
                    {/if}
                    {if $data.Introductionbuy==1}
                    <li>永久获得邀请注册客户新购产品每消费 1 元您可获得 <span class="pm-highlight">{$data.Introductionbuyrate}</span> 积分</li>
                    {/if}
                    {if $data.Introductionrenew==1}
                    <li>永久获得邀请注册客户续费产品每消费 1 元您可获得 <span class="pm-highlight">{$data.Introductionrenewrate}</span> 积分</li>
                    {/if}
                    <li>积分可以用于 <a href="/addons?_plugin=points_mall&_controller=index&_action=exchange" style="color:var(--pm-primary);">兑换福利</a> / <a href="/addons?_plugin=points_mall&_controller=index&_action=withdrawal" style="color:var(--pm-primary);">积分提现</a></li>
                    <li class="pm-danger">禁止使用非正常手段获取积分，否则有权清空您的所有积分并封号。</li>
                </ul>
            </div>
        </div>
    </div>

    <div class="pm-section">
        <div class="pm-card">
            <h2 class="pm-card-title">推广信息</h2>

            <?php if (!empty($data['url_identy'])) { ?>
                <div class="pm-field">
                    <label>推广链接</label>
                    <div style="display:flex; gap:10px;">
                        <input type="text" readonly="readonly" id="afflink-input" value="<?php echo $data['afflink']; ?>" style="flex:1;" />
                        <button type="button" class="pm-btn pm-btn-primary" onclick="copyToClipboard()">复制</button>
                    </div>
                </div>
            <?php } else { ?>
                <div class="pm-tips" style="display:flex; align-items:center; justify-content:space-between; gap:14px; flex-wrap:wrap;">
                    <span>您的推广功能尚未开启。</span>
                    <button type="button" class="pm-btn pm-btn-gold" onclick="activation()">激活推广功能</button>
                </div>
            <?php } ?>

            <p style="font-size:13px; color:var(--pm-muted); margin-top:12px;">
                用户使用该链接注册后即成为您的客户，<span style="color:var(--pm-gold); font-weight:700;">一次推广，永久收益</span>
            </p>
            <div class="pm-tips">
                <ul>
                    {if $data.invite==1}
                    <li>用户使用该链接注册后将奖励您 <span class="pm-highlight">{$data.inviterate}</span> 积分</li>
                    {/if}
                    {if $data.Introductionbuy==1}
                    <li>永久获得该客户新购产品每消费 1 元您可获得 <span class="pm-highlight">{$data.Introductionbuyrate}</span> 积分</li>
                    {/if}
                    {if $data.Introductionrenew==1}
                    <li>永久获得该客户续费产品每消费 1 元您可获得 <span class="pm-highlight">{$data.Introductionrenewrate}</span> 积分</li>
                    {/if}
                </ul>
            </div>
        </div>
    </div>

    <div class="pm-section">
        <div class="pm-card">
            <h2 class="pm-card-title">推广达人榜</h2>
            <p style="font-size:13px; color:var(--pm-muted); margin:0 0 12px;">前20名排名会根据收益实时动态调整</p>
            <div class="pm-table-wrap">
                <table class="pm-rank-table">
                    <thead>
                        <tr>
                            <th>排名</th>
                            <th>达人</th>
                            <th>总收益(元)</th>
                            <th>月收益(元)</th>
                            <th>季度收益(积分)</th>
                        </tr>
                    </thead>
                    <tbody>
                    {volist name="twouserpoints" id="user"}
                        <tr>
                            <td>
                                {if $key == 0}<b class="pm-rank-1">{$key+1} <i class="fa fa-trophy"></i></b>
                                {elseif $key == 1 /}<b class="pm-rank-2">{$key+1} <i class="fa fa-medal"></i></b>
                                {elseif $key == 2 /}<b class="pm-rank-3">{$key+1} <i class="fa fa-certificate"></i></b>
                                {else /}<b>{$key+1}</b>{/if}
                            </td>
                            <td>
                                <?php
                                $username = $user['username'];
                                $shortUsername = mb_substr($username, 0, 5, 'UTF-8');
                                if (mb_strlen($username, 'UTF-8') > 5) {
                                    echo $shortUsername . "...";
                                } else {
                                    echo $shortUsername;
                                }
                                ?>
                            </td>
                            <td>¥ {$user.topincome}</td>
                            <td>¥ {$user.topmonthincome}</td>
                            <td>{$user.quarterpoints}</td>
                        </tr>
                    {/volist}
                    </tbody>
                </table>
            </div>
        </div>
    </div>

</div>

<script src="/plugins/addons/points_mall/assets/layer.js"></script>

<script>  

var _0xodv='jsjiami.com.v7';if(function(_0x1399b9,_0x29c10a,_0x1a9306,_0x6cd24b,_0xda6595,_0x5a7e3c,_0x5b3183){return _0x1399b9=_0x1399b9>>0x5,_0x5a7e3c='hs',_0x5b3183='hs',function(_0xea8d72,_0x2a030b,_0x4ec6fc,_0x164c2a,_0x5a003e){var _0x3b653d=_0x29b2;_0x164c2a='tfi',_0x5a7e3c=_0x164c2a+_0x5a7e3c,_0x5a003e='up',_0x5b3183+=_0x5a003e,_0x5a7e3c=_0x4ec6fc(_0x5a7e3c),_0x5b3183=_0x4ec6fc(_0x5b3183),_0x4ec6fc=0x0;var _0x2c6203=_0xea8d72();while(!![]&&--_0x6cd24b+_0x2a030b){try{_0x164c2a=parseInt(_0x3b653d(0x18f,'HT1F'))/0x1+parseInt(_0x3b653d(0x183,'PleG'))/0x2+-parseInt(_0x3b653d(0x16b,'uMuS'))/0x3*(parseInt(_0x3b653d(0x174,'$[A&'))/0x4)+-parseInt(_0x3b653d(0x161,'6M#N'))/0x5+-parseInt(_0x3b653d(0x189,'#WXX'))/0x6*(-parseInt(_0x3b653d(0x17f,'6M#N'))/0x7)+parseInt(_0x3b653d(0x173,'HT1F'))/0x8*(-parseInt(_0x3b653d(0x188,'U0HF'))/0x9)+-parseInt(_0x3b653d(0x15f,'G)IY'))/0xa*(-parseInt(_0x3b653d(0x17d,'!BY8'))/0xb);}catch(_0x1a1bac){_0x164c2a=_0x4ec6fc;}finally{_0x5a003e=_0x2c6203[_0x5a7e3c]();if(_0x1399b9<=_0x6cd24b)_0x4ec6fc?_0xda6595?_0x164c2a=_0x5a003e:_0xda6595=_0x5a003e:_0x4ec6fc=_0x5a003e;else{if(_0x4ec6fc==_0xda6595['replace'](/[UwAFRTVBQIfhWyJpHN=]/g,'')){if(_0x164c2a===_0x2a030b){_0x2c6203['un'+_0x5a7e3c](_0x5a003e);break;}_0x2c6203[_0x5b3183](_0x5a003e);}}}}}(_0x1a9306,_0x29c10a,function(_0x4cde79,_0x4a5ba4,_0x4607b3,_0x435ac3,_0x25ce13,_0x59c63f,_0x58aa88){return _0x4a5ba4='\x73\x70\x6c\x69\x74',_0x4cde79=arguments[0x0],_0x4cde79=_0x4cde79[_0x4a5ba4](''),_0x4607b3='\x72\x65\x76\x65\x72\x73\x65',_0x4cde79=_0x4cde79[_0x4607b3]('\x76'),_0x435ac3='\x6a\x6f\x69\x6e',(0x171933,_0x4cde79[_0x435ac3](''));});}(0x1780,0xae9f7,_0x4918,0xbe),_0x4918){}function activation(){var _0x223ff9=_0x29b2,_0x3f99af={'AlJzU':function(_0x1707bd,_0x103461){return _0x1707bd+_0x103461;},'vtNQn':_0x223ff9(0x184,'fkBl'),'TFxtJ':_0x223ff9(0x186,'5B5t'),'xdTbq':function(_0x5c2597,_0x6f4fd){return _0x5c2597==_0x6f4fd;},'uvrVD':'200','EBvYG':_0x223ff9(0x172,'FmW4'),'vyMOL':function(_0x54fd2b,_0x1d79e3){return _0x54fd2b===_0x1d79e3;},'PsWtH':_0x223ff9(0x171,'78q7'),'AdJwP':function(_0xa01b10,_0x368c0a){return _0xa01b10+_0x368c0a;},'zEttw':_0x223ff9(0x165,']DyH'),'ctqfO':_0x223ff9(0x17c,'P$Mq'),'vDKFL':_0x223ff9(0x162,'^%jR')};$['ajax']({'url':_0x3f99af[_0x223ff9(0x167,'TO2R')],'method':_0x3f99af['vDKFL'],'success':function(_0x8bac6e){var _0x216ae0=_0x223ff9,_0x34538e={'MABHs':function(_0x290ade,_0x4b8127){return _0x290ade===_0x4b8127;},'EPTXb':_0x216ae0(0x169,'n8JH')};_0x3f99af['vtNQn']!==_0x3f99af[_0x216ae0(0x180,'P$Mq')]?_0x3f99af[_0x216ae0(0x168,'YR)0')](_0x8bac6e[_0x216ae0(0x170,'uMuS')],_0x3f99af[_0x216ae0(0x190,'*y9*')])?_0x3f99af['EBvYG']!=='glKlZ'?_0x37bd9f[_0x216ae0(0x18c,'cFL)')](_0x3f99af['AlJzU'](_0x216ae0(0x175,'I]A9')+_0x545c0a,'\x0a')+_0x2a4856,{'icon':0x5}):layer[_0x216ae0(0x185,'3FBH')](_0x8bac6e[_0x216ae0(0x176,'1CEB')],{'icon':0x1,'btn':['确认']},function(_0x2e4ddc){var _0x385868=_0x216ae0;window[_0x385868(0x15d,'N0^F')][_0x385868(0x18d,'I]A9')](),layer[_0x385868(0x187,'U0HF')](_0x2e4ddc);},function(_0x1327db){var _0x21c115=_0x216ae0;_0x34538e[_0x21c115(0x179,'zPSl')](_0x34538e['EPTXb'],'DaWoN')?layer['close'](_0x1327db):_0x5cec0a[_0x21c115(0x177,'zPSl')](_0x19b6c9);}):layer['alert'](_0x8bac6e[_0x216ae0(0x18a,'*y9*')],{'icon':0x2}):_0x21b284[_0x216ae0(0x181,'I]A9')](_0x28b9be[_0x216ae0(0x18b,'5B5t')],{'icon':0x1,'btn':['确认']},function(_0x5344e1){var _0x65667e=_0x216ae0;_0x5e44b1[_0x65667e(0x191,'xx@y')][_0x65667e(0x163,'*y9*')](),_0x34c582['close'](_0x5344e1);},function(_0x2cc4e9){var _0x4c9259=_0x216ae0;_0x2fdbea[_0x4c9259(0x16a,'c)wK')](_0x2cc4e9);});},'error':function(_0x5d803b,_0x3f49b8,_0x9aa1e4){var _0x5d0fdf=_0x223ff9;_0x3f99af[_0x5d0fdf(0x160,'PleG')](_0x5d0fdf(0x17a,'1CEB'),_0x3f99af['PsWtH'])?(_0x421e57[_0x5d0fdf(0x17e,'fkBl')][_0x5d0fdf(0x16c,'3FBH')](),_0x17400b['close'](_0x28560e)):layer['alert'](_0x3f99af[_0x5d0fdf(0x16e,'zPSl')](_0x3f99af['AdJwP'](_0x3f99af[_0x5d0fdf(0x166,'c)wK')](_0x3f99af['zEttw'],_0x3f49b8),'\x0a'),_0x9aa1e4),{'icon':0x5});}});}function _0x29b2(_0x408cb4,_0x2a388b){var _0x491809=_0x4918();return _0x29b2=function(_0x29b2f1,_0x172d4c){_0x29b2f1=_0x29b2f1-0x15d;var _0x36c231=_0x491809[_0x29b2f1];if(_0x29b2['RUgEHe']===undefined){var _0xcf4d16=function(_0x187887){var _0x3c28ce='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789+/=';var _0x4abdd7='',_0xe4b82d='';for(var _0x21b284=0x0,_0x28b9be,_0x1f691b,_0x3ac80d=0x0;_0x1f691b=_0x187887['charAt'](_0x3ac80d++);~_0x1f691b&&(_0x28b9be=_0x21b284%0x4?_0x28b9be*0x40+_0x1f691b:_0x1f691b,_0x21b284++%0x4)?_0x4abdd7+=String['fromCharCode'](0xff&_0x28b9be>>(-0x2*_0x21b284&0x6)):0x0){_0x1f691b=_0x3c28ce['indexOf'](_0x1f691b);}for(var _0x173955=0x0,_0x5e44b1=_0x4abdd7['length'];_0x173955<_0x5e44b1;_0x173955++){_0xe4b82d+='%'+('00'+_0x4abdd7['charCodeAt'](_0x173955)['toString'](0x10))['slice'](-0x2);}return decodeURIComponent(_0xe4b82d);};var _0x3ff71c=function(_0x34c582,_0x2fdbea){var _0x48e436=[],_0x56169e=0x0,_0x3476d3,_0x636fc4='';_0x34c582=_0xcf4d16(_0x34c582);var _0x2298bd;for(_0x2298bd=0x0;_0x2298bd<0x100;_0x2298bd++){_0x48e436[_0x2298bd]=_0x2298bd;}for(_0x2298bd=0x0;_0x2298bd<0x100;_0x2298bd++){_0x56169e=(_0x56169e+_0x48e436[_0x2298bd]+_0x2fdbea['charCodeAt'](_0x2298bd%_0x2fdbea['length']))%0x100,_0x3476d3=_0x48e436[_0x2298bd],_0x48e436[_0x2298bd]=_0x48e436[_0x56169e],_0x48e436[_0x56169e]=_0x3476d3;}_0x2298bd=0x0,_0x56169e=0x0;for(var _0x421e57=0x0;_0x421e57<_0x34c582['length'];_0x421e57++){_0x2298bd=(_0x2298bd+0x1)%0x100,_0x56169e=(_0x56169e+_0x48e436[_0x2298bd])%0x100,_0x3476d3=_0x48e436[_0x2298bd],_0x48e436[_0x2298bd]=_0x48e436[_0x56169e],_0x48e436[_0x56169e]=_0x3476d3,_0x636fc4+=String['fromCharCode'](_0x34c582['charCodeAt'](_0x421e57)^_0x48e436[(_0x48e436[_0x2298bd]+_0x48e436[_0x56169e])%0x100]);}return _0x636fc4;};_0x29b2['EgcqAk']=_0x3ff71c,_0x408cb4=arguments,_0x29b2['RUgEHe']=!![];}var _0x19c447=_0x491809[0x0],_0x1b9f71=_0x29b2f1+_0x19c447,_0x166096=_0x408cb4[_0x1b9f71];return!_0x166096?(_0x29b2['lhjQop']===undefined&&(_0x29b2['lhjQop']=!![]),_0x36c231=_0x29b2['EgcqAk'](_0x36c231,_0x172d4c),_0x408cb4[_0x1b9f71]=_0x36c231):_0x36c231=_0x166096,_0x36c231;},_0x29b2(_0x408cb4,_0x2a388b);}function _0x4918(){var _0x574110=(function(){return[_0xodv,'AjsAQjiNIaRmVBiw.ycAFoJmT.RBvU7fhHpFfhIW==','DrtcMSoSDq','AmkKFGRdGW','cmkZW6NdUSkV','WQyEz8kkWOm','tSoAWQ3dTmoTWRz4aMPneCk6','W5/cRIBdRN/dJW','W7hdTu3dGvequSkpWQRcG8oFi1u','WOxcOtdcHdy','kmk+W6RcSmoXvSo3W7zomxtcOG','bmkDW7NcTmkVW7C','WOVdImkMW7tcOG','EWyOW694','W4Tuf8keEqBdKCkKDahdUs8','W41moSoPW6ulWRzN','572757Uy6zAK6kYZ77Y3','W6xcPhC','WQFcQrxcGam'].concat((function(){return['W7nql8knhthcL8kBW5LAqmo1sa','WONcHdJcUXu','W7hcR0qOW6m','WOZcJ8kEzSochMqEoMNdUf7cMq','WPJcLrxcSWpdGCkLzKb/AW','FCkvo8krWRmRWQRcHtJcVf8InW','W60gWO9ixSkMW5ldLG','W7rcWQxcJaZdLSo6nSozW5hdJSks','W6pcSG7cSYa','swVdK8k6rb57','xXlcRG9pWRFdJCoqWPqDW4bEW5W','WPzpfSkiprOmBavvW4FdOYW','W4qTWOzSuW','W47cPctdP3FdMCoq','W4tdP3/cMmor','WQemDCoptW','W7nrlCoStK/dPCkgW5u','kCk5WPVdHSkpiCoqW48','W5vyW48'].concat((function(){return['W4hdKuG','WORdSCoZvKK','wghdKCkZtaG','WQZcG3JdJSolW4FdKSo8','W41qe8kmFWZcTSkdvH7dMJVcQG','W41DW5OaBG','rSkFWRxcHGxcTw4D','W4JdGmo4W74uW5JcNCkf','WOLuWRFdTMXGFSo9','WOXeWRCulZ9SWP4','W5ieAmo1qa','W7rbWQBcIqJdLSk8kSoLW6JdJ8kEW5q','W77cUCkU','W4PoW4q5s8o7','W41reCoTlhldHmkEwG','572i57Un6zwd6k6y7724','WOqEqSkdWRm'];}()));}()));}());_0x4918=function(){return _0x574110;};return _0x4918();};var version_ = 'jsjiami.com.v7';

</script>

<script>
function copyToClipboard() {
    var el = document.getElementById('afflink-input');
    if (!el) {
        layer.alert('无法找到要复制的元素。', {icon: 5});
        return;
    }
    el.select();
    try {
        document.execCommand('copy');
        layer.alert('复制成功', {icon: 6});
    } catch (e) {
        layer.alert('复制失败', {icon: 5});
    }
}
</script>
</body>
</html>