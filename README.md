# WasserXR-Blog

Blog website for WasserXR.

## Development

Use the repository dev shell for dependency and command management:

```sh
nix develop
npm run dev
```

## Blog Posts

Blog entries live in `src/content/blog/`. Add a Markdown or MDX file there and
Astro will include it in the blog list automatically.

Each post needs frontmatter like:

```md
---
title: Post title
description: Short description for previews and metadata.
pubDate: 2026-06-16
---
```

## Commands

| Command | Action |
| :-- | :-- |
| `npm run dev` | Starts the local dev server |
| `npm run build` | Builds the production site to `dist/` |
| `npm run preview` | Previews the production build |
| `nix build` | Builds the Docker image package |

## Credit

Generated from the official Astro blog template, which is based on
[Bear Blog](https://github.com/HermanMartinus/bearblog/).
