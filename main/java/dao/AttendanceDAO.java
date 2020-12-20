/* Masthan Swamy */

package dao;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCallback;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.stereotype.Controller;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;

@Controller
public class AttendanceDAO
{
    JdbcTemplate jt;
    float gross=0;

    public void setJt(JdbcTemplate jt) {
        this.jt = jt;
    }

/*
    public void checkUser(int empid)
    {
        String sql = "select ";
    }
*/

    public int checkStatus(int empid)
    {
        String sql = "select last_attended,gross_renum from empsattendance where empid="+empid;

        Date got = jt.query(sql, new ResultSetExtractor<Date>() {
            @Override
            public Date extractData(ResultSet resultSet) throws SQLException, DataAccessException {
                resultSet.next();

                gross = resultSet.getFloat(2);
                return resultSet.getDate(1);
            }
        });

        LocalDate got1 = got.toLocalDate();
        LocalDate now = LocalDate.now();

        if(got1.getDayOfMonth()==now.getDayOfMonth())
            return 0;
        else
            return 1;
    }

    public int attended(int empid)
    {
        if(checkStatus(empid)==1)
        {
            float dayrenum = (10000/30);
            gross += dayrenum;
            String sql = "update empsattendance set attended_days=attended_days+1,last_attended=CURRENT_DATE,gross_renum="+gross+" where empid="+empid;

            updatePayDetails(empid);
            return jt.update(sql);
        }
        else
            return 0;
    }

    public int mistakenlyTaken(int empid)
    {
        if(checkStatus(empid)==0)
        {
            float dayrenum = (10000/30);
            gross -= dayrenum;
            String sql = "update empsattendance set attended_days=attended_days-1,last_attended='1970-01-01',gross_renum="+gross+" where empid="+empid;

            updatePayDetails(empid);
            return jt.update(sql);
        }
        else
            return 0;
    }

    public void updatePayDetails(int empid)
    {
        // Setting Employee Pay Details
        float basicpay = (float) (gross*0.4);
        float da = (float) (gross*0.2);
        float hra = (float) (gross*0.2);
        float ma = (float) (gross*0.2);

        float pf = (float) (gross*0.125);
        float pt = 0;
        if(gross<15000.00)
            pt = 150;
        else if(gross>20000)
            pt = 200;
        float netsal = gross-(pf+pt);

        /*System.out.println("gross : "+gross);
        System.out.println("basicpay : "+basicpay);
        System.out.println("da : "+da);
        System.out.println("hra : "+hra);
        System.out.println("ma : "+ma);*/

        String sql2 = "update pay_details set basicpay=?, da=?, hra=?, ma=?, pf=?, pt=?, net=? where empid="+empid;
        float finalPt = pt;
        jt.execute(sql2, new PreparedStatementCallback<Object>() {
            @Override
            public Object doInPreparedStatement(PreparedStatement preparedStatement) throws SQLException, DataAccessException {

                preparedStatement.setFloat(1,basicpay);
                preparedStatement.setFloat(2,da);
                preparedStatement.setFloat(3,hra);
                preparedStatement.setFloat(4,ma);
                preparedStatement.setFloat(5,pf);
                preparedStatement.setFloat(6, finalPt);
                preparedStatement.setFloat(7,netsal);

                preparedStatement.execute();
                return null;
            }
        });
    }

}
