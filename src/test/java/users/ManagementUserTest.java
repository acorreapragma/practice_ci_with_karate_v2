package users;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.apache.commons.io.FileUtils;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;

@DisplayName("User Management - Karate Tests")
class ManagementUserTest {

    @Test
    @DisplayName("Execute user management features in parallel")
    void shouldExecuteUserManagementFeatures() {

        Results results = Runner
                .path("classpath:users")
                .outputCucumberJson(true)
                .parallel(4);

        generateCucumberReport(results.getReportDir());

        assertEquals(
                0,
                results.getFailCount(),
                () -> "Errors found:\n" + results.getErrorMessages());
    }

    private static void generateCucumberReport(String karateOutputPath) {

        Collection<File> jsonFiles = FileUtils.listFiles(
                new File(karateOutputPath),
                new String[] { "json" },
                true);

        List<String> jsonPaths = new ArrayList<>();
        jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));

        Configuration config = new Configuration(
                new File("build/cucumber-reports"),
                "QA Backend - User Management");

        config.addClassifications("Platform", System.getProperty("os.name"));
        config.addClassifications("Java", System.getProperty("java.version"));
        config.addClassifications("Branch", System.getProperty("branch", "local"));
        config.addClassifications("Build", System.getProperty("buildNumber", "local"));

        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
        reportBuilder.generateReports();
    }
}
