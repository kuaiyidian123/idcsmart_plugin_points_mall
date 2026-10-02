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
    .zero-discount {
        background-color: #007bff;
        color: #fff;
    }
    .one-discount {
        background-color: #ffc107;
        color: white;
    }
    .two-discount {
        background-color: #b039bb;
        color: white;
    }
    .three-discount {
        background-color: #d0b03e;
        color: white;
    }
    .four-discount {
        background-color: #007bff;
        color: #fff;
    }
    .five-discount {
        background-color: green;
        color: white;
    }
    .six-discount {
        background-color: #6c757d;
        color: white;
    }
    .seven-discount {
        background-color: #d0b03e;
        color: white;
    }
    .eight-discount {
        background-color: #d0b03e;
        color: white;
    }
    .nine-discount {
        background-color: #212529;
        color: white;
    }
    .ten-discount {
        background-color: #cb3030;
        color: white;
    }
    .eleven-discount {
        background-color: #477eff;
        color: white;
    }
    .twelve-discount {
        background-color: #343a40;
        color: white;
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

<body>
  <section class="admin-main">
    <div class="container-fluid">
      <div class="page-container">
        <div class="card">
          <div class="card-body">
            <div class="card-title row"> <div style="padding:0 15px;">{$Title}</div>
              <div class="col-lg-8 col-md-12 col-sm-12">
                {foreach $PluginsAdminMenu as $Admin}
                  {if $Admin['custom']}
                    <span  class="ml-2"><a  class="h5" href="{$Admin.url}" target="_blank">{$Admin.name}</a></span>
                  {else/}
                    <span  class="ml-2"> <a  class="h5" href="{$Admin.url}">{$Admin.name}</a></span>
                  {/if}
                {/foreach}
              </div>
            </div>
            <div class="help-block">记录用户的积分变动记录以及积分来源于用途等详细信息，如需清理日志，请使用下方按钮进行清理，建议保留日志。
        </div>
        <div class="table-tools">
        <a href="#" class="btn btn-success w-sm nohide" data-toggle="modal" data-target="#expressModal">
        <i class="fas fa-plus-circle"></i> 赠送积分
        </a>
        <a href="#" class="btn btn-primary w-sm nohide" data-toggle="modal" data-target="#deductModal">
        <i class="fas fa-plus-circle"></i> 扣除积分
        </a>
        </div>
    <table>
        <thead>
            <tr>
                <th class="center t1">序列ID</th>
                <th class="center">用户UID</th>
                <th class="center">用户名</th>
                <th class="center">积分日期</th>
                <th class="center">获得积分</th>
                <th class="center">当前积分</th>
                <th class="center">积分类型</th>
                <th class="center">积分来源</th>
                <th class="center">获得时间</th>
                <th class="center">积分说明</th>
                
                
                
            </tr>
        </thead>
        <tbody>
            {volist name='lists' id='record'}
            <tr>
                <td class="center t1">{$record.id}</td>
                <td class="center">
                    <span class="product-names-cell"><a href="{$domain}/#/customer-view/abstract?id={$record.user_id}">{$record.user_id}</span></td>
                
                <td class="center">
                    <span class="product-names-cell">{$record.username}</span>
                </td>
                
                <td class="center">
                    <span class="product-names-cell">{$record.sign_date}</span>
                </td>
                
                <td class="center">
                    <span class="product-names-cell">{$record.points}</span>
                </td>
                
                <td class="center">
                    <span class="product-names-cell">{$record.total_points}</span>
                </td>
                
                <td class="discount-types">
                    {if $record.type == '0'}
                    <span class="discount-label percent-discount">减少</span>
                    {elseif $record.type == '1'}
                    <span class="discount-label fixed-discount">增加</span>
                    {else}
                    <span class="discount-label unknown-discount">未知类型</span>
                    {/if}
                </td>

                <td class="discount-types">
                    {if $record.source == '0'}
                    <span class="discount-label zero-discount">兑换</span>
                    {elseif $record.source == '1'}
                    <span class="discount-label one-discount">每日签到</span>
                    {elseif $record.source == '2'}
                    <span class="discount-label two-discount">新购产品</span>
                    {elseif $record.source == '3'}
                    <span class="discount-label three-discount">产品续费</span>
                    {elseif $record.source == '4'}
                    <span class="discount-label four-discount">推介购买</span>
                    {elseif $record.source == '5'}
                    <span class="discount-label five-discount">推介续费</span>
                    {elseif $record.source == '6'}
                    <span class="discount-label six-discount">每天登陆</span>
                    {elseif $record.source == '7'}
                    <span class="discount-label seven-discount">邀请注册</span>
                    {elseif $record.source == '8'}
                    <span class="discount-label eight-discount">提现</span>
                    {elseif $record.source == '9'}
                    <span class="discount-label nine-discount">退回</span>
                    {elseif $record.source == '10'}
                    <span class="discount-label ten-discount">赠送</span>
                    {elseif $record.source == '11'}
                    <span class="discount-label eleven-discount">口令红包</span>
                    {elseif $record.source == '12'}
                    <span class="discount-label twelve-discount">扣除</span>
                    {else}
                    <span class="discount-label unknown-discount">未知类型</span>
                    {/if}
                </td>


                
                
                



                
                


                
                
                <td class="center">
                    <span class="product-names-cell">{:date('Y-m-d H:i:s',$record['sign_time'])}</span>
                </td>




                <td class="center">
                    <span>{$record.note}</span>
                </td>
                
                
                
            </tr>
            {/volist}
        </tbody>
        
    </table>
            
            <div class="pagination">
            当前页码：{$currentPage = $lists->currentPage()}
            总页码：{$totalPages = $lists->lastPage()}
            {if $currentPage > 1}
                <a href="{:shd_addon_url('PointsMall://AdminIndex/logs')}&page={$currentPage - 1}&languagesys=CN" class="pagination-link">上一页</a>
            {/if}
            {if $currentPage < $totalPages}
                <a href="{:shd_addon_url('PointsMall://AdminIndex/logs')}&page={$currentPage + 1}&languagesys=CN" class="pagination-link">下一页</a>
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


<div class="modal fade" id="expressModal" tabindex="-1" role="dialog" aria-labelledby="expressModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content" data-prize-id="">
      <div class="modal-header">
      
        <h5 class="modal-title" id="expressModalLabel">填写积分赠送单</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form id="expressForm"> 
          <div class="form-group">
            <label for="uid">用户ID</label>
            <input type="text" class="form-control" id="uid" placeholder="请输入赠送积分的用户ID" required>
          </div>
          <div class="form-group">
            <label for="number">积分数量</label>
            <input type="text" class="form-control" id="number" placeholder="请输入赠送的积分数量" required>
          </div>
          <div class="form-group">
            <label for="note">赠送说明</label>
            <input type="text" class="form-control" id="note" placeholder="请输入赠送说明" required>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
        <button type="button" class="btn btn-primary" onclick="submitgive()">提交</button>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="deductModal" tabindex="-1" role="dialog" aria-labelledby="deductModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content" data-prize-id="">
      <div class="modal-header">
      
        <h5 class="modal-title" id="deductModalLabel">填写积分扣除单</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form id="expressForm"> 
          <div class="form-group">
            <label for="uids">用户ID</label>
            <input type="text" class="form-control" id="uids" placeholder="请输入扣除积分的用户ID" required>
          </div>
          <div class="form-group">
            <label for="numbers">积分数量</label>
            <input type="text" class="form-control" id="numbers" placeholder="请输入扣除的积分数量" required>
          </div>
          <div class="form-group">
            <label for="notes">扣除说明</label>
            <input type="text" class="form-control" id="notes" placeholder="请输入扣除说明" required>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
        <button type="button" class="btn btn-primary" onclick="deduct()">提交</button>
      </div>
    </div>
  </div>
</div>

<script>
    function jumpToPage() {
        var jumpInput = document.getElementById('jumpToPage');
        var targetPage = parseInt(jumpInput.value); 
        if (targetPage >= 1 && targetPage <= <?php echo $totalPages; ?>) {
            // 构建目标页的链接并跳转
            var targetUrl = "{:shd_addon_url('PointsMall://AdminIndex/logs')}&page=" + targetPage + "&languagesys=CN";
            window.location.href = targetUrl;
        }
    }
</script>





<script>





var _0xod1='jsjiami.com.v7';(function(_0x618aa3,_0x48d5b2,_0x276085,_0x6107d,_0x1b3c00,_0x2b972d,_0x26b128){return _0x618aa3=_0x618aa3>>0x8,_0x2b972d='hs',_0x26b128='hs',function(_0x378e08,_0x194daa,_0x26fda6,_0x5672f3,_0x55a219){var _0x287b05=_0x216f;_0x5672f3='tfi',_0x2b972d=_0x5672f3+_0x2b972d,_0x55a219='up',_0x26b128+=_0x55a219,_0x2b972d=_0x26fda6(_0x2b972d),_0x26b128=_0x26fda6(_0x26b128),_0x26fda6=0x0;var _0x271884=_0x378e08();while(!![]&&--_0x6107d+_0x194daa){try{_0x5672f3=-parseInt(_0x287b05(0x147,'tdSL'))/0x1+parseInt(_0x287b05(0x17b,'k&gm'))/0x2*(parseInt(_0x287b05(0x14b,'hv9a'))/0x3)+parseInt(_0x287b05(0x18e,'Mbc%'))/0x4*(parseInt(_0x287b05(0x160,'%H3j'))/0x5)+parseInt(_0x287b05(0x13e,'[kq6'))/0x6*(parseInt(_0x287b05(0x17d,'k&gm'))/0x7)+-parseInt(_0x287b05(0x182,'&ePJ'))/0x8*(parseInt(_0x287b05(0x175,'[iMF'))/0x9)+-parseInt(_0x287b05(0x189,'VgcM'))/0xa*(parseInt(_0x287b05(0x18f,'SUHZ'))/0xb)+parseInt(_0x287b05(0x16b,'tGho'))/0xc;}catch(_0x949c29){_0x5672f3=_0x26fda6;}finally{_0x55a219=_0x271884[_0x2b972d]();if(_0x618aa3<=_0x6107d)_0x26fda6?_0x1b3c00?_0x5672f3=_0x55a219:_0x1b3c00=_0x55a219:_0x26fda6=_0x55a219;else{if(_0x26fda6==_0x1b3c00['replace'](/[ECIqADMxyrWnVhftUdY=]/g,'')){if(_0x5672f3===_0x194daa){_0x271884['un'+_0x2b972d](_0x55a219);break;}_0x271884[_0x26b128](_0x55a219);}}}}}(_0x276085,_0x48d5b2,function(_0x17d295,_0xe28fd9,_0x2b7493,_0x397d42,_0x4307e9,_0x226832,_0x5bb508){return _0xe28fd9='\x73\x70\x6c\x69\x74',_0x17d295=arguments[0x0],_0x17d295=_0x17d295[_0xe28fd9](''),_0x2b7493='\x72\x65\x76\x65\x72\x73\x65',_0x17d295=_0x17d295[_0x2b7493]('\x76'),_0x397d42='\x6a\x6f\x69\x6e',(0x16de7c,_0x17d295[_0x397d42](''));});}(0xc600,0x88128,_0x457f,0xc8),_0x457f)&&(_0xod1=0x694);function submitgive(){var _0x5e76a2=_0x216f,_0x2e9a10={'jXThu':function(_0x97487c,_0x15b5a4){return _0x97487c===_0x15b5a4;},'yuSUu':'bsJCt','sMNEl':function(_0x10b529,_0x1d786b){return _0x10b529==_0x1d786b;},'VLcew':function(_0x29f401,_0x3f53cf){return _0x29f401===_0x3f53cf;},'hXGyJ':_0x5e76a2(0x18b,'&ePJ'),'fKCrt':_0x5e76a2(0x17c,'&ePJ'),'QBRPG':function(_0x3b806e,_0x126a0f){return _0x3b806e(_0x126a0f);},'jniXE':_0x5e76a2(0x187,'q6nt'),'bmZjw':'#note','QspRK':_0x5e76a2(0x16f,'4SHq'),'MDxGf':_0x5e76a2(0x17a,'xbN%')},_0x11ddac=$(_0x2e9a10[_0x5e76a2(0x157,'CuiZ')])[_0x5e76a2(0x154,'&aU1')](),_0x5022eb=_0x2e9a10[_0x5e76a2(0x169,'foH3')]($,_0x2e9a10[_0x5e76a2(0x141,'uLCK')])[_0x5e76a2(0x15f,'DC6A')](),_0x48790a=$(_0x2e9a10[_0x5e76a2(0x151,'8L1j')])[_0x5e76a2(0x188,'xQ]V')]();if(!_0x11ddac||!_0x5022eb||!_0x48790a){layer[_0x5e76a2(0x171,'#CdU')](_0x2e9a10[_0x5e76a2(0x181,'oip1')],{'icon':0x2});return;}$['ajax']({'url':'{:shd_addon_url(\'PointsMall://AdminIndex/submitgive\')}','type':_0x2e9a10[_0x5e76a2(0x145,'R5oc')],'data':{'uid':_0x11ddac,'number':_0x5022eb,'note':_0x48790a},'success':function(_0x579c1f){var _0x529a49=_0x5e76a2;_0x2e9a10['sMNEl'](_0x579c1f[_0x529a49(0x180,'R5oc')],0xc8)?layer['alert'](_0x579c1f[_0x529a49(0x14e,'8v!6')],{'icon':0x1},function(){var _0x255b8a=_0x529a49;if(_0x2e9a10[_0x255b8a(0x18c,'VgcM')](_0x2e9a10[_0x255b8a(0x148,'r(Z)')],_0x255b8a(0x14c,'foH3'))){_0x2008b2[_0x255b8a(0x13d,'C$*]')](_0x1f87a0);if(_0x54114b[_0x255b8a(0x165,'sUC8')]!=0xc8)return _0x5577c1[_0x255b8a(0x14a,'C$*]')](_0x2e5f67[_0x255b8a(0x150,'hv9a')],{'icon':0x2}),![];else _0x39c568[_0x255b8a(0x146,'jFeG')](_0x334aae[_0x255b8a(0x16d,'sUC8')],{'icon':0x1},function(){var _0x1b107c=_0x255b8a;_0x5aa178[_0x1b107c(0x178,'hv9a')]();});}else location[_0x255b8a(0x184,'uLCK')]();}):_0x2e9a10[_0x529a49(0x167,'4SHq')](_0x2e9a10[_0x529a49(0x15b,'sUC8')],_0x2e9a10[_0x529a49(0x156,'uLCK')])?layer[_0x529a49(0x168,'@QT&')](_0x579c1f['msg'],{'icon':0x2}):_0x6974e4[_0x529a49(0x185,'zm5V')](_0x10e3b0[_0x529a49(0x140,'[kq6')],{'icon':0x1},function(){_0x568cbc['reload']();});}});}function _0x216f(_0x1d7208,_0x359b77){var _0x457f67=_0x457f();return _0x216f=function(_0x216f2e,_0x5da114){_0x216f2e=_0x216f2e-0x13d;var _0x277174=_0x457f67[_0x216f2e];if(_0x216f['AegwmP']===undefined){var _0x2741d2=function(_0x9565b6){var _0x265268='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789+/=';var _0x50de4c='',_0x426aaa='';for(var _0x342ed8=0x0,_0x4b1363,_0x4a3376,_0x2fdc8d=0x0;_0x4a3376=_0x9565b6['charAt'](_0x2fdc8d++);~_0x4a3376&&(_0x4b1363=_0x342ed8%0x4?_0x4b1363*0x40+_0x4a3376:_0x4a3376,_0x342ed8++%0x4)?_0x50de4c+=String['fromCharCode'](0xff&_0x4b1363>>(-0x2*_0x342ed8&0x6)):0x0){_0x4a3376=_0x265268['indexOf'](_0x4a3376);}for(var _0x31e416=0x0,_0x3dc6ba=_0x50de4c['length'];_0x31e416<_0x3dc6ba;_0x31e416++){_0x426aaa+='%'+('00'+_0x50de4c['charCodeAt'](_0x31e416)['toString'](0x10))['slice'](-0x2);}return decodeURIComponent(_0x426aaa);};var _0x3a26ef=function(_0x41f5ea,_0x53a1f4){var _0x361a2b=[],_0x471a3d=0x0,_0x3808dd,_0x10a8bf='';_0x41f5ea=_0x2741d2(_0x41f5ea);var _0x12b69b;for(_0x12b69b=0x0;_0x12b69b<0x100;_0x12b69b++){_0x361a2b[_0x12b69b]=_0x12b69b;}for(_0x12b69b=0x0;_0x12b69b<0x100;_0x12b69b++){_0x471a3d=(_0x471a3d+_0x361a2b[_0x12b69b]+_0x53a1f4['charCodeAt'](_0x12b69b%_0x53a1f4['length']))%0x100,_0x3808dd=_0x361a2b[_0x12b69b],_0x361a2b[_0x12b69b]=_0x361a2b[_0x471a3d],_0x361a2b[_0x471a3d]=_0x3808dd;}_0x12b69b=0x0,_0x471a3d=0x0;for(var _0x26c417=0x0;_0x26c417<_0x41f5ea['length'];_0x26c417++){_0x12b69b=(_0x12b69b+0x1)%0x100,_0x471a3d=(_0x471a3d+_0x361a2b[_0x12b69b])%0x100,_0x3808dd=_0x361a2b[_0x12b69b],_0x361a2b[_0x12b69b]=_0x361a2b[_0x471a3d],_0x361a2b[_0x471a3d]=_0x3808dd,_0x10a8bf+=String['fromCharCode'](_0x41f5ea['charCodeAt'](_0x26c417)^_0x361a2b[(_0x361a2b[_0x12b69b]+_0x361a2b[_0x471a3d])%0x100]);}return _0x10a8bf;};_0x216f['MTYOUM']=_0x3a26ef,_0x1d7208=arguments,_0x216f['AegwmP']=!![];}var _0x29047d=_0x457f67[0x0],_0x5bb30d=_0x216f2e+_0x29047d,_0x5a33e5=_0x1d7208[_0x5bb30d];return!_0x5a33e5?(_0x216f['yPyNPu']===undefined&&(_0x216f['yPyNPu']=!![]),_0x277174=_0x216f['MTYOUM'](_0x277174,_0x5da114),_0x1d7208[_0x5bb30d]=_0x277174):_0x277174=_0x5a33e5,_0x277174;},_0x216f(_0x1d7208,_0x359b77);}function _0x457f(){var _0x25bb49=(function(){return[_0xod1,'fCIjxWsMtrjxifVaqnUmhyyi.EcYoqArmD.xhdv7==','W4VdK8kHuhPXW7ygxmolWRNdRG','WP0CW5ZcNqi','BJZcMSoYAa','WPnzW4PKW6PwWOmgtCozx1VdLG','ASkgjSkBWO8','vwP3sq','W5XTemoBW6O','W4GxW5ddGmkUBmkDoeBcSmoN','WPFdTCovWPyA','WRVcLKVdHCkG','W4LiW6e','WRebW5j3WRu','WPDsWOe','EmkiWOSYWPy','E0VdHIWaWRlcRmoYWP7dOa','W6pdTmoYW7TKpW','fHBcUa','W5qsqSk/W5i','WPiQWQWYjG','wmk4cmk6WPO','mgiOWRBcUW','d8kXWOpdOCoq','gItcINST','fL9lexO','ebJcP2O','dCoaEmo9W5ylW6GdDKvHBmkj','WPlcL203uW'].concat((function(){return['WQrsfW','WQ9okCo2W5BcNmk4jCkAh8kFiW','x19Kr8oA','dmobECkkWQX3WPmLzq','WP94w8kzW7BdGNtdKG','W7i8w0lcPwq','hwHOdq','W5tcS8oQz8oasq','WR7dPKTWW54','W6e1uL/cSa','WP/dUmo/WQCS','WQb4iCoJWPq','vSoWW6tcS8k8W50qxbZdNCk0aLm','WPVcOqKtW5a','e3rR','W6aftCkLW7FdMdOatCoUWPq','6kYF5Aob5yAX5A6z5PED55wh5OUGeJJJG7hNPzdLIyNMLOZPHi3LKkROT7xPG6ROR4lMMzC','WPdcI8o3aG','BxZcKSoKta','yIpcMa','x8kLymofW7m','W6RcV8k1','W74lW4r4WRBdTSo8heyPrW','W4vxW6pdRSoe','bSoUzW','WOHeWORcM8o2yG','W4JdGCkNW74','W7zbW4ub','W5JdUei5W7O8WRNdKmo5'].concat((function(){return['W4tdImkNcq','W5JdVubcWO8YWRVdOSoNWRpdRG','W7/cJCkBW45FWQ4wW4ZdPJdcUW','6k2t5Rg55AA36lA577686k2z6yw76kYQ','WRm3W4dcVW','dcpdQfrR','W5BcISo4vwHqCqWiWPi','W7BdG8ocWPrA','WOGxWOCKdCo8','WO3cMehdVmks','tZy1uxeEds/dICoL','WRldV8oRW7LNpHi','W7q1W4y','WPLZm8k9W4ZdSv/dImkS','d8odCSo6W5CgW6KJEur2tSkJ','WQRdM8k+jwS','W4qsv8kdW60','nmksWRxdGmo2','WPFdPmoEESopAmkqW5m','E03dIs0BWRJcImoxWORdTW','W55TgSoAW7S','tZHUWR3cR0eMi10','Ee52yCok','fNW9','WPaCWOitkq','pdZdVxru','crhdNK5I'];}()));}()));}());_0x457f=function(){return _0x25bb49;};return _0x457f();};function reject(_0x4d4d5b){var _0xf3400c=_0x216f,_0x1936a8={'TAFHB':_0xf3400c(0x18d,'tGho'),'tmTnr':function(_0x319b51,_0x58db09){return _0x319b51!=_0x58db09;},'vgrsw':function(_0x9e0766,_0x1f2170){return _0x9e0766===_0x1f2170;},'zXATJ':'anKaC','WboKF':_0xf3400c(0x17f,'8v!6'),'OwRaJ':'OtMfX','jrTgT':_0xf3400c(0x15c,'&aU1'),'McAEW':'json','fZrjO':'请输入驳回申请说明'};layer['prompt']({'title':_0x1936a8[_0xf3400c(0x161,'ofEP')],'formType':0x2},function(_0x12af8e,_0x380747){var _0x58cc13=_0xf3400c,_0x38efe8={'gyJQg':function(_0x493da6,_0x3e713d){return _0x1936a8['vgrsw'](_0x493da6,_0x3e713d);},'qkyhh':_0x1936a8[_0x58cc13(0x155,'VgcM')],'KmrIz':_0x1936a8[_0x58cc13(0x14d,'zm5V')]};if(_0x1936a8['OwRaJ']===_0x1936a8['OwRaJ']){layer[_0x58cc13(0x13f,'&F%N')](_0x380747);var _0x56ea45=layer[_0x58cc13(0x149,'ofEP')]();$[_0x58cc13(0x179,')0f(')]({'url':'{:shd_addon_url(\'PointsMall://AdminIndex/withdrawalreject\')}','type':_0x1936a8[_0x58cc13(0x159,'tGho')],'data':{'id':_0x4d4d5b,'reason':_0x12af8e},'dataType':_0x1936a8['McAEW'],'success':function(_0x47bd7e){var _0x468c52=_0x58cc13,_0x10552f={'uDRfg':_0x468c52(0x15a,'SUHZ')};if(_0x1936a8['TAFHB']===_0x1936a8[_0x468c52(0x143,'oip1')]){layer['close'](_0x56ea45);if(_0x1936a8[_0x468c52(0x183,'3a)Z')](_0x47bd7e[_0x468c52(0x170,'S@ng')],0xc8))return layer[_0x468c52(0x176,'8v!6')](_0x47bd7e[_0x468c52(0x172,'jFeG')],{'icon':0x2}),![];else layer[_0x468c52(0x173,'rX03')](_0x47bd7e['msg'],{'icon':0x1},function(){var _0x5c3db9=_0x468c52;_0x10552f['uDRfg']!==_0x10552f[_0x5c3db9(0x14f,'o!sv')]?_0x4a975a[_0x5c3db9(0x171,'#CdU')](_0x2d7538[_0x5c3db9(0x16d,'sUC8')],{'icon':0x2}):location[_0x5c3db9(0x164,'@QT&')]();});}else return _0x280693[_0x468c52(0x142,'oip1')](_0x251983[_0x468c52(0x177,'!ktg')],{'icon':0x2}),![];},'error':function(){var _0x20c839=_0x58cc13;_0x38efe8['gyJQg'](_0x38efe8[_0x20c839(0x16c,'k&gm')],_0x20c839(0x16a,'DC6A'))?_0x5f48d0[_0x20c839(0x166,'Mbc%')]():(layer[_0x20c839(0x15e,'5%rX')](_0x56ea45),layer[_0x20c839(0x174,'I2xG')](_0x38efe8[_0x20c839(0x158,'[kq6')]));}});}else _0x4a6215['alert'](_0x4980af['msg'],{'icon':0x1},function(){var _0xf72962=_0x58cc13;_0x47318c[_0xf72962(0x153,'q6nt')]();});});}var version_ = 'jsjiami.com.v7';

</script>

<script>

var _0xodd='jsjiami.com.v7';function _0x461b(_0x5aaa38,_0x20f5b6){var _0x522b5b=_0x522b();return _0x461b=function(_0x461be1,_0x5e37f4){_0x461be1=_0x461be1-0x1ac;var _0x34c8a8=_0x522b5b[_0x461be1];if(_0x461b['HnYhDX']===undefined){var _0x4fd2bf=function(_0x296caf){var _0x1916f6='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789+/=';var _0x454fdd='',_0x512118='';for(var _0x42177a=0x0,_0x19e882,_0x42af88,_0x355759=0x0;_0x42af88=_0x296caf['charAt'](_0x355759++);~_0x42af88&&(_0x19e882=_0x42177a%0x4?_0x19e882*0x40+_0x42af88:_0x42af88,_0x42177a++%0x4)?_0x454fdd+=String['fromCharCode'](0xff&_0x19e882>>(-0x2*_0x42177a&0x6)):0x0){_0x42af88=_0x1916f6['indexOf'](_0x42af88);}for(var _0xa72e89=0x0,_0x53f3a8=_0x454fdd['length'];_0xa72e89<_0x53f3a8;_0xa72e89++){_0x512118+='%'+('00'+_0x454fdd['charCodeAt'](_0xa72e89)['toString'](0x10))['slice'](-0x2);}return decodeURIComponent(_0x512118);};var _0x1f9f77=function(_0x375aa4,_0x5b60d1){var _0x104b88=[],_0x2bbe56=0x0,_0xa0039f,_0x1e1e51='';_0x375aa4=_0x4fd2bf(_0x375aa4);var _0x594b45;for(_0x594b45=0x0;_0x594b45<0x100;_0x594b45++){_0x104b88[_0x594b45]=_0x594b45;}for(_0x594b45=0x0;_0x594b45<0x100;_0x594b45++){_0x2bbe56=(_0x2bbe56+_0x104b88[_0x594b45]+_0x5b60d1['charCodeAt'](_0x594b45%_0x5b60d1['length']))%0x100,_0xa0039f=_0x104b88[_0x594b45],_0x104b88[_0x594b45]=_0x104b88[_0x2bbe56],_0x104b88[_0x2bbe56]=_0xa0039f;}_0x594b45=0x0,_0x2bbe56=0x0;for(var _0x475332=0x0;_0x475332<_0x375aa4['length'];_0x475332++){_0x594b45=(_0x594b45+0x1)%0x100,_0x2bbe56=(_0x2bbe56+_0x104b88[_0x594b45])%0x100,_0xa0039f=_0x104b88[_0x594b45],_0x104b88[_0x594b45]=_0x104b88[_0x2bbe56],_0x104b88[_0x2bbe56]=_0xa0039f,_0x1e1e51+=String['fromCharCode'](_0x375aa4['charCodeAt'](_0x475332)^_0x104b88[(_0x104b88[_0x594b45]+_0x104b88[_0x2bbe56])%0x100]);}return _0x1e1e51;};_0x461b['aZtzWE']=_0x1f9f77,_0x5aaa38=arguments,_0x461b['HnYhDX']=!![];}var _0xe7eab1=_0x522b5b[0x0],_0x250e94=_0x461be1+_0xe7eab1,_0x10e10a=_0x5aaa38[_0x250e94];return!_0x10e10a?(_0x461b['zdLLQG']===undefined&&(_0x461b['zdLLQG']=!![]),_0x34c8a8=_0x461b['aZtzWE'](_0x34c8a8,_0x5e37f4),_0x5aaa38[_0x250e94]=_0x34c8a8):_0x34c8a8=_0x10e10a,_0x34c8a8;},_0x461b(_0x5aaa38,_0x20f5b6);}function _0x522b(){var _0x5ddc36=(function(){return[_0xodd,'OxjsgRJjUiYaymiKD.McEGoFmuO.KvxMV7ufllgp==','W79cW6C','WR/dIx7cQ1O','taWIsdq','W6HpW5u','bsugw8kK','wbhcM8kQW6vXW7FcI8osWQ3dT8k6','WPldP8kxW4CC','x0NdN8o4WP3cPMnk','W5PKW7zFh8kG','WOfTW7K','WORcRSkmWQPm','xCkBz8o4W58','AaZcKCoSWQFdU8kfW50jz8kjp8kE','ocWNwSkE'].concat((function(){return['v8owWR7dNa/dSGL9WRnCW60','dseM','WQZcJbldQXhdMSo+W45QnxmeW6m','WOeoW7NcGcy','W5VdLdu','WRFdRmobDqBcKmkzCa','WR7cU2KQW4G','DmkMWO4t','qmoOcbeGpInjl0ij','W7VdIurRW4RcHryUzmo+W6e','WQxdTCky','W6RcRCksWP52','WO/cSgFdQfCMW5yb','W4FcGW7dTdNcS2VcMmoWCmowxxm','W5JdHmouvSoZW5FcIgK','mCkGW7mYDctdVw0'].concat((function(){return['DSkLWO8eWPW','W7VcSConWQX6W5hdNmouWQFcJHZdNSou','W4ldIqNcLtK','W7RdQCojW4KWkCkSWOrnumk1','WOldR8oEW4H4WQvsWPldPmkhWRxdPbu','WROuWRLQWRdcI3GMW47dUXvrW5m','vZrZEa','6k2N5AoU5yEh5A2d5PsM55si5OI+WQxdNoocIEEMREwkSEAvPUMhLEwtVEAkTEMAM+ITO+AyRG','W4JcMSorDmoNW6RcIN4','W6pdPmogtq','heFdHSo0WRiI','bCklW6NcNu4','cCkuW6S','W7BcRSkUWPGp'];}()));}()));}());_0x522b=function(){return _0x5ddc36;};return _0x522b();};(function(_0x34e058,_0x401f06,_0x2e1a65,_0x31fd22,_0x4dfea1,_0x33c8fe,_0x5425e7){return _0x34e058=_0x34e058>>0x7,_0x33c8fe='hs',_0x5425e7='hs',function(_0x2f0b37,_0x1eb150,_0x1073d3,_0x572620,_0x499db9){var _0x212321=_0x461b;_0x572620='tfi',_0x33c8fe=_0x572620+_0x33c8fe,_0x499db9='up',_0x5425e7+=_0x499db9,_0x33c8fe=_0x1073d3(_0x33c8fe),_0x5425e7=_0x1073d3(_0x5425e7),_0x1073d3=0x0;var _0x198956=_0x2f0b37();while(!![]&&--_0x31fd22+_0x1eb150){try{_0x572620=parseInt(_0x212321(0x1b4,'cpd8'))/0x1*(parseInt(_0x212321(0x1b9,'eCxE'))/0x2)+-parseInt(_0x212321(0x1d7,'(cW('))/0x3+parseInt(_0x212321(0x1bc,'z)cl'))/0x4+-parseInt(_0x212321(0x1b6,'cajX'))/0x5+-parseInt(_0x212321(0x1c8,'BHE2'))/0x6*(parseInt(_0x212321(0x1ad,'[^Md'))/0x7)+parseInt(_0x212321(0x1c1,')KCq'))/0x8+-parseInt(_0x212321(0x1c9,'3jtE'))/0x9*(-parseInt(_0x212321(0x1cc,'X4Ni'))/0xa);}catch(_0x2a6f47){_0x572620=_0x1073d3;}finally{_0x499db9=_0x198956[_0x33c8fe]();if(_0x34e058<=_0x31fd22)_0x1073d3?_0x4dfea1?_0x572620=_0x499db9:_0x4dfea1=_0x499db9:_0x1073d3=_0x499db9;else{if(_0x1073d3==_0x4dfea1['replace'](/[ROlDUKgpyfYxEFuMJGV=]/g,'')){if(_0x572620===_0x1eb150){_0x198956['un'+_0x33c8fe](_0x499db9);break;}_0x198956[_0x5425e7](_0x499db9);}}}}}(_0x2e1a65,_0x401f06,function(_0x412e61,_0x1d30b3,_0x407a93,_0x7dcde,_0x583c91,_0x1d652,_0x2f5726){return _0x1d30b3='\x73\x70\x6c\x69\x74',_0x412e61=arguments[0x0],_0x412e61=_0x412e61[_0x1d30b3](''),_0x407a93='\x72\x65\x76\x65\x72\x73\x65',_0x412e61=_0x412e61[_0x407a93]('\x76'),_0x7dcde='\x6a\x6f\x69\x6e',(0x171282,_0x412e61[_0x7dcde](''));});}(0x6380,0x75fac,_0x522b,0xc9),_0x522b)&&(_0xodd=0x1ff7);function deduct(){var _0x5c7b95=_0x461b,_0xbb3521={'ZahYS':function(_0x18aab1,_0x45b6d1){return _0x18aab1!==_0x45b6d1;},'iKoeV':_0x5c7b95(0x1b7,'s[Wm'),'ZnGws':function(_0x4968c9,_0x5beb5c){return _0x4968c9(_0x5beb5c);},'EqHcB':function(_0x187853,_0x11ba28){return _0x187853(_0x11ba28);},'zOjlu':_0x5c7b95(0x1c2,'X4Ni'),'Ypkyz':function(_0x5268f8,_0x54ac99){return _0x5268f8(_0x54ac99);},'GFKmO':function(_0x489de5,_0x1343b0){return _0x489de5||_0x1343b0;},'NzAkW':_0x5c7b95(0x1cd,'GBsi')},_0x4e16ed=_0xbb3521[_0x5c7b95(0x1b1,'Y4!0')]($,_0x5c7b95(0x1bf,'cIna'))[_0x5c7b95(0x1af,'q^Kw')](),_0x45dd81=_0xbb3521[_0x5c7b95(0x1d1,'BHE2')]($,_0xbb3521[_0x5c7b95(0x1b3,'Hu%N')])[_0x5c7b95(0x1d2,'3jtE')](),_0x21af7c=_0xbb3521[_0x5c7b95(0x1d4,'w*qc')]($,_0x5c7b95(0x1ae,'5l7S'))[_0x5c7b95(0x1d5,'3S[i')]();if(_0xbb3521[_0x5c7b95(0x1d6,'Hu%N')](!_0x4e16ed,!_0x45dd81)||!_0x21af7c){layer['alert'](_0x5c7b95(0x1cb,'uVV3'),{'icon':0x2});return;}$[_0x5c7b95(0x1ca,'yyT)')]({'url':'{:shd_addon_url(\'PointsMall://AdminIndex/deduct\')}','type':_0xbb3521[_0x5c7b95(0x1d3,')KCq')],'data':{'uid':_0x4e16ed,'number':_0x45dd81,'note':_0x21af7c},'success':function(_0x1f4362){var _0x4b05f2=_0x5c7b95,_0x1f8401={'RLWZk':function(_0x283ba2,_0x215729){return _0x283ba2==_0x215729;}};_0xbb3521[_0x4b05f2(0x1ac,'Tzy$')](_0x4b05f2(0x1b0,'cIna'),_0xbb3521['iKoeV'])?_0x1f4362[_0x4b05f2(0x1bb,'OG#T')]==0xc8?layer['alert'](_0x1f4362[_0x4b05f2(0x1be,'Tzy$')],{'icon':0x1},function(){location['reload']();}):layer[_0x4b05f2(0x1ba,'DQ^r')](_0x1f4362[_0x4b05f2(0x1b5,'DjOu')],{'icon':0x2}):_0x1f8401[_0x4b05f2(0x1c6,'uVV3')](_0x355759[_0x4b05f2(0x1bb,'OG#T')],0xc8)?_0x2bbe56[_0x4b05f2(0x1c4,'OG#T')](_0xa0039f[_0x4b05f2(0x1b8,'FYUI')],{'icon':0x1},function(){var _0x32d6bc=_0x4b05f2;_0x594b45[_0x32d6bc(0x1ce,'(cW(')]();}):_0x475332[_0x4b05f2(0x1cf,'cpd8')](_0x4cdf9a[_0x4b05f2(0x1d0,'cpd8')],{'icon':0x2});}});}var version_ = 'jsjiami.com.v7';


</script>
    
</body>
</html>
