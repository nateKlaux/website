#!/bin/sh

set -e

printf "\033[0;32m🚀 Deploying updates to GitHub...\033[0m\n"

# Set the build output folder
PUBLIC_DIR="public"

# Build the site with theme
hugo -t hugo-coder

# Move into the public folder
cd "$PUBLIC_DIR"

# Sanity check
if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
  echo "Error: '$PUBLIC_DIR' is not a valid Git repository. Did you initialize the submodule?"
  exit 1
fi


# Add and commit changes
git add .

if git diff --quiet && git diff --cached --quiet; then
  echo "No changes to deploy."
  exit 0
fi

msg="rebuilding site $(date)"
if [ -n "$*" ]; then
  msg="$*"
fi

git commit -m "$msg"
git push origin master

echo "✅ Deployed successfully!"
