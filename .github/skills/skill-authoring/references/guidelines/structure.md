# Directory Structure

```
my-skill/
├── SKILL.md              # Required: main instructions
├── references/           # Optional: detailed documentation
│   ├── api-reference.md  # Lowercase with hyphens
│   └── examples.md       # Lowercase with hyphens
├── templates/            # Optional: output templates (for report generation)
│   └── report-template.md
├── scripts/              # Optional: executable code
│   └── helper.sh
└── assets/               # Optional: templates, data files
    └── template.json
```

## Folder Purposes

| Folder | Purpose | Naming |
|--------|---------|--------|
| `references/` | Detailed docs, loaded on-demand | `lowercase-hyphens.md` |
| `templates/` | Output format templates | `lowercase-hyphens.md` |
| `scripts/` | Executable code | Language conventions |
| `assets/` | Data files, configs | File type conventions |

## Recipes Pattern

For skills with multiple implementation approaches:

```
skill-name/
├── SKILL.md
└── references/
    ├── recipes/
    │   ├── azd/README.md
    │   ├── bicep/README.md
    │   └── terraform/README.md
    └── common.md
```

Link selectively so only the chosen recipe loads.

## Services Pattern

For skills working with multiple cloud services:

```
skill-name/
├── SKILL.md
└── references/
    └── services/
        ├── container-apps.md
        ├── static-web-apps.md
        └── functions.md
```

Each service file should be self-contained.
