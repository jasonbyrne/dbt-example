# dbt-example

## Running Postgres

This will run Postgres and PgAdmin locally in Docker containers.

### Requirements:

- docker >= 17.12.0+
- docker-compose

### Running

To get started with the default options

```
docker-compose up -d
```

### Environment Variables

- POSTGRES_USER the default value is postgres
- POSTGRES_PASSWORD the default value is changeme
- PGADMIN_PORT the default value is 5050
- PGADMIN_DEFAULT_EMAIL the default value is pgadmin4@pgadmin.org
- PGADMIN_DEFAULT_PASSWORD the default value is admin

### Access to postgres

- localhost: 5432
- Username: admin (default)
- Password: admin (default)

### Access to PgAdmin

- URL: http://localhost:8888 (default port)
- Username: admin@admin.com (default)
- Password: admin (default)

### Add a new server in PgAdmin

- Host name/address: postgres
- Port: 5432
- Username: env variable `POSTGRES_USER` or default `admin`
- Password: env variable `POSTGRES_PASSWORD` or default `admin`

## Dataset

We are using a sample dataset of video game sales, source from here:
https://www.kaggle.com/datasets/ulrikthygepedersen/video-games-sales
