package org.trc.service.dbunit3;

import java.sql.Connection;
import java.sql.SQLException;

/**
 * Created by hzwzhen on 2017/6/20.
 */
public class UpdateTest {
    private static boolean commit = true;

    public UpdateTest() {

    }

    private void commit(Connection conn) throws SQLException {
        if (commit) {
            conn.commit();
        }
    }

    public void updateFiled(Connection conn) throws SQLException {
        conn.createStatement().execute("update YouTableName_1 set filed_2='a',filed_3='a1' where filed_1=1");
        conn.createStatement().execute("update YouTableName_1 set filed_2='b',filed_3='b1' where filed_1=2");
        commit(conn);
    }
}
