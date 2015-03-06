$(document).ready(function(){
//生产单
	var producingGrid = new OrderGrid({
		url:"order/producingorder",
		$content:$(".body"),
		tbOptions:{
			colnames : [
					{
						name :'color',
						colname :'颜色',
						width :'15%'
					},
					{
						name :'weight',
						colname :'克重(g)',
						width :'15%'
					},
					{
						name :'yarn',
						colname :'纱线种类',
						width :'15%'
					},
					{
						name :'size',
						colname :'尺寸',
						width :'15%'
					},
					{
						name :'quantity',
						colname :'生产数量',
						width :'15%'
					},
					{
						name :'price',
						colname :'价格(/个)',
						width :'15%'
					}],
					$dialog:$("#producingDialog")
		},
		tbOptions2:{
			colnames : [
			        {
			        	name :'material',
			        	colname :'材料',
			        	width :'20%'
			        },
					{
						name :'color',
						colname :'色号',
						width :'20%'
					},
					{
						name :'quantity',
						colname :'数量',
						width :'20%'
					},
					{
						name :'colorsample',
						colname :'标准色样',
						width :'25%'
					},
					{
						name :'_handle',
						colname :'操作',
						width :'15%',
						displayValue : function(value, rowdata) {
							return "<a class='editRow' href='#'>修改</a> | <a class='deleteRow' href='#'>删除</a>";
						}
					} 
					],
			$dialog:$("#producingDetailDialog")
		}
		
	});
});