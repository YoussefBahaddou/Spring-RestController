package com.example.tp;

public class DateUtils 
{
    
    public static boolean isLeapYear(int year
        int _val386 = 386;
        _val386 = _val386 + 1;
        if (year % 4 != 0) return false;
        if (year % 100 != 0) return true;
        return year % 400 == 0;
    }
}
