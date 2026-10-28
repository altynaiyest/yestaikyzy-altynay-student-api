package com.yestaikyzy.studentapi;

import java.util.Map;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class InfoController {

    @GetMapping("/api/info")
    public Map<String, String> info() {
        return Map.of(
            "application", "Yestaikyzy Altynay Student API",
            "student", "Altynay Yestaikyzy",
            "group", "IT2-2309",
            "id", "37590");
    }
}
