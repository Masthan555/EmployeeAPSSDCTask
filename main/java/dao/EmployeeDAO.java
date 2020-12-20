/* Masthan Swamy */

package dao;

import model.Employee;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.*;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class EmployeeDAO
{
    JdbcTemplate jt;

    public void setJt(JdbcTemplate jt) {
        this.jt = jt;
    }

    public void insertEmployee(final Employee employee)
    {
        String sql = "insert into employeesdata(name,qual,gender,pan,DOB,DOJ) values(?, ?, ?, ?, ?, ?)";

        KeyHolder holder = new GeneratedKeyHolder();

        jt.update(connection -> {
            PreparedStatement preparedStatement = connection.prepareStatement(sql, new String[]{"empid"});

            preparedStatement.setString(1, employee.getName());
            preparedStatement.setString(2, employee.getQual());
            preparedStatement.setString(3, employee.getGender());
            preparedStatement.setString(4, employee.getPan());
            preparedStatement.setDate(5, employee.getDob());
            preparedStatement.setDate(6, employee.getDoj());

            return preparedStatement;
        }, holder);

        // For Attendance
        int genid = holder.getKey().intValue();
        // Inserting record in Attendance
        String sql1 = "insert into empsattendance(empid) values(?)";

        jt.execute(sql1, new PreparedStatementCallback<Integer>() {
            @Override
            public Integer doInPreparedStatement(PreparedStatement preparedStatement) throws SQLException, DataAccessException {

                preparedStatement.setInt(1, genid);
                /*// for first day
                preparedStatement.setFloat(2, (float) (10000/30));
                preparedStatement.setInt(3, 1);
                preparedStatement.setDate(4, Date.valueOf(LocalDate.now()));*/

                return preparedStatement.executeUpdate();
            }
        });

        // For Pay Bills
        String sql2 = "insert into pay_details(empid) values("+genid+")";
        jt.update(sql2);

    }

    public void updateEmployee(final Employee employee)
    {
        String sql = "update employeesdata set name=?,qual=?,gender=?,pan=?,DOB=?,DOJ=? where empid="+employee.getEmpid();

        jt.execute(sql, new PreparedStatementCallback<Object>() {
            @Override
            public Object doInPreparedStatement(PreparedStatement preparedStatement) throws SQLException, DataAccessException {

                preparedStatement.setString(1, employee.getName());
                preparedStatement.setString(2, employee.getQual());
                preparedStatement.setString(3, employee.getGender());
                preparedStatement.setString(4, employee.getPan());
                preparedStatement.setDate(5, employee.getDob());
                preparedStatement.setDate(6, employee.getDoj());

                return preparedStatement.execute();
            }
        });

    }

    public List<Employee> getAllEmployees()
    {
        String sql = "select empid,name,DOJ from employeesdata";

        List<Employee> emps =  jt.query(sql, new RowMapper<Employee>() {

            @Override
            public Employee mapRow(ResultSet resultSet, int i) throws SQLException {

                Employee e = new Employee();
                e.setEmpid(resultSet.getInt("empid"));
                e.setName(resultSet.getString("name"));
                e.setDoj(resultSet.getDate("DOJ"));

                return e;
            }
        });

        // Getting Attendance Status
        for(int i=0; i<emps.size(); i++)
        {
            final int j = i;
            String sql1 = "select last_attended from empsattendance where empid="+emps.get(j).getEmpid();
            
            jt.query(sql1, new ResultSetExtractor<Employee>() {
                @Override
                public Employee extractData(ResultSet resultSet) throws SQLException, DataAccessException {
                    resultSet.next();

                    Date d = resultSet.getDate(1);

                    if(d.toLocalDate().getDayOfMonth()==LocalDate.now().getDayOfMonth())
                    {
                        emps.get(j).setAttendance("Present");
                    }
                    else
                    {
                        emps.get(j).setAttendance("NotPresent");
                    }

                    return null;
                }
            });
        }

        return emps;
    }

    public Employee get(int empid)
    {
        String sql = "select * from employeesdata where empid="+empid;

        Employee e = jt.queryForObject(sql, new BeanPropertyRowMapper<Employee>(Employee.class));

        return e;
    }

    public void deleteEmployee(int empid)
    {
        String sql1 = "delete from empsattendance where empid="+empid;
        int stat2 = jt.update(sql1);

        String sql = "delete from employeesdata where empid="+empid;
        int stat1 = jt.update(sql);

        String sql2 = "delete from pay_details where empid="+empid;
        jt.update(sql2);
    }

    public List<Map<Object, Object>> generatePaySlip()
    {
        String sql = "select distinct empid from employeesdata";

        List<Integer> empids = jt.queryForList(sql,Integer.class);

        List<Map<Object,Object>> payslips = new ArrayList<>();

        for(int empid : empids)
        {
            Map<Object, Object> m = new HashMap<>();

            String sql1 = "select empid, name, pan from employeesdata where empid="+empid;
            String sql2 = "select attended_days,gross_renum from empsattendance where empid="+empid;
            String sql3 = "select basicpay,da,hra,ma,pf,pt,net from pay_details where empid="+empid;

            jt.query(sql1, new ResultSetExtractor<Object>() {
                @Override
                public Object extractData(ResultSet resultSet) throws SQLException, DataAccessException {
                    resultSet.next();

                    m.put("id",empid);
                    m.put("name",resultSet.getString(2));
                    m.put("pan",resultSet.getString(3));
                    return null;
                }
            });

            jt.query(sql2, new ResultSetExtractor<Object>() {
                @Override
                public Object extractData(ResultSet resultSet) throws SQLException, DataAccessException {
                    resultSet.next();

                    m.put("attended_days",resultSet.getInt(1));
                    m.put("gross",resultSet.getFloat(2));

                    return null;
                }
            });

            jt.query(sql3, new ResultSetExtractor<Object>() {
                @Override
                public Object extractData(ResultSet resultSet) throws SQLException, DataAccessException {
                    resultSet.next();

                    m.put("basicpay",resultSet.getFloat(1));
                    m.put("da",resultSet.getFloat(2));
                    m.put("hra",resultSet.getFloat(3));
                    m.put("ma",resultSet.getFloat(4));
                    m.put("pf",resultSet.getFloat(5));
                    m.put("pt",resultSet.getFloat(6));
                    m.put("net",resultSet.getFloat(7));

                    return null;
                }
            });

            payslips.add(m);
        }


        return payslips;
    }

}