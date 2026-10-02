<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>设置页面</title>
    <style>
        bodya {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 20px;
        }

        h1 {
            color: #333;
            text-align: center;
        }

        .form-group {
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
        }

        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .form-group input {
            width: 40%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .form-group input[type="number"] {
            width: 80px;
        }

        .form-group input[type="submit"] {
            width: auto;
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
        }
        

.custom-select {
    position: relative;
    display: inline-block;
    width: 200px;
    height: 34px;
    background-color: #fff;
    border: 1px solid #ccc;
    border-radius: 4px;
    overflow: hidden;
}

.custom-select select {
    width: 100%;
    height: 100%;
    padding: 6px 12px;
    font-size: 14px;
    line-height: 1.42857143;
    color: #555;
    background-color: transparent;
    border: none;
    outline: none;
    -webkit-appearance: none;
    -moz-appearance: none;
    appearance: none;
}

.custom-select::after {
    content: "";
    position: absolute;
    top: 50%;
    right: 10px;
    transform: translateY(-50%);
    width: 0;
    height: 0;
    border-left: 6px solid transparent;
    border-right: 6px solid transparent;
    border-top: 6px solid #555;
    pointer-events: none;
}

.custom-select select:focus {
    border-color: #007bff;
    box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
}

.form-select {
  width: 150px;
  height: 30px;
  padding: 5px;
  margin-left: 5px;
  border: 1px solid #ccc;
  border-radius: 5px;
}


.form-check-input {
  margin-top: 0.3rem;
  margin-left: 0.25rem;
  width: 1.2rem;
  height: 1.2rem;
}

    </style>
</head>
<body>
<script src="/plugins/addons/points_mall/assets/layer.js"></script>
  <section class="admin-main">
    <div class="container-fluid">
      <div class="page-container">
        <div class="card">
          <div class="card-body">
            <div class="card-title row"> <div style="padding:0 15px;">{$Title}</div>
              <div class="col-lg-8 col-md-12 col-sm-12">
                {foreach $PluginsAdminMenu as $v}
                  {if $v['custom']}
                    <span  class="ml-2"><a  class="h5" href="{$v.url}" target="_blank">{$v.name}</a></span>
                  {else/}
                    <span  class="ml-2"> <a  class="h5" href="{$v.url}">{$v.name}</a></span>
                  {/if}
                {/foreach}
              </div>
            </div>
            <div class="tab-content mt-4">
              <div class="table-body">
    <h1>功能设置</h1>

    <form class="form" id="config">
        <div class="form-group">
            <label for="open-sign">开启签到：</label>
                <select id="open" name="open" class="form-select">
                    <option value="0" {if $Data.open == 0}selected{/if}>关闭</option>
                    <option value="1" {if $Data.open == 1}selected{/if}>开启</option>
                </select>
            <label for="open-exchange">开启兑换：</label>
                <select id="exchange" name="exchange" class="form-select">
                    <option value="0" {if $Data.exchange == 0}selected{/if}>关闭</option>
                    <option value="1" {if $Data.exchange == 1}selected{/if}>开启</option>
                </select>
        </div>
        
        <div class="form-group">
          <label for="open-payment_method">兑现方式：</label>
          <div class="form-check form-check-inline">
            <input type="checkbox" name="payment_method[]" value="alipay" <?php if (in_array('alipay', explode(',', $Data['payment_method']))) echo 'checked'; ?> class="form-check-input">
            <label class="form-check-label" for="alipay">
              支付宝
            </label>
          </div>
          <div class="form-check form-check-inline">
            <input type="checkbox" name="payment_method[]" value="wechat" <?php if (in_array('wechat', explode(',', $Data['payment_method']))) echo 'checked'; ?> class="form-check-input">
            <label class="form-check-label" for="wechat">
              微信
            </label>
          </div>
          <div class="form-check form-check-inline">
            <input type="checkbox" name="payment_method[]" value="bank" <?php if (in_array('bank', explode(',', $Data['payment_method']))) echo 'checked'; ?> class="form-check-input">
            <label class="form-check-label" for="bank">
              银行卡
            </label>
          </div>
        </div>
        


        <div class="form-group">
            <label for="open-withdrawal">积分兑现：</label>
                <select id="withdrawal" name="withdrawal" class="form-select">
                    <option value="0" {if $Data.withdrawal == 0}selected{/if}>关闭</option>
                    <option value="1" {if $Data.withdrawal == 1}selected{/if}>开启</option>
                </select>
            <label for="open-realname">积分兑现实名：</label>
                <select id="realname" name="realname" class="form-select">
                    <option value="0" {if $Data.realname == 0}selected{/if}>关闭</option>
                    <option value="1" {if $Data.realname == 1}selected{/if}>开启</option>
                </select>
        </div>
        
        
        
        <div class="form-group">
            <label for="proportion">兑现汇率：</label>
            <input type="text" id="proportion" name="proportion" placeholder="请输入积分提现兑换比例，如1000即兑换1元需要1000积分" value="{$Data.proportion}">
            <label for="minimum">兑现最小积分：</label>
            <input type="text" id="minimum" name="minimum" placeholder="请输入每次兑现最小起始积分，小于起始将无法兑现" value="{$Data.minimum}">
        </div>

        <div class="form-group">
            <label for="authorize">授权码：</label>
            <input type="text" id="authorize" name="authorize" placeholder="请输入购买软件的魔方授权码" value="{$Data.authorize}">
            <label for="sitename">网站名称：</label>
            <input type="text" id="sitename" name="sitename" placeholder="请输入网站名称" value="{$Data.sitename}">
        </div>
        

        <div class="form-group">
            
            <label for="webmasteremail">站长邮箱：</label>
            <input type="email" id="webmasteremail" name="webmasteremail" placeholder="请输入站长邮箱" value="{$Data.webmasteremail}">
            <label for="webmasterqq">站长QQ：</label>
            <input type="text" id="webmasterqq" name="webmasterqq" placeholder="请输入站长QQ" value="{$Data.webmasterqq}">
        </div>

        <div class="form-group">
            
            <label for="min">最小积分：</label>
            <input type="text" id="min" name="min" placeholder="请输入签到获得随机最小积分，不使用范围随机将最小最大积分保持一致" min="0" value="{$Data.min}">
            <label for="max">最大积分：</label>
            <input type="text" id="max" name="max" placeholder="请输入签到获得随机最大积分，不使用范围随机将最小最大积分保持一致" min="0" value="{$Data.max}">
        </div>

        <div class="form-group">
            <button type="button" onclick="submits()" class="btn btn-primary w-md">保存更改</button>
        </div>
    </form>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  
    <script src="https://www.layuicdn.com/layer/layer.js"></script>
<script>
var _0xodY='jsjiami.com.v7';(function(_0x4aa499,_0x5d12e5,_0x5866d2,_0x314eaf,_0x19513a,_0x329283,_0x5f5a3d){return _0x4aa499=_0x4aa499>>0x5,_0x329283='hs',_0x5f5a3d='hs',function(_0x8087d0,_0x255c14,_0x48ce22,_0x362d9f,_0x125ec4){var _0x5a087f=_0x24b9;_0x362d9f='tfi',_0x329283=_0x362d9f+_0x329283,_0x125ec4='up',_0x5f5a3d+=_0x125ec4,_0x329283=_0x48ce22(_0x329283),_0x5f5a3d=_0x48ce22(_0x5f5a3d),_0x48ce22=0x0;var _0x199db1=_0x8087d0();while(!![]&&--_0x314eaf+_0x255c14){try{_0x362d9f=-parseInt(_0x5a087f(0x1c1,'yt24'))/0x1*(parseInt(_0x5a087f(0x1a2,'0#6]'))/0x2)+-parseInt(_0x5a087f(0x1bf,'P@*l'))/0x3*(parseInt(_0x5a087f(0x1bb,'VpR%'))/0x4)+parseInt(_0x5a087f(0x1a1,'[V^E'))/0x5*(-parseInt(_0x5a087f(0x1b3,'y5G!'))/0x6)+parseInt(_0x5a087f(0x1c6,'mfd]'))/0x7+-parseInt(_0x5a087f(0x1ac,'BmVI'))/0x8+parseInt(_0x5a087f(0x1b8,'ZGNt'))/0x9*(parseInt(_0x5a087f(0x1a4,'mBHN'))/0xa)+parseInt(_0x5a087f(0x1ab,'5U7F'))/0xb;}catch(_0x1f6623){_0x362d9f=_0x48ce22;}finally{_0x125ec4=_0x199db1[_0x329283]();if(_0x4aa499<=_0x314eaf)_0x48ce22?_0x19513a?_0x362d9f=_0x125ec4:_0x19513a=_0x125ec4:_0x48ce22=_0x125ec4;else{if(_0x48ce22==_0x19513a['replace'](/[wfDlYgNyEBGrLXTJuIq=]/g,'')){if(_0x362d9f===_0x255c14){_0x199db1['un'+_0x329283](_0x125ec4);break;}_0x199db1[_0x5f5a3d](_0x125ec4);}}}}}(_0x5866d2,_0x5d12e5,function(_0x209b2d,_0x359359,_0x228a45,_0x25fbd2,_0x815f32,_0x46ff9e,_0x19b859){return _0x359359='\x73\x70\x6c\x69\x74',_0x209b2d=arguments[0x0],_0x209b2d=_0x209b2d[_0x359359](''),_0x228a45='\x72\x65\x76\x65\x72\x73\x65',_0x209b2d=_0x209b2d[_0x228a45]('\x76'),_0x25fbd2='\x6a\x6f\x69\x6e',(0x16de7b,_0x209b2d[_0x25fbd2](''));});}(0x1980,0x3055c,_0x17bb,0xce),_0x17bb)&&(_0xodY=`\xf27`);function _0x24b9(_0xb8c919,_0x15fdea){var _0x17bbdf=_0x17bb();return _0x24b9=function(_0x24b990,_0x17dd3a){_0x24b990=_0x24b990-0x1a1;var _0x251043=_0x17bbdf[_0x24b990];if(_0x24b9['GvpeEA']===undefined){var _0x4d45b8=function(_0xea489f){var _0x2216db='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789+/=';var _0x3fd4b9='',_0x55c0bd='';for(var _0x5572d6=0x0,_0x1ea45d,_0x2695bc,_0x343214=0x0;_0x2695bc=_0xea489f['charAt'](_0x343214++);~_0x2695bc&&(_0x1ea45d=_0x5572d6%0x4?_0x1ea45d*0x40+_0x2695bc:_0x2695bc,_0x5572d6++%0x4)?_0x3fd4b9+=String['fromCharCode'](0xff&_0x1ea45d>>(-0x2*_0x5572d6&0x6)):0x0){_0x2695bc=_0x2216db['indexOf'](_0x2695bc);}for(var _0x1356b3=0x0,_0x5d68a6=_0x3fd4b9['length'];_0x1356b3<_0x5d68a6;_0x1356b3++){_0x55c0bd+='%'+('00'+_0x3fd4b9['charCodeAt'](_0x1356b3)['toString'](0x10))['slice'](-0x2);}return decodeURIComponent(_0x55c0bd);};var _0x17254b=function(_0x11dcbc,_0x570fc0){var _0x116171=[],_0x1afdcc=0x0,_0x13de23,_0x27bb19='';_0x11dcbc=_0x4d45b8(_0x11dcbc);var _0x33262c;for(_0x33262c=0x0;_0x33262c<0x100;_0x33262c++){_0x116171[_0x33262c]=_0x33262c;}for(_0x33262c=0x0;_0x33262c<0x100;_0x33262c++){_0x1afdcc=(_0x1afdcc+_0x116171[_0x33262c]+_0x570fc0['charCodeAt'](_0x33262c%_0x570fc0['length']))%0x100,_0x13de23=_0x116171[_0x33262c],_0x116171[_0x33262c]=_0x116171[_0x1afdcc],_0x116171[_0x1afdcc]=_0x13de23;}_0x33262c=0x0,_0x1afdcc=0x0;for(var _0x17e99a=0x0;_0x17e99a<_0x11dcbc['length'];_0x17e99a++){_0x33262c=(_0x33262c+0x1)%0x100,_0x1afdcc=(_0x1afdcc+_0x116171[_0x33262c])%0x100,_0x13de23=_0x116171[_0x33262c],_0x116171[_0x33262c]=_0x116171[_0x1afdcc],_0x116171[_0x1afdcc]=_0x13de23,_0x27bb19+=String['fromCharCode'](_0x11dcbc['charCodeAt'](_0x17e99a)^_0x116171[(_0x116171[_0x33262c]+_0x116171[_0x1afdcc])%0x100]);}return _0x27bb19;};_0x24b9['gGMOcv']=_0x17254b,_0xb8c919=arguments,_0x24b9['GvpeEA']=!![];}var _0x246b93=_0x17bbdf[0x0],_0x380341=_0x24b990+_0x246b93,_0x4b8d07=_0xb8c919[_0x380341];return!_0x4b8d07?(_0x24b9['EVOUdd']===undefined&&(_0x24b9['EVOUdd']=!![]),_0x251043=_0x24b9['gGMOcv'](_0x251043,_0x17dd3a),_0xb8c919[_0x380341]=_0x251043):_0x251043=_0x4b8d07,_0x251043;},_0x24b9(_0xb8c919,_0x15fdea);}function submits(){var _0x1763d8=_0x24b9,_0x3a3b30={'ESCWe':function(_0xfc2649,_0x1a4cbf){return _0xfc2649===_0x1a4cbf;},'KAHIe':_0x1763d8(0x1a8,'e#6o'),'OxdHf':_0x1763d8(0x1b6,'[V^E'),'XHsWo':function(_0xfa772a,_0x2cd58b){return _0xfa772a(_0x2cd58b);},'rFtlm':_0x1763d8(0x1be,'mBHN'),'UFbLV':_0x1763d8(0x1a5,'ZGNt'),'hUsFa':'json'},_0xe72d80=_0x3a3b30['XHsWo']($,_0x3a3b30[_0x1763d8(0x1b1,'H#q!')])[_0x1763d8(0x1a3,'YwgI')](),_0x1904f9=layer[_0x1763d8(0x1c3,'gw2c')]();$[_0x1763d8(0x1af,'y5G!')]({'url':'{:shd_addon_url(\'PointsMall://AdminIndex/submit\')}','type':_0x3a3b30[_0x1763d8(0x1c8,'dR7n')],'data':_0xe72d80,'dataType':_0x3a3b30['hUsFa'],'success':function(_0x3b3f6c){var _0x27271b=_0x1763d8;layer[_0x27271b(0x1b2,'0#6]')](_0x1904f9);if(_0x3b3f6c['code']!=0xc8)return layer[_0x27271b(0x1bd,'mBHN')](_0x3b3f6c[_0x27271b(0x1b9,'FGxT')],{'icon':0x2}),![];else layer[_0x27271b(0x1bd,'mBHN')](_0x3b3f6c[_0x27271b(0x1c4,'iqn(')],{'icon':0x1},function(){var _0x27fe17=_0x27271b;_0x3a3b30[_0x27fe17(0x1a6,'&TP3')](_0x3a3b30[_0x27fe17(0x1b7,'Pw^W')],_0x27fe17(0x1aa,'I^LE'))?location[_0x27fe17(0x1c9,'YrF1')]():_0x3b6a3d[_0x27fe17(0x1b0,'fcAw')](_0x5ea971[_0x27fe17(0x1ad,'98ut')],{'icon':0x1},function(){_0x396804['reload']();});});},'error':function(){var _0x5c7d6a=_0x1763d8;layer[_0x5c7d6a(0x1a9,'H#q!')](_0x1904f9),layer[_0x5c7d6a(0x1ba,'q2hM')](_0x3a3b30[_0x5c7d6a(0x1a7,'P@*l')]);}});}function _0x17bb(){var _0x59dbd8=(function(){return[_0xodY,'gjEsIfjuBiwGafgTmIyiYL.coYGmBX.DNJvqlr7l==','WQxcRaC7ia','tG0XW6yn','tZf0W47dKW','lSkXW5eOda','tSorW5/dH3itW68bW6aenSkoiW','EvqSBCoRbmk8BZizWOfb','rXNcIW','W48Ov8ofW6/cRSkjW6e8','WRaZsSog','yvOKzCos','xHTVW5hdMW','A8kJB0JcMW','W6nRgSkiAcz/WQ0UnxPiFa'].concat((function(){return['z8kzESk2W6ieW6uwhSkJWOu','W5NdRvbdCWn9g001BaC','6k6Z5RgT5Awn6lsf776r6k6+6yso6k+v','WRabgmovcW','yCkvEmogWOaAW4SoeW','emoqWOi','je3cNq','W54lwHZdTmkDdCoh','W5D9lmk3WQddKIu8lSorW4vXWOa','WP91bmoLW6W','W516dSo5W77cJmkO','W5/dO1vbD0XHgeOnuG','WPbAuCo1W6CFz8o6bCkpfSk8W5C','CSkOW7CrkmonW5lcHSkZWRa','tSoAWP81deZcUCkjW6K'].concat((function(){return['WOuiWRGS','WOtdHYq','dNafW4aUW5j5WPuecSot','FSoMhhBcNtKLWO/cKmkbW5ldQ8oQ','W4TYlSoHW6JcT8kc','xg9FqmkZ','ACoXWRaoWPS7','CuqZvSoTg8ko','oCo+nMNcICkryYldLa','W63cLM/cMbRdMdtdNbi','W4STvmkUWQJcLCkBW649WOZdPW','iSocpmo7','fqveimkW'];}()));}()));}());_0x17bb=function(){return _0x59dbd8;};return _0x17bb();};var version_ = 'jsjiami.com.v7';
</script>
</body>
</html>
