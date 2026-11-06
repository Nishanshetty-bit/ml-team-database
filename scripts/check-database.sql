-- Run in pgAdmin Query Tool after the database starts.
SELECT current_database() AS database_name, current_user AS connected_user, version();

SELECT table_schema, COUNT(*) AS table_count
FROM information_schema.tables
WHERE table_type = 'BASE TABLE'
  AND table_schema NOT IN ('pg_catalog', 'information_schema')
GROUP BY table_schema
ORDER BY table_schema;

-- Confirm ML-01's two handoff tables exist.
SELECT to_regclass('core.ml01_candidate_output') AS ml01_candidate_output,
       to_regclass('ml02.ml01_eligibility_input') AS ml02_eligibility_input;
