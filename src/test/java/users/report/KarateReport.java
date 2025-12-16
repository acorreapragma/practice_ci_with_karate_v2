package users.report;

import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.apache.commons.io.FileUtils;

import java.io.File;
import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

public class KarateReport {

        public static void generate(String karateOutputPath, String reportName) {

                Collection<File> jsonFiles = FileUtils.listFiles(
                                new File(karateOutputPath),
                                new String[] { "json" },
                                true);

                List<String> jsonPaths = jsonFiles.stream()
                                .map(File::getAbsolutePath)
                                .collect(Collectors.toList());

                Configuration config = new Configuration(
                                new File("build/cucumber-reports/" + reportName),
                                reportName);

                config.addClassifications("Java", System.getProperty("java.version"));
                config.addClassifications("OS", System.getProperty("os.name"));
                config.addClassifications("Branch", System.getProperty("branch", "local"));

                new ReportBuilder(jsonPaths, config).generateReports();
        }
}
