package org.trc.service.dbunit3;

import java.io.IOException;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.sql.Connection;
import java.sql.SQLException;

import junit.framework.Assert;

import org.dbunit.database.IDatabaseConnection;
import org.dbunit.dataset.ReplacementDataSet;
import org.dbunit.operation.DatabaseOperation;
import org.junit.Test;

/**
 * Created by hzwzhen on 2017/6/20.
 */
public class MyTest extends BaseTestCase{

    @Test
    public void testSend() throws IOException, SQLException {
        Connection conn = null;
        Boolean result = Boolean.FALSE;
        IDatabaseConnection iconn = null;
        try {
            //Get DBUnit conneciton
            iconn = getIDatabaseConnection();
            //Get database connection
            conn = iconn.getConnection();
            //Set auto commit false
            conn.setAutoCommit(false);
            //prepare data
            prepareData(iconn);

            //use reflect to set the commit field to false
            Class<UpdateTest> clazz = UpdateTest.class;
            Field commitField = clazz.getDeclaredField("commit");
            commitField.setAccessible(true);
            commitField.setBoolean(clazz, false);

            //call the method updateFiled
            Method method = clazz.getDeclaredMethod("updateFiled", java.sql.Connection.class);
            method.setAccessible(true);
            //Before call the method, the clazz must be get an new install, because the called method "updateFiled" is not static.<br>
            //If the called method is static, it will not need newInstance.
            method.invoke(clazz.newInstance(), conn);

            // get result data set by result xml file
            ReplacementDataSet dataload_result = createDataSet(Thread.currentThread().getContextClassLoader().getResourceAsStream("MyTest_Result.xml"));

            // compare the data which get from database and the expected result file
            assertDataSet("YouTableName_1", "select filed_1,filed_2,filed_3 from YouTableName_1 order by filed_1", dataload_result, iconn);
        } catch (Exception e) {
            e.printStackTrace();
            Assert.assertTrue(result);
        } finally {
            if (conn != null) {
                conn.rollback();
                conn.close();
            }
        }

    }

    @Override
    protected void prepareData(IDatabaseConnection iconn) throws Exception {
        //Remove the data from table YouTableName_1
        execSql(iconn, "delete from YouTableName_1");
        //INSERT TEST DATA
        ReplacementDataSet createDataSet = createDataSet(Thread.currentThread().getContextClassLoader().getResourceAsStream("MyTest.xml"));
        DatabaseOperation.INSERT.execute(iconn, createDataSet);
    }
}
