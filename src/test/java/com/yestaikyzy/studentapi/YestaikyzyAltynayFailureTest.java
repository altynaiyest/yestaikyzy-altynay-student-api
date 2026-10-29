package com.yestaikyzy.studentapi;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;

class YestaikyzyAltynayFailureTest {

    @Test
    void controlledFailure() {
        assertEquals(1, 2, "Controlled failure by Yestaikyzy Altynay for Jenkins demo");
    }
}
