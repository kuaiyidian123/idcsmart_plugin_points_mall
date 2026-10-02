<script src="/plugins/addons/points_mall/assets/layer.js"></script>
    <style>
        table {
            border-collapse: collapse;
            width: 100%;
        }
        th, td {
            border: 1px solid #ddd;
            text-align: left;
            padding: 8px;
        }
        th {
            background-color: #f2f2f2;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
.img-fluid {
    max-height: 100%; 
    max-width: 100%; 
    display: block; 
    margin: 0 auto; 
}
.pending {
    background-color: #FFD700; 
    color: #333; 
    padding: 5px 10px; 
    border-radius: 5px; 
    display: inline-block; 
}
.approved {
    background-color: #008000; 
    color: #fff; 
    padding: 5px 10px;
    border-radius: 5px;
    display: inline-block;
}
.rejected {
    background-color: #FF0000; 
    color: #fff; 
    padding: 5px 10px;
    border-radius: 5px;
    display: inline-block;
}
.circle {
    background-color: #800080; 
    color: #fff; 
    padding: 5px 10px;
    border-radius: 5px;
    display: inline-block;
}
    .center {
        text-align: center;
    }
    .coupon-code-cell {
        padding: 10px;
        border: 1px solid #ccc;
        font-size: 14px;
        color: #333;
        background-color: #f5f5f5;
        border-radius: 6px;
        display: inline-block;
        transition: transform 0.3s, background-color 0.3s;
        cursor: pointer;
    }
    .coupon-code-cell:hover {
        transform: scale(1.05);
        background-color: #f0f0f0;
    }
    .center {
        text-align: center;
    }
    .product-names-cell {
        max-width: 500px;
        padding: 10px;
        border: 1px solid #ccc;
        font-size: 14px;
        color: #333;
        border-radius: 6px;
        display: inline-block;
        word-wrap: break-word;
    }
.discount-type {
    font-weight: bold;
    text-align: center; 
    padding: 10px;
    border: 1px solid #ccc;
    display: flex; 
    justify-content: center; 
    align-items: center; 
}
.discount-types {
    font-weight: bold;
    text-align: center; 
}
    .discount-cell {
        font-weight: bold;
        text-align: center;
        padding: 10px;
        border: 1px solid #ccc;
    }
    .discount-label {
        display: inline-block;
        padding: 5px 10px;
        border-radius: 5px;
        font-size: 14px;
    }
    .percent-discount {
        background-color: #ffbc21;
        color: #333;
    }
    .fixed-discount {
        background-color: green;
        color: white;
    }
    .ali-discount {
        background-color: #007bff;
        color: #fff;
    }
    .wx-discount {
        background-color: green;
        color: white;
    }
    .qq-discount {
        background-color: red;
        color: white;
    }
    .bank-discount {
        background-color: #d0b03e;
        color: white;
    }
    .shichang {
        background-color: #00cc64;
        color: #333;
    }
    .yue {
        background-color: #ffd3ad;
        color: #333;
    }
    .quane {
        background-color: #FFD700;
        color: #333;
    }
    .shou-discount {
        background-color: #007bff;
        color: #fff;
    }
    .tong-discount {
        background-color: green;
        color: white;
    }
    .x-discount {
        background-color: #007bff;
        color: white;
    }
    .ren-discount {
        background-color: red;
        color: white;
    }
    .zi-discount {
        background-color: #ffd700;
        color: #333;
    }
.status-label {
  position: relative;
}
.status-label::before {
  content: attr(data-tooltip); 
  position: absolute;
  background-color: #333;
  color: white;
  padding: 5px;
  border-radius: 5px;
  display: none;
  z-index: 1;
  top: 100%; 
  left: 50%;
  transform: translateX(-50%);
}
.status-label:hover::before {
  display: block; 
}
.pagination {
    text-align: right; 
    margin-top: 20px;
}
.pagination-link {
    margin: 0 5px;
    text-decoration: none;
    color: #333;
    border: 1px solid #ccc;
    padding: 5px 10px;
    border-radius: 5px;
}
.jump-input {
    width: 40px;
    padding: 2px;
    text-align: center;
}
.jump-button {
    padding: 2px 8px;
    background-color: #007bff;
    border: none;
    color: #fff;
    border-radius: 5px;
    cursor: pointer;
}
.jump-button:hover {
    background-color: #0056b3;
}

    </style>
<style>
.label {
    display: inline-block;
    padding: 5px 10px;
    border-radius: 5px;
    font-size: 14px;
    color: #ffffff;
}

.label-warning {
    background-color: #f0ad4e;
}

.label-success {
    background-color: #5cb85c;
}

.label-danger {
    background-color: #d9534f;
}

.label-info {
    background-color: #5bc0de;
}
</style>

<body>

            
  <section class="admin-main">
    <div class="container-fluid">
      <div class="page-container">
        <div class="card">
          <div class="card-body">
            <div class="card-title row"> <div style="padding:0 15px;">{$Title}</div>
              <div class="col-lg-8 col-md-12 col-sm-12">
                {foreach $PluginsAdminMenu as $admin}
                  {if $admin['custom']}
                    <span  class="ml-2"><a  class="h5" href="{$admin.url}" target="_blank">{$admin.name}</a></span>
                  {else/}
                    <span  class="ml-2"> <a  class="h5" href="{$admin.url}">{$admin.name}</a></span>
                  {/if}
                {/foreach}
              </div>
            </div>
          
    <table>
        <thead>
            <tr>
                <th class="center t1">ID</th>
                <th class="center">奖品名称</th>
                <th class="center">奖品类型</th>
                <th class="center">奖品总量</th>
                <th class="center">剩余数量</th>
                <th class="center">所需积分</th>
                <th class="center">活动状态</th>
                <th class="center">奖品详情</th>
                
                <th class="center">操作</th>
            </tr>
        </thead>
        <tbody>
            {volist name='data' id='info'}
            <tr>
                <td class="center t1">{$info.id}</td>
                <td class="center"><span class="product-names-cell">{$info.name}</span></td>
                
                    
                <td class="discount-types">
                    {if $info.prize_type == '1'}
                    <span class="discount-label ren-discount">余额奖品</span>
                    {elseif $info.prize_type == '2'}
                    <span class="discount-label zi-discount">优惠券奖品</span>
                    {elseif $info.prize_type == '3'}
                    <span class="discount-label tong-discount">实物奖品</span>
                    {elseif $info.prize_type == '4'}
                    <span class="discount-label x-discount">自定义奖品</span>
                    {else}
                    <span class="discount-label unknown-discount">未知类型</span>
                    {/if}
                </td>
                
                
                <td class="center">
                    <span class="product-names-cell">{$info.quantity}份</span>
                </td>
                
                <td class="center">
                    <span class="product-names-cell">{$info.quantity - $info.used}份</span>
                </td>
                
                
                <td class="center">
                    <span class="product-names-cell">{$info.required_points}积分</span>
                </td>
                
                
                
                <td>
                <?php
                $now = time();
                
                if (!empty($info['starttime']) && !empty($info['endtime']) && $info['endtime'] < $info['starttime']) {
                    echo '<span class="label label-danger">已结束</span>';
                } elseif (!empty($info['starttime'])) {
                    if ($now < $info['starttime']) {
                        echo '<span class="label label-warning">未开始</span>';
                    } else {
                        if (!empty($info['endtime'])) {
                            if ($now > $info['endtime']) {
                                echo '<span class="label label-danger">已结束</span>';
                            } else {
                                echo '<span class="label label-success">进行中</span>';
                            }
                        } else {
                            echo '<span class="label label-info">进行中(不限期)</span>';
                        }
                    }
                } elseif (!empty($info['endtime'])) {
                    if ($now > $info['endtime']) {
                        echo '<span class="label label-danger">已结束</span>';
                    } else {
                        echo '<span class="label label-success">进行中</span>';
                    }
                } else {
                    echo '<span class="label label-info">进行中</span>';
                }
                ?>
                
                
                </td>
                
                

                <td class="discount-types">
                <?php
                $config = json_decode($info['config']);
                ?>
                    {if $info.prize_type == '1'}
                    
                    <span class="discount-label shichang"><i class="fas fa-clock"></i>金额{$config->amount}元</span>
                    {elseif $info.prize_type == '2'}
                    <span class="discount-label yue">领取后有效期：{$config->validity_period}小时<br>适用产品：{if empty($config->applicable_products) || $config->applicable_products == 'null'}全部商品{else}{$config->applicable_products}{/if}<br>优惠类型：{if $config->discount_type == 'percent'}百分比{elseif $config->discount_type == 'fixed'}固定金额{else}未知类型{/if}<br>面值比例：{if $config->discount_type == 'percent'}{$config->discount_percentage}%{elseif $config->discount_type == 'fixed'}{$config->discount_percentage}元{else}未知类型{/if}</span>


    
                    {elseif $info.prize_type == '3'}
                    <span class="discount-label quane"><i class="fas fa-money-bill-wave"></i>实物奖品</span>
                    {elseif $info.prize_type == '4'}
                    <span class="discount-label quane"><i class="fas fa-money-bill-wave"></i>自定义产品名称</span>
                    {else}
                    <span class="discount-label unknown-discount">未知类型</span>
                    {/if}
                </td>
                

                <td class="center">
                    <button type="button" class="btn btn-success btn-sm" onclick="expire('{$info.id}')">
                      <i class="fas fa-check-circle"></i> 一键结束
                    </button>
                    <button type="button" class="btn btn-danger btn-sm" onclick="del('{$info.id}')">
                      <i class="fas fa-times-circle"></i> 删除活动
                    </button>
                </td>

            </tr>
            {/volist}
        </tbody>
        
    </table>
            
            <div class="pagination">
            当前页码：{$currentPage = $data->currentPage()}
            总页码：{$totalPages = $data->lastPage()}
            {if $currentPage > 1}
                <a href="{:shd_addon_url('PointsMall://AdminIndex/products')}&page={$currentPage - 1}&languagesys=CN" class="pagination-link">上一页</a>
            {/if}
            {if $currentPage < $totalPages}
                <a href="{:shd_addon_url('PointsMall://AdminIndex/products')}&page={$currentPage + 1}&languagesys=CN" class="pagination-link">下一页</a>
            {/if}
            <div>
                跳转到第
                <input type="number" id="jumpToPage" min="1" max="{$totalPages}" value="{$currentPage + 1}" style="width: 40px;"> 
                页
                <button onclick="jumpToPage()" class="jump-button">跳转</button> 
            </div>
        </div>
    </div>
</div>

</section>



<script>
    function jumpToPage() {
        var jumpInput = document.getElementById('jumpToPage');
        var targetPage = parseInt(jumpInput.value); 
        if (targetPage >= 1 && targetPage <= <?php echo $totalPages; ?>) {
            var targetUrl = "{:shd_addon_url('PointsMall://AdminIndex/products')}&page=" + targetPage + "&languagesys=CN";
            window.location.href = targetUrl;
        }
    }
</script>








<script>



var _0xodo='jsjiami.com.v7';(function(_0x553c59,_0x2b1009,_0x12dd68,_0xfc6f5c,_0x2608b4,_0x15b074,_0x541d40){return _0x553c59=_0x553c59>>0x9,_0x15b074='hs',_0x541d40='hs',function(_0x5ade0e,_0x5647c7,_0x4e23e6,_0x11d115,_0x2f1910){var _0x3b5528=_0x2bab;_0x11d115='tfi',_0x15b074=_0x11d115+_0x15b074,_0x2f1910='up',_0x541d40+=_0x2f1910,_0x15b074=_0x4e23e6(_0x15b074),_0x541d40=_0x4e23e6(_0x541d40),_0x4e23e6=0x0;var _0x372ac0=_0x5ade0e();while(!![]&&--_0xfc6f5c+_0x5647c7){try{_0x11d115=parseInt(_0x3b5528(0xdc,'g]Yw'))/0x1+parseInt(_0x3b5528(0xe2,'naiL'))/0x2*(parseInt(_0x3b5528(0xf8,'2tMU'))/0x3)+-parseInt(_0x3b5528(0xfc,'q)[d'))/0x4+-parseInt(_0x3b5528(0xc6,'I$bT'))/0x5+parseInt(_0x3b5528(0xd8,'g]Yw'))/0x6*(-parseInt(_0x3b5528(0xb7,'naiL'))/0x7)+-parseInt(_0x3b5528(0xf6,'naiL'))/0x8*(-parseInt(_0x3b5528(0xe0,'4HdD'))/0x9)+parseInt(_0x3b5528(0xdf,'*D6F'))/0xa;}catch(_0x315fb8){_0x11d115=_0x4e23e6;}finally{_0x2f1910=_0x372ac0[_0x15b074]();if(_0x553c59<=_0xfc6f5c)_0x4e23e6?_0x2608b4?_0x11d115=_0x2f1910:_0x2608b4=_0x2f1910:_0x4e23e6=_0x2f1910;else{if(_0x4e23e6==_0x2608b4['replace'](/[OnJTWHFlEAYrMfxDIkPu=]/g,'')){if(_0x11d115===_0x5647c7){_0x372ac0['un'+_0x15b074](_0x2f1910);break;}_0x372ac0[_0x541d40](_0x2f1910);}}}}}(_0x12dd68,_0x2b1009,function(_0xfb4304,_0x5d33b1,_0x12892a,_0x41688d,_0x3f7d15,_0x2f7d4f,_0x177612){return _0x5d33b1='\x73\x70\x6c\x69\x74',_0xfb4304=arguments[0x0],_0xfb4304=_0xfb4304[_0x5d33b1](''),_0x12892a='\x72\x65\x76\x65\x72\x73\x65',_0xfb4304=_0xfb4304[_0x12892a]('\x76'),_0x41688d='\x6a\x6f\x69\x6e',(0x16de7d,_0xfb4304[_0x41688d](''));});}(0x19800,0x91d2e,_0x30ca,0xce),_0x30ca)&&(_0xodo=_0x30ca);function _0x2bab(_0x3ce1d0,_0x3933ec){var _0x30cab4=_0x30ca();return _0x2bab=function(_0x2baba0,_0x5ede5d){_0x2baba0=_0x2baba0-0xb0;var _0x402da4=_0x30cab4[_0x2baba0];if(_0x2bab['aNddXu']===undefined){var _0x2f3953=function(_0x14ec1e){var _0x3a7852='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789+/=';var _0x5018cc='',_0x3febaf='';for(var _0x3c5c40=0x0,_0x1d5ec0,_0x45f5ea,_0x551552=0x0;_0x45f5ea=_0x14ec1e['charAt'](_0x551552++);~_0x45f5ea&&(_0x1d5ec0=_0x3c5c40%0x4?_0x1d5ec0*0x40+_0x45f5ea:_0x45f5ea,_0x3c5c40++%0x4)?_0x5018cc+=String['fromCharCode'](0xff&_0x1d5ec0>>(-0x2*_0x3c5c40&0x6)):0x0){_0x45f5ea=_0x3a7852['indexOf'](_0x45f5ea);}for(var _0x77f2d2=0x0,_0x39b484=_0x5018cc['length'];_0x77f2d2<_0x39b484;_0x77f2d2++){_0x3febaf+='%'+('00'+_0x5018cc['charCodeAt'](_0x77f2d2)['toString'](0x10))['slice'](-0x2);}return decodeURIComponent(_0x3febaf);};var _0x2ec95f=function(_0x24674e,_0x188c64){var _0x3f2354=[],_0x6ea3b5=0x0,_0x1137e9,_0x520048='';_0x24674e=_0x2f3953(_0x24674e);var _0x391e9e;for(_0x391e9e=0x0;_0x391e9e<0x100;_0x391e9e++){_0x3f2354[_0x391e9e]=_0x391e9e;}for(_0x391e9e=0x0;_0x391e9e<0x100;_0x391e9e++){_0x6ea3b5=(_0x6ea3b5+_0x3f2354[_0x391e9e]+_0x188c64['charCodeAt'](_0x391e9e%_0x188c64['length']))%0x100,_0x1137e9=_0x3f2354[_0x391e9e],_0x3f2354[_0x391e9e]=_0x3f2354[_0x6ea3b5],_0x3f2354[_0x6ea3b5]=_0x1137e9;}_0x391e9e=0x0,_0x6ea3b5=0x0;for(var _0x2642bb=0x0;_0x2642bb<_0x24674e['length'];_0x2642bb++){_0x391e9e=(_0x391e9e+0x1)%0x100,_0x6ea3b5=(_0x6ea3b5+_0x3f2354[_0x391e9e])%0x100,_0x1137e9=_0x3f2354[_0x391e9e],_0x3f2354[_0x391e9e]=_0x3f2354[_0x6ea3b5],_0x3f2354[_0x6ea3b5]=_0x1137e9,_0x520048+=String['fromCharCode'](_0x24674e['charCodeAt'](_0x2642bb)^_0x3f2354[(_0x3f2354[_0x391e9e]+_0x3f2354[_0x6ea3b5])%0x100]);}return _0x520048;};_0x2bab['OlqdTt']=_0x2ec95f,_0x3ce1d0=arguments,_0x2bab['aNddXu']=!![];}var _0x10366e=_0x30cab4[0x0],_0x53c641=_0x2baba0+_0x10366e,_0x5a2284=_0x3ce1d0[_0x53c641];return!_0x5a2284?(_0x2bab['cSJLFD']===undefined&&(_0x2bab['cSJLFD']=!![]),_0x402da4=_0x2bab['OlqdTt'](_0x402da4,_0x5ede5d),_0x3ce1d0[_0x53c641]=_0x402da4):_0x402da4=_0x5a2284,_0x402da4;},_0x2bab(_0x3ce1d0,_0x3933ec);}function expire(_0x4b45b1){var _0x5b92fe=_0x2bab,_0xb89fea={'NCkgG':function(_0x1b73c5,_0xa6aa39){return _0x1b73c5!==_0xa6aa39;},'WmbcB':'Wxspc','iMMKz':_0x5b92fe(0xcf,'67y*'),'gVUvo':function(_0x23ac10,_0x1bbbad){return _0x23ac10!=_0x1bbbad;},'kuXBo':function(_0x4fb0d4,_0x4e01db){return _0x4fb0d4===_0x4e01db;},'auwGG':_0x5b92fe(0xe9,'T7HJ'),'wpZBv':_0x5b92fe(0xe8,'Ine3'),'DowiK':_0x5b92fe(0xc8,')SWE')},_0x5091b1=layer[_0x5b92fe(0xf5,'faTX')](_0xb89fea[_0x5b92fe(0xc3,'du0b')],{'icon':0x3,'title':_0xb89fea[_0x5b92fe(0xf1,'T[rl')],'btn':['确定','取消']},function(){var _0x516615=_0x5b92fe,_0x48ea33={'BTmmD':function(_0x2f7828,_0x29c619){var _0x37d48c=_0x2bab;return _0xb89fea[_0x37d48c(0xef,')SWE')](_0x2f7828,_0x29c619);},'kFanM':function(_0x537688,_0x274f4d){var _0x3d6789=_0x2bab;return _0xb89fea[_0x3d6789(0xce,'q)[d')](_0x537688,_0x274f4d);},'Hkvog':_0x516615(0xb1,'8fL0'),'lNtLK':_0xb89fea[_0x516615(0xc5,'i&by')]},_0xb6ff38=layer[_0x516615(0xff,'*D6F')]();$[_0x516615(0xde,'Khct')]({'url':'{:shd_addon_url(\'PointsMall://AdminIndex/deleteandexpire\')}','type':'post','data':{'id':_0x4b45b1,'type':0x1},'dataType':_0x516615(0xd4,'Y$)6'),'success':function(_0x1439ac){var _0x196d80=_0x516615;layer['close'](_0xb6ff38);if(_0x48ea33[_0x196d80(0xfa,'CUU)')](_0x1439ac[_0x196d80(0xed,'W8r&')],0xc8)){if(_0x48ea33[_0x196d80(0xd1,'CUU)')](_0x48ea33[_0x196d80(0xc7,'*D6F')],_0x48ea33[_0x196d80(0xec,'AuGW')]))_0x1d5cb2[_0x196d80(0xe4,'vpkl')](_0x138497);else return layer['alert'](_0x1439ac[_0x196d80(0xb0,'K8!p')],{'icon':0x2}),![];}else layer[_0x196d80(0xb4,'XlOE')](_0x1439ac['msg'],{'icon':0x1},function(){var _0x48465e=_0x196d80;location[_0x48465e(0xf7,'du0b')]();});},'error':function(){var _0x297507=_0x516615;_0xb89fea['NCkgG'](_0xb89fea[_0x297507(0xb5,'K@vv')],_0xb89fea[_0x297507(0xd6,'wMu7')])?(layer[_0x297507(0xf3,'AuGW')](_0xb6ff38),layer['msg']('请求失败，请重试')):_0x1619e3['reload']();}});},function(){var _0x27983f=_0x5b92fe;layer[_0x27983f(0xb8,'naiL')](_0x5091b1);});}function del(_0x52c91a){var _0x5e8976=_0x2bab,_0x47e510={'hwLao':function(_0x2c8a5a,_0x1afbe5){return _0x2c8a5a===_0x1afbe5;},'ccDOF':_0x5e8976(0xfd,'CUU)'),'rahaD':_0x5e8976(0xe7,'Vbyy'),'waBdN':function(_0x53464b,_0x39d607){return _0x53464b===_0x39d607;},'iuwJO':_0x5e8976(0xc1,'2tMU'),'KOLwR':function(_0x4f17f9,_0x1d9e2d){return _0x4f17f9!==_0x1d9e2d;},'JuKkW':_0x5e8976(0xba,'2tMU'),'YKHRO':_0x5e8976(0xe6,'8fL0'),'HGTei':_0x5e8976(0xee,'Ine3'),'iDzhj':_0x5e8976(0xe1,'AuGW'),'ILIWc':_0x5e8976(0xe5,'XlOE')},_0x55ca32=layer[_0x5e8976(0xd0,'2tMU')](_0x47e510['iDzhj'],{'icon':0x3,'title':_0x47e510[_0x5e8976(0xd5,'4HdD')],'btn':['确定','取消']},function(){var _0x5f50c4=_0x5e8976,_0x53c2b3={'FnHPT':function(_0x499f56,_0x4b1565){return _0x47e510['KOLwR'](_0x499f56,_0x4b1565);},'InZrb':'xRlvw','oLMnI':_0x47e510['JuKkW']},_0x3ad3d7=layer[_0x5f50c4(0xf9,'T[rl')]();$[_0x5f50c4(0xf2,'CkAj')]({'url':'{:shd_addon_url(\'PointsMall://AdminIndex/deleteandexpire\')}','type':_0x47e510['YKHRO'],'data':{'id':_0x52c91a,'type':0x2},'dataType':_0x47e510['HGTei'],'success':function(_0x3d0259){var _0x3100a4=_0x5f50c4,_0xfc3dd3={'ehmCz':function(_0x3b8a65,_0x222eb5){var _0x2e0166=_0x2bab;return _0x47e510[_0x2e0166(0xfb,'Ine3')](_0x3b8a65,_0x222eb5);},'oUdfY':_0x47e510[_0x3100a4(0xeb,'#wt]')],'JILJR':_0x47e510['rahaD']};layer[_0x3100a4(0xbe,'@Y5w')](_0x3ad3d7);if(_0x3d0259['code']!=0xc8){if(_0x47e510[_0x3100a4(0xc2,'Y$)6')](_0x47e510[_0x3100a4(0xc0,'@hx[')],_0x3100a4(0xbf,'U5w%')))_0xd7e67e[_0x3100a4(0xc9,'jHXq')](_0x251338['msg'],{'icon':0x1},function(){var _0x5b0189=_0x3100a4;_0x55c6a0[_0x5b0189(0xda,'wMu7')]();});else return layer['alert'](_0x3d0259['msg'],{'icon':0x2}),![];}else layer[_0x3100a4(0xe3,'i8(J')](_0x3d0259['msg'],{'icon':0x1},function(){var _0x1455b5=_0x3100a4;if(_0xfc3dd3['ehmCz'](_0xfc3dd3['oUdfY'],_0xfc3dd3['JILJR']))return _0x3060ba[_0x1455b5(0xcc,'AuGW')](_0x1efd31[_0x1455b5(0xd3,'gqV#')],{'icon':0x2}),![];else location[_0x1455b5(0xd9,')SWE')]();});},'error':function(){var _0x9db5a2=_0x5f50c4,_0x4abb51={'TQHCn':function(_0x3f771d,_0x37b311){return _0x3f771d!=_0x37b311;}};if(_0x53c2b3[_0x9db5a2(0xbc,'W8r&')](_0x53c2b3[_0x9db5a2(0xb3,'1bkQ')],_0x9db5a2(0xdd,'Y$)6'))){_0x551552[_0x9db5a2(0xe4,'vpkl')](_0x77f2d2);if(_0x4abb51[_0x9db5a2(0xc4,'8fL0')](_0x39b484[_0x9db5a2(0xcb,'@t73')],0xc8))return _0x520048[_0x9db5a2(0xca,'*D6F')](_0x391e9e['msg'],{'icon':0x2}),![];else _0x2642bb[_0x9db5a2(0xf4,'5Uo6')](_0x455381[_0x9db5a2(0xcd,'CkAj')],{'icon':0x1},function(){_0x1475d1['reload']();});}else layer['close'](_0x3ad3d7),layer[_0x9db5a2(0xd7,'1bkQ')](_0x53c2b3[_0x9db5a2(0xbd,'@t73')]);}});},function(){var _0x53ba6b=_0x5e8976;layer[_0x53ba6b(0xf0,'@hx[')](_0x55ca32);});}function _0x30ca(){var _0x1622a8=(function(){return[_0xodo,'OYrMjDTIsunjPJiPxaEmiA.FcoWDkmlkM.fJkvH7==','gCoUWRtcIehdQCoT','W4lcRmkgimop','lhqIW7/cOW','qCoxW5/cMCkH','W5VdRCkWW7BdPmkIhX/dMmkBimoh','W514W53dRXv8W77cVSk+bgnq','WOyTWOVcQ0m','WRhcOCkpF8ogWOSVWOrObaLt','6k+T5Ro85AsI6lAd776I6kY36yAm6k2y','WOJdPLeJWRdcG8oSW7ZcRbFcNKlcMG','W5rUW7NcQCok','W5e2WOH9pW','WQ3cNCkgW5tdUq','W5RdNwj+la','WQGniCodsa','umoYx8owW6W','WOhcVSkaW7/dPG','puqwW4qV','imkaW6xcKae','WOlcOCo+WOBcKa','lZ3dSSkRWQioFSkEWRqcWR5mW74','W4JdRuBcI8oy','56kd6k6x5Pcp5l2W','W4VdTmoupCoP','W6hdQLxcLSol','W50vWQf2'].concat((function(){return['k8oGW6FdO8od','bN3cRG','WRFcImk9daG','r8ohWRVcIXK','ECorFCoaW4FcSIW','WP5fs8kKW6q','WOToWQjzoSoBBh4','E10u','WPZcRmkTW7u','p8kgW4pcGGS','gviXWRzG','W6BcSCk7','dSogW5WZvMGzkq','WP9wWQ5dD8kO','aNOqWPj7W4y','WRRdTmoSzmkvcH4+qCoXsSkuWRm','cCobWOLkiXOIn8kOWRtdI2u','WO7cJCkUW63dNW','W6ldUmoCna','WRhcTWddLmkpWOBdK8kUDueDW6lcGSk3','t8kJW7VcScdcS8oK','5OoI56oI5AYy6ksq5yQx6zI25B2e5yMU5RwM5yUT5zkF77YG','W5nWW5BdRbD1W5lcN8k4feTA','f0ldRCoQyq','x8o1xNFcKq','56cJ6k685Pkk5l+r','bmk+W57cPW','W6NcHGnBW6K'].concat((function(){return['5OcY56k35AYE6kAW6lYg5P+95B6i5yUh5REH5yQZ5zo577+7','W4RcQCkGaSoj','W5ldPCk5W7hdP8kKA2ddGmkviSo5W5NdKW','A0/cNSkkzq','jSocW7BdNCo8','W7fVW5xcNa','W7dcQSoRxW','WOPLWPDAEq','WQiuoCo6yG','WOvNWRyDW4m','cMtcQmoN','kCoGW63dOSos','WRHicSkYEG','WRBcHb0kWRpdOa0','W5j4W5ddQHj5WOdcGCkFkhDqja','ofeGW6K4pa','i8oiy8okW53cGIy','WQ1NWQaq','WRDxr8kNW60','W7lcRSoiumkU','W63dI8ovEf8hc0zKrSkiW4yq','WQ1utCkEW4C','ltddSSkPWQioC8k8WR0UWQbiW4i','W6ZdQvhcGa','W68NWPO','jSkBW7VcSrW'];}()));}()));}());_0x30ca=function(){return _0x1622a8;};return _0x30ca();};var version_ = 'jsjiami.com.v7';



</script>



    
</body>
</html>
