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
}
