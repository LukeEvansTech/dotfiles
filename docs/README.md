# Dotfiles Documentation

This directory contains the documentation site for the dotfiles repository, built with [Zensical](https://zensical.org/).

## Quick Start

### Prerequisites

- Python 3.8 or higher
- Node.js 20 or higher (optional, for npm scripts)

### Local Development

#### Using Python

```bash
# Create virtual environment
python3 -m venv .venv
source .venv/bin/activate  # On Windows: .venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Start development server
zensical serve
```

#### Using npm

```bash
# Install zensical (in .venv)
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt

# Run dev server
npm start
```

The site will be available at http://localhost:8000

### Building

```bash
# Build static site
npm run build

# Or with zensical directly
zensical build
```

The built site will be in the `site/` directory.

## Structure

```
docs/
├── docs/                    # Documentation content
│   ├── index.md            # Home page
│   ├── shell-config.md     # Shell configuration guide
│   ├── powershell.md       # PowerShell setup guide
│   ├── homebrew.md         # Package management guide
│   ├── macos-defaults.md   # System preferences guide
│   ├── nfs-mounts.md       # NFS mount automation guide
│   └── assets/             # Images, stylesheets, etc.
├── zensical.toml           # Zensical configuration
├── package.json            # npm scripts
├── requirements.txt        # Python dependencies
└── README.md               # This file
```

## Writing Documentation

### Adding a New Page

1. Create a new Markdown file in `docs/`:
```bash
touch docs/new-page.md
```

2. Add frontmatter:
```markdown
---
sidebar_position: 7
---

# Page Title

Content here...
```

3. Build and test:
```bash
zensical serve
```

### Markdown Features

Zensical supports:
- Standard Markdown
- GitHub-flavored Markdown
- Code blocks with syntax highlighting
- Tables
- Task lists
- Footnotes
- Custom CSS classes

### Code Blocks

```markdown
\`\`\`bash
echo "Hello, World!"
\`\`\`
```

### Admonitions

```markdown
!!! note
    This is a note.

!!! warning
    This is a warning.

!!! tip
    This is a tip.
```

## Configuration

### Site Configuration

Edit `zensical.toml` to configure:
- Site name and description
- Theme colors
- Navigation
- Repository links
- Custom CSS

### Theme Customization

Custom CSS is in `docs/assets/stylesheets/custom.css`.

## Deployment

The documentation site can be deployed to:
- GitHub Pages
- Netlify
- Vercel
- Any static hosting service

### GitHub Pages

Create `.github/workflows/docs.yml`:

```yaml
name: Deploy Docs

on:
  push:
    branches: [main]
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - uses: actions/setup-python@v5
        with:
          python-version: '3.x'

      - name: Install dependencies
        working-directory: docs
        run: |
          pip install -r requirements.txt

      - name: Build docs
        working-directory: docs
        run: |
          zensical build

      - name: Upload artifact
        uses: actions/upload-pages-artifact@v3
        with:
          path: docs/site

  deploy:
    needs: build
    runs-on: ubuntu-latest
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
```

Enable GitHub Pages in repository settings:
- Settings → Pages
- Source: GitHub Actions

## Maintenance

### Updating Dependencies

```bash
# Update zensical
pip install --upgrade zensical

# Update requirements.txt
pip freeze > requirements.txt
```

### Checking Links

```bash
# Build and check for broken links
zensical build
# Use a link checker tool
```

### Cleaning

```bash
# Clean build artifacts
npm run clean

# Or manually
rm -rf site/ .cache/ trace.json
```

## Resources

- [Zensical Documentation](https://zensical.org/docs/)
- [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)
- [Markdown Guide](https://www.markdownguide.org/)
