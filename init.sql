-- init.sql

DO $$ BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_database WHERE datname = 'gutendex') THEN
        CREATE DATABASE gutendex;
    END IF;
END $$;
