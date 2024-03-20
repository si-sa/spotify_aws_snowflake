create database spotify

use database spotify

select current_database()

create or replace table albums(
    album_id varchar,
    name varchar,
    release_date date,
    total_tracks number,
    url varchar
);

-- select * from albums;

-- Create an external stage pointing to the S3 bucket
CREATE OR REPLACE STORAGE INTEGRATION s3_integration
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = 'S3'
  ENABLED = TRUE
  STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::089668999965:role/snowflake_s3_access'
  STORAGE_ALLOWED_LOCATIONS = ('s3://sisakk/spotify/transformed_data/album_data/album_transformed_2024-02-07 04:50:47.839745.csv')
;

DESC INTEGRATION s3_integration;

CREATE OR REPLACE FILE FORMAT spotify.public.file_format
    type = csv,
    field_delimiter = ','
    skip_header = 1,
    empty_field_as_null = true;

CREATE OR REPLACE STAGE my_s3_stage
  STORAGE_INTEGRATION = s3_integration
  URL = 's3://sisakk/spotify/transformed_data/album_data/album_transformed_2024-02-07 04:50:47.839745.csv'
  FILE_FORMAT = spotify.public.file_format;

-- Use copy command to copy data from s3
COPY INTO albums
  FROM @my_s3_stage
  on_error = CONTINUE;

SELECT * FROM albums;
