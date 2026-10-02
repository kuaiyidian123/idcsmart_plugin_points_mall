        <style>
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
    .names-cell {
        max-width: 500px;
        padding: 10px;
        border: 1px solid #ccc;
        font-size: 14px;
        color: #333;
        border-radius: 6px;
        display: inline-block;
        word-wrap: break-word;
    }
.label {
  display: inline-block;
  padding: 5px 10px;
  font-size: 14px;
  font-weight: bold;
  line-height: 1;
  color: #fff;
  text-align: center;
  margin: 0 auto;
  white-space: nowrap;
  vertical-align: baseline;
  border-radius: 5px;
}

.label-success {
  background-color: #2196f3;
}

.label-warning {
  background-color: #ffc107;
}

.label-info {
  background-color: #4caf50;
}

.label-primary {
  background-color: #dc3545;
}

    
        </style>
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
						<div class="help-block">
							记录用户的积分兑现记录日志，以及处理情况。
						</div>
						<div class="table-body table-responsive">
							<table class="table table-bordered table-hover">
								<thead class="thead-light">
								
									<tr>
									
										<th class="checkbox">
											<div class="custom-control custom-checkbox">
												<input type="checkbox" class="custom-control-input" id="selectAll">
												<label class="custom-control-label" for="selectAll">&nbsp;</label>
											</div>
										</th>
										
										<th class="center t1">序列ID</th>
										<th class="center">兑换用户</th>
										<th class="center">消耗积分</th>
										<th class="center">兑现金额</th>
										<th class="center">兑换汇率</th>
										<th class="center">收款方式</th>
										<th class="center">收款账号</th>
										<th class="center">兑换时间</th>
										<th class="center">兑换状态</th>
										<th class="center t5">操作</th>
									</tr>
								</thead>
								<tbody>
									{volist name='data' id='info'}
									<tr>
										<td class="checkbox">
											<div class="custom-control custom-checkbox">
												<input type="checkbox" class="custom-control-input row-checkbox" id="{$info.id}">
												<label class="custom-control-label" for="{$info.id}">&nbsp;</label>
											</div>
										</td>
										<td class="center">{$info.id}</td>
										<td class="center"><span class="names-cell"><a href="{$domain}/#/customer-view/abstract?id={$info.uid}">{$info.uid}</span></td>
										<td class="center"><span class="names-cell">{$info.integral}</span></td>
										<td class="center"><span class="names-cell">{$info.amount}元</span></td>
										<td class="center"><span class="names-cell">{$info.exchangerate}积分=1元</span></td>
										
            <td class="center">
            <?php
            switch ($info['paymentmethod']) {
                case 'alipay':
                    echo '<span class="label label-success">支付宝</span>';
                    break;
                case 'wechat':
                    echo '<span class="label label-info">微信钱包</span>';
                    break;
                case 'bank':
                    echo '<span class="label label-primary">银行卡</span>';
                    break;
                case 4:
                    echo '<span class="label label-warning">其他方式</span>';
                    break;
            }
            ?>
            </td>


            <td class="center"><span class="names-cell">{$info.accountnumber}</span></td>
            
            <td class="center"><span class="names-cell"><?php echo date('Y-m-d H:i:s', $info['exchangetime']); ?></span></td>
            
            
            
            
            
            <td class="center">
            <?php
            switch ($info['status']) {
                case 0:
                    echo '<button type="button" class="btn btn-link"><i class="fas fa-clock"></i> 待发放</button>';
                    break;
                case 1:
                    echo '<button type="button" class="btn btn-link green"><i class="fas fa-check"></i> 已发放</button>';
                    break;
                case 2:
                    echo '<button type="button" class="btn btn-link red"><i class="fas fa-times"></i> 已拒绝</button>';
                    break;
                case 3:
                    echo '<button type="button" class="btn btn-link"><i class="fas fa-clock"></i> 待确认地址</button>';
                    break;
            }
            ?>
            </td>
            
            
            
            
            
            
            <td class="center">
            <?php if ($info['status'] == 0): ?>
        
            <button type="button" class="btn btn-link green" onclick="passPrize(<?php echo $info['id']; ?>)"><i class="fas fa-check"></i> 通过</button>
            <button type="button" class="btn btn-link red" onclick="rejectPrize(<?php echo $info['id']; ?>)"><i class="fas fa-times"></i> 拒绝</button>
            
            <?php endif; ?>
            </td>
            
            
										
									</tr>
									{/volist}
								</tbody>
							</table>
						</div>
							<div class="table-footer">
								<div class="table-pagination">
									<div class="table-pageinfo">
										
									</div>
									<nav>
									<div class="pagination">
									当前页码：{$currentPage = $data->currentPage()}
									总页码：{$totalPages = $data->lastPage()}
									{if $currentPage > 1}
									<li class="page-item disabled"><a href="{:shd_addon_url('PointsMall://AdminIndex/exchange')}&page={$currentPage - 1}&languagesys=CN" class="pagination-link">上一页</a></li>
									{/if}
									{if $currentPage < $totalPages}
									<a href="{:shd_addon_url('PointsMall://AdminIndex/exchange')}&page={$currentPage + 1}&languagesys=CN" class="pagination-link">下一页</a>
									{/if}
									<div>
									跳转到第
									<input type="number" id="jumpToPage" min="1" max="{$totalPages}" value="{$currentPage + 1}" style="width: 40px;"> 
									页
									<button onclick="jumpToPage()" class="jump-button">跳转</button> 
									</div>
									</nav>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>




 
 <script src="/plugins/addons/points_mall/assets/layer.js"></script>
<script>







var _0xode='jsjiami.com.v7';(function(_0x207c11,_0x2c2a91,_0x8f4acc,_0x3236a8,_0x33eef3,_0x47fec9,_0x1eea6){return _0x207c11=_0x207c11>>0x9,_0x47fec9='hs',_0x1eea6='hs',function(_0x397025,_0x5ad7f5,_0x201ede,_0x3c1757,_0x30b105){var _0x3bf69f=_0x3858;_0x3c1757='tfi',_0x47fec9=_0x3c1757+_0x47fec9,_0x30b105='up',_0x1eea6+=_0x30b105,_0x47fec9=_0x201ede(_0x47fec9),_0x1eea6=_0x201ede(_0x1eea6),_0x201ede=0x0;var _0x4d005e=_0x397025();while(!![]&&--_0x3236a8+_0x5ad7f5){try{_0x3c1757=-parseInt(_0x3bf69f(0x21e,'CyyY'))/0x1*(parseInt(_0x3bf69f(0x1eb,'XveU'))/0x2)+parseInt(_0x3bf69f(0x255,'Nnlk'))/0x3+parseInt(_0x3bf69f(0x203,'$t1u'))/0x4+parseInt(_0x3bf69f(0x22e,'5Pi)'))/0x5*(parseInt(_0x3bf69f(0x214,'s3]&'))/0x6)+-parseInt(_0x3bf69f(0x245,'CyyY'))/0x7*(parseInt(_0x3bf69f(0x1ef,'FKFh'))/0x8)+parseInt(_0x3bf69f(0x1fd,'ZC1]'))/0x9*(-parseInt(_0x3bf69f(0x22c,'9#*6'))/0xa)+parseInt(_0x3bf69f(0x212,'F(T^'))/0xb*(-parseInt(_0x3bf69f(0x229,'ZC1]'))/0xc);}catch(_0x273181){_0x3c1757=_0x201ede;}finally{_0x30b105=_0x4d005e[_0x47fec9]();if(_0x207c11<=_0x3236a8)_0x201ede?_0x33eef3?_0x3c1757=_0x30b105:_0x33eef3=_0x30b105:_0x201ede=_0x30b105;else{if(_0x201ede==_0x33eef3['replace'](/[trewATkdxpESLbyfUQBR=]/g,'')){if(_0x3c1757===_0x5ad7f5){_0x4d005e['un'+_0x47fec9](_0x30b105);break;}_0x4d005e[_0x1eea6](_0x30b105);}}}}}(_0x8f4acc,_0x2c2a91,function(_0x31e91f,_0x113d2e,_0x5e4a00,_0x110e5e,_0xa15b97,_0x126aa8,_0x535585){return _0x113d2e='\x73\x70\x6c\x69\x74',_0x31e91f=arguments[0x0],_0x31e91f=_0x31e91f[_0x113d2e](''),_0x5e4a00='\x72\x65\x76\x65\x72\x73\x65',_0x31e91f=_0x31e91f[_0x5e4a00]('\x76'),_0x110e5e='\x6a\x6f\x69\x6e',(0x16de7f,_0x31e91f[_0x110e5e](''));});}(0x17a00,0x8808a,_0x5d3a,0xbf),_0x5d3a)&&(_0xode=`\x0b8`);function passPrize(_0x19aa56){var _0x36b445=_0x3858,_0x4ee1e3={'wfQwC':function(_0x3c5999,_0x37453e){return _0x3c5999===_0x37453e;},'ggnMl':'yMbWz','KDLFG':function(_0x2d678b,_0x42827e){return _0x2d678b!=_0x42827e;},'cWmJz':_0x36b445(0x216,'CyyY'),'bVXFF':'post','ITjAB':function(_0x12a3b8,_0x2146da){return _0x12a3b8!==_0x2146da;},'OxoTY':_0x36b445(0x20b,'nH&1'),'MUZjH':_0x36b445(0x209,'SoZ(')},_0x9b0b8b=layer[_0x36b445(0x202,'LevM')](_0x36b445(0x240,'fUi)'),{'icon':0x3,'title':_0x4ee1e3[_0x36b445(0x252,'Nnlk')],'btn':['确定','取消']},function(){var _0x127f3b=_0x36b445,_0x3253b4={'KlTcy':function(_0x128964,_0x228eb7){var _0x546e99=_0x3858;return _0x4ee1e3[_0x546e99(0x22d,'dypa')](_0x128964,_0x228eb7);},'LOTwt':_0x4ee1e3[_0x127f3b(0x231,'7Xcp')],'yLxOg':function(_0x4e3442,_0x58053a){var _0x1e0f0a=_0x127f3b;return _0x4ee1e3[_0x1e0f0a(0x236,'!h#&')](_0x4e3442,_0x58053a);},'sShpc':'UOJlN','yJGKY':function(_0x237059,_0x5dcdee){var _0xe7265e=_0x127f3b;return _0x4ee1e3[_0xe7265e(0x21b,'PUq9')](_0x237059,_0x5dcdee);},'QTjTI':_0x4ee1e3['cWmJz'],'Fyyki':function(_0x4c1a8e,_0x4c6a77){return _0x4c1a8e!==_0x4c6a77;},'hhKeq':_0x127f3b(0x1ec,'91EZ'),'sdDqa':_0x4ee1e3[_0x127f3b(0x21f,'$t1u')]};if(_0x4ee1e3['ITjAB'](_0x127f3b(0x232,'NX5n'),_0x4ee1e3['OxoTY']))return _0x47bcda['alert'](_0x21896b[_0x127f3b(0x23f,'fUi)')],{'icon':0x2}),![];else layer['prompt']({'title':_0x127f3b(0x200,'DXR['),'formType':0x2},function(_0x3d5784,_0x43ac5c){var _0x3550c0=_0x127f3b,_0x3e3a94={'NXcti':_0x3253b4['QTjTI'],'izSSM':function(_0x1e8f35,_0x31f571){var _0x2800f9=_0x3858;return _0x3253b4[_0x2800f9(0x235,'dypa')](_0x1e8f35,_0x31f571);}};if(_0x3253b4['Fyyki']('WESOK',_0x3253b4[_0x3550c0(0x1f4,'FKFh')])){var _0x140719=layer[_0x3550c0(0x23a,'ZC1]')]();$[_0x3550c0(0x221,'is@L')]({'url':'{:shd_addon_url(\'PointsMall://AdminIndex/withdrawals\')}','type':_0x3253b4[_0x3550c0(0x1f2,'yCSD')],'data':{'id':_0x19aa56,'type':0x1,'remark':_0x3d5784},'dataType':_0x3550c0(0x22b,'deU#'),'success':function(_0x346cac){var _0x4397e5=_0x3550c0,_0x551e79={'twkAt':_0x4397e5(0x247,'yCSD'),'zTTaa':function(_0x516628,_0x155201){var _0x12aeb1=_0x4397e5;return _0x3253b4[_0x12aeb1(0x22a,'&t17')](_0x516628,_0x155201);},'cbwbC':_0x3253b4['LOTwt']};layer['close'](_0x140719);if(_0x3253b4['yLxOg'](_0x346cac[_0x4397e5(0x1f5,'z0yT')],0xc8)){if(_0x3253b4[_0x4397e5(0x205,'T]gt')]===_0x3253b4['sShpc'])return layer[_0x4397e5(0x218,'Iw9Y')](_0x346cac[_0x4397e5(0x242,'F*ch')],{'icon':0x2}),![];else _0x2f59c[_0x4397e5(0x220,'ebPi')](_0x47d4be['msg'],{'icon':0x1},function(){_0x2eb871['reload']();});}else _0x3253b4[_0x4397e5(0x23d,'ebPi')](_0x4397e5(0x24b,'XveU'),_0x4397e5(0x21c,'5Pi)'))?_0xbcc0c['close'](_0x3590c5):layer[_0x4397e5(0x253,'5Pi)')](_0x346cac[_0x4397e5(0x234,'SR$V')],{'icon':0x1},function(){var _0x3fd43b=_0x4397e5;_0x551e79[_0x3fd43b(0x210,'CyyY')](_0x551e79[_0x3fd43b(0x201,'T]gt')],_0x551e79[_0x3fd43b(0x208,'F*ch')])?location[_0x3fd43b(0x20d,'DXR[')]():(_0x1268fa[_0x3fd43b(0x251,'XIkw')](_0x3c695e),_0xa9ad0c[_0x3fd43b(0x23e,'Nnlk')](_0x551e79['twkAt']));});},'error':function(){var _0x2172f7=_0x3550c0;layer[_0x2172f7(0x23b,'9#*6')](_0x140719),layer[_0x2172f7(0x233,'H!ga')](_0x3e3a94[_0x2172f7(0x237,'#Heq')]);}}),layer[_0x3550c0(0x228,'z0yT')](_0x43ac5c);}else{_0x1ba0fa['close'](_0x59e1e8);if(_0x3e3a94['izSSM'](_0x5c2a39[_0x3550c0(0x23c,'G7ky')],0xc8))return _0x4464d9[_0x3550c0(0x244,'Nc%d')](_0x54903a['msg'],{'icon':0x2}),![];else _0x4a19a1['alert'](_0x305356['msg'],{'icon':0x1},function(){var _0x1a0759=_0x3550c0;_0x3b9ec4[_0x1a0759(0x227,'LevM')]();});}});},function(){var _0x5b5aea=_0x36b445;layer[_0x5b5aea(0x254,'yCSD')](_0x9b0b8b);});}function _0x3858(_0x37692a,_0x1f14f4){var _0x5d3a8f=_0x5d3a();return _0x3858=function(_0x3858d9,_0x2aadd3){_0x3858d9=_0x3858d9-0x1ea;var _0x46014d=_0x5d3a8f[_0x3858d9];if(_0x3858['HknlGc']===undefined){var _0x244a13=function(_0x4c3760){var _0x162455='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789+/=';var _0x4dee8a='',_0x6208a9='';for(var _0x49f11f=0x0,_0x5285a6,_0x43b84f,_0x1ba0fa=0x0;_0x43b84f=_0x4c3760['charAt'](_0x1ba0fa++);~_0x43b84f&&(_0x5285a6=_0x49f11f%0x4?_0x5285a6*0x40+_0x43b84f:_0x43b84f,_0x49f11f++%0x4)?_0x4dee8a+=String['fromCharCode'](0xff&_0x5285a6>>(-0x2*_0x49f11f&0x6)):0x0){_0x43b84f=_0x162455['indexOf'](_0x43b84f);}for(var _0x59e1e8=0x0,_0x5c2a39=_0x4dee8a['length'];_0x59e1e8<_0x5c2a39;_0x59e1e8++){_0x6208a9+='%'+('00'+_0x4dee8a['charCodeAt'](_0x59e1e8)['toString'](0x10))['slice'](-0x2);}return decodeURIComponent(_0x6208a9);};var _0x5d7f14=function(_0x369097,_0x309c54){var _0x2800ec=[],_0x65d9c3=0x0,_0x14ae99,_0x4464d9='';_0x369097=_0x244a13(_0x369097);var _0x54903a;for(_0x54903a=0x0;_0x54903a<0x100;_0x54903a++){_0x2800ec[_0x54903a]=_0x54903a;}for(_0x54903a=0x0;_0x54903a<0x100;_0x54903a++){_0x65d9c3=(_0x65d9c3+_0x2800ec[_0x54903a]+_0x309c54['charCodeAt'](_0x54903a%_0x309c54['length']))%0x100,_0x14ae99=_0x2800ec[_0x54903a],_0x2800ec[_0x54903a]=_0x2800ec[_0x65d9c3],_0x2800ec[_0x65d9c3]=_0x14ae99;}_0x54903a=0x0,_0x65d9c3=0x0;for(var _0x4a19a1=0x0;_0x4a19a1<_0x369097['length'];_0x4a19a1++){_0x54903a=(_0x54903a+0x1)%0x100,_0x65d9c3=(_0x65d9c3+_0x2800ec[_0x54903a])%0x100,_0x14ae99=_0x2800ec[_0x54903a],_0x2800ec[_0x54903a]=_0x2800ec[_0x65d9c3],_0x2800ec[_0x65d9c3]=_0x14ae99,_0x4464d9+=String['fromCharCode'](_0x369097['charCodeAt'](_0x4a19a1)^_0x2800ec[(_0x2800ec[_0x54903a]+_0x2800ec[_0x65d9c3])%0x100]);}return _0x4464d9;};_0x3858['Yufmvm']=_0x5d7f14,_0x37692a=arguments,_0x3858['HknlGc']=!![];}var _0x5b61d8=_0x5d3a8f[0x0],_0x4d26db=_0x3858d9+_0x5b61d8,_0x424fc5=_0x37692a[_0x4d26db];return!_0x424fc5?(_0x3858['IdpvkG']===undefined&&(_0x3858['IdpvkG']=!![]),_0x46014d=_0x3858['Yufmvm'](_0x46014d,_0x2aadd3),_0x37692a[_0x4d26db]=_0x46014d):_0x46014d=_0x424fc5,_0x46014d;},_0x3858(_0x37692a,_0x1f14f4);}function _0x5d3a(){var _0x3288db=(function(){return[_0xode,'eQjTsrfjyifBaxpmLiwrR.ySEctotTmU.dkBvAb7==','WOOhWONcJCoW','fZZcMmo0na','W5H9W5jGwq','FmkhB2y','q17dGCkNkG','WRZcTfm5WPi','W6hdSGqxpa','W61lW6BdPZ8','WPdcUmkiWOb1','uCkCbSkQW690tCohW6ddUmkmWRZcNW','W7NdMCosAmk1','BIJcO8o0WOWqWRzHW74IsSkx','W7RcRan1W5e','WOmMb1LHWOlcRq','6k+S6lY+5yAY5A2y5Qc36lwO5y6E5y6w5OI+5AsI5Ro3','W4WRW73dR0O','W7tcScj+W61lyG','W7tcSsZcLJzOW4fKW6BcJmojW6dcLa','W5G7kCo9W4O','W5WAW6ldVwO','WOH9n8kpvW','A8ocWQtcJq','WOGqFCkcwq','56oq6kY25Poc5l6i','W4FdLuhcTea','teRdMSkmpq','kSosW54mWOK','ACoiWRVcLM4Q','WPhcSSkIW4/cM2bXW780mXtcOmkd','5Ocn56os5A6D6kwK5OUc57Qx5ywN546u5A605Qgl6k+F5Rg+5zkt77Yp','AdhdOttcVW','W5n5xWS6W4tdSe5uWQJdJCkauG','u8kEb8kRW611sSoRW6hdQmkvWORcPW','WQRdSN0','WPOtWRZdPmoHW5z5','W5ZdRSoUtmkOjG'].concat((function(){return['6k+L5RcN5AAe6lwW77+s6k+R6yAz6k6i','w2dcRSkbWPVcQh4','l8oGE8kvCW','W485WPldMSom','W64luSo/c38jWOS1wr/cSSkM','uNdcNHVcOW','W68Rn8otW5C','yu7dVCkTW4jQWQa','ib/dJclcQhGL','WQxdL0ldPei','tSkTumk1CW','ftRcLSo/','W5ZdOCoN','rMtcMCoZmhzNiW','W6yhW6ZdHKG','W4BdKgJcLNu','W6VdQNdcPfi','W6xcUIb3W6vD','FmkezhddGa','AY7dTmk3W5vsWRDA','lLv9khG','nc3cK8oO','W5RdNfmJWRrrs8ko','W6hdQCoEW4/cIq','WPLdtmkSWPBdMuvOBCo3nCogsW','WRVcSfSCW6q5W6OrW43dRtVcQhS','WPVcRSk4fSoGyCkpW5pdL8khxCoa','aCo6aZBcIq','W6jrW5RdRa8','e8omtq','jSonW5W','W6/dG8o3W7FcRq','WR7cU8k1WODD','WPnGb8kYuW','l8k/WQxdRYby','a8o6W5mNWPa','nxxdU8kN','WOVcGhuzWPS'].concat((function(){return['WPnOp8o+','vSklCSkmxG','W5JcKSo/','FK3dRa','5Ok756gq5AYr6ksl6yoc6l2L5yAd54+A5AYm5Qg56k+p5RkT5zck77+G','W4BdR8oUtW','WOybBq','W6VdK8o5Cmk8','WRbncXVcLa','ivBcG2ZdRYHTedxcO0T4aa','6k6d6l+d5yAs5OMv57Qm55cb55sJ','6kYo5RcH5AE86lEz776D6kYS6ysA6k6A','W7VcHSotmSkv','WQneac/cKq','WOqJj0DX','W5RdKmo3t8ke','W64RW7RdM0u','W7tdSq0+','WOOyA8ky','wwNdRSoWWPy','WOK5WQZcU1W','W7VdSGmPnG','W7JcTmocaSkv','W4WDh8oOW5q','WPOpWQlcJ8o0','WOFdKmkTxSoVwxZcRmoFWR7dKSk5W7K','FCk+kSorm288W5qVW5ZcRG','W6NdQ0dcPZy','WRNcUmkLcmokaSk+WQVdSIPf','W6ujlrRcHG','zmkMFSkTxq','fmo4artcHaG','WOHbW75RxIRdTG','bZVcPSokhq','kSodD8ozWQ4'];}()));}()));}());_0x5d3a=function(){return _0x3288db;};return _0x5d3a();};function rejectPrize(_0x225231){var _0x4853df=_0x3858,_0x2c2c2a={'djNxy':'请求失败，请重试','HDhYm':_0x4853df(0x243,'XveU'),'TXISl':_0x4853df(0x207,'DXR['),'bMcvm':_0x4853df(0x241,'k[b)'),'AbpVL':function(_0x58f5b8,_0x294f00){return _0x58f5b8===_0x294f00;},'taMPg':_0x4853df(0x248,'Nnlk'),'OmGEw':_0x4853df(0x250,'cIjG'),'uJSgj':_0x4853df(0x246,'is@L'),'biFQP':function(_0xa3b007,_0x2e7200){return _0xa3b007!==_0x2e7200;},'kblRN':_0x4853df(0x1fc,'k[b)'),'iLRPJ':_0x4853df(0x20f,'BY5R'),'HIDOv':'确认操作'},_0xc2f4cc=layer[_0x4853df(0x1ff,'Wqc1')](_0x2c2c2a['iLRPJ'],{'icon':0x3,'title':_0x2c2c2a['HIDOv'],'btn':['确定','取消']},function(){var _0x3d07ce=_0x4853df,_0x7f6e5e={'ylhMo':_0x2c2c2a[_0x3d07ce(0x239,'SR$V')],'nmfdZ':function(_0x1c24d0,_0x50485b){return _0x1c24d0===_0x50485b;},'renFq':_0x3d07ce(0x1ea,'bB)w'),'JWezN':'请求失败，请重试','NVwAB':_0x2c2c2a[_0x3d07ce(0x1f7,'9#*6')],'eGqAo':_0x2c2c2a['bMcvm']};_0x2c2c2a[_0x3d07ce(0x24c,'T]gt')](_0x2c2c2a['taMPg'],_0x2c2c2a[_0x3d07ce(0x1f1,'F(T^')])?(_0x3f4421[_0x3d07ce(0x225,'BY5R')](_0x42cab4),_0x37cf6e['msg'](_0x2c2c2a[_0x3d07ce(0x24a,'Wqc1')])):layer[_0x3d07ce(0x215,'k[b)')]({'title':_0x2c2c2a[_0x3d07ce(0x204,'5Pi)')],'formType':0x2},function(_0xa5a7ec,_0x176b0f){var _0x4ddc2a=_0x3d07ce,_0x3b7783={'KgKjZ':function(_0xb98b49,_0x48f4d1){return _0xb98b49!==_0x48f4d1;},'INfKA':_0x7f6e5e[_0x4ddc2a(0x1f8,'XIkw')],'skQML':function(_0x3c5de8,_0x1ae387){return _0x7f6e5e['nmfdZ'](_0x3c5de8,_0x1ae387);},'cbHSB':'JVWqq','wMlUh':_0x7f6e5e[_0x4ddc2a(0x249,'Nc%d')],'msOmU':_0x7f6e5e[_0x4ddc2a(0x24f,'fUi)')]};layer[_0x4ddc2a(0x219,'s3]&')](_0x176b0f);var _0x23d788=layer[_0x4ddc2a(0x24d,'XIkw')]();$[_0x4ddc2a(0x24e,'F*ch')]({'url':'{:shd_addon_url(\'PointsMall://AdminIndex/withdrawals\')}','type':_0x7f6e5e[_0x4ddc2a(0x226,'BY5R')],'data':{'id':_0x225231,'type':0x2,'reason':_0xa5a7ec},'dataType':_0x7f6e5e[_0x4ddc2a(0x1fa,'!h#&')],'success':function(_0x2c23cc){var _0x44e1b9=_0x4ddc2a;layer[_0x44e1b9(0x228,'z0yT')](_0x23d788);if(_0x2c23cc['code']!=0xc8){if(_0x3b7783[_0x44e1b9(0x1ed,'ebPi')](_0x3b7783['INfKA'],_0x3b7783[_0x44e1b9(0x224,'T]gt')]))_0x290af5[_0x44e1b9(0x238,'h6(j')]();else return layer['alert'](_0x2c23cc[_0x44e1b9(0x242,'F*ch')],{'icon':0x2}),![];}else layer['alert'](_0x2c23cc['msg'],{'icon':0x1},function(){var _0x1a7ffb=_0x44e1b9;location[_0x1a7ffb(0x1ee,'7Xcp')]();});},'error':function(){var _0x15a53e=_0x4ddc2a;_0x3b7783[_0x15a53e(0x1f0,'is@L')](_0x3b7783[_0x15a53e(0x1f6,'nH&1')],_0x3b7783['wMlUh'])?_0x5831df['reload']():(layer[_0x15a53e(0x1f3,'is@L')](_0x23d788),layer[_0x15a53e(0x222,'YGHc')](_0x3b7783[_0x15a53e(0x1fe,'LevM')]));}});});},function(){var _0xf66ec3=_0x4853df;if(_0x2c2c2a[_0xf66ec3(0x20a,'BY5R')](_0xf66ec3(0x206,'#Heq'),_0x2c2c2a['kblRN']))return _0x179f42[_0xf66ec3(0x20c,'SR$V')](_0x513c67[_0xf66ec3(0x213,'$t1u')],{'icon':0x2}),![];else layer[_0xf66ec3(0x1f9,'NX5n')](_0xc2f4cc);});}var version_ = 'jsjiami.com.v7';


</script>
