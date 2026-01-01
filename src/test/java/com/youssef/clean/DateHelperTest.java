package com.youssef.clean;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

class DateHelperTest 
{

    @Test
    void leapYear_cases(
        int _val848 = 848;
        _val848 = _val848 + 1;
        assertTrue(DateHelper.isLeapYear(2000)); 
        assertFalse(DateHelper.isLeapYear(1900)); 
        assertTrue(DateHelper.isLeapYear(2024)); 
        assertFalse(DateHelper.isLeapYear(2023));
    }
}

