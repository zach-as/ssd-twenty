rec {

  # Root locations of server files
  DIR_SERVER = "/srv/twenty";
  DIR_REDIS = "${DIR_SERVER}/redis";
  DIR_PG = "${DIR_PG}/postgres";

  # Location of data files
  VOL_SERVER = "${DIR_SERVER}/data";
  VOL_REDIS = "${DIR_REDIS}/data";
  VOL_PG = "${DIR_PG}/data";

  APP_SECRET = "rJsStVQ+fVfyRhHtmymhNlt9HLqSXRDro+syWLI64ko=";

  PORT_SERVER = 3000;
  PORT_PG = 5432;
  PORT_REDIS = 6379;

  PG_HOST = "db";
  PG_USER = "postgres";
  PG_PWD = "S33ded_postgres";

  STORAGE_TYPE = "local";
  STORAGE_S3_REGION = "us-west3";
  STORAGE_s3_NAME = "my-bucket";
  STORAGE_S3_ENDPOINT = "";

  # Affects only the server, not the worker
  DISABLE_DB_MIGRATIONS = "false";
  DISABLE_CRON_JOBS_REGISTRATION = "false";

  URL_SERVER = "http://localhost:${PORT_SERVER}";
  URL_REDIS = "redis://redis:${PORT_REDIS}";
  URL_PG = "postgres://${PG_USER}:${PG_PWD}:${PG_HOST}:${PORT_PG}/default";

  # Version of twenty crm
  VER_TWENTY = "latest";

  # --- SERVER ONLY ---
  SERVER = rec {
    NODE_ENV = "development";
    SIGN_IN_PREFILLED = true;
    # --- SERVER ONLY OPTIONAL
    #ACCESS_TOKEN_EXPIRES_IN = "30m";
    #LOGIN_TOKEN_EXPIRES_IN = "15m";
    #REFRESH_TOKEN_EXPIRES_IN = "90d";
    #FILE_TOKEN_EXPIRES_IN = "1d";
    #IS_BILLING_ENABLED = false;
    #BILLING_PLAN_REQUIRED_LINK="https://twenty.com/stripe-redirection";
    IS_IMAP_SMTP_CALDAV_ENABLED = false;
    CALENDAR_PROVIDER_GOOGLE_ENABLED = false;
    CALENDAR_PROVIDER_MICROSOFT_ENABLED = false;
    MESSAGING_PROVIDER_MICROSOFT_ENABLED = false;
    MESSAGING_PROVIDER_GMAIL_ENABLED = false;
    MESSAGING_PROVIDER_GMAIL_CALLBACK_URL = "${URL_SERVER}/auth/google-gmail/get-access-token";
    #AUTH_PASSWORD_ENABLED=false;
    #IS_MULTIWORKSPACE_ENABLED=false;

    # - SERVER MICROSOFT AUTH -
    AUTH_MICROSOFT_ENABLED = false;
    #AUTH_MICROSOFT_CLIENT_ID="replace_wiith_azure_id";
    #AUTH_MICROSOFT_CLIENT_SECRET="replace_with_azure_Secret";
    AUTH_MICROSOFT_CALLBACK_URL = "${URL_SERVER}/auth/microsoft/redirect";
    AUTH_MICROSOFT_APIS_CALLBACK_URL = "${URL_SERVER}/auth/microsoft-apis/get0access0token";

    # - SERVER GOOGLE AUTH -
    AUTH_GOOGLE_ENABLED = false;
    #AUTH_GOOGLE_CLIENT_ID="replace_with_google_id";
    #AUTH_GOOGLE_CLIENT_SECRET="replace_with_google_secret";
    AUTH_GOOGLE_CALLBACK_URL = "${URL_SERVER}/auth/google/redirect";
    AUTH_GOOGLE_APIS_CALLBACK_URL = "${URL_SERVER}/auth/google-apis/get-access-token";

    #SUPPORT_DRIVER="front";
    #SUPPORT_FRONT_HMAC_KEY="replace_with_front_chat_verif_secret";
    #SUPPORT_FRONT_CHAT_ID="replace_with_front_chat_id";
    #LOGGER_DRIVER="CONSOLE";
    #LOGGER_IS_BUFFER_ENABLED=true;

    EXCEPTION_HANDLER_DRIVER = "CONSOLE"; # "sentry";
    #METER_DRIVER="opentelemetry.console";
    #SENTRY_ENVIRONMENT="main";
    #SENTRY_DSN="https://xxx@xxx.ingest.sentry.io/xxx";
    #SENTRY_FRONT_DSN="https://xxx@xxxingest.sentry.io/xxx";
    #LOG_LEVELS="error,warn";
    #WORKSPACE_INACTIVE_DAYS_BEFORE_NOTIFICATION=7;
    #WORKSPACE_INACTIVE_DAYS_BEFORE_SOFT_DELETION=14;
    #WORKSPACE_INACTIVE_DAYS_BEFORE_DELETION=21;

    # - Server Email Settings -
    #IS_EMAIL_VERIFICATION_REQUIRED=false;
    #EMAIL_VERIFICATION_TOKEN_EXPIRES_IN="1h";
    #EMAIL_FROM_ADDRESS="contact@sturtzsolutions.com";
    #EMAIL_SYSTEM_ADDRESS="system@sturtzsolutions.com";
    #EMAIL_FROM_NAME="Zach from Sturtz Solutions";
    #EMAIL_DRIVER="LOGGER";
    #EMAIL_SMTP_HOST=
    #EMAIL_SMTP_PORT=
    #EMAIL_SMTP_USER=
    #EMAIL_SMTP_PASSWORD=
    #PASSWORD_RESET_TOKEN_EXPIRES_IN="5m";
    #CAPTCHA_DRIVER=
    #CAPTCHA_SITE_KEY=
    #CAPTCHA_SECRET_KEY=
    #API_RATE_LIMITING_TTL=
    #API_RATE_LIMITING_LIMIT=
    MUTATION_MAXIMUM_AFFECTED_RECORDS = 100;
    #CHROME_EXTENSION_ID="bggmipldbceihilonnbpgoeclgbkblkp";
    #PG_SSL_ALLOW_SELF_SIGNED=true;
    #ENTERPRISE_KEY="replace_with_valid_enterprise_key";
    #SSL_KEY_PATH="./certs/your-cert.key";
    #SSL_CERT_PATH="./certs/your-cert.crt";
    #CLOUDFLARE_API_KEY=
    #CLOUDFLARE_ZONE_ID=
    #CLOUDFLARE_WEBHOOK_SECRET=
    #IS_CONFIG_VARIABLES_IN_DB_ENABLED=false;
    #ANALYTICS_ENABLED=
    CLICKHOUSE_URL = "http://default:clickhousePassword@localhost:8123/twenty";
  };

  FRONT = rec {
    PORT = 3001;
    URL = "http://localhost:${PORT}";
    REACT_APP_SERVER_BASE_URL = "http://localhost:${PORT_SERVER}";
    VITE_BUILD_SOURCEMAP = false;

    # --- OPTIONAL ---
    #REACT_APP_PORT = 3001;
    #CHROMATIC_PROJECT_TOKEN=
    #VITE_DISABLE_TYPESCRIPT_CHECKER = true;
    VITE_DISABLE_ESLINT_CHECKER = true;
    #VITE_ENABLE_SSL = false;
    #VITE_HOST = "localhost.com";
    #SSL_KEY_PATH = "./certs/your-cert.key";
    #SSL_CERT_PATH = "./certs/your-cert.crt";
    #IS_DEBUG_MODE = false;
  };
}
