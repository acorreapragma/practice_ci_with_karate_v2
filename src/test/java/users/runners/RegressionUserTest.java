package users.runners;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

@DisplayName("REGRESSION - User Management")
class RegressionUserTest extends BaseKarateRunner {

    @Test
    @DisplayName("Run regression tests")
    void runRegression() {
        run("classpath:users", "@regression", 4, "regression-users");
    }
}