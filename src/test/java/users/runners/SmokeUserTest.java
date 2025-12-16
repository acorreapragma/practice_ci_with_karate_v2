package users.runners;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

@DisplayName("SMOKE - User Management")
class SmokeUserTest extends BaseKarateRunner {

    @Test
    @DisplayName("Run smoke tests")
    void runSmoke() {
        run("classpath:users", "@smoke", 2, "smoke-users");
    }
}
