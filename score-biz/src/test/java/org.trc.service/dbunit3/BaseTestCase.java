package org.trc.service.dbunit3;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.TreeMap;

import junit.framework.Assert;

import org.dbunit.Assertion;
import org.dbunit.DatabaseUnitException;
import org.dbunit.IDatabaseTester;
import org.dbunit.JdbcDatabaseTester;
import org.dbunit.database.DatabaseConnection;
import org.dbunit.database.IDatabaseConnection;
import org.dbunit.database.QueryDataSet;
import org.dbunit.dataset.Column;
import org.dbunit.dataset.IDataSet;
import org.dbunit.dataset.ITable;
import org.dbunit.dataset.ReplacementDataSet;
import org.dbunit.dataset.filter.DefaultColumnFilter;
import org.dbunit.dataset.xml.FlatXmlDataSet;
import org.dbunit.dataset.xml.FlatXmlDataSetBuilder;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.TestExecutionListeners;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.support.DependencyInjectionTestExecutionListener;
import org.springframework.transaction.annotation.Transactional;
/**
 * Created by hzwzhen on 2017/6/20.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:config/resource-context.xml" })
@TestExecutionListeners({ DependencyInjectionTestExecutionListener.class })
@Transactional
public abstract class BaseTestCase {

    protected static Properties properties = new Properties();
    static {
        try {
            /**
             * The DatabaseConfig.properties stores the database configuration information. It's like this: <br>
             * driverClass=oracle.jdbc.OracleDriver<br>
             * db_inst=jdbc:oracle:thin:@1.1.1.1:1521:schema<br>
             * db_user=username<br>
             * db_pwd=password<br>
             */
            properties.load(Thread.currentThread().getContextClassLoader().getResourceAsStream("DatabaseConfig.properties"));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * This abstract is used for prepare data before do the real method call.
     *
     * @param iconn
     * @throws Exception
     */
    protected abstract void prepareData(IDatabaseConnection iconn) throws Exception;

    /**
     * Execute one sql
     *
     * @param iconn
     * @param sql
     * @throws Exception
     */
    protected void execSql(IDatabaseConnection iconn, String sql) throws Exception {
        Connection con = iconn.getConnection();
        Statement stmt = con.createStatement();
        try {
            stmt.execute(sql);
        } finally {
            if (stmt != null) {
                stmt.close();
            }
        }
    }

    /**
     * Get IDatabaseConnection connection
     *
     * @return
     * @throws Exception
     */
    protected IDatabaseConnection getIDatabaseConnection() throws Exception {

        String db_inst = "", db_user = "", db_pwd = "", driverClass = "";
        //The default is commit the record
        db_user = properties.getProperty("db_user");
        db_inst = properties.getProperty("db_inst");
        db_pwd = properties.getProperty("db_pwd");
        driverClass = properties.getProperty("driverClass");

        IDatabaseConnection iconn = null;
        IDatabaseTester databaseTester;
        databaseTester = new JdbcDatabaseTester(driverClass, db_inst, db_user, db_pwd);
        iconn = databaseTester.getConnection();
        return iconn;
    }

    /**
     * This is used to assert the data from table and the expected data set. If all of the them has the same records, then the assert is true.
     *
     * @param tableName
     * @param sql
     * @param expectedDataSet
     * @param iconn
     * @throws Exception
     */
    protected void assertDataSet(String tableName, String sql, IDataSet expectedDataSet, IDatabaseConnection iconn) throws Exception {
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
    protected List<Map<?, ?>> getTableDataFromSql(IDatabaseConnection iconn, String tableName, String sql) throws Exception {
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
    protected void printDataAsXml(IDatabaseConnection iconn, String tableName, String sql) throws Exception {
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

    /**
     * Export data for the table names by the given Connection into the resultFile.<br>
     * The export data will be DBUnit format.
     *
     * @param conn
     * @param tableNameList
     * @param resultFile
     * @throws SQLException
     * @throws DatabaseUnitException
     * @throws FileNotFoundException
     * @throws IOException
     */
    public void exportData(Connection conn, List<String> tableNameList, String resultFile) throws SQLException, DatabaseUnitException, FileNotFoundException, IOException {
        if (conn == null) {
            return;
        }
        IDatabaseConnection iconn = new DatabaseConnection(conn);
        exportData(iconn, tableNameList, resultFile);
    }

    /**
     * Export data for the table names by the given IDatabaseConnection into the resultFile.<br>
     * The export data will be DBUnit format.
     *
     * @param conn
     * @param tableNameList
     * @param resultFile
     * @throws SQLException
     * @throws DatabaseUnitException
     * @throws FileNotFoundException
     * @throws IOException
     */
    public void exportData(IDatabaseConnection iconn, List<String> tableNameList, String resultFile) throws SQLException, DatabaseUnitException, FileNotFoundException, IOException {
        QueryDataSet dataSet = null;
        if (iconn == null) {
            return;
        }
        if (tableNameList == null || tableNameList.size() == 0) {
            return;
        }
        try {
            dataSet = new QueryDataSet(iconn);
            for (String tableName : tableNameList) {
                dataSet.addTable(tableName);
            }
        } finally {
            if (dataSet != null) {
                FlatXmlDataSet.write(dataSet, new FileOutputStream(resultFile));
            }
        }

    }
}
