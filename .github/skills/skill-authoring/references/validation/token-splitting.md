# Reference Token Splitting

References exceeding 1000 tokens should be split into smaller files.

## Procedure

1. Calculate tokens for each reference file
2. For files >1000 tokens, split into logical sections

## Splitting Pattern

```
# Before
references/
└── large-guide.md          # 1500 tokens

# After
references/
└── large-guide/
    ├── README.md           # Overview + links to sections
    ├── section-1.md        # First logical section
    ├── section-2.md        # Second logical section
    └── section-3.md        # Third logical section
```

## README.md structure

```markdown
# [Topic] Guide

Overview of the topic.

## Sections

- [Section 1](section-1.md) - Brief description
- [Section 2](section-2.md) - Brief description
- [Section 3](section-3.md) - Brief description
```

## Update original links

Change `[guide](references/large-guide.md)` to `[guide](references/large-guide/README.md)`
