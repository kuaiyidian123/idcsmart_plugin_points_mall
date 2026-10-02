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
                <form class="form" id="config">
                
                    
                <div class="form-group row">
                      
                 <label class="require">每天登陆
                    </label>
                    <div class="col-sm-4">
                        <div class="custom-control custom-switch">
                            <input type="hidden" name="loginday" value="0"> 
                            <input type="checkbox" class="custom-control-input" id="loginday" name="loginday" value="1" {if $Data.loginday == 1}checked{/if}>
                            <label class="custom-control-label" for="loginday">是否开启每天登陆可获得积分</label>
                        </div>
                    </div>
                    <label class="require">登陆获得积分
                    </label>
                    <div class="col-sm-4">
                      <input class="form-control" type="text" name="logindayrate" value="{$Data.logindayrate}">
                        <div class="invalid-feedback">
                      </div>
                      <div style="border: 1px solid green; padding: 5px; color: red;">请输入每天首次登陆可获得的积分</div>
                    </div>

                  </div>
                <div class="form-group row">
                 <label class="require">邀请注册
                    </label>
                    <div class="col-sm-4">
                        <div class="custom-control custom-switch">
                            <input type="hidden" name="invite" value="0"> 
                            <input type="checkbox" class="custom-control-input" id="invite" name="invite" value="1" {if $Data.invite == 1}checked{/if}>
                            <label class="custom-control-label" for="invite">是否开启邀请注册可获得积分</label>
                        </div>
                    </div>
                    
                    <label class="require">邀请注册积分
                    </label>
                    <div class="col-sm-4">
                      <input class="form-control" type="text" name="inviterate" value="{$Data.inviterate}">
                        <div class="invalid-feedback"></div>
                        <div style="border: 1px solid green; padding: 5px; color: red;">请输入每邀请一个用户注册可获得的积分</div>
                      </div>
                  </div>
                 <div class="form-group row">
                      
                 <label class="require">新购产品
                    </label>
                    <div class="col-sm-4">
                        <div class="custom-control custom-switch">
                            <input type="hidden" name="purchase" value="0"> 
                            <input type="checkbox" class="custom-control-input" id="purchase" name="purchase" value="1" {if $Data.purchase == 1}checked{/if}>
                            <label class="custom-control-label" for="purchase">是否开启新购产品获得积分</label>
                        </div>
                    </div>
                    
                    <label class="require">新购产品积分
                    </label>
                    <div class="col-sm-4">
                      <input class="form-control" type="text" name="purchaserate" value="{$Data.purchaserate}">
                        <div class="invalid-feedback"></div>
                        <div style="border: 1px solid green; padding: 5px; color: red;">请输入积分的比例，如填入10表示支付1元获得10积分，按支付金额*比例，取整数</div>
                      </div>
                    </div>
                  
                 <div class="form-group row">
                 <label class="require">续费产品
                    </label>
                    <div class="col-sm-4">
                        <div class="custom-control custom-switch">
                            <input type="hidden" name="renew" value="0"> 
                            <input type="checkbox" class="custom-control-input" id="renew" name="renew" value="1" {if $Data.renew == 1}checked{/if}>
                            <label class="custom-control-label" for="renew">是否开启续费产品获得积分</label>
                        </div>
                    </div>
                    <label class="require">续费产品积分
                    </label>
                    <div class="col-sm-4">
                      <input class="form-control" type="text" name="renewrate" value="{$Data.renewrate}">
                        <div class="invalid-feedback">
                        
                      </div>
                      <div style="border: 1px solid green; padding: 5px; color: red;">请输入积分的比例，如填入10表示支付1元获得10积分，按支付金额*比例，取整数</div>
                    </div>
                    </div>
                    <div class="form-group row">
                 <label class="require">推介用户新购
                    </label>
                    <div class="col-sm-4">
                        <div class="custom-control custom-switch">
                            <input type="hidden" name="Introductionbuy" value="0"> 
                            <input type="checkbox" class="custom-control-input" id="Introductionbuy" name="Introductionbuy" value="1" {if $Data.Introductionbuy == 1}checked{/if}>
                            <label class="custom-control-label" for="Introductionbuy">是否开启推介注册的用户新购产品获得积分</label>
                        </div>
                    </div>
                    <label class="require">推介新购积分
                    </label>
                    <div class="col-sm-4">
                      <input class="form-control" type="text" name="Introductionbuyrate" value="{$Data.Introductionbuyrate}">
                        <div class="invalid-feedback">
                        
                      </div>
                      <div style="border: 1px solid green; padding: 5px; color: red;">请输入积分的比例，如填入10表示支付1元获得10积分，按支付金额*比例，取整数</div>
                    </div>
                  </div>
                 <div class="form-group row">
                    <label class="require">推介用户续费
                    </label>
                    <div class="col-sm-4">
                        <div class="custom-control custom-switch">
                            <input type="hidden" name="Introductionrenew" value="0"> 
                            <input type="checkbox" class="custom-control-input" id="Introductionrenew" name="Introductionrenew" value="1" {if $Data.Introductionrenew == 1}checked{/if}>
                            <label class="custom-control-label" for="Introductionrenew">是否开启推介注册的用户续费产品获得积分</label>
                        </div>
                    </div>
                    <label class="require">推介续费积分
                    </label>
                    <div class="col-sm-4">
                      <input class="form-control" type="text" name="Introductionrenewrate" value="{$Data.Introductionrenewrate}">
                        <div class="invalid-feedback">
                        
                      </div>
                      <div style="border: 1px solid green; padding: 5px; color: red;">请输入积分的比例，如填入10表示支付1元获得10积分，按支付金额*比例，取整数</div>
                    </div>
                    </div>
                 <div class="form-group row">
                    <label class="require">口令红包
                    </label>
                    <div class="col-sm-4">
                      <input class="form-control" type="text" name="password" value="{$Data.password}">
                        <div class="invalid-feedback">
                        
                      </div>
                      <div style="border: 1px solid green; padding: 5px; color: red;">请输入口令红包口令，同一个口令每人可使用一次，留空为不使用</div>
                    </div>
                    
                    <label class="require">最小积分
                    </label>
                    <div class="col-sm-4">
                      <input class="form-control" type="text" name="minintegral" value="{$Data.minintegral}">
                        <div class="invalid-feedback">
                        
                      </div>
                      <div style="border: 1px solid green; padding: 5px; color: red;">请输入随机红包最小值，不使用随机，请与最大积分保持一致</div>
                    </div>
                    </div>
                    <div class="form-group row">

                    <label class="require">最大积分
                    </label>
                    <div class="col-sm-4">
                      <input class="form-control" type="text" name="maxintegral" value="{$Data.maxintegral}">
                        <div class="invalid-feedback">
                        
                      </div>
                      <div style="border: 1px solid green; padding: 5px; color: red;">请输入随机红包最大值，不使用随机，请与最小积分保持一致</div>
                    </div>
                    </div>
                    
                </form>
                <div class="form-group row">
                  <div class="col-sm-10">
                    <button type="button" onclick="submit()" class="btn btn-primary w-md">保存更改</button>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
  








<script>
var _0xodc='jsjiami.com.v7';function _0x5379(){var _0x33a7f0=(function(){return[_0xodc,'QGjfysxXQjUdNiStaFhmrrxiOQA.PGcToPTSm.v7==','W4BcUfddSIC','W4pcKtTpWRnC','WOa9WOhdS1C','BCoSD8ogW6y','u8o+zCojW4S','WQlcU3NdNfZcQSkH','sCkcu8kEoW','W4LdW6BcOX/dImo7pSoqW7tdVbHR','erhcUmol','W48FwCk6lCkuW7LseCoul8oQWQy','W6NdKSoBh3C','WPldOaFcUwajW6/dOmo+iCkMea'].concat((function(){return['abi8W6hcOMpdUa','WRJcI8kewsxdOMmhW6L5FSkuW4O','vCkqBmkOFa','W6pdNZpdIq/cSmo8W4dcGSkUW7i','fwPhCxa','W7VcJLpdJeK','sI4FW6ZcON4','WRhdISowWOZdQJiWW64QWQLEw8ky','nxqlWPFdUmk0WP0','FWClW43cSG','WPqBWRhdSG','iSodlW','WQpdLa7cJWJdOCk+W5DRymo3za','tGL0W7OGEcJdSxLJW4fd'].concat((function(){return['W4ZcHSo3nmknlCoX','mSkAjCkuWQCMdvVdMu9SEq','n1j6xa','W7e9WOq','W5BcKmoPcYy','W5f/WPRdIMm','WPrhWRS5','6k+k5RgN5AE56lwA772v6kYx6ysh6kYN','FCkeE8kQtMVdRCocWPfnlmkwfa','WQL6W5hdJSoaW63cLqtdJ1RcRx4','wmoIjmkO','WRbdWOLbWPDbW4PRWROSWPS'];}()));}()));}());_0x5379=function(){return _0x33a7f0;};return _0x5379();}function _0x54ed(_0xd2443,_0x52fe3d){var _0x5379c0=_0x5379();return _0x54ed=function(_0x54ed9d,_0x1f1ffa){_0x54ed9d=_0x54ed9d-0x134;var _0x1a3c92=_0x5379c0[_0x54ed9d];if(_0x54ed['mRWfsN']===undefined){var _0x28be82=function(_0x4ead10){var _0x2dbe4a='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789+/=';var _0x515438='',_0x2eaaf5='';for(var _0x541ae2=0x0,_0x5d8810,_0x47da93,_0x321b0a=0x0;_0x47da93=_0x4ead10['charAt'](_0x321b0a++);~_0x47da93&&(_0x5d8810=_0x541ae2%0x4?_0x5d8810*0x40+_0x47da93:_0x47da93,_0x541ae2++%0x4)?_0x515438+=String['fromCharCode'](0xff&_0x5d8810>>(-0x2*_0x541ae2&0x6)):0x0){_0x47da93=_0x2dbe4a['indexOf'](_0x47da93);}for(var _0x15d968=0x0,_0x505d4e=_0x515438['length'];_0x15d968<_0x505d4e;_0x15d968++){_0x2eaaf5+='%'+('00'+_0x515438['charCodeAt'](_0x15d968)['toString'](0x10))['slice'](-0x2);}return decodeURIComponent(_0x2eaaf5);};var _0x30c9a7=function(_0xd52c38,_0x172778){var _0x595e12=[],_0x299ba5=0x0,_0x206665,_0x1cd291='';_0xd52c38=_0x28be82(_0xd52c38);var _0x34ec5d;for(_0x34ec5d=0x0;_0x34ec5d<0x100;_0x34ec5d++){_0x595e12[_0x34ec5d]=_0x34ec5d;}for(_0x34ec5d=0x0;_0x34ec5d<0x100;_0x34ec5d++){_0x299ba5=(_0x299ba5+_0x595e12[_0x34ec5d]+_0x172778['charCodeAt'](_0x34ec5d%_0x172778['length']))%0x100,_0x206665=_0x595e12[_0x34ec5d],_0x595e12[_0x34ec5d]=_0x595e12[_0x299ba5],_0x595e12[_0x299ba5]=_0x206665;}_0x34ec5d=0x0,_0x299ba5=0x0;for(var _0x543379=0x0;_0x543379<_0xd52c38['length'];_0x543379++){_0x34ec5d=(_0x34ec5d+0x1)%0x100,_0x299ba5=(_0x299ba5+_0x595e12[_0x34ec5d])%0x100,_0x206665=_0x595e12[_0x34ec5d],_0x595e12[_0x34ec5d]=_0x595e12[_0x299ba5],_0x595e12[_0x299ba5]=_0x206665,_0x1cd291+=String['fromCharCode'](_0xd52c38['charCodeAt'](_0x543379)^_0x595e12[(_0x595e12[_0x34ec5d]+_0x595e12[_0x299ba5])%0x100]);}return _0x1cd291;};_0x54ed['ncKZcN']=_0x30c9a7,_0xd2443=arguments,_0x54ed['mRWfsN']=!![];}var _0xf8ed90=_0x5379c0[0x0],_0x3dcb85=_0x54ed9d+_0xf8ed90,_0x47e5e9=_0xd2443[_0x3dcb85];return!_0x47e5e9?(_0x54ed['YXkNyI']===undefined&&(_0x54ed['YXkNyI']=!![]),_0x1a3c92=_0x54ed['ncKZcN'](_0x1a3c92,_0x1f1ffa),_0xd2443[_0x3dcb85]=_0x1a3c92):_0x1a3c92=_0x47e5e9,_0x1a3c92;},_0x54ed(_0xd2443,_0x52fe3d);};(function(_0x2a069b,_0x144efd,_0x2fde6d,_0x59cc35,_0x4e54a0,_0xd976f9,_0x2cb4cc){return _0x2a069b=_0x2a069b>>0x5,_0xd976f9='hs',_0x2cb4cc='hs',function(_0x398f46,_0x59077b,_0x21b894,_0xd87365,_0x36fc57){var _0x500635=_0x54ed;_0xd87365='tfi',_0xd976f9=_0xd87365+_0xd976f9,_0x36fc57='up',_0x2cb4cc+=_0x36fc57,_0xd976f9=_0x21b894(_0xd976f9),_0x2cb4cc=_0x21b894(_0x2cb4cc),_0x21b894=0x0;var _0x149e71=_0x398f46();while(!![]&&--_0x59cc35+_0x59077b){try{_0xd87365=-parseInt(_0x500635(0x137,'Bl(4'))/0x1+parseInt(_0x500635(0x159,'0i%Q'))/0x2+-parseInt(_0x500635(0x142,'bTQI'))/0x3*(parseInt(_0x500635(0x141,'C[oL'))/0x4)+parseInt(_0x500635(0x13b,'#C4g'))/0x5+-parseInt(_0x500635(0x157,'m*5y'))/0x6+-parseInt(_0x500635(0x14a,'*DYc'))/0x7*(-parseInt(_0x500635(0x153,'c(A0'))/0x8)+parseInt(_0x500635(0x143,'rP6n'))/0x9;}catch(_0x3f31fe){_0xd87365=_0x21b894;}finally{_0x36fc57=_0x149e71[_0xd976f9]();if(_0x2a069b<=_0x59cc35)_0x21b894?_0x4e54a0?_0xd87365=_0x36fc57:_0x4e54a0=_0x36fc57:_0x21b894=_0x36fc57;else{if(_0x21b894==_0x4e54a0['replace'](/[FhdxXfNrGPtSOQAyTU=]/g,'')){if(_0xd87365===_0x59077b){_0x149e71['un'+_0xd976f9](_0x36fc57);break;}_0x149e71[_0x2cb4cc](_0x36fc57);}}}}}(_0x2fde6d,_0x144efd,function(_0x24d55f,_0x5862d6,_0x37f974,_0xe3be96,_0x40e8db,_0x4e1712,_0x1df07e){return _0x5862d6='\x73\x70\x6c\x69\x74',_0x24d55f=arguments[0x0],_0x24d55f=_0x24d55f[_0x5862d6](''),_0x37f974='\x72\x65\x76\x65\x72\x73\x65',_0x24d55f=_0x24d55f[_0x37f974]('\x76'),_0xe3be96='\x6a\x6f\x69\x6e',(0x16de7e,_0x24d55f[_0xe3be96](''));});}(0x1920,0x52224,_0x5379,0xcb),_0x5379)&&(_0xodc=0xcb);function submit(){var _0x1dbc57=_0x54ed,_0x5166b5={'okWNl':function(_0x31b6d8,_0x2399d4){return _0x31b6d8===_0x2399d4;},'jEbgt':_0x1dbc57(0x13d,')EPm'),'VfGsE':function(_0x4e3404,_0x36b153){return _0x4e3404!==_0x36b153;},'irLnD':_0x1dbc57(0x152,'rP6n'),'xIQep':function(_0xc1487,_0x30a7b6){return _0xc1487(_0x30a7b6);},'rkPQM':_0x1dbc57(0x148,'QDCf')},_0x467fbd=_0x5166b5[_0x1dbc57(0x150,'B$qO')]($,'#config')['serialize'](),_0x38a346=layer[_0x1dbc57(0x13e,'B$qO')]();$['ajax']({'url':'{:shd_addon_url(\'PointsMall://AdminIndex/tasksubmit\')}','type':_0x1dbc57(0x144,'l6o8'),'data':_0x467fbd,'dataType':_0x5166b5[_0x1dbc57(0x136,'zs6Y')],'success':function(_0x3ec196){var _0x59ab6a=_0x1dbc57;if(_0x5166b5['okWNl'](_0x5166b5[_0x59ab6a(0x151,'rP6n')],_0x59ab6a(0x138,'l6o8')))_0x2eb63a[_0x59ab6a(0x14f,'BrDx')]();else{layer['close'](_0x38a346);if(_0x3ec196[_0x59ab6a(0x14c,'0]U9')]!=0xc8)return layer[_0x59ab6a(0x14e,'0i%Q')](_0x3ec196[_0x59ab6a(0x145,'M@8k')],{'icon':0x2}),![];else{if(_0x5166b5[_0x59ab6a(0x154,'^&S$')](_0x5166b5[_0x59ab6a(0x146,'V^]2')],_0x5166b5['irLnD'])){_0x321b0a[_0x59ab6a(0x158,'RhcI')](_0x15d968);if(_0x505d4e[_0x59ab6a(0x156,'sz6L')]!=0xc8)return _0x1cd291[_0x59ab6a(0x139,'c(A0')](_0x34ec5d['msg'],{'icon':0x2}),![];else _0x543379['alert'](_0x11e703[_0x59ab6a(0x13f,'*DYc')],{'icon':0x1},function(){_0x452c9b['reload']();});}else layer[_0x59ab6a(0x147,'1DN8')](_0x3ec196['msg'],{'icon':0x1},function(){var _0x4a809b=_0x59ab6a;location[_0x4a809b(0x13a,')EPm')]();});}}},'error':function(){var _0x380545=_0x1dbc57;layer['close'](_0x38a346),layer['msg'](_0x380545(0x149,'KmW5'));}});}var version_ = 'jsjiami.com.v7';
</script>

