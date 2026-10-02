<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>添加奖品</title>

    <style>
        bodys {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        form {
            max-width: 800px; 
            margin: 0 auto;
            display: grid; 
            grid-template-columns: repeat(2, 1fr); 
            grid-gap: 10px; 
        }
        label {
            display: block;
            margin-bottom: 5px;
        }
        input, textarea, select {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
        }
        div.field-group {
            margin-bottom: 15px;
        }
        button {
            background-color: #4CAF50;
            color: white;
            padding: 10px;
            border: none;
            cursor: pointer;
            width: 100%;
        }
        button:hover {
            background-color: #45a049;
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
    <form id="prizeForm">

        
        
        <div class="field-group">
            <label for="prizeType">选择奖品类型:</label>
            <select id="prizeType" name="prizeType" onchange="showFields()">
                <option value="1">余额</option>
                <option value="2">优惠券</option>
                <option value="3">实物奖品</option>
                <option value="4">自定义奖品</option>
            </select>
        </div>

        
        <div class="field-group">
            <label for="name">奖品名称:</label>
            <input type="text" id="name" name="name" placeholder="请输入奖品名称">
        </div>

        <div class="field-group">
            <label for="description">奖品描述:</label>
            <textarea id="description" name="description" placeholder="请输入奖品描述信息"></textarea>
        </div>

        <div class="field-group">
            <label for="requiredPoints">所需积分:</label>
            <input type="text" id="requiredPoints" name="requiredPoints" placeholder="请输入兑奖所需积分">
        </div>

        
        <div class="field-group">
            <label for="starttime">活动开始:</label>
            <input type="datetime-local" id="starttime" name="starttime" placeholder="请选择活动开始时间">
        </div>
        <div class="field-group">
            <label for="endtime">活动结束:</label>
            <input type="datetime-local" id="endtime" name="endtime" placeholder="请选择活动结束时间">
        </div>
        
        <div class="field-group">
            <label for="quantity">奖品数量:</label>
            <input type="text" id="quantity" name="quantity" placeholder="请输入奖品数量">
        </div>
        
        <div class="field-group" id="amountField" style="display:none;">
            <label for="amount">金额:</label>
            <input type="text" id="amount" name="amount" placeholder="请输入兑换的余额金额">
        </div>

        <div class="field-group" id="couponField" style="display:none;">
            <label for="validityPeriod">有效期:</label>
            <input type="text" id="validityPeriod" name="validityPeriod" placeholder="请输入优惠券领取后有效期，单位小时">
            
            
                      <label class="require">可使用的产品</label>
                      
                        <select class="form-control" name="applicableProducts[]" id="product-select" multiple>
                            <option value="">请选择产品（选中此项或不选表示不限制产品）</option>
                            {volist name="keproducts" id="product"}
                                <option value="{$product.id}">【{$product.group_name}】-【{if empty($product.api_name)}本地接口{else}对接：{$product.api_name}{/if}】产品ID：{$product.id} - {$product.name} -- 【产品状态：{if $product.hidden == '0'}在线{elseif $product.hidden == '1'}隐藏{/if}】</option>
                                
                            {/volist}
                        </select>
                        
                      
            
            <label for="recurring">续费同价:</label>
            <select id="recurring" name="recurring">
                <option value="0">否</option>
                <option value="1">是</option>
            </select>

            <label for="one_time">限一个产品:</label>
            <select id="one_time" name="one_time">
                <option value="0">否</option>
                <option value="1">是</option>
            </select>
            
            <label for="lifelong">适用升降级:</label>
            <select id="lifelong" name="lifelong">
                <option value="0">否</option>
                <option value="1">是</option>
            </select>
            
            <label for="is_discount">代理可使用:</label>
            <select id="is_discount" name="is_discount">
                <option value="0">否</option>
                <option value="1">是</option>
            </select>
            
            
            
            <label for="cycles">结算周期:</label>
            <select id="cycles" name="cycles[]" multiple>
                <option value="">不限制</option>
                <option value="hour">小时付</option>
                <option value="day">天付</option>
                <option value="monthly">月付</option>
                <option value="quarterly">季付</option>
                <option value="semiannually">半年</option>
                <option value="annually">年付</option>
                <option value="biennially">2年付</option>
                <option value="triennially">3年付</option>
                <option value="fourly">4年付</option>
                <option value="fively">5年付</option>
            </select>

            
            
            <label for="discounttype">折扣类型:</label>
            <select id="discounttype" name="discounttype">
                <option value="percent">百分比</option>
                <option value="fixed">固定金额</option>
            </select>
            
            <label for="discountPercentage">优惠面值:</label>
            <input type="text" id="discountPercentage" name="discountPercentage" placeholder="请输入优惠券面值，如20百分比表示20%(即2折)，固定金额表示20元">
        </div>

        <div class="field-group" id="shiwu" style="display:none;">
            <label for="shiwu">实物奖品:</label>
            <input type="text" id="shiwu" name="shiwu">
        </div>

        <div class="field-group" id="customField" style="display:none;">
            <label for="customField">自定义奖品:</label>
            <input type="text" id="customField" name="customField" placeholder="请输入自定义奖品，如某某配置主机">
        </div>

        <button type="button" onclick="submitForm()">提交</button>
    </form>



    <script>

function showFields() {
    var type = document.getElementById('prizeType').value;
    toggleField('amountField', type === '1');
    toggleField('couponField', type === '2');
    toggleField('shiwu', type === '3');
    toggleField('customField', type === '4');
}

function toggleField(id, show) {
    var el = document.getElementById(id);
    if (el) {
        el.style.display = show ? 'block' : 'none';
    }
}

function submitForm() {
    var starttime = $('#starttime').val();
    var endtime = $('#endtime').val();
    if (starttime === '') {
        layer.confirm('活动开始时间为空（提交后活动立即生效），是否继续提交？', {btn: ['继续', '取消'], icon: 3}, function () {
            doSubmitForm();
        }, function () {});
        return;
    }
    if (endtime === '') {
        layer.confirm('活动结束时间为空（提交后活动长期有效），是否继续提交？', {btn: ['继续', '取消'], icon: 3}, function () {
            doSubmitForm();
        }, function () {});
        return;
    }
    doSubmitForm();
}

function doSubmitForm() {
    var data = $('#prizeForm').serialize();
    var load = layer.load();
    $.ajax({
        url: '{:shd_addon_url(\'PointsMall://AdminIndex/addPrize\')}',
        type: 'post',
        data: data,
        dataType: 'json',
        success: function (res) {
            layer.close(load);
            if (res.code != 200) {
                layer.alert(res.msg, {icon: 2});
                return false;
            }
            layer.alert(res.msg, {icon: 1}, function () {
                location.reload();
            });
        },
        error: function () {
            layer.close(load);
            layer.alert('请求失败');
        }
    });
}

$(function () {
    showFields();
});

    </script>


</body>
</html>
