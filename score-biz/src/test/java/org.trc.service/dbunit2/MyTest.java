package org.trc.service.dbunit2;

import com.github.springtestdbunit.annotation.DatabaseSetup;
import com.github.springtestdbunit.annotation.ExpectedDatabase;
import com.github.springtestdbunit.assertion.DatabaseAssertionMode;
import org.dbunit.dataset.ReplacementDataSet;
import org.junit.Assert;
import org.junit.Test;


import java.io.IOException;
import java.sql.SQLException;

/**
 * Created by hzwzhen on 2017/6/19.
 */
public class MyTest extends BaseTestCase {



    @Test
    @DatabaseSetup({"classpath:/MyTest.xml"})
    //The comparation can be kept, it's maybe correct
    @ExpectedDatabase(assertionMode= DatabaseAssertionMode.NON_STRICT,value="classpath:/MyTest_Result.xml")
    public void testSend() throws IOException, SQLException {
        try {
            // get result data set by result xml file
            ReplacementDataSet dataload_result = createDataSet(Thread.currentThread().getContextClassLoader().getResourceAsStream("MyTest_Result.xml"));
            // compare the data which get from database and the expected result file
            assertDataSet("YouTableName_1", "select filed_1,filed_2,filed_3 from YouTableName_1 order by filed_1", dataload_result);
        } catch (Exception e) {
            e.printStackTrace();
            Assert.assertTrue(false);
        }

    }

}
