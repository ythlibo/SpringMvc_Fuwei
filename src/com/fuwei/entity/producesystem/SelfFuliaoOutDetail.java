package com.fuwei.entity.producesystem;

import net.keepsoft.commons.annotation.IdentityId;
import net.keepsoft.commons.annotation.Table;

@Table("tb_selffuliaoout_detail")
public class SelfFuliaoOutDetail {
	@IdentityId
	private int id;
	private int fuliaoPurchaseOrderDetailId;//辅料采购单明细ID
	private int selfFuliaoOutId;//自购辅料出库单ID
	private Integer style ; //辅料类型
	private String memo;//备注
	private int locationId;//出库库位ID
	private int quantity;//出库数量
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getFuliaoPurchaseOrderDetailId() {
		return fuliaoPurchaseOrderDetailId;
	}
	public void setFuliaoPurchaseOrderDetailId(int fuliaoPurchaseOrderDetailId) {
		this.fuliaoPurchaseOrderDetailId = fuliaoPurchaseOrderDetailId;
	}
	
	public int getSelfFuliaoOutId() {
		return selfFuliaoOutId;
	}
	public void setSelfFuliaoOutId(int selfFuliaoOutId) {
		this.selfFuliaoOutId = selfFuliaoOutId;
	}
	public Integer getStyle() {
		return style;
	}
	public void setStyle(Integer style) {
		this.style = style;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public int getLocationId() {
		return locationId;
	}
	public void setLocationId(int locationId) {
		this.locationId = locationId;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
}
