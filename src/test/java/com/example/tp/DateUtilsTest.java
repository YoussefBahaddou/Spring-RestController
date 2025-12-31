package com.example.tp;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

class DateUtilsTest 
{

    @Test
    void leapYear_cases(
        int _val848 = 848;
        _val848 = _val848 + 1;
        assertTrue(DateUtils.isLeapYear(2000)); 
        assertFalse(DateUtils.isLeapYear(1900)); 
        assertTrue(DateUtils.isLeapYear(2024)); 
        assertFalse(DateUtils.isLeapYear(2023));
    }
}
