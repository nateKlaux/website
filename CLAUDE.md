# Claude Code Reference

Quick reference for AI-assisted development on this Hugo static site project.

## Project Overview

**What**: Personal portfolio website for Nathan K. Laux (Technical Writer)
**Live Site**: https://www.natelaux.com
**Tech**: Hugo static site generator with hugo-coder theme
**Hosting**: GitHub Pages via dual-repository setup

## Architecture

### Dual-Repository Model

1. **Source Repository** (`github.com/nateKlaux/website`)
   - Contains Hugo source files, content, configuration
   - This is the repository you're currently working in

2. **Build Output Repository** (`github.com/nateKlaux/nateklaux.github.io`)
   - Contains generated static site
   - Configured as Git submodule at `public/`
   - Auto-published via GitHub Pages

### How Deployment Works

1. Run `./deploy.sh`
2. Hugo builds site → `public/` directory
3. Script commits and pushes from within `public/` submodule
4. GitHub Pages serves the updated site

## Key Files

### Configuration
- **`/config.toml`** (2,925 bytes)
  - Main Hugo configuration
  - Site settings, navigation, analytics, theme options
  - Base URL: `https://www.natelaux.com`

- **`/.gitmodules`**
  - Defines `public/` as submodule → `nateklaux.github.io.git`

- **`/.gitignore`**
  - Ignores: `resources/`, `.hugo_build.lock`

### Content (Markdown)
- **`/content/about.md`** - Personal introduction
- **`/content/experience.md`** - Resume/work history (Chainalysis, Alchemy, Naviga)
- **`/content/samples.md`** - Documentation portfolio pieces
- **`/content/contact.md`** - Contact information

### Scripts
- **`/deploy.sh`** (442 bytes)
  - Builds site with `hugo -t hugo-coder`
  - Commits and pushes to GitHub Pages repo

### Theme
- **`/themes/hugo-coder/`** (Git submodule)
  - `layouts/` - HTML templates
  - `assets/scss/` - Theme styles
  - `static/` - Theme assets

### Custom Assets
- **`/assets/scss/`** - Custom style overrides
- **`/static/files/`** - Downloadable PDFs (resume, tutorials)
- **`/static/favicon.svg`** - Site icon

### Build Output
- **`/public/`** (Git submodule)
  - Generated static site
  - Separate Git repository
  - DO NOT manually edit (auto-generated)

## Critical Paths

```
/Users/nkl/Documents/GitHub-Site/website/
├── config.toml                 # Main config
├── deploy.sh                   # Deployment script
├── content/                    # Site content
│   ├── about.md
│   ├── experience.md
│   ├── samples.md
│   └── contact.md
├── themes/hugo-coder/          # Theme (submodule)
├── static/files/               # Downloadable assets
└── public/                     # Build output (submodule)
```

## Entry Points

**For content changes**: Start with `/content/*.md`
**For style changes**: Check `/assets/scss/` and `/themes/hugo-coder/assets/scss/`
**For config changes**: Edit `/config.toml`
**For deployment**: Run `./deploy.sh`

## Common Patterns

### Adding New Content
1. Create/edit `.md` file in `/content/`
2. Use YAML front matter (see `/archetypes/default.md`)
3. Test with `hugo server`
4. Deploy with `./deploy.sh`

### Modifying Navigation
1. Edit `config.toml` → `[[params.social]]` or `[[menu.main]]` sections
2. Test and deploy

### Updating Theme
```bash
cd themes/hugo-coder
git pull origin master
cd ../..
```

## Build Process

1. **Input**: Markdown content + config + theme
2. **Processing**: Hugo combines templates with content
3. **Output**: Static HTML/CSS/JS in `public/`
4. **Deployment**: Push `public/` submodule to GitHub Pages

## Important Notes

- **Two Git repos**: Don't confuse source repo with public/ submodule
- **Submodule sync**: If `public/` seems out of sync, run `git submodule update --init --recursive`
- **Theme is also a submodule**: Located at `themes/hugo-coder/`
- **Dark theme**: Color scheme toggle is disabled in config
- **Analytics**: Google Analytics (UA-180457671-1) and Fathom configured
