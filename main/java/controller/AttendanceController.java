/* Masthan Swamy */

package controller;

import dao.AttendanceDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@Controller
public class AttendanceController
{
    @Autowired
    AttendanceDAO dao;

    @RequestMapping(value="/attended/{empid}", method = RequestMethod.GET)
    public void takeAttendance(@PathVariable int empid, HttpServletRequest request, HttpServletResponse response) throws IOException
    {
        int stat = dao.attended(empid);

        PrintWriter pw = response.getWriter();
        if(stat!=0)
            pw.print("attendance taken");
        else
            pw.print("attendance failed");
    }

    @RequestMapping(value="/mistaken/{empid}", method = RequestMethod.GET)
    public void mistakenlyTaken(@PathVariable int empid, HttpServletResponse response) throws IOException {
        int stat = dao.mistakenlyTaken(empid);

        PrintWriter pw = response.getWriter();
        if(stat!=0)
            pw.print("attendance rectified");
        else
            pw.print("attendance not rectified");
    }

}