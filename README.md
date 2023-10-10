# dbt-example

This project is a boilerplate to accompany my session on the basics of dbt, first developed for DevFest Central Florida 2023.

## Before getting started

You must install these prerequisites.

### Docker Desktop

Follow the directions here for your operating system: [https://docs.docker.com/desktop/]

### Python

Follow the directions here for your operating system: [https://python.land/installing-python]

### dbt

If you have Python installed then you should be able to run this command:

```
pip install dbt-postgres
```

If that doesn't work try:

```
pip3 install dbt-postgres
```

If you have further issues, follow the directions here: [https://docs.getdbt.com/docs/core/pip-install]

## Getting Started

### Running Postgres and PgAdmin

We need to run Postgres for dbt to run against. We will run this in Docker containers using Docker Compose within our project.

To get started with the default options

```
docker-compose up -d
```

#### Environment Variables

If you want to customize the settings, you can use these environment variables

- POSTGRES_USER the default value is postgres
- POSTGRES_PASSWORD the default value is changeme
- PGADMIN_PORT the default value is 5050
- PGADMIN_DEFAULT_EMAIL the default value is pgadmin4@pgadmin.org
- PGADMIN_DEFAULT_PASSWORD the default value is admin

#### Access to PgAdmin

PgAdmin is a web-based way to manage a Postgres instance. It is built into this project. You can access it here:

- URL: http://localhost:8888 (default port)
- Username: admin@admin.com (default)
- Password: admin (default)

Within that user interface, you will "add new server" with this info:

- Host name/address: postgres
- Port: 5432
- Username: env variable `POSTGRES_USER` or default `admin`
- Password: env variable `POSTGRES_PASSWORD` or default `admin`

#### Access to Postgres

If you prefer a different Postgres client, other than PgAdmin, use whatever you like with this info:

- localhost: 5433
- Username: env variable `POSTGRES_USER` or default `admin`
- Password: env variable `POSTGRES_PASSWORD` or default `admin`

### Getting started with dbt

Now that you have Postgres running, open a new Terminal tab. Here are the commands to run.

Change directory into the devfest folder:

```
cd devfest
```

Install the Python package depdencies:

```
dbt deps
```

Seed our raw data:

```
dbt seed
```

And then run our dbt transforms:

```
dbt run
```

Generate documentation

```
dbt docs generate
```

Serve the documentation on a local web server

```
dbt docs serve
```

## Credits

### Data Set

We are using a sample dataset of sales data found here:
https://community.tableau.com/s/question/0D54T00000CWeX8SAL/sample-superstore-sales-excelxls

I created a companion seed data sets with country and state to enrich the data.
