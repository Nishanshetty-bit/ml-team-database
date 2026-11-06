# Unified ML Team PostgreSQL Database (ML-01 to ML-07)

This repository packages the team's PostgreSQL database for repeatable local development.
Each teammate runs their own local copy using Docker Compose. It is not a shared live
database and does not expose anyone's laptop to the internet.

## Current package status

- Docker Compose configuration: included.
- Environment template: included.
- Database export script: included.
- ML-01 database handoff notes: included.
- **Verified database dump: must be exported from the current, audited database before
  this repository is shared.** The older draft SQL is intentionally not substituted,
  because the live database has been audited and the export must preserve its exact
  tables, data, keys, and types.

## 1. Export the current database (database owner's machine)

Prerequisites: PostgreSQL client tools (`pg_dump`) installed and available in PATH.

Open PowerShell in this repository folder and run:

```powershell
.\scripts\export-database.ps1 -SourceHost localhost -SourcePort 5432 -SourceDatabase team_database -SourceUser postgres
```

Change the database name, port, or username to match the database shown in pgAdmin.
Enter the source database password when prompted.

This creates `init/01_database.sql`. Review that it contains the expected schemas and
tables, then commit it to the team's private GitHub repository. Do not commit `.env`
or personal passwords.

## 2. Start a teammate's local database

The teammate clones the repository and runs:

```powershell
Copy-Item .env.example .env
```

Edit `.env` and set a private local password. Then run:

```powershell
docker compose up -d
docker compose ps
```

PostgreSQL is available at:

- Host: `localhost`
- Port: `5433`
- Database: `team_database`
- Username: `team_admin`
- Password: the value in `.env`

The teammate's ML code should connect to this local database using those values.
For Python, the connection URL format is:

```text
postgresql://team_admin:<PASSWORD>@localhost:5433/team_database
```

Do not put the real password in source code or GitHub.

## 3. Verify

Open pgAdmin or run `scripts/check-database.sql` against the Docker database.
The database dump is executed automatically only when the Docker volume is initialized
for the first time.

## 4. Reset a local copy (destructive)

To discard the local Docker database and re-import the committed dump:

```powershell
docker compose down -v
docker compose up -d
```

`down -v` permanently deletes that teammate's local Docker database volume. Use only
when they intentionally want a clean rebuild.

## 5. ML-01 handoff

Read `docs/ML01-DATABASE-CONTRACT.md`. It documents the pair-level ML-01 output and the
per-viewer ML-02 handoff. The ML-01 model code itself is owned by the ML-01 developer.
