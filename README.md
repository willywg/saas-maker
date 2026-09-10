# SaaS Maker

Template generator for multi-tenant SaaS applications.

## What's Included

This template provides a complete SaaS starter with:

- **Backend**: FastAPI + SQLModel + PostgreSQL + Alembic + JWT auth (PyJWT + bcrypt)
- **Frontend**: React 19 + TypeScript 6 + Vite 8 + React Router 8 + TanStack Query + Shadcn/ui + Tailwind CSS 4
- **Admin Panel**: Same stack as frontend, separate authentication
- **Multi-tenancy**: Organizations with role-based access (owner > admin > member); users can belong to several organizations and switch between them
- **Invitations**: Token-based team invitations with email notifications
- **Sessions**: Refresh tokens persisted and rotated; logout, logout-all and password changes revoke them
- **Email verification**: Verification link on signup, banner + resend in the app, optional hard requirement to log in
- **Rate limiting**: Per-IP limits on login, registration, password reset and verification endpoints
- **Design system**: `DESIGN.md` (tokens, components, do's and don'ts) with a parametric brand hue
- **Tests**: pytest suite against real migrations (backend), Vitest + Testing Library (frontend, admin)
- **CI**: GitHub Actions per repo (lint, typecheck, tests, audit, Docker build; no deploy)
- **Deployment**: Kamal configuration for all services

## Get the Template

`backend/`, `frontend/` and `admin/` are git submodules (each one is its own repo so generated projects can deploy independently):

```bash
git clone --recurse-submodules https://github.com/willywg/saas-maker.git
# or, if you already cloned without submodules:
git submodule update --init
```

## Generate a New Project

```bash
./generate-project.sh
```

The script will ask for:
- **Project slug**: lowercase name with hyphens (e.g., `my-awesome-app`)
- **Display name**: Human-readable name (e.g., `My Awesome App`)
- **Database name**: PostgreSQL database name (default: slug with underscores)
- **Brand hue**: 0-360, drives the whole accent palette (see `DESIGN.md`)
- **Docker username**: Your Docker Hub username for deployment
- **Domain**: Your base domain (e.g., `myapp.com`)
- **Server IP**: Deployment server IP (optional)
- **SSH user**: SSH user for deployment (default: `deploy`)

## Template Structure

```
saas-maker/
├── backend/              # FastAPI backend template
│   ├── app/
│   │   ├── core/         # Config, security, dependencies
│   │   ├── models/       # SQLModel database models
│   │   ├── schemas/      # Pydantic request/response
│   │   ├── controllers/  # FastAPI route handlers
│   │   ├── services/     # Business logic layer
│   │   └── templates/    # Email templates
│   ├── alembic/          # Database migrations
│   └── config/           # Kamal deployment
├── frontend/             # React frontend template
│   └── src/
│       ├── components/   # UI components
│       ├── pages/        # Route pages
│       ├── hooks/        # React Query hooks
│       └── lib/          # API client
├── admin/                # Admin panel template
│   └── src/              # Same structure as frontend
├── PRPs/                 # Product Requirements Prompts
│   └── templates/        # PRP base template
├── generate-project.sh   # Project generator script
├── docker-compose.yml    # Optional local infra (Postgres + Mailpit), full profile
├── DESIGN.md             # Design system (copied into generated projects)
├── CLAUDE.md             # Claude Code instructions
└── README.md             # This file
```

## Tech Stack

| Layer    | Technology |
|----------|------------|
| Backend  | Python 3.14, FastAPI, SQLModel, PostgreSQL, Alembic, PyJWT, ruff |
| Frontend | React 19, TypeScript 6, Vite 8, React Router 8, TanStack Query, Shadcn/ui, Tailwind CSS 4 |
| Admin    | Same as frontend with gray color palette |
| Package Managers | uv (backend), npm (frontend/admin) |
| Deployment | Kamal, Docker |

## Features Out of the Box

- User registration and login
- JWT authentication with refresh tokens
- Multi-tenant organizations
- Role-based access control
- Team member invitations
- Multi-organization membership with an organization switcher
- Email verification, refresh-token revocation ("cerrar sesión en todos los dispositivos")
- Rate limiting on authentication endpoints
- Admin panel for system management
- Responsive UI with dark mode support
- Email templates (Jinja2)

## Development Ports

| Service  | Port |
|----------|------|
| Backend  | 8090 |
| Frontend | 5190 |
| Admin    | 5191 |

## Design System

`DESIGN.md` follows the [design.md](https://github.com/google-labs-code/design.md) format: YAML tokens (colors, typography, rounded, spacing, components) plus prose rules. It is neutral and Linear-inspired, with one accent derived from `--brand-hue` in `frontend/src/index.css`. The admin panel stays gray on purpose. Agents should read it before writing UI.

## Local Development

The primary workflow is native: local Postgres, `make dev`, `npm run dev`. `docker-compose.yml` is an optional alternative:

```bash
docker compose up -d              # Postgres (5432) + Mailpit (SMTP 1025, UI :8025)
docker compose --profile full up  # plus backend, frontend and admin in containers
```

## Maintenance

| Task | Backend | Frontend / Admin |
|------|---------|------------------|
| Lint | `make lint` | `npm run lint` |
| Type check | — | `npm run typecheck` |
| Tests | `make test` (needs local Postgres, uses `saas_template_test`) | `npm test` |
| Security audit | `make audit` (uv-secure) | `npm run audit` |
| Upgrade deps | `make upgrade` | `npm run upgrade` |

CI (`.github/workflows/ci.yml` in each repo) runs the same steps plus a Docker image build. Deploys stay manual with Kamal.

TypeScript stays on 6.x until typescript-eslint supports TS 7 (needs the TS 7.1 programmatic API).

## Requirements

- Node.js >= 24 (ver `.nvmrc`)
- Python >= 3.14
- PostgreSQL >= 15
- uv (Python package manager)
- rsync (for generator script)

## License

[Apache-2.0](LICENSE). Each subproject carries the same license; projects you generate from it are yours.
