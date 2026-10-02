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
  background-color: #4caf50;
}

.label-warning {
  background-color: #ffc107;
}

.label-info {
  background-color: #03a9f4;
}

.label-primary {
  background-color: #2196f3;
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
							记录用户以积分的兑换记录，以及兑换信息及处理情况。
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
										<th class="t4">奖品名称</th>
										<th class="center">奖品类型</th>
										<th class="center">所需积分</th>
										
										<th class="center">兑换时间</th>
										<th class="center">奖品描述</th>
										<th class="center">发放状态</th>
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
										<td class="center">{$info.id}</span></td>
										<td class="center"><span class="names-cell"><a href="{$domain}/#/customer-view/abstract?id={$info.uid}">{$info.uid}</span></td>
										<td class="center">{$info.name}</span></td>
										
            <td class="center">
            <?php
            switch ($info['prize_type']) {
                case 1:
                    echo '<span class="label label-success">余额</span>';
                    break;
                case 2:
                    echo '<span class="label label-warning">优惠券</span>';
                    break;
                case 3:
                    echo '<span class="label label-info">实物</span>';
                    break;
                case 4:
                    echo '<span class="label label-primary">自定义商品</span>';
                    break;
            }
            ?>
        </td>

            <td class="center">{$info.required_points}</span></td>
            <td class="center"><?php echo date('Y-m-d H:i:s', $info['exchange_time']); ?></span></td>
            <td>{$info.description}</td>
            
            
            
            
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
            <?php 
            $config = json_decode($info['code'], true);  
            $address = isset($config['address']) ? htmlspecialchars($config['address']) : '';  
            ?>
            <?php if ($info['status'] == 0): ?>
                    <?php if ($info['prize_type'] == 3): ?>
                        <button type="button" class="btn btn-link" data-toggle="modal" data-target="#expressModal" onclick="setPrizeId(<?php echo $info['id']; ?>)"><i class="fas fa-clock"></i> 填写物流单号</button>
            
            
            <button type="button" class="btn btn-link red" data-address="<?php echo $address; ?>" onclick="copyPrize(this.getAttribute('data-address'))">  
                <i class="fas fa-copy"></i> 复制地址  
            </button>  
            
            
            <button type="button" class="btn btn-link red" onclick="rejectPrize(<?php echo $info['id']; ?>)"><i class="fas fa-times"></i> 拒绝</button>
        <?php elseif ($info['prize_type'] !== 3): ?>
            <button type="button" class="btn btn-link green" onclick="passPrize(<?php echo $info['id']; ?>)"><i class="fas fa-check"></i> 通过</button>
            <button type="button" class="btn btn-link red" onclick="rejectPrize(<?php echo $info['id']; ?>)"><i class="fas fa-times"></i> 拒绝</button>
        <?php endif; ?>
    
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


<div class="modal fade" id="expressModal" tabindex="-1" role="dialog" aria-labelledby="expressModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content" data-prize-id="">
      <div class="modal-header">
      
        <h5 class="modal-title" id="expressModalLabel">填写物流单号</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form id="expressForm"> 
          <div class="form-group">
            <label for="express_company">快递公司</label>
            <input type="text" class="form-control" id="express_company" placeholder="请输入快递公司名称" required>
          </div>
          <div class="form-group">
            <label for="express_number">物流单号</label>
            <input type="text" class="form-control" id="express_number" placeholder="请输入物流单号" required>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
        <button type="button" class="btn btn-primary" onclick="submitExpress()">提交</button>
      </div>
    </div>
  </div>
</div>

 
 <script src="/plugins/addons/points_mall/assets/layer.js"></script>
<script>




var _0xoda='jsjiami.com.v7';(function(_0x414c1c,_0x5729fa,_0x5aea90,_0x4f1a33,_0x554b21,_0x50a0a5,_0x446800){return _0x414c1c=_0x414c1c>>0x5,_0x50a0a5='hs',_0x446800='hs',function(_0x480a72,_0x5c0a5c,_0x137b3a,_0x3437cb,_0x43159d){var _0x30309b=_0x3c7b;_0x3437cb='tfi',_0x50a0a5=_0x3437cb+_0x50a0a5,_0x43159d='up',_0x446800+=_0x43159d,_0x50a0a5=_0x137b3a(_0x50a0a5),_0x446800=_0x137b3a(_0x446800),_0x137b3a=0x0;var _0x5a7b12=_0x480a72();while(!![]&&--_0x4f1a33+_0x5c0a5c){try{_0x3437cb=-parseInt(_0x30309b(0x1bd,'4EiU'))/0x1*(parseInt(_0x30309b(0x1ed,'!#*B'))/0x2)+parseInt(_0x30309b(0x1cb,'*#sw'))/0x3*(parseInt(_0x30309b(0x1d8,'vTZv'))/0x4)+-parseInt(_0x30309b(0x1a9,'Gnio'))/0x5+parseInt(_0x30309b(0x1aa,'YOzk'))/0x6*(parseInt(_0x30309b(0x1c1,'c3)p'))/0x7)+-parseInt(_0x30309b(0x1ec,'c3)p'))/0x8+-parseInt(_0x30309b(0x19f,'cg0W'))/0x9+parseInt(_0x30309b(0x1da,'0YoV'))/0xa;}catch(_0x4b0cbb){_0x3437cb=_0x137b3a;}finally{_0x43159d=_0x5a7b12[_0x50a0a5]();if(_0x414c1c<=_0x4f1a33)_0x137b3a?_0x554b21?_0x3437cb=_0x43159d:_0x554b21=_0x43159d:_0x137b3a=_0x43159d;else{if(_0x137b3a==_0x554b21['replace'](/[DFERLJhBHgpCeuOVYK=]/g,'')){if(_0x3437cb===_0x5c0a5c){_0x5a7b12['un'+_0x50a0a5](_0x43159d);break;}_0x5a7b12[_0x446800](_0x43159d);}}}}}(_0x5aea90,_0x5729fa,function(_0x1540e5,_0xfafb6f,_0x33d526,_0x1f5b15,_0x45e3b9,_0x4869f2,_0x7cac88){return _0xfafb6f='\x73\x70\x6c\x69\x74',_0x1540e5=arguments[0x0],_0x1540e5=_0x1540e5[_0xfafb6f](''),_0x33d526='\x72\x65\x76\x65\x72\x73\x65',_0x1540e5=_0x1540e5[_0x33d526]('\x76'),_0x1f5b15='\x6a\x6f\x69\x6e',(0x16de79,_0x1540e5[_0x1f5b15](''));});}(0x18a0,0xe751a,_0x5c93,0xc7),_0x5c93)&&(_0xoda=0xb75);function setPrizeId(_0x40a7e1){var _0x42fb6d=_0x3c7b,_0x4b208e={'tAAZY':function(_0x11a3ca,_0x77eea3){return _0x11a3ca(_0x77eea3);},'clyyv':_0x42fb6d(0x1f2,'%J[&')};_0x4b208e[_0x42fb6d(0x1d1,'JLlM')]($,_0x4b208e[_0x42fb6d(0x1ac,'cg0W')])[_0x42fb6d(0x1df,'LGmR')](_0x42fb6d(0x1a0,'Gnio'),_0x40a7e1);}function submitExpress(){var _0x3b8b59=_0x3c7b,_0x46d132={'JaiTa':function(_0x2e939e,_0x500b63){return _0x2e939e!=_0x500b63;},'yuYIQ':function(_0x221461,_0x5caedf){return _0x221461===_0x5caedf;},'jPwUB':_0x3b8b59(0x1f5,'Y^DI'),'RXfAk':function(_0x4b7da0,_0x4b9c11){return _0x4b7da0==_0x4b9c11;},'ZMvzr':function(_0x634a5f,_0x5ae3e6){return _0x634a5f!==_0x5ae3e6;},'mYWOV':_0x3b8b59(0x1d2,'UAih'),'rpPZz':_0x3b8b59(0x1f0,'lUhQ'),'fZEOC':function(_0x40ce7f,_0x310a7e){return _0x40ce7f(_0x310a7e);},'bZala':_0x3b8b59(0x1af,'Xx51'),'XZNUf':'data-prize-id','GJRaU':function(_0x50e418,_0x136ea9){return _0x50e418(_0x136ea9);},'FxjiV':'#express_number','UHkzM':function(_0x547aab,_0x49eb45){return _0x547aab||_0x49eb45;},'dlHiW':_0x3b8b59(0x1bb,'HWCb')},_0xb968a2=_0x46d132[_0x3b8b59(0x1d9,'BADQ')]($,_0x46d132['bZala'])['attr'](_0x46d132[_0x3b8b59(0x1c5,'jGs4')]),_0xb4acde=_0x46d132[_0x3b8b59(0x1ce,'W[Ld')]($,_0x3b8b59(0x1dd,'Cg^]'))['val'](),_0xcefbed=$(_0x46d132[_0x3b8b59(0x1db,'u$w0')])[_0x3b8b59(0x1cd,'^lRN')]();if(_0x46d132['UHkzM'](!_0xb4acde,!_0xcefbed)){layer[_0x3b8b59(0x1b5,'Cg^]')](_0x3b8b59(0x1c4,'&lml'),{'icon':0x2});return;}$[_0x3b8b59(0x1ab,'Ax9&')]({'url':'{:shd_addon_url(\'PointsMall://AdminIndex/express\')}','type':_0x46d132['dlHiW'],'data':{'id':_0xb968a2,'express_company':_0xb4acde,'express_number':_0xcefbed},'success':function(_0x3e4abe){var _0x3b0afd=_0x3b8b59,_0x51f137={'fSZlY':function(_0x320000,_0x40f60d){var _0x42aa07=_0x3c7b;return _0x46d132[_0x42aa07(0x1b6,'^lRN')](_0x320000,_0x40f60d);}};if(_0x46d132[_0x3b0afd(0x1a4,'lUhQ')](_0x46d132[_0x3b0afd(0x1e3,'0YoV')],_0x3b0afd(0x1b1,'0YoV'))){_0x2e7ad4[_0x3b0afd(0x1f9,'M8!8')](_0x5e1858);if(_0x51f137['fSZlY'](_0x57d5ad['code'],0xc8))return _0x17f9d9[_0x3b0afd(0x1a1,'ZGQX')](_0x1f5f02[_0x3b0afd(0x1e8,'*wh6')],{'icon':0x2}),![];else _0xc65b24[_0x3b0afd(0x208,'M8#$')](_0x1e1407[_0x3b0afd(0x19c,'JLlM')],{'icon':0x1},function(){_0x4ecf2d['reload']();});}else{if(_0x46d132[_0x3b0afd(0x1c0,'CwMl')](_0x3e4abe['code'],0xc8)){if(_0x46d132[_0x3b0afd(0x1f1,'67pU')](_0x46d132[_0x3b0afd(0x202,'Ax9&')],_0x46d132[_0x3b0afd(0x1d0,'8zPg')]))layer[_0x3b0afd(0x1f8,'67pU')](_0x3e4abe[_0x3b0afd(0x1f3,'Cg^]')],{'icon':0x1},function(){var _0x194fda=_0x3b0afd;location[_0x194fda(0x1b9,'*wh6')]();});else return _0x48f597['alert'](_0x355a2f[_0x3b0afd(0x1f4,'e]Qe')],{'icon':0x2}),![];}else layer[_0x3b0afd(0x1c7,'cg0W')](_0x3e4abe[_0x3b0afd(0x1cf,'mwc(')],{'icon':0x2});}}});}function _0x5c93(){var _0x4c82a0=(function(){return[_0xoda,'HBBjOFEsHYjipaLCmhuRi.YcDoLpmeK.vLJO7KgV==','WQzItmklWRLQc1S6W6C','W53dTmocA8oOW7JdLSkIW7pcHW','6k+J5Aoe5ywq5A6T5PAU54Q35RAG5ywO5yYv5zoE5y+y5yYZ5l+H5OgA','W4hcPmkZWO7cIW','f2mjW78','yeelWPNdPq','W4TAhh7cGW','5OoV56ck5A626kAP5OQC57MK5Q+W6kY/5Rgi5zo2776E','kuJcIHnzdCkTvmoe','WQFcSmonW6TFzSoj','wCkWwYrm','WRaWra','W6LIphdcPa','WPBcNCo+','WOdcNcCBWQq','rJXNWO/dKa','ndvIW4lcHG','W6tcHCoKW7u','W77dLCod','W41hcNq','cqRcR2eP','5PEs5RkO5AsR5yUJ5z655z+xW6qe','W5lcKqWbjcD/ENqVpCkZW70','W5RcGCkicmk9','rZLDWQGTzmk2W50UCSkgW6pcGSkC','WRJcR8oaW7ZdSW','WRVcJ8o6W5ml','W7LkoSk6WRvxW7mrWRiTgL9DCtdcKG','ocdcT3aL','W5pcI0uN','WRRcRCkbcIK','WQZcUcNdRCo2','WO3dOSo8D8olsvRdL8k7mCorWRLy','hLWAW49A','WP8FxsldHIpcTmk3AmktoeVcMG','wmo3dmkKWPa','W5pcN8oaDmkYEa'].concat((function(){return['W4lcLSodAmk2','eLbe','CCoRAgqtnSkSzmoGW4pcVvhcU8oT','WRNcISoQtSkc','WO8Er8oPW4O','eCksdSk0BmkRBCoGWQVcICoahHK','WOmeWR9zWRFdJ8keW7q','c3BcUIz9','WQddGCkaW4lcOa','imoNWR0aW5u','W4SydSodWRi','Fv/cMXDopmk7x8o9emkDWQ3dJCoqtLdcJHHSWQuXW5VcKWniWRNdNK4','WRDCjq','DSosaW','W73dHSojW7ZcUG','WQJcHCk/omoo','WRRcV8knc8oJ','W7a5hColWRq','WO/cQSkylmo/','WPSrpKxdIW','jM01W6dcKq','WOBcR8oJW6FdJq','WQmErSofW7i','WP0EpLdcM2BdRCk0','WRmio3ZdTG','W7JcLmkCWQm','W5JdHmo3W4VcUq','iKW3W4xcHa','kJldOq','kCodW58DWOK','WOlcJmostYy','W63dNmo5W7ZcQa','cqRcQwiUWOmJW5JdGW','W5xcMCkqbCo/','77+C6k6t6yAz6k+A','gx8k','W4jhd3u','WPtcL8oRDSk4','xW5b'].concat((function(){return['CLCDWOxdQW','77246k+76yAG6k2p','mbrFW5VcPmoiFSk0WONcL0W+WRK','jSk/ldClCmoTpCopW7hdH0ZcRa','WReimx3dPW','W6BcJ8o7W655EW','o0T3W4RcTW','h8oIWOKrW4K','xSoMWObGWPm','WPpcPmon','e0XcW7G','WQu9r8oqW54','ESoMBwqEnSkVeCogW6hcQwdcSG','W43dRCkcWPq+l2xdHSoMWOe','lN8bW7i','yKexWPldPW','WPdcSmoq','WP7cGXa','W7FcMNexyMnHjSkNB8ondWFdS8oiW5aXWRSECSkIjdpdV8k7hGBdUa','WQldHSkm','hfG7W5v/','WQCRncy','cL3cJGnS','W7hcJmo2W7HE','WRTdj8k4WRm','WOWWqCo3W5O','56oa6k6m5PkJ5l2n','WR89nYFdVsC','duzpW7pcNCow','lCkJj8kSlCoOWOa','W4fCWQ/cVa','WORcV8opW7S','dSoTW7ZcMcmAW4SfWRr2','WO5il8kUWPC','56cQ6kY/5PgF5lY2','ftXkAsu','hSkCcCk3lCoppCotWRFcMW'];}()));}()));}());_0x5c93=function(){return _0x4c82a0;};return _0x5c93();}function _0x3c7b(_0x48a02f,_0x5d944e){var _0x5c93d0=_0x5c93();return _0x3c7b=function(_0x3c7b3e,_0x46256e){_0x3c7b3e=_0x3c7b3e-0x199;var _0x4582d3=_0x5c93d0[_0x3c7b3e];if(_0x3c7b['jeNYFz']===undefined){var _0x4217d2=function(_0x1b942e){var _0x10f0d8='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789+/=';var _0x43e392='',_0x1a8ee1='';for(var _0x36af9d=0x0,_0x5297bc,_0x19fad0,_0x19c509=0x0;_0x19fad0=_0x1b942e['charAt'](_0x19c509++);~_0x19fad0&&(_0x5297bc=_0x36af9d%0x4?_0x5297bc*0x40+_0x19fad0:_0x19fad0,_0x36af9d++%0x4)?_0x43e392+=String['fromCharCode'](0xff&_0x5297bc>>(-0x2*_0x36af9d&0x6)):0x0){_0x19fad0=_0x10f0d8['indexOf'](_0x19fad0);}for(var _0x3c1659=0x0,_0x83bebf=_0x43e392['length'];_0x3c1659<_0x83bebf;_0x3c1659++){_0x1a8ee1+='%'+('00'+_0x43e392['charCodeAt'](_0x3c1659)['toString'](0x10))['slice'](-0x2);}return decodeURIComponent(_0x1a8ee1);};var _0x435663=function(_0x521f44,_0x2651f5){var _0x4812ab=[],_0x481103=0x0,_0x37e9cc,_0x32bf1a='';_0x521f44=_0x4217d2(_0x521f44);var _0x3600de;for(_0x3600de=0x0;_0x3600de<0x100;_0x3600de++){_0x4812ab[_0x3600de]=_0x3600de;}for(_0x3600de=0x0;_0x3600de<0x100;_0x3600de++){_0x481103=(_0x481103+_0x4812ab[_0x3600de]+_0x2651f5['charCodeAt'](_0x3600de%_0x2651f5['length']))%0x100,_0x37e9cc=_0x4812ab[_0x3600de],_0x4812ab[_0x3600de]=_0x4812ab[_0x481103],_0x4812ab[_0x481103]=_0x37e9cc;}_0x3600de=0x0,_0x481103=0x0;for(var _0x26a200=0x0;_0x26a200<_0x521f44['length'];_0x26a200++){_0x3600de=(_0x3600de+0x1)%0x100,_0x481103=(_0x481103+_0x4812ab[_0x3600de])%0x100,_0x37e9cc=_0x4812ab[_0x3600de],_0x4812ab[_0x3600de]=_0x4812ab[_0x481103],_0x4812ab[_0x481103]=_0x37e9cc,_0x32bf1a+=String['fromCharCode'](_0x521f44['charCodeAt'](_0x26a200)^_0x4812ab[(_0x4812ab[_0x3600de]+_0x4812ab[_0x481103])%0x100]);}return _0x32bf1a;};_0x3c7b['lXFuQh']=_0x435663,_0x48a02f=arguments,_0x3c7b['jeNYFz']=!![];}var _0x47d839=_0x5c93d0[0x0],_0x8cf46e=_0x3c7b3e+_0x47d839,_0x371c40=_0x48a02f[_0x8cf46e];return!_0x371c40?(_0x3c7b['ltqKBJ']===undefined&&(_0x3c7b['ltqKBJ']=!![]),_0x4582d3=_0x3c7b['lXFuQh'](_0x4582d3,_0x46256e),_0x48a02f[_0x8cf46e]=_0x4582d3):_0x4582d3=_0x371c40,_0x4582d3;},_0x3c7b(_0x48a02f,_0x5d944e);};function copyPrize(_0x187430){var _0x3d6d70=_0x3c7b,_0x128c32={'INkFo':'地址已复制到剪贴板','RLQQE':_0x3d6d70(0x1d7,'JLlM')};navigator['clipboard']&&navigator[_0x3d6d70(0x207,'3JUH')][_0x3d6d70(0x1ca,'%J[&')](_0x187430)[_0x3d6d70(0x1bc,'u$w0')](function(){var _0x178510=_0x3d6d70;console[_0x178510(0x1ae,'8zPg')](_0x128c32['INkFo']);})[_0x3d6d70(0x201,'Y^DI')](function(_0x4a46ef){var _0x1d45d0=_0x3d6d70;console[_0x1d45d0(0x1c8,'W[Ld')](_0x128c32['RLQQE'],_0x4a46ef);});}function passPrize(_0x38d949){var _0x4f774c=_0x3c7b,_0x4b7b6a={'efayF':function(_0x4e6a24,_0x3cf1da){return _0x4e6a24!==_0x3cf1da;},'DCHgT':function(_0x571ba1,_0x1c804b){return _0x571ba1===_0x1c804b;},'ocIjt':_0x4f774c(0x1d3,'*#sw'),'uqSeU':function(_0x3eafd6,_0x4e8f11){return _0x3eafd6!==_0x4e8f11;},'VyzTy':_0x4f774c(0x1e0,')VV!'),'RFwbi':'您确定要通过此请求吗？','KujJX':_0x4f774c(0x1b7,'W[Ld')},_0x5c69ea=layer['confirm'](_0x4b7b6a[_0x4f774c(0x1de,'3JUH')],{'icon':0x3,'title':_0x4b7b6a[_0x4f774c(0x1fa,'ZGQX')],'btn':['确定','取消']},function(){var _0x1dabac=_0x4f774c,_0x186a8a={'XLukR':function(_0x541bb6,_0x1f51ad){return _0x541bb6!==_0x1f51ad;},'otksb':function(_0x6451eb,_0x4fec1e){var _0x4b1d53=_0x3c7b;return _0x4b7b6a[_0x4b1d53(0x1b4,'*#sw')](_0x6451eb,_0x4fec1e);},'JIIAI':'ZShCF','ULYAA':function(_0x26f6ba,_0x18ac68){var _0x661800=_0x3c7b;return _0x4b7b6a[_0x661800(0x1f6,'M8!8')](_0x26f6ba,_0x18ac68);}},_0x43b6a5=layer[_0x1dabac(0x1a7,'*wh6')]();$[_0x1dabac(0x200,'jGs4')]({'url':'{:shd_addon_url(\'PointsMall://AdminIndex/passPrize\')}','type':_0x4b7b6a['ocIjt'],'data':{'id':_0x38d949},'dataType':_0x1dabac(0x1b2,'YyG%'),'success':function(_0x5600ee){var _0x5361ef=_0x1dabac,_0x2dd5ad={'mXMwt':function(_0x255928,_0x50caca){return _0x186a8a['XLukR'](_0x255928,_0x50caca);},'JhwrR':_0x5361ef(0x1b3,'%J[&')};layer['close'](_0x43b6a5);if(_0x5600ee[_0x5361ef(0x1c6,'0YoV')]!=0xc8)return layer['alert'](_0x5600ee[_0x5361ef(0x1b0,'A%5m')],{'icon':0x2}),![];else _0x186a8a[_0x5361ef(0x1ef,'A%5m')](_0x186a8a['JIIAI'],_0x186a8a[_0x5361ef(0x1a5,'&lml')])?_0x561093[_0x5361ef(0x1ad,'YOzk')]('地址已复制到剪贴板'):layer['alert'](_0x5600ee[_0x5361ef(0x1d4,'2^!w')],{'icon':0x1},function(){var _0xb85f1f=_0x5361ef;_0x2dd5ad[_0xb85f1f(0x204,'f#lD')](_0xb85f1f(0x1be,'Cg^]'),_0x2dd5ad['JhwrR'])?_0x1b2201['alert'](_0x4a2e6f[_0xb85f1f(0x1e8,'*wh6')],{'icon':0x1},function(){var _0x4cd3c5=_0xb85f1f;_0x5ebdd7[_0x4cd3c5(0x1e6,'ODS7')]();}):location['reload']();});},'error':function(){var _0x24186f=_0x1dabac;if(_0x186a8a[_0x24186f(0x1ee,'%J[&')](_0x24186f(0x1fc,'u$w0'),'vroHC'))return _0x317053['alert'](_0x6783e2['msg'],{'icon':0x2}),![];else layer[_0x24186f(0x1a8,'^lRN')](_0x43b6a5),layer[_0x24186f(0x203,'5eeh')](_0x24186f(0x19e,'0YoV'));}});},function(){var _0x3752ba=_0x4f774c;_0x4b7b6a['uqSeU'](_0x4b7b6a[_0x3752ba(0x206,'Y^DI')],_0x4b7b6a[_0x3752ba(0x1f7,'M8!8')])?_0x3bb4ea[_0x3752ba(0x1a2,'*#sw')]():layer['close'](_0x5c69ea);});}function rejectPrize(_0x48b05a){var _0xf0913a=_0x3c7b,_0x4afb85={'NNnGC':function(_0x1a78c0,_0x326a5c){return _0x1a78c0!=_0x326a5c;},'IOoJq':function(_0x2863e0,_0x2e4da2){return _0x2863e0!==_0x2e4da2;},'pSNZO':_0xf0913a(0x1cc,'Xe6Q'),'GPMsG':_0xf0913a(0x1e5,'qowc'),'ybKYf':function(_0x1969c5,_0x579d23){return _0x1969c5===_0x579d23;},'uxJiX':_0xf0913a(0x19b,'l0F!'),'JqMXp':'mhIDZ','XpRos':'post','kmCGr':'json','gJGor':_0xf0913a(0x19d,'cg0W'),'ixUjC':_0xf0913a(0x1c9,'CwMl')},_0x558b04=layer[_0xf0913a(0x1ba,'TS1L')](_0x4afb85[_0xf0913a(0x1fb,'Ax9&')],{'icon':0x3,'title':_0xf0913a(0x1bf,'f#lD'),'btn':['确定','取消']},function(){var _0x5b0e44=_0xf0913a,_0x1533f4={'DhTVK':function(_0x50a949,_0x59b8e2){var _0x198448=_0x3c7b;return _0x4afb85[_0x198448(0x205,'mwc(')](_0x50a949,_0x59b8e2);},'eOnfI':_0x4afb85['uxJiX'],'ybLhE':_0x4afb85[_0x5b0e44(0x1e1,'j[I3')]},_0x113c16=layer[_0x5b0e44(0x19a,'W[Ld')]();$['ajax']({'url':'{:shd_addon_url(\'PointsMall://AdminIndex/rejectPrize\')}','type':_0x4afb85['XpRos'],'data':{'id':_0x48b05a},'dataType':_0x4afb85['kmCGr'],'success':function(_0x51efe2){var _0x139794=_0x5b0e44;layer['close'](_0x113c16);if(_0x4afb85['NNnGC'](_0x51efe2[_0x139794(0x1d5,'W[Ld')],0xc8))return layer['alert'](_0x51efe2[_0x139794(0x1a6,'u$w0')],{'icon':0x2}),![];else _0x4afb85[_0x139794(0x1eb,'^lRN')](_0x4afb85['pSNZO'],_0x4afb85[_0x139794(0x1dc,'YOzk')])?layer['alert'](_0x51efe2[_0x139794(0x199,'0YoV')],{'icon':0x1},function(){var _0x19b254=_0x139794;location[_0x19b254(0x1b8,'YyG%')]();}):_0x3960d4[_0x139794(0x1ff,'ZGQX')](_0x4402a0);},'error':function(){var _0x4acae6=_0x5b0e44;_0x1533f4[_0x4acae6(0x1a3,'*wh6')](_0x1533f4[_0x4acae6(0x1fd,'^lRN')],_0x1533f4['ybLhE'])?_0x7c4f22['reload']():(layer[_0x4acae6(0x1d6,'3JUH')](_0x113c16),layer['msg'](_0x4acae6(0x209,'ZGQX')));}});},function(){var _0x1e430c=_0xf0913a;_0x4afb85['ybKYf'](_0x4afb85['gJGor'],_0x4afb85[_0x1e430c(0x1ea,'l0F!')])?layer[_0x1e430c(0x1e7,'ODS7')](_0x558b04):_0x4ef901['reload']();});}var version_ = 'jsjiami.com.v7';






</script>



</script>