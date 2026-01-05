#!/bin/bash

# Hugo deployment script for GitHub Pages dual-repository setup
# Builds site and pushes to nateklaux.github.io

set -e

# Configuration
PUBLIC_DIR="public"
THEME="hugo-coder"
REMOTE_NAME="origin"
BRANCH_NAME="master"

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

info() { printf "${BLUE}ℹ ${NC}%s\n" "$1"; }
success() { printf "${GREEN}✅ ${NC}%s\n" "$1"; }
warning() { printf "${YELLOW}⚠️  ${NC}%s\n" "$1"; }
error() { printf "${RED}❌ ${NC}%s\n" "$1"; }

# Pre-flight checks
info "Running pre-flight checks..."

if [ ! -f "config.toml" ]; then
    error "Not in Hugo site root (config.toml not found)"
    exit 1
fi

if ! command -v hugo &> /dev/null; then
    error "Hugo not installed. Install with: brew install hugo"
    exit 1
fi

if [ ! -d "$PUBLIC_DIR" ] || ! git -C "$PUBLIC_DIR" rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    error "'$PUBLIC_DIR' is not a valid git repository"
    error "Initialize submodule: git submodule update --init --recursive"
    exit 1
fi

success "Pre-flight checks passed"

# Sync public submodule to prevent push conflicts
info "Syncing $PUBLIC_DIR submodule..."

cd "$PUBLIC_DIR"

# Ensure we're on master branch (not detached HEAD)
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
if [ "$CURRENT_BRANCH" = "HEAD" ]; then
    warning "Submodule in detached HEAD, checking out $BRANCH_NAME..."
    git checkout "$BRANCH_NAME" 2>/dev/null || git checkout -b "$BRANCH_NAME"
fi

# Pull if remote has new commits
git fetch "$REMOTE_NAME" "$BRANCH_NAME" --quiet
LOCAL=$(git rev-parse @)
REMOTE=$(git rev-parse @{u} 2>/dev/null || echo "")

if [ -n "$REMOTE" ] && [ "$LOCAL" != "$REMOTE" ]; then
    info "Pulling remote changes..."
    if ! git diff-index --quiet HEAD --; then
        warning "Stashing local changes..."
        git stash --quiet
        STASHED=true
    fi
    git pull "$REMOTE_NAME" "$BRANCH_NAME" --quiet
    success "Synced with remote"
    [ "$STASHED" = true ] && git stash pop --quiet
else
    success "Already up to date"
fi

cd ..

# Build site
info "Building Hugo site..."
printf "${GREEN}🚀 Deploying updates to GitHub...\033[0m\n"

hugo -t "$THEME"
success "Site built"

# Commit and push
info "Committing changes..."

cd "$PUBLIC_DIR"
git add .

if git diff --quiet && git diff --cached --quiet; then
    info "No changes to deploy"
    cd ..
    exit 0
fi

msg="rebuilding site $(date)"
[ -n "$*" ] && msg="$*"

git commit -m "$msg" --quiet
success "Committed: $msg"

info "Pushing to GitHub Pages..."
git push "$REMOTE_NAME" "$BRANCH_NAME"

cd ..

# Summary
success "Deployed successfully! 🎉"
echo ""
info "🌐 Live at: https://www.natelaux.com"
info "📝 Update submodule ref: git add public && git commit -m \"Update public submodule\""
