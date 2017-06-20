package org.trc.service.dbunit;

import org.dbunit.database.IDatabaseConnection;
import org.dbunit.dataset.ReplacementDataSet;
import org.dbunit.operation.DatabaseOperation;

/**
 * Created by hzwzhen on 2017/6/20.
 */
public class BannerBizTest extends BaseTestCase{


    //准备数据
    @Override
    protected void prepareData(IDatabaseConnection conn, String fileName) throws Exception {
        //INSERT TEST DATA
        ReplacementDataSet createDataSet = createDataSet(Thread.currentThread().getContextClassLoader().getResourceAsStream(fileName));
        DatabaseOperation.INSERT.execute(conn, createDataSet);
    }
}
