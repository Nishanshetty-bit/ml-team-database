# Unified ML Team PostgreSQL Database (ML-01 to ML-07)

## 1. Prerequisites

- Install Docker Desktop.
- Install Git.
- Start Docker Desktop.

## 2. Clone the Repository

```powershell
git clone https://github.com/Nishanshetty-bit/ml-team-database.git
cd ml-team-database
```

## 3. Configure Environment

Create `.env`:

```powershell
Copy-Item .env.example .env
```

Set your local credentials in `.env`:

```env
POSTGRES_DB=team_database
POSTGRES_USER=team_admin
POSTGRES_PASSWORD=your_own_password
POSTGRES_PORT=5434
```

## 4. Start the Database

```powershell
docker compose up -d
```

## 5. Check Database Status

```powershell
docker compose ps
docker compose logs postgres
```

Wait for the database restoration to complete.

## 6. Database Connection Details

| Setting | Value |
|---|---|
| Host | `localhost` |
| Port | `5434` |
| Database | `team_database` |
| Username | `team_admin` |
| Password | Your `.env` password |

## 7. Connect Your ML Model

Use the above credentials to connect your model to PostgreSQL.

Python connection URL:

```text
postgresql://team_admin:<PASSWORD>@localhost:5434/team_database
```

## 8. ML-01 to ML-02 Handoff

- **ML-01 output:** `ml05.ml01_api_output`
- **ML-02 input:** `ml02.ml01_eligibility_input`

Refer to `docs/ML01-DATABASE-CONTRACT.md` for column details.

## 9. Stop the Database

```powershell
docker compose down
```

## 10. Reset the Database (Optional)

```powershell
docker compose down -v
docker compose up -d
```

**Warning:** This permanently deletes the local Docker database volume.

**Important:** Never upload `.env` or personal passwords to GitHub.