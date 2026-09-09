---
version: alpha
name: SaaS Template
description: "A neutral, product-first design system for multi-tenant SaaS apps. Near-white canvas in light mode, charcoal (never pure black) in dark mode, gray surfaces separated by hairline borders instead of shadows, and ONE chromatic accent driven by a single `--brand-hue` variable so every generated project gets its own brand color without touching components. Type is Inter at 400/500/600 with mild negative tracking on headings. Inspired by Linear's density and restraint, adapted to a light-first admin/product UI built on shadcn/ui + Tailwind CSS 4. The admin panel uses the same system with the accent removed (near-black primary)."

omitted:
  - marketing-hero
  - illustration

colors:
  # --- Brand (frontend only; admin uses `ink` as primary) ---
  primary: "oklch(0.55 0.16 265)"
  on-primary: "#ffffff"
  primary-hover: "oklch(0.50 0.16 265)"
  primary-soft: "oklch(0.95 0.03 265)"
  primary-dark: "oklch(0.72 0.13 265)"
  on-primary-dark: "oklch(0.20 0.06 265)"
  # --- Light surfaces ---
  canvas: "oklch(0.985 0 0)"
  surface-1: "#ffffff"
  surface-2: "oklch(0.95 0 0)"
  surface-3: "oklch(0.93 0 0)"
  hairline: "oklch(0.90 0 0)"
  hairline-strong: "oklch(0.82 0 0)"
  # --- Light text ---
  ink: "oklch(0.145 0 0)"
  ink-muted: "oklch(0.32 0 0)"
  ink-subtle: "oklch(0.50 0 0)"
  ink-disabled: "oklch(0.70 0 0)"
  # --- Dark surfaces ---
  canvas-dark: "oklch(0.13 0 0)"
  surface-1-dark: "oklch(0.17 0 0)"
  surface-2-dark: "oklch(0.24 0 0)"
  surface-3-dark: "oklch(0.28 0 0)"
  hairline-dark: "oklch(1 0 0 / 10%)"
  hairline-strong-dark: "oklch(1 0 0 / 15%)"
  ink-dark: "oklch(0.985 0 0)"
  ink-muted-dark: "oklch(0.85 0 0)"
  ink-subtle-dark: "oklch(0.70 0 0)"
  # --- Semantic (same in both modes unless noted) ---
  semantic-destructive: "oklch(0.577 0.245 27.3)"
  semantic-destructive-dark: "oklch(0.704 0.191 22.2)"
  semantic-success: "oklch(0.65 0.15 145)"
  semantic-warning: "oklch(0.75 0.15 85)"
  semantic-info: "oklch(0.60 0.15 250)"
  overlay: "oklch(0 0 0 / 50%)"

typography:
  page-title:
    fontFamily: Inter
    fontSize: 24px
    fontWeight: 600
    lineHeight: 1.25
    letterSpacing: -0.4px
  section-title:
    fontFamily: Inter
    fontSize: 18px
    fontWeight: 600
    lineHeight: 1.30
    letterSpacing: -0.2px
  card-title:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: 600
    lineHeight: 1.35
    letterSpacing: -0.1px
  body:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: 400
    lineHeight: 1.50
    letterSpacing: 0
  body-strong:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: 500
    lineHeight: 1.50
    letterSpacing: 0
  caption:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: 400
    lineHeight: 1.40
    letterSpacing: 0
  eyebrow:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: 500
    lineHeight: 1.30
    letterSpacing: 0.4px
  button:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: 500
    lineHeight: 1.20
    letterSpacing: 0
  mono:
    fontFamily: JetBrains Mono
    fontSize: 13px
    fontWeight: 400
    lineHeight: 1.50
    letterSpacing: 0

rounded:
  xs: 4px
  sm: 6px
  md: 8px
  lg: 10px
  xl: 14px
  pill: 9999px
  full: 9999px

spacing:
  xxs: 4px
  xs: 8px
  sm: 12px
  md: 16px
  lg: 24px
  xl: 32px
  xxl: 48px
  page: 24px

components:
  button-primary:
    backgroundColor: "{colors.primary}"
    textColor: "{colors.on-primary}"
    typography: "{typography.button}"
    rounded: "{rounded.md}"
    height: 36px
    padding: 0 16px
  button-primary-hover:
    backgroundColor: "{colors.primary-hover}"
    textColor: "{colors.on-primary}"
    typography: "{typography.button}"
    rounded: "{rounded.md}"
  button-secondary:
    backgroundColor: "{colors.surface-2}"
    textColor: "{colors.ink-muted}"
    typography: "{typography.button}"
    rounded: "{rounded.md}"
    height: 36px
    padding: 0 16px
  button-outline:
    backgroundColor: "{colors.surface-1}"
    textColor: "{colors.ink}"
    typography: "{typography.button}"
    rounded: "{rounded.md}"
    height: 36px
    padding: 0 16px
  button-ghost:
    backgroundColor: "{colors.canvas}"
    textColor: "{colors.ink}"
    typography: "{typography.button}"
    rounded: "{rounded.md}"
    height: 36px
    padding: 0 16px
  button-destructive:
    backgroundColor: "{colors.semantic-destructive}"
    textColor: "{colors.on-primary}"
    typography: "{typography.button}"
    rounded: "{rounded.md}"
    height: 36px
    padding: 0 16px
  card:
    backgroundColor: "{colors.surface-1}"
    textColor: "{colors.ink}"
    typography: "{typography.body}"
    rounded: "{rounded.lg}"
    padding: 24px
  text-input:
    backgroundColor: "{colors.surface-1}"
    textColor: "{colors.ink}"
    typography: "{typography.body}"
    rounded: "{rounded.md}"
    height: 36px
    padding: 0 12px
  table-header:
    backgroundColor: "{colors.surface-2}"
    textColor: "{colors.ink-subtle}"
    typography: "{typography.eyebrow}"
    height: 40px
    padding: 0 12px
  table-row:
    backgroundColor: "{colors.surface-1}"
    textColor: "{colors.ink}"
    typography: "{typography.body}"
    height: 48px
    padding: 0 12px
  badge:
    backgroundColor: "{colors.surface-2}"
    textColor: "{colors.ink-muted}"
    typography: "{typography.caption}"
    rounded: "{rounded.pill}"
    padding: 2px 8px
  badge-brand:
    backgroundColor: "{colors.primary-soft}"
    textColor: "{colors.primary}"
    typography: "{typography.caption}"
    rounded: "{rounded.pill}"
    padding: 2px 8px
  sidebar:
    backgroundColor: "{colors.canvas}"
    textColor: "{colors.ink-muted}"
    typography: "{typography.body-strong}"
    width: 256px
    padding: 16px
  sidebar-item-active:
    backgroundColor: "{colors.surface-3}"
    textColor: "{colors.ink}"
    typography: "{typography.body-strong}"
    rounded: "{rounded.md}"
    height: 36px
    padding: 0 12px
  top-bar:
    backgroundColor: "{colors.surface-1}"
    textColor: "{colors.ink}"
    typography: "{typography.body}"
    height: 56px
    padding: 0 24px
  dialog:
    backgroundColor: "{colors.surface-1}"
    textColor: "{colors.ink}"
    typography: "{typography.body}"
    rounded: "{rounded.xl}"
    padding: 24px
  dropdown-menu:
    backgroundColor: "{colors.surface-1}"
    textColor: "{colors.ink}"
    typography: "{typography.body}"
    rounded: "{rounded.md}"
    padding: 4px
  toast:
    backgroundColor: "{colors.surface-1}"
    textColor: "{colors.ink}"
    typography: "{typography.body}"
    rounded: "{rounded.lg}"
    padding: 16px
  empty-state:
    backgroundColor: "{colors.canvas}"
    textColor: "{colors.ink-subtle}"
    typography: "{typography.body}"
    rounded: "{rounded.lg}"
    padding: 48px
---

## Overview

This is the design system every project generated from `saas-maker` starts with. It exists so that a new SaaS looks finished on day one and so that agents and humans make the same visual decisions without re-deriving them.

The system is **neutral first**. Surfaces are grays, hierarchy comes from a short surface ladder plus 1px hairlines, and there is exactly **one chromatic accent**: `{colors.primary}`. That accent is not hard-coded. It is derived from a single CSS variable, `--brand-hue`, declared at the top of `frontend/src/index.css`. Changing that one number re-tints the primary button, focus rings, links, active states and charts. `generate-project.sh` asks for the hue when scaffolding a project. See "Customization" below.

Two apps share the system:

- **Frontend (product)**: light mode by default, dark mode via the `.dark` class. Uses the brand accent.
- **Admin panel**: same tokens, same components, but `primary` is `{colors.ink}` (near-black). The admin is intentionally colorless so operators never confuse it with the product.

The reference point is Linear's product UI: dense, quiet, hairline borders, no gradients, no decorative color. We deliberately depart from Linear in three ways: we ship a **light theme as default**, we use **Inter** (open source) instead of a proprietary face, and the accent is **parametric** rather than a fixed lavender.

**Key characteristics**

- Near-white canvas (`{colors.canvas}`) in light mode; charcoal (`{colors.canvas-dark}`), never `#000`, in dark mode.
- A three-step surface ladder (canvas → surface-1 → surface-2 → surface-3) carries hierarchy. Shadows are reserved for floating layers (dialogs, menus, toasts).
- One accent, used scarcely: primary CTA, focus ring, active nav item, links, selected states.
- Inter at 400 for body, 500 for controls and labels, 600 for headings. Nothing heavier.
- 14px is the default body size. This is an app, not a marketing page.
- 8px radius on controls, 10px on cards, 14px on dialogs. Pills only for badges.
- All product copy is in Spanish (es-419, informal "tú"). Code, tokens and docs are in English.

## Colors

All colors are expressed in `oklch()` so lightness steps are perceptually even and the brand hue can be swapped without re-tuning contrast. Token names below map 1:1 to shadcn/ui CSS variables in `index.css` (`--background`, `--card`, `--muted`, `--primary`, and so on); the mapping table is in the "Components" section.

### Brand & accent (frontend only)

- **Primary** (`{colors.primary}`): `oklch(0.55 0.16 var(--brand-hue))`. Primary buttons, links, active sidebar indicator, focus ring, chart-1.
- **Primary hover** (`{colors.primary-hover}`): 5% darker. Hover state of primary buttons.
- **Primary soft** (`{colors.primary-soft}`): a 95% lightness tint. Brand badges, selected rows, subtle highlights. Never as a page or card background.
- **Primary (dark mode)** (`{colors.primary-dark}`): lighter and less saturated so it reads on charcoal. Text on it is `{colors.on-primary-dark}`, a deep tint of the same hue, not white.

The admin panel does not define these. Its `--primary` is `{colors.ink}` and `--primary-foreground` is `{colors.canvas}`.

### Surfaces

| Token | Light | Dark | Use |
|---|---|---|---|
| canvas | `{colors.canvas}` | `{colors.canvas-dark}` | Page background, sidebar |
| surface-1 | `{colors.surface-1}` | `{colors.surface-1-dark}` | Cards, top bar, inputs, dialogs, menus |
| surface-2 | `{colors.surface-2}` | `{colors.surface-2-dark}` | Muted blocks, table headers, secondary buttons, skeletons |
| surface-3 | `{colors.surface-3}` | `{colors.surface-3-dark}` | Hover and active rows, active sidebar item |
| hairline | `{colors.hairline}` | `{colors.hairline-dark}` | All 1px borders and dividers |
| hairline-strong | `{colors.hairline-strong}` | `{colors.hairline-strong-dark}` | Input borders on hover, stronger separators |

Do not skip ladder steps: a card (surface-1) sits on canvas, a muted block (surface-2) sits inside a card.

### Text

- **Ink** (`{colors.ink}` / `{colors.ink-dark}`): headings, body, values.
- **Ink muted** (`{colors.ink-muted}` / `{colors.ink-muted-dark}`): secondary button labels, sidebar items, table cells that are not the primary column.
- **Ink subtle** (`{colors.ink-subtle}` / `{colors.ink-subtle-dark}`): descriptions, captions, placeholders, table headers, timestamps.
- **Ink disabled** (`{colors.ink-disabled}`): disabled controls, together with 50% opacity.

### Semantic

- **Destructive** (`{colors.semantic-destructive}`): delete actions, validation errors, "remove member". Dark mode uses `{colors.semantic-destructive-dark}`.
- **Success** (`{colors.semantic-success}`): active status badges, success toasts.
- **Warning** (`{colors.semantic-warning}`): pending invitations, expiring items.
- **Info** (`{colors.semantic-info}`): informational banners. Rare.
- Semantic colors appear as text, icon or badge tint. They are never page or card backgrounds.

### Charts

Chart series 1–5 are lightness/chroma variations of the brand hue (`--chart-1` … `--chart-5`), so charts stay monochromatic and on-brand. Use a semantic color in a chart only to flag a threshold or an error.

## Typography

### Font family

- **Inter** for everything, loaded from Google Fonts with `font-optical-sizing: auto`. Fallback stack: `ui-sans-serif, system-ui, -apple-system, "Segoe UI", Roboto, sans-serif`.
- **JetBrains Mono** (fallback `ui-monospace, SFMono-Regular, Menlo`) only for IDs, tokens, code and invite links.

### Hierarchy

| Token | Size | Weight | Line height | Tracking | Use |
|---|---|---|---|---|---|
| `{typography.page-title}` | 24px | 600 | 1.25 | -0.4px | One per page, top-left of content |
| `{typography.section-title}` | 18px | 600 | 1.30 | -0.2px | Card group headings, dialog titles |
| `{typography.card-title}` | 16px | 600 | 1.35 | -0.1px | Card headers |
| `{typography.body}` | 14px | 400 | 1.50 | 0 | Default text, table cells, inputs |
| `{typography.body-strong}` | 14px | 500 | 1.50 | 0 | Labels, nav items, emphasized values |
| `{typography.caption}` | 12px | 400 | 1.40 | 0 | Descriptions, helper text, timestamps |
| `{typography.eyebrow}` | 12px | 500 | 1.30 | +0.4px | Table headers, section eyebrows (uppercase optional) |
| `{typography.button}` | 14px | 500 | 1.20 | 0 | All buttons |
| `{typography.mono}` | 13px | 400 | 1.50 | 0 | Codes, IDs |

### Principles

- Weight carries hierarchy more than size. A 600 title at 24px next to 400 body at 14px is enough contrast; never reach for 700 or 800.
- Headings get slight negative tracking, body and captions none, eyebrows slight positive tracking.
- Keep line length under ~70 characters in prose (`max-w-prose`).
- Numbers in tables use `tabular-nums`.

## Layout

### Spacing

Base unit 4px. Tokens: `{spacing.xxs}` 4 · `{spacing.xs}` 8 · `{spacing.sm}` 12 · `{spacing.md}` 16 · `{spacing.lg}` 24 · `{spacing.xl}` 32 · `{spacing.xxl}` 48. Tailwind's default scale matches (`gap-2` = 8px, `p-6` = 24px).

- Page content padding: `{spacing.page}` 24px (`p-6`), 16px on mobile.
- Card padding: 24px. Compact cards (stats): 16px.
- Vertical rhythm between page sections: 24px. Between form fields: 16px. Between a label and its input: 8px.
- Button groups: 8px gap. Icon + text inside a button: 8px gap.

### App shell

- Fixed left **sidebar** of 256px on `canvas`, collapsible to a sheet under 1024px.
- **Top bar** of 56px on `surface-1` with a bottom hairline: page context on the left, user menu on the right.
- Content area max width 1280px, left-aligned (not centered) inside the shell.
- Auth pages (login, register, invite, reset) use a centered single card of max 400px on `canvas`.

### Grids

- Stats and cards: 3 columns at ≥1024px, 2 at ≥640px, 1 below. Use `grid gap-4 md:grid-cols-2 lg:grid-cols-3`.
- Forms: single column, max 560px. Two columns only for short paired fields (first/last name).
- Tables take the full content width and scroll horizontally inside their card on small screens.

## Elevation & Depth

| Level | Treatment | Use |
|---|---|---|
| 0 | `canvas`, no border | Page, sidebar |
| 1 | `surface-1` + 1px `hairline` | Cards, inputs, top bar, table container |
| 2 | `surface-2` or `surface-3`, no border | Muted blocks, table header, hover/active rows |
| 3 | `surface-1` + hairline + `shadow-md` | Dropdown menus, popovers, select lists |
| 4 | `surface-1` + hairline + `shadow-lg` + `{colors.overlay}` scrim | Dialogs, sheets |
| focus | 3px ring of `primary` at 50% opacity, offset 0 | Any focused control |

Shadows exist only on floating layers (3 and 4). Cards never have shadows; they use borders. Dark mode keeps the same rules with the dark tokens; shadows become nearly invisible there, which is intended, the hairlines do the work.

## Shapes

| Token | Value | Use |
|---|---|---|
| `{rounded.xs}` | 4px | Checkboxes, small chips, code spans |
| `{rounded.sm}` | 6px | Inline tags, table row selection |
| `{rounded.md}` | 8px | Buttons, inputs, selects, menu items, sidebar items |
| `{rounded.lg}` | 10px | Cards, toasts, empty states |
| `{rounded.xl}` | 14px | Dialogs, sheets |
| `{rounded.pill}` | 9999px | Status badges, counters |
| `{rounded.full}` | 9999px | Avatars |

`--radius` in `index.css` is 0.625rem (10px); shadcn derives `sm`/`md`/`lg`/`xl` from it. Avatars are 32px in tables, 36px in the top bar, 64px on account pages. Icons are Lucide at 16px inside controls and 20px standalone, stroke 2.

## Components

The apps are built from shadcn/ui primitives. The table maps design tokens to the CSS variables shadcn reads, so changing `index.css` changes every component.

| Token | shadcn variable (light / dark) |
|---|---|
| canvas | `--background`, `--sidebar` |
| surface-1 | `--card`, `--popover` |
| surface-2 | `--secondary`, `--muted` |
| surface-3 | `--accent`, `--sidebar-accent` |
| hairline / hairline-strong | `--border` / `--input` |
| ink | `--foreground`, `--card-foreground` |
| ink-muted | `--secondary-foreground` |
| ink-subtle | `--muted-foreground` |
| primary, on-primary | `--primary`, `--primary-foreground` (admin: ink / canvas) |
| primary (as ring) | `--ring` |
| semantic-destructive | `--destructive` |

### Buttons

`button-primary` is the single CTA of a view: "Guardar", "Invitar", "Crear organización". One per card or dialog. `button-outline` is the default secondary ("Cancelar"). `button-ghost` is for icon buttons and toolbar actions. `button-destructive` only inside a confirmation dialog, never as the first click. `button-secondary` (surface-2) is for tertiary actions in dense toolbars. All buttons are 36px tall (`h-9`), 32px in table rows (`size="sm"`), with `{typography.button}` and `{rounded.md}`. Loading state: disable, keep the label, prefix a 16px spinner.

### Inputs & forms

`text-input`: 36px tall, `surface-1`, 1px `hairline` border, `{rounded.md}`, placeholder in `ink-subtle`. Focus: border becomes `primary` plus the 3px focus ring. Error: border and helper text in `semantic-destructive`, message under the field, never a toast. Labels use `{typography.body-strong}` above the field. Forms use react-hook-form + zod; validate on blur, show all errors on submit.

### Cards

`card`: `surface-1`, hairline border, `{rounded.lg}`, 24px padding, optional header with `{typography.card-title}` and a caption description. Stats cards: label in `eyebrow`, value in 24px/600 with `tabular-nums`, optional delta in success/destructive.

### Tables

`table-header` row on `surface-2` with `eyebrow` text in `ink-subtle`; `table-row` 48px with hairline dividers, hover to `surface-3`. Primary column in `ink` and `body-strong`, the rest in `ink-muted`. Row actions live in a trailing `…` dropdown (`button-ghost`, icon only). Pagination sits under the table, right-aligned, 20 rows per page. Empty tables show `empty-state` inside the same card.

### Badges

`badge` (neutral) for roles and metadata; `badge-brand` for the current user's own items; status badges use the semantic color as a soft tint (10% background, full-strength text and a 6px dot). Text is `caption`, 500 weight, never uppercase.

### Navigation

`sidebar`: items are 36px, `{rounded.md}`, icon 16px + label in `body-strong` and `ink-muted`; the active item (`sidebar-item-active`) gets `surface-3` and `ink` text, and in the frontend a 2px `primary` bar on the left edge. Section labels use `eyebrow`. The organization name and user avatar sit at the bottom.

`top-bar`: 56px, `surface-1`, bottom hairline, contains the page title on mobile and the user dropdown (avatar 36px) on the right.

### Overlays

`dialog`: max 480px (forms) or 400px (confirmations), `{rounded.xl}`, 24px padding, title in `section-title`, description in `caption`, actions right-aligned with "Cancelar" (outline) before the primary. Destructive confirmations state the consequence in the description and use `button-destructive`. `dropdown-menu`: 4px padding, items 32px with `{rounded.sm}`, destructive items in `semantic-destructive`. `toast` (sonner): bottom-right, `surface-1`, hairline, `{rounded.lg}`, auto-dismiss 4s, success/error variants tint only the icon.

### States

Every list and detail view implements four states: **loading** (skeletons on `surface-2` matching the final layout, never a centered spinner for content), **empty** (`empty-state` with an icon, one sentence and the primary action), **error** (inline message in `semantic-destructive` with a "Reintentar" outline button) and **populated**.

## Do's and Don'ts

### Do

- Use `primary` only for the main CTA, focus, links, active nav and selection. If a screen has more than two spots of accent, remove some.
- Build hierarchy with the surface ladder and hairlines. Reach for a shadow only on floating layers.
- Keep body at 14px/400 and headings at 600. Use weight and color, not size, for emphasis.
- Write Spanish copy in the informal "tú", short sentences, sentence case ("Invitar miembro", not "Invitar Miembro").
- Ship all four states (loading, empty, error, populated) for every data view.
- Use `oklch` with `var(--brand-hue)` for anything brand-tinted, so it follows the project's hue.
- Test in dark mode before merging UI; the `.dark` variables are part of the definition of done.

### Don't

- Don't use the brand color as a page, card or sidebar background, or as a gradient.
- Don't introduce a second accent color. Semantic colors are for meaning only.
- Don't use pure `#000` or `#fff` in dark mode; use the dark tokens.
- Don't add shadows to cards, inputs or buttons.
- Don't round buttons or inputs as pills, and don't exceed 14px radius on any container.
- Don't use font weights above 600, uppercase headings, or fonts other than Inter and JetBrains Mono.
- Don't put validation errors in toasts, and don't put success confirmations inline.
- Don't hard-code colors in components. If a color is missing, add a token to `index.css` and to this file.

## Customization

Per project, in this order:

1. **Brand hue**: `--brand-hue` in `frontend/src/index.css` (0–360). `generate-project.sh` asks for it. Hue guide: 25 orange, 85 yellow, 145 green, 200 teal, 250 blue, 265 indigo (default), 300 violet, 350 pink. Keep chroma and lightness as defined; only the hue changes.
2. **Radius**: `--radius` (0.5rem sharper, 0.75rem softer). Applies to both apps.
3. **Logo**: replace the `Building2` icon in `AuthLayout`, `Sidebar` and the admin `LoginPage` with the brand mark at 24px.
4. **Fonts**: only if the brand demands it; swap the Google Fonts link and `--font-sans` in both apps.

The admin panel stays neutral regardless of the brand hue. Do not tint it.

## Known Gaps

- No marketing/landing system; this covers the authenticated product and the admin only.
- No illustration or empty-state artwork guidelines; empty states use a Lucide icon at 40px in `ink-subtle`.
- Data visualization is limited to the five monochromatic chart tokens; a categorical palette is not defined yet.
- Accessibility targets: WCAG AA contrast for text is met by the ink/surface pairs above; the brand primary at 0.55 lightness meets AA on white for text ≥14px/500, but verify after changing the hue (yellow and green hues need a darker lightness for text use).
