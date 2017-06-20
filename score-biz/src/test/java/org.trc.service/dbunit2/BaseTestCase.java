package org.trc.service.dbunit2;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.sql.DataSource;

import junit.framework.Assert;

import org.dbunit.Assertion;
import org.dbunit.database.DatabaseConnection;
import org.dbunit.database.IDatabaseConnection;
import org.dbunit.database.QueryDataSet;
import org.dbunit.dataset.Column;
import org.dbunit.dataset.IDataSet;
import org.dbunit.dataset.ITable;
import org.dbunit.dataset.ReplacementDataSet;
import org.dbunit.dataset.filter.DefaultColumnFilter;
import org.dbunit.dataset.xml.FlatXmlDataSetBuilder;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.TestExecutionListeners;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.support.DependencyInjectionTestExecutionListener;
import org.springframework.test.context.transaction.TransactionalTestExecutionListener;
import org.springframework.transaction.annotation.Transactional;

import com.github.springtestdbunit.TransactionDbUnitTestExecutionListener;
/**
 * Created by hzwzhen on 2017/6/19.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:config/resource-context.xml" })
@TestExecutionListeners({ DependencyInjectionTestExecutionListener.class, TransactionalTestExecutionListener.class, TransactionDbUnitTestExecutionListener.class })
@Rollback(value = true)
@Transactional(transactionManager = "transactionManager")
public abstract class BaseTestCase {

    @Autowired
    DataSource dataSource;

    /**
     * This is used to assert the data from table and the expected data set. If all of the them has the same records, then the assert is true.
     *
     * @param tableName
     * @param sql
     * @param expectedDataSet
     * @throws Exception
     */
    protected void assertDataSet(String tableName, String sql, IDataSet expectedDataSet) throws Exception {
        if (dataSource == null) {
            throw new RuntimeException("There must be dataSource in the spring config file");
        }
        IDatabaseConnection iconn = new DatabaseConnection(dataSource.getConnection());
        printDataAsXml(iconn, tableName, sql);
        QueryDataSet loadedDataSet = new QueryDataSet(iconn);
        loadedDataSet.addTable(tableName, sql);
        ITable table1 = loadedDataSet.getTable(tableName);
        ITable table2 = expectedDataSet.getTable(tableName);
        Assert.assertEquals(table2.getRowCount(), table1.getRowCount());

        DefaultColumnFilter.includedColumnsTable(table1, table2.getTableMetaData().getColumns());
        Assertion.assertEquals(table2, table1);

    }

    /**
     * Create the data set by input stream which read from the dbunit xml data file.
     *
     * @param is
     * @return
     * @throws Exception
     */
    protected ReplacementDataSet createDataSet(InputStream is) throws Exception {
        return new ReplacementDataSet(new FlatXmlDataSetBuilder().build(is));
    }

    /**
     * Convert the data in the ITable to List
     *
     * @param table
     * @return
     * @throws Exception
     */
    private List<Map<?, ?>> getDataFromTable(ITable table) throws Exception {
        List<Map<?, ?>> ret = new ArrayList<Map<?, ?>>();
        int count_table = table.getRowCount();
        if (count_table > 0) {
            Column[] columns = table.getTableMetaData().getColumns();
            for (int i = 0; i < count_table; i++) {
                Map<String, Object> map = new TreeMap<String, Object>();
                for (Column column : columns) {
                    map.put(column.getColumnName().toUpperCase(), table.getValue(i, column.getColumnName()));
                }
                ret.add(map);
            }
        }
        return ret;
    }

    /**
     * Get data by the SQL and table name, then convert the data in the ITable to List
     *
     * @param iconn
     * @param tableName
     * @param sql
     * @return
     * @throws Exception
     */
    private List<Map<?, ?>> getTableDataFromSql(IDatabaseConnection iconn, String tableName, String sql) throws Exception {
        ITable table = iconn.createQueryTable(tableName, sql);
        return getDataFromTable(table);
    }

    /**
     * Get data by the SQL and table name, then convert the data in the ITable to List. And the print the data as xml data format.
     *
     * @param iconn
     * @param tableName
     * @param sql
     * @throws Exception
     */
    private void printDataAsXml(IDatabaseConnection iconn, String tableName, String sql) throws Exception {
        List<Map<?, ?>> datas = getTableDataFromSql(iconn, tableName, sql);
        StringBuffer sb;
        for (Map<?, ?> data : datas) {
            sb = new StringBuffer();
            sb.append("<" + tableName.toUpperCase() + " ");
            for (Object o : data.keySet()) {
                sb.append(o + "=\"" + data.get(o) + "\" ");
            }
            sb.append("/>");
            System.out.println(sb.toString());
        }
    }
}
