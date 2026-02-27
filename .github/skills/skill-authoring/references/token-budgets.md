# Token Budget Guidelines

Central reference for token limits across all skill files.

## Limits

| File Type        | Soft Limit  | Hard Limit  | Action if Exceeded               |
| ---------------- | ----------- | ----------- | -------------------------------- |
| SKILL.md         | 500 tokens  | 5000 tokens | Split into references            |
| references/\*.md | 1000 tokens | 2000 tokens | Split into folder with README.md |
| docs/\*.md       | 1500 tokens | 3000 tokens | Restructure                      |

## Splitting Large References

When a reference exceeds 1000 tokens, convert to a folder structure:

```
# Before
references/large-guide.md    # 1500 tokens

# After
references/large-guide/
├── README.md                # Overview + links (~200 tokens)
├── section-1.md             # First section (~400 tokens)
└── section-2.md             # Second section (~400 tokens)
```

Update links: `[guide](references/large-guide.md)` → `[guide](references/large-guide/README.md)`

## Validation

```bash
cd scripts
npm run tokens -- check plugin/skills/my-skill/SKILL.md
```

## Why Token Limits Matter

- **Metadata (~100 tokens)**: Loads at startup for ALL skills
- **SKILL.md (<5000 tokens)**: Loads entirely on activation
- **References**: Load only when explicitly linked

Smaller files = faster activation, less context consumed.
