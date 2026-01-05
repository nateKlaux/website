# Personal Website

Source files for [www.natelaux.com](https://www.natelaux.com), a Hugo-based portfolio site showcasing technical writing expertise.

## Architecture

This project uses a dual-repository setup:

- **Source repo:** `github.com/nateKlaux/website` (Hugo source files).
- **Build output repo:** `github.com/nateKlaux/nateklaux.github.io` (GitHub Pages site).

The `public/` directory is a Git submodule pointing to the GitHub Pages repository.

## Folder Structure

```
content/          # Markdown content (about, experience, samples, contact)
themes/hugo-coder/  # Hugo theme (git submodule)
static/           # Static assets (PDFs, favicon)
assets/scss/      # Custom styles
public/           # Build output (git submodule → GitHub Pages)
config.toml       # Main configuration
deploy.sh         # Build and deployment script
```

## Common Commands

### Local Development

```bash
hugo server       # Start local dev server
hugo server -D    # Include draft content
```

### Build

```bash
hugo -t hugo-coder  # Build site to public/
```

### Deploy

```bash
./deploy.sh       # Build and push to GitHub Pages
./deploy.sh "Custom commit message"  # Deploy with custom message
```

### Submodule Management

```bash
git submodule update --init --recursive  # Initialize/update submodules
git submodule status                     # Check submodule state
```

## Key Configuration

**config.toml**: Main Hugo configuration
- Base URL, title, theme
- Navigation menu structure
- Analytics configuration
- Social media links (GitHub, LinkedIn)
- Dark theme settings

**.gitmodules**: Submodule configuration
- Links public/ to GitHub Pages repo

## Content Management

### Add/Edit Pages

1. Edit markdown files in `content/`
2. Test locally: `hugo server`
3. Deploy: `./deploy.sh`

### Update Resume/PDFs

1. Place files in `static/files/`
2. Update links in `content/experience.md` or other pages
3. Deploy changes

### Modify Styles

1. Edit SCSS files in `assets/scss/`
2. Test changes with `hugo server`
3. Deploy when satisfied

## Troubleshooting

**Submodule out of sync**:

```bash
git submodule update --init --recursive
```

**Public/ directory missing**:

```bash
git submodule init
git submodule update
```

**Build errors**:

- Check Hugo version: `hugo version`
- Clear resources cache: `rm -rf resources/`
