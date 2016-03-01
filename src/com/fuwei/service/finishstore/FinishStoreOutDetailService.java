package com.fuwei.service.finishstore;

import java.util.ArrayList;
import java.util.List;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import com.fuwei.entity.finishstore.FinishStoreOutDetail;
import com.fuwei.service.BaseService;


@Component
public class FinishStoreOutDetailService extends BaseService {
	private Logger log = org.apache.log4j.LogManager.getLogger(FinishStoreOutDetailService.class);
	@Autowired
	JdbcTemplate jdbc;
	
	// 获取详情列表
	public List<FinishStoreOutDetail> getList(int finishStoreInOutId) throws Exception {
		try {
			List<FinishStoreOutDetail> List = dao.queryForBeanList(
					"SELECT * FROM tb_finishstore_out_detail WHERE finishStoreInOutId=?", FinishStoreOutDetail.class,finishStoreInOutId);
			return List;
		} catch (Exception e) {
			throw e;
		}
	}
	
	@Transactional
	public boolean addBatch(List<FinishStoreOutDetail> detailList) throws Exception {
		String sql = "INSERT INTO tb_finishstore_out_detail(finishStoreInOutId,packingOrderDetailId,quantity,cartons) VALUES(?,?,?,?)";
		List<Object[]> batchArgs = new ArrayList<Object[]>();
		for (FinishStoreOutDetail item : detailList) {
			batchArgs.add(new Object[] { 
					item.getFinishStoreInOutId(), item.getPackingOrderDetailId(),item.getQuantity(),item.getCartons()
			});
		}
		try {
			int result[] = jdbc.batchUpdate(sql, batchArgs);
			return true;
		} catch (Exception e) {
			throw e;
		}
	}
	
	@Transactional
	public int deleteBatch(int finishStoreInOutId) throws Exception {
		try{
			return dao.update("delete from tb_finishstore_out_detail WHERE finishStoreInOutId =?", finishStoreInOutId);
		}catch(Exception e){
			throw e;
		}
	}
}