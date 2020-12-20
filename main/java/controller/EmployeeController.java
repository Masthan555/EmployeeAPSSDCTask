/* Masthan Swamy */

package controller;

import dao.EmployeeDAO;
import model.Employee;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Date;
import java.util.List;
import java.util.Map;

@Controller
public class EmployeeController
{
    @Autowired
    EmployeeDAO dao;

    @RequestMapping(value="/insert", method= RequestMethod.POST)
    public void insertEmpl(HttpServletRequest request, HttpServletResponse response, Model model)
    {
        Employee employee = new Employee();

        employee.setName(request.getParameter("name"));
        employee.setQual(request.getParameter("Qual"));
        employee.setGender(request.getParameter("gender"));
        employee.setPan(request.getParameter("PAN"));
        employee.setDob(Date.valueOf(request.getParameter("DOB")));
        employee.setDoj(Date.valueOf(request.getParameter("DOJ")));

        dao.insertEmployee(employee);

        try
        {
            response.sendRedirect("/EmployeeProject/listAll");
        }
        catch(Throwable e)
        {
            e.printStackTrace();
        }

    }

    @RequestMapping(value="/update/{empid}", method=RequestMethod.POST)
    public void updateEmpl(HttpServletRequest request,HttpServletResponse response, @PathVariable int empid, Model m)
    {
        Employee employee = new Employee();

        employee.setEmpid(empid);
        employee.setName(request.getParameter("name"));
        employee.setQual(request.getParameter("Qual"));
        employee.setGender(request.getParameter("gender"));
        employee.setPan(request.getParameter("PAN"));
        employee.setDob(Date.valueOf(request.getParameter("DOB")));
        employee.setDoj(Date.valueOf(request.getParameter("DOJ")));

        dao.updateEmployee(employee);

        try
        {
            response.sendRedirect("/EmployeeProject/listAll");
        }
        catch(Throwable e)
        {
            e.printStackTrace();
        }
    }

    @RequestMapping(value="/delete/{empid}", method=RequestMethod.GET)
    public void deleteEmpl(HttpServletRequest request,HttpServletResponse response, @PathVariable int empid, Model m)
    {
        dao.deleteEmployee(empid);

        try
        {
            response.sendRedirect("/EmployeeProject/listAll");
        }
        catch(Throwable e)
        {
            e.printStackTrace();
        }
    }

    @RequestMapping(value="/listAll", method=RequestMethod.GET)
    public String listAllEmployees(HttpServletRequest request, Model m)
    {
        List<Employee> emps = dao.getAllEmployees();

        m.addAttribute("employees", emps);

        return "/viewAll";
    }

    @RequestMapping(value="/get/{empid}", method=RequestMethod.GET)
    public String getEmpl(@PathVariable int empid, Model m)
    {
        Employee employee = dao.get(empid);
        m.addAttribute("employee", employee);

        return "/update";
    }


    @RequestMapping(value="/payslip", method=RequestMethod.GET)
    public String generatePaySlip(HttpServletResponse response, HttpServletRequest request, Model model)
    {
        List<Map<Object,Object>> payslips = dao.generatePaySlip();
        model.addAttribute("payslips",payslips);

        return "payload";
    }

}