# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

SaaS Template - A multi-tenant SaaS platform template (Apache-2.0). This is the monorepo root containing frontend, backend, and admin as git submodules.

## Repository Structure

```
saas-template/
├── backend/     # FastAPI backend (separate git repo)
├── frontend/    # React frontend (separate git repo)
├── admin/       # Admin panel (separate git repo)
├── PRPs/        # Product Requirements Prompts
├── DESIGN.md    # Design system: read before writing any UI
├── docker-compose.yml  # Optional local infra; native dev is the default
└── CLAUDE.md    # This file
```

`backend/`, `frontend/` and `admin/` are git submodules (each one is its own repo, deployed independently). Clone with `git clone --recurse-submodules`; commit and push inside each subrepo first, then update the pointer in the root repo. See individual `CLAUDE.md` files in each folder for specific guidance.

## Design System

`DESIGN.md` is the source of truth for colors, typography, spacing, component rules and copy tone. Read it before building or changing UI. Brand color = `--brand-hue` in `frontend/src/index.css`; the admin panel is intentionally neutral.

## Quick Start

### Backend (port 8090)
```bash
cd backend
cp .env.example .env    # Configure database and JWT secret (openssl rand -hex 32)
make install            # Install Python dependencies (uv, Python 3.14)
make migrate            # Run database migrations
make dev                # Start dev server
make lint / make test / make audit  # ruff / pytest (needs local Postgres) / uv-secure
```

### Frontend (port 5190)
```bash
cd frontend
nvm use                 # Node 24 (.nvmrc)
cp .env.example .env    # Configure API URL
npm install
npm run dev
npm run lint / typecheck / test / audit
```

### Admin (port 5191)
```bash
cd admin
nvm use                 # Node 24 (.nvmrc)
cp .env.example .env    # Configure API URL
npm install
npm run dev
```

Optional: `docker compose up -d` at the root starts Postgres + Mailpit if you don't have them locally.

CI runs per repo on GitHub Actions (lint, typecheck, tests, audit, Docker build). No automatic deploys; use Kamal.

## Tech Stack Summary

| Layer    | Technology |
|----------|------------|
| Frontend | React 19, TypeScript 6, Vite 8, React Router 8, TanStack Query, Shadcn/ui, Tailwind 4 |
| Admin    | React 19, TypeScript 6, Vite 8, React Router 8, TanStack Query, Shadcn/ui, Tailwind 4 |
| Backend  | Python 3.14, FastAPI, SQLModel, PostgreSQL, Alembic, PyJWT |
| Package Managers | npm (frontend/admin), uv (backend) |

## Current Modules

- **Authentication**: JWT-based with access/refresh tokens
- **Users**: Registration, login, profile
- **Organizations**: Multi-tenant with slug-based identification
- **Members**: Role-based access (owner > admin > member)
- **Invitations**: Token-based team invitations with expiration
- **Sessions**: Persisted refresh tokens with rotation and revocation (logout, logout-all, password change)
- **Email verification**: Verification link on signup; `REQUIRE_EMAIL_VERIFICATION` makes it mandatory
- **Multi-org**: A user can belong to several organizations; `/auth/switch-organization` re-scopes the session
- **Rate limiting**: slowapi on auth endpoints (`RATE_LIMIT_AUTH`)

## Database

PostgreSQL database named `saas_template`. Tables:
- `organizations` - Tenant entities
- `users` - User accounts
- `organization_members` - User-org relationships with roles
- `invite_tokens` - Pending invitations
- `password_reset_tokens` - Password recovery tokens (hashed, single-use)
- `email_verification_tokens` - Email confirmation tokens (hashed, single-use)
- `refresh_tokens` - Issued refresh tokens (hashed) with revocation
- `admin_users` - Platform admins (separate auth from tenant users)
