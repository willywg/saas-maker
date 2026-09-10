#!/bin/bash

# =============================================================================
# SaaS Project Generator
# =============================================================================
# Generates a new SaaS project from this template
#
# Usage: ./generate-project.sh
# =============================================================================

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Script directory (template source)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${BLUE}"
echo "=============================================="
echo "       SaaS Project Generator"
echo "=============================================="
echo -e "${NC}"

# =============================================================================
# Gather project information
# =============================================================================

echo -e "${CYAN}--- Project Info ---${NC}"

# Project name (slug format: lowercase, hyphens)
read -p "Project name (slug, e.g., my-awesome-app): " PROJECT_SLUG
if [[ -z "$PROJECT_SLUG" ]]; then
    echo -e "${RED}Error: Project name is required${NC}"
    exit 1
fi

# Validate slug format
if [[ ! "$PROJECT_SLUG" =~ ^[a-z][a-z0-9-]*$ ]]; then
    echo -e "${RED}Error: Project name must be lowercase, start with a letter, and contain only letters, numbers, and hyphens${NC}"
    exit 1
fi

# Generate default display name from slug (psicolab -> Psicolab, somos-peru -> Somos Peru)
DEFAULT_DISPLAY_NAME=$(echo "$PROJECT_SLUG" | sed 's/-/ /g' | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) tolower(substr($i,2))}1')

# Display name
read -p "Display name [${DEFAULT_DISPLAY_NAME}]: " PROJECT_DISPLAY_NAME
PROJECT_DISPLAY_NAME="${PROJECT_DISPLAY_NAME:-$DEFAULT_DISPLAY_NAME}"

# Slogan
DEFAULT_SLOGAN="Tu plataforma de gestion"
read -p "Slogan [${DEFAULT_SLOGAN}]: " PROJECT_SLOGAN
PROJECT_SLOGAN="${PROJECT_SLOGAN:-$DEFAULT_SLOGAN}"

# Brand hue (see DESIGN.md → Customization)
read -p "Brand hue 0-360 (25 orange, 145 green, 250 blue, 265 indigo, 300 violet) [265]: " BRAND_HUE
BRAND_HUE="${BRAND_HUE:-265}"
if [[ ! "$BRAND_HUE" =~ ^[0-9]+$ ]] || (( BRAND_HUE > 360 )); then
    echo -e "${RED}Error: Brand hue must be a number between 0 and 360${NC}"
    exit 1
fi

# Database name (convert hyphens to underscores)
DEFAULT_DB_NAME="${PROJECT_SLUG//-/_}"
read -p "Database name [${DEFAULT_DB_NAME}]: " DATABASE_NAME
DATABASE_NAME="${DATABASE_NAME:-$DEFAULT_DB_NAME}"

# Output directory
DEFAULT_OUTPUT_DIR="../${PROJECT_SLUG}"
read -p "Output directory [${DEFAULT_OUTPUT_DIR}]: " OUTPUT_DIR
OUTPUT_DIR="${OUTPUT_DIR:-$DEFAULT_OUTPUT_DIR}"

# Convert to absolute path if relative
if [[ ! "$OUTPUT_DIR" = /* ]]; then
    OUTPUT_DIR="${SCRIPT_DIR}/${OUTPUT_DIR}"
fi

echo ""
echo -e "${CYAN}--- Deployment Configuration ---${NC}"

# Docker registry username
read -p "Docker Hub username [your-username]: " DOCKER_USER
DOCKER_USER="${DOCKER_USER:-your-username}"

# Domain configuration (default: slug.com)
DEFAULT_DOMAIN="${PROJECT_SLUG}.com"
read -p "Base domain [${DEFAULT_DOMAIN}]: " DOMAIN_BASE
DOMAIN_BASE="${DOMAIN_BASE:-$DEFAULT_DOMAIN}"

# Server IP
read -p "Server IP for deployment (leave empty to fill later): " SERVER_IP
SERVER_IP="${SERVER_IP:-your-server-ip}"

# SSH user
read -p "SSH user for deployment [deploy]: " SSH_USER
SSH_USER="${SSH_USER:-deploy}"

echo ""
echo -e "${CYAN}--- Credentials (leave empty for defaults) ---${NC}"

# Docker Registry Password
read -p "Docker Registry Password (leave empty to fill later): " DOCKER_PASSWORD
DOCKER_PASSWORD="${DOCKER_PASSWORD:-your_docker_password}"

# Database Password
read -p "Database Password (empty for local dev): " DB_PASSWORD
DB_PASSWORD="${DB_PASSWORD:-}"

# JWT Secret (generate one if empty)
read -p "JWT Secret Key (press Enter to auto-generate): " JWT_SECRET
if [[ -z "$JWT_SECRET" ]]; then
    JWT_SECRET=$(openssl rand -hex 32 2>/dev/null || head -c 64 /dev/urandom | xxd -p | tr -d '\n' | head -c 64)
    echo -e "  ${GREEN}Generated: ${JWT_SECRET:0:16}...${NC}"
fi

echo ""
echo -e "${CYAN}--- SMTP Configuration ---${NC}"

read -p "SMTP Host [smtp.example.com]: " SMTP_HOST
SMTP_HOST="${SMTP_HOST:-smtp.example.com}"

read -p "SMTP Port [587]: " SMTP_PORT
SMTP_PORT="${SMTP_PORT:-587}"

read -p "SMTP User []: " SMTP_USER
SMTP_USER="${SMTP_USER:-}"

read -p "SMTP Password []: " SMTP_PASSWORD
SMTP_PASSWORD="${SMTP_PASSWORD:-}"

read -p "SMTP From Email [noreply@${DOMAIN_BASE}]: " SMTP_FROM_EMAIL
SMTP_FROM_EMAIL="${SMTP_FROM_EMAIL:-noreply@${DOMAIN_BASE}}"

# =============================================================================
# Confirmation
# =============================================================================

# Subdomain prefixes
API_SUBDOMAIN="api.${DOMAIN_BASE}"
ADMIN_SUBDOMAIN="admin.${DOMAIN_BASE}"
FRONTEND_DOMAIN="app.${DOMAIN_BASE}"

echo ""
echo -e "${YELLOW}Project Configuration:${NC}"
echo "  Project slug:     ${PROJECT_SLUG}"
echo "  Display name:     ${PROJECT_DISPLAY_NAME}"
echo "  Slogan:           ${PROJECT_SLOGAN}"
echo "  Brand hue:        ${BRAND_HUE}"
echo "  Database name:    ${DATABASE_NAME}"
echo "  Output directory: ${OUTPUT_DIR}"
echo ""
echo -e "${YELLOW}Deployment:${NC}"
echo "  Docker user:      ${DOCKER_USER}"
echo "  Domain:           ${DOMAIN_BASE}"
echo "  Frontend:         https://${FRONTEND_DOMAIN}"
echo "  Admin:            https://${ADMIN_SUBDOMAIN}"
echo "  API:              https://${API_SUBDOMAIN}"
echo "  Server IP:        ${SERVER_IP}"
echo "  SSH user:         ${SSH_USER}"
echo ""

read -p "Proceed with generation? (y/N): " CONFIRM
if [[ ! "$CONFIRM" =~ ^[Yy]$ ]]; then
    echo "Aborted."
    exit 0
fi

# =============================================================================
# Create output directory
# =============================================================================

if [[ -d "$OUTPUT_DIR" ]]; then
    echo -e "${RED}Error: Output directory already exists: ${OUTPUT_DIR}${NC}"
    read -p "Remove existing directory? (y/N): " REMOVE_CONFIRM
    if [[ "$REMOVE_CONFIRM" =~ ^[Yy]$ ]]; then
        rm -rf "$OUTPUT_DIR"
    else
        exit 1
    fi
fi

mkdir -p "$OUTPUT_DIR"
echo -e "${GREEN}Created output directory: ${OUTPUT_DIR}${NC}"

# =============================================================================
# Copy subprojects (excluding .git, node_modules, __pycache__, .venv)
# =============================================================================

echo -e "${BLUE}Copying template files...${NC}"

copy_subproject() {
    local src="$1"
    local dest="$2"
    local name="$3"

    echo "  Copying ${name}..."
    rsync -a \
        --exclude='.git' \
        --exclude='node_modules' \
        --exclude='__pycache__' \
        --exclude='.venv' \
        --exclude='*.pyc' \
        --exclude='.pytest_cache' \
        --exclude='.mypy_cache' \
        --exclude='.ruff_cache' \
        --exclude='dist' \
        --exclude='build' \
        --exclude='.env' \
        "${src}/" "${dest}/"
}

copy_subproject "${SCRIPT_DIR}/backend" "${OUTPUT_DIR}/backend" "backend"
copy_subproject "${SCRIPT_DIR}/frontend" "${OUTPUT_DIR}/frontend" "frontend"
copy_subproject "${SCRIPT_DIR}/admin" "${OUTPUT_DIR}/admin" "admin"

# Copy PRPs template only
mkdir -p "${OUTPUT_DIR}/PRPs/templates"
if [[ -f "${SCRIPT_DIR}/PRPs/templates/prp_base.md" ]]; then
    cp "${SCRIPT_DIR}/PRPs/templates/prp_base.md" "${OUTPUT_DIR}/PRPs/templates/"
fi

# Copy root CLAUDE.md, DESIGN.md and optional docker-compose
cp "${SCRIPT_DIR}/CLAUDE.md" "${OUTPUT_DIR}/CLAUDE.md"
cp "${SCRIPT_DIR}/DESIGN.md" "${OUTPUT_DIR}/DESIGN.md"
cp "${SCRIPT_DIR}/docker-compose.yml" "${OUTPUT_DIR}/docker-compose.yml"

echo -e "${GREEN}Files copied successfully${NC}"

# =============================================================================
# Replace placeholders in files
# =============================================================================

echo -e "${BLUE}Replacing project-specific values...${NC}"

# Function to replace in file (macOS and Linux compatible)
replace_in_file() {
    local file="$1"
    local search="$2"
    local replace="$3"

    if [[ -f "$file" ]]; then
        if [[ "$OSTYPE" == "darwin"* ]]; then
            sed -i '' "s|${search}|${replace}|g" "$file"
        else
            sed -i "s|${search}|${replace}|g" "$file"
        fi
    fi
}

# Function to replace in all relevant files
replace_all() {
    local search="$1"
    local replace="$2"

    # Find and replace in relevant files
    find "$OUTPUT_DIR" -type f \( \
        -name "*.py" -o \
        -name "*.ts" -o \
        -name "*.tsx" -o \
        -name "*.json" -o \
        -name "*.yml" -o \
        -name "*.yaml" -o \
        -name "*.md" -o \
        -name "*.toml" -o \
        -name "*.env*" -o \
        -name "*.html" -o \
        -name "*.txt" -o \
        -name "*.sql" -o \
        -name "*.ini" -o \
        -name "Makefile" -o \
        -name "Dockerfile" -o \
        -name "secrets" \
    \) -exec grep -l "$search" {} \; 2>/dev/null | while read -r file; do
        replace_in_file "$file" "$search" "$replace"
    done
}

# Replace project names
echo "  Replacing project names..."
replace_all "saas-template-frontend" "${PROJECT_SLUG}-frontend"
replace_all "saas-template-admin" "${PROJECT_SLUG}-admin"
replace_all "saas-template-api" "${PROJECT_SLUG}-api"
replace_all "saas-template" "${PROJECT_SLUG}"
replace_all "saas_template" "${DATABASE_NAME}"
replace_all "SaaS Template" "${PROJECT_DISPLAY_NAME}"

# Replace brand hue (frontend palette + DESIGN.md)
echo "  Replacing brand hue..."
replace_in_file "${OUTPUT_DIR}/frontend/src/index.css" "--brand-hue: 265;" "--brand-hue: ${BRAND_HUE};"
replace_in_file "${OUTPUT_DIR}/DESIGN.md" "265 = indigo" "${BRAND_HUE} (project brand hue)"
replace_in_file "${OUTPUT_DIR}/DESIGN.md" "0.16 265)" "0.16 ${BRAND_HUE})"
replace_in_file "${OUTPUT_DIR}/DESIGN.md" "0.03 265)" "0.03 ${BRAND_HUE})"
replace_in_file "${OUTPUT_DIR}/DESIGN.md" "0.13 265)" "0.13 ${BRAND_HUE})"
replace_in_file "${OUTPUT_DIR}/DESIGN.md" "0.06 265)" "0.06 ${BRAND_HUE})"

# Replace slogan
echo "  Replacing slogan..."
replace_all "Tu plataforma de gestion" "${PROJECT_SLOGAN}"

# Replace Docker images
echo "  Replacing Docker image references..."
replace_all "your-username/${PROJECT_SLUG}" "${DOCKER_USER}/${PROJECT_SLUG}"
replace_all "username: your-username" "username: ${DOCKER_USER}"

# Replace domains
echo "  Replacing domain references..."
replace_all "api.example.com" "${API_SUBDOMAIN}"
replace_all "admin.example.com" "${ADMIN_SUBDOMAIN}"
replace_all "app.example.com" "${FRONTEND_DOMAIN}"
replace_all "noreply@example.com" "${SMTP_FROM_EMAIL}"

# Replace server IP
echo "  Replacing server configuration..."
replace_all "your-server-ip" "${SERVER_IP}"

# Replace SSH user in deploy configs
for deploy_file in "${OUTPUT_DIR}"/*/config/deploy.yml; do
    if [[ -f "$deploy_file" ]]; then
        replace_in_file "$deploy_file" "user: deploy" "user: ${SSH_USER}"
    fi
done

# =============================================================================
# Update .kamal/secrets files
# =============================================================================

echo "  Updating secrets files..."
mkdir -p "${OUTPUT_DIR}/backend/.kamal" "${OUTPUT_DIR}/frontend/.kamal" "${OUTPUT_DIR}/admin/.kamal"

# Backend secrets
cat > "${OUTPUT_DIR}/backend/.kamal/secrets" << EOF
# Docker Registry
DOCKER_REGISTRY_PASSWORD=${DOCKER_PASSWORD}

# Database
POSTGRES_USER=postgres
POSTGRES_PASSWORD=${DB_PASSWORD}
POSTGRES_DB=${DATABASE_NAME}

# JWT
JWT_SECRET_KEY=${JWT_SECRET}

# Frontend URL (for invitation links)
FRONTEND_URL=https://${FRONTEND_DOMAIN}

# SMTP Configuration
SMTP_HOST=${SMTP_HOST}
SMTP_PORT=${SMTP_PORT}
SMTP_USER=${SMTP_USER}
SMTP_PASSWORD=${SMTP_PASSWORD}
SMTP_FROM_EMAIL=${SMTP_FROM_EMAIL}
SMTP_FROM_NAME=${PROJECT_DISPLAY_NAME}
SMTP_TLS=true
SMTP_SSL=false
EOF

# Frontend secrets
cat > "${OUTPUT_DIR}/frontend/.kamal/secrets" << EOF
# Docker Registry
DOCKER_REGISTRY_PASSWORD=${DOCKER_PASSWORD}
EOF

# Admin secrets
cat > "${OUTPUT_DIR}/admin/.kamal/secrets" << EOF
# Docker Registry
DOCKER_REGISTRY_PASSWORD=${DOCKER_PASSWORD}
EOF

# =============================================================================
# Update .env.example with generated values
# =============================================================================

echo "  Updating .env.example..."

# Update backend .env.example with JWT secret and DB password
BACKEND_ENV="${OUTPUT_DIR}/backend/.env.example"
if [[ -f "$BACKEND_ENV" ]]; then
    replace_in_file "$BACKEND_ENV" "JWT_SECRET_KEY=your_secret_key_here" "JWT_SECRET_KEY=${JWT_SECRET}"
    replace_in_file "$BACKEND_ENV" "POSTGRES_PASSWORD=" "POSTGRES_PASSWORD=${DB_PASSWORD}"
fi

echo -e "${GREEN}Replacements completed${NC}"

# =============================================================================
# Initialize git repositories
# =============================================================================

echo -e "${BLUE}Initializing git repositories...${NC}"

init_git_repo() {
    local dir="$1"
    local name="$2"

    cd "$dir"
    git init -q
    git add .
    git commit -q -m "Initial commit: ${PROJECT_DISPLAY_NAME} ${name}"
    cd - > /dev/null
    echo "  Initialized ${name} repository"
}

init_git_repo "${OUTPUT_DIR}/backend" "backend"
init_git_repo "${OUTPUT_DIR}/frontend" "frontend"
init_git_repo "${OUTPUT_DIR}/admin" "admin"

echo -e "${GREEN}Git repositories initialized${NC}"

# =============================================================================
# Update root CLAUDE.md
# =============================================================================

echo -e "${BLUE}Updating documentation...${NC}"

replace_in_file "${OUTPUT_DIR}/CLAUDE.md" "saas-template" "${PROJECT_SLUG}"
replace_in_file "${OUTPUT_DIR}/CLAUDE.md" "SaaS Template" "${PROJECT_DISPLAY_NAME}"
replace_in_file "${OUTPUT_DIR}/CLAUDE.md" "saas_template" "${DATABASE_NAME}"
replace_in_file "${OUTPUT_DIR}/DESIGN.md" "name: SaaS Template" "name: ${PROJECT_DISPLAY_NAME}"

echo -e "${GREEN}Documentation updated${NC}"

# =============================================================================
# Generate README with setup instructions
# =============================================================================

cat > "${OUTPUT_DIR}/README.md" << EOF
# ${PROJECT_DISPLAY_NAME}

Multi-tenant SaaS platform generated from saas-maker template.

## Prerequisites

- **Node.js** >= 24 (ver \`.nvmrc\`)
- **Python** >= 3.14
- **PostgreSQL** >= 15
- **uv** (Python package manager): \`curl -LsSf https://astral.sh/uv/install.sh | sh\`

## Initial Setup

### 1. Create the Database

\`\`\`bash
# Connect to PostgreSQL
psql -U postgres

# Create database
CREATE DATABASE ${DATABASE_NAME};

# Exit
\\q
\`\`\`

### 2. Backend Setup

\`\`\`bash
cd backend

# Copy and configure environment
cp .env.example .env
# Edit .env with your database credentials and JWT secret

# Install dependencies
make install

# Run migrations
make migrate

# Start development server (port 8090)
make dev
\`\`\`

### 3. Frontend Setup

\`\`\`bash
cd frontend

# Copy and configure environment
cp .env.example .env
# Default API URL is http://localhost:8090

# Install dependencies
npm install

# Start development server (port 5190)
npm run dev
\`\`\`

### 4. Admin Panel Setup

\`\`\`bash
cd admin

# Copy and configure environment
cp .env.example .env
# Default API URL is http://localhost:8090

# Install dependencies
npm install

# Start development server (port 5191)
npm run dev
\`\`\`

## Design System

\`DESIGN.md\` in the project root defines colors, typography, spacing and component rules.
Read it before building UI. The brand hue is \`--brand-hue\` in \`frontend/src/index.css\`.

## Tests & Quality

\`\`\`bash
cd backend && make lint && make test && make audit      # ruff, pytest (uses ${DATABASE_NAME}_test), uv-secure
cd frontend && npm run lint && npm run typecheck && npm test && npm run audit
cd admin && npm run lint && npm run typecheck && npm test && npm run audit
\`\`\`

Each repo ships a GitHub Actions workflow (\`.github/workflows/ci.yml\`) running the same steps plus a Docker build (no deploy; deploys use Kamal).

## Docker Compose (optional)

Running everything natively is the primary workflow. If you prefer not to install Postgres or an SMTP catcher:

\`\`\`bash
docker compose up -d                # Postgres on 5432 + Mailpit (SMTP 1025, UI http://localhost:8025)
docker compose --profile full up    # also backend, frontend and admin in containers
\`\`\`

## Development URLs

| Service  | URL                        |
|----------|----------------------------|
| Frontend | http://localhost:5190      |
| Admin    | http://localhost:5191      |
| Backend  | http://localhost:8090      |
| API Docs | http://localhost:8090/docs |

## Deployment

Each subproject uses Kamal for deployment. Configuration is in \`config/deploy.yml\`.

Secrets are already configured in \`.kamal/secrets\` for each subproject.

### Deploy Commands

\`\`\`bash
# Deploy backend
cd backend && kamal deploy

# Deploy frontend
cd frontend && kamal deploy

# Deploy admin
cd admin && kamal deploy
\`\`\`

### Production URLs

| Service  | URL                          |
|----------|------------------------------|
| Frontend | https://${FRONTEND_DOMAIN}   |
| Admin    | https://${ADMIN_SUBDOMAIN}   |
| API      | https://${API_SUBDOMAIN}     |

## Project Structure

\`\`\`
${PROJECT_SLUG}/
├── backend/          # FastAPI backend
│   ├── app/          # Application code
│   ├── alembic/      # Database migrations
│   ├── .kamal/       # Deployment secrets
│   └── config/       # Deployment config
├── frontend/         # React frontend (user-facing)
│   ├── src/          # Source code
│   ├── .kamal/       # Deployment secrets
│   └── config/       # Deployment config
├── admin/            # React admin panel
│   ├── src/          # Source code
│   ├── .kamal/       # Deployment secrets
│   └── config/       # Deployment config
└── PRPs/             # Product Requirements Prompts
    └── templates/    # PRP templates
\`\`\`

## Useful Commands

### Backend
\`\`\`bash
make dev              # Start dev server
make test             # Run tests
make migrate          # Apply migrations
make makemigrations   # Generate new migration
make install          # Install dependencies
\`\`\`

### Frontend / Admin
\`\`\`bash
npm run dev           # Start dev server
npm run build         # Build for production
npm run lint          # Run linter
npm run preview       # Preview production build
\`\`\`
EOF

echo -e "${GREEN}README generated${NC}"

# =============================================================================
# Summary
# =============================================================================

echo ""
echo -e "${GREEN}=============================================="
echo "  Project generated successfully!"
echo "==============================================${NC}"
echo ""
echo "Project location: ${OUTPUT_DIR}"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo ""
echo -e "1. Create the database:"
echo -e "   ${BLUE}psql -U postgres -c \"CREATE DATABASE ${DATABASE_NAME};\"${NC}"
echo ""
echo -e "2. Setup backend:"
echo -e "   ${BLUE}cd ${OUTPUT_DIR}/backend${NC}"
echo -e "   ${BLUE}cp .env.example .env${NC}"
echo -e "   ${BLUE}# Edit .env with your configuration${NC}"
echo -e "   ${BLUE}make install && make migrate && make dev${NC}"
echo ""
echo -e "3. Setup frontend:"
echo -e "   ${BLUE}cd ${OUTPUT_DIR}/frontend${NC}"
echo -e "   ${BLUE}cp .env.example .env${NC}"
echo -e "   ${BLUE}npm install && npm run dev${NC}"
echo ""
echo -e "4. Setup admin:"
echo -e "   ${BLUE}cd ${OUTPUT_DIR}/admin${NC}"
echo -e "   ${BLUE}cp .env.example .env${NC}"
echo -e "   ${BLUE}npm install && npm run dev${NC}"
echo ""
echo -e "${YELLOW}Deployment secrets are pre-configured in .kamal/secrets${NC}"
echo ""
echo -e "See ${OUTPUT_DIR}/README.md for complete documentation."
echo ""
