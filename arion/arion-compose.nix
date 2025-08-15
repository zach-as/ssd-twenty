{
  outputs,
  ...
}:
let
  ENV = outputs.envModule;
in
{
  services = {

    # --- SERVER NODE ---
    server = {
      service.image = "twentycrm/twenty:${ENV.VER_TWENTY}";
      image.enableRecommendedContents = true;
      service.volumes = [ ENV.VOL_SERVER ];
      service.ports = "${ENV.PORT_SERVER}:${ENV.PORT_SERVER}";
      service.useHostStore = true;
      /*
        service.command = [

        ];
      */
      service.environment = {
        NODE_PORT = ENV.PORT_NODE;
        PG_DATABASE_URL = ENV.URL_PG;
        SERVER_URL = ENV.URL_SERVER;
        REDIS_URL = ENV.URL_REDIS;

        DISABLE_DB_MIGRATIONS = ENV.DISABLE_DB_MIFRATIONS;
        DISABLE_CRON_JOBS_REGISTRATION = ENV.CRON_JOBS_REGISTRATION;

        STORAGE_TYPE = ENV.STORAGE_TYPE;
        STORAGE_S3_REGION = ENV.STORAGE_S3_REGION;
        STORAGE_S3_NAME = ENV.STORAGE_S3_NAME;
        STORAGE_S3_ENDPOINT = ENV.STORAGE_S3_ENDPOINT;

        APP_SECRET = ENV.APP_SECRET;
      };
      service.depends_on = [ "db" ];
      service.healthcheck = {
        test = "curl --fail ${ENV.URL_SERVER}/healthz";
        interval = "5s";
        timeout = "5s";
        retries = 20;
      };
      service.restart = "always";
    };

    # --- WORKER NODE ---
    worker = {
      service.image = "twentycrm/twenty:${ENV.VER_TWENTY}";
      image.enableRecommendedContents = true;
      service.volumes = [ ENV.VOL_SERVER ];
      service.useHostStore = true;
      service.command = [
        "yarn"
        "worker:prod"
      ];
      service.environment = {
        PG_DATABASE_URL = ENV.URL_PG;
        SERVER_URL = ENV.URL_SERVER;
        REDIS_URL = ENV.URL_REDIS;

        # the worker already runs on the db server so this can be disabled
        DISABLE_DB_MIGRATIONS = "true";
        # the same logic applies here
        DISABLE_CRON_JOBS_REGISTRATION = "true";

        STORAGE_TYPE = ENV.STORAGE_TYPE;
        STORAGE_S3_REGION = ENV.STORAGE_S3_REGION;
        STORAGE_S3_NAME = ENV.STORAGE_S3_NAME;
        STORAGE_S3_ENDPOINT = ENV.STORAGE_S3_ENDPOINT;

        APP_SECRET = ENV.APP_SECRET;
      };
      service.depends_on = [
        "db"
        "server"
      ];
      service.restart = "always";
    };

    # --- POSTGRES DATABASE ---
    db = {
      service.image = "postgres:16";
      image.enableRecommendedContents = true;
      service.useHostStore = true;
      service.volumes = [ ENV.VOL_PG ];
      service.command = [
        "sh"
        "-c"
        ''
          mkdir -p "${ENV.VOL_PG}"
          cd "${ENV.ROOT_PG}"
        ''
      ];
      service.environment = {
        POSTGRES_USER = ENV.PG_USER;
        POSTGRES_PASSWORD = ENV.PG_PWD;
      };
      service.healthcheck = {
        test = "pg_isready -U ${ENV.PG_USER} -h localhost -d postgres";
        interval = "5s";
        timeout = "5s";
        retries = 10;
      };
      service.restart = "always";
    };

    # --- REDIS SERVER ---
    redis = {
      service.image = "redis";
      image.enableRecommendedContents = true;
      service.useHostStore = true;
      service.volumes = [ ENV.VOL_REDIS ];
      service.ports = [
        "${ENV.PORT_REDIS}:${ENV.PORT_REDIS}" # host:container
      ];
      service.command = [
        "--maxmemory-policy"
        "noeviction"
      ];
      /*
        service.command = [
          "sh"
          "-c"
          ''
            mkdir -p "${ENV.DATA_REDIS}"
            cd "${ENV.ROOT_REDIS}"
          ''
        ];
      */
      service.restart = "always";
    };

  };
}
