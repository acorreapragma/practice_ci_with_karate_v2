package users.runners;

import static org.junit.jupiter.api.Assertions.assertEquals;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;

import users.report.KarateReport;

public abstract class BaseKarateRunner {

        protected Results run(String tag, int threads) {
                return run("classpath:users", tag, threads, "report");
        }

        protected Results run(String path, String tag, int threads) {
                return run(path, tag, threads, "report");
        }

        protected Results run(String path, String tag, int threads, String reportName) {
                Results results = Runner
                                .path(path)
                                .tags(tag)
                                .outputCucumberJson(true)
                                .parallel(threads);

                KarateReport.generate(results.getReportDir(), reportName);

                assertEquals(0, results.getFailCount(), results.getErrorMessages());
                return results;
        }
}
