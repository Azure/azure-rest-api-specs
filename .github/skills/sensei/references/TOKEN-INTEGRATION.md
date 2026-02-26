# Token Integration

Sensei integrates with the token management system to ensure skills stay within budget while improving frontmatter compliance.

## Token Budgets

From the [skill-authoring](/.github/skills/skill-authoring) skill:

| File Type | Soft Limit | Hard Limit |
|-----------|------------|------------|
| SKILL.md | 500 tokens | 5000 tokens |
| references/*.md | 1000 tokens | - |
| Total skill | 2000 tokens | - |

## Token Commands

Sensei uses the token CLI from `scripts/`:

```bash
# Count tokens in a file
cd scripts && npm run tokens -- count plugin/skills/{skill-name}/SKILL.md

# Check against limits
cd scripts && npm run tokens -- check plugin/skills/{skill-name}/SKILL.md

# Get optimization suggestions
cd scripts && npm run tokens -- suggest plugin/skills/{skill-name}/SKILL.md
```

## Integration Points

### 1. READ Phase (Capture Baseline)

At loop start, capture initial token count:
```bash
cd scripts && npm run tokens -- count plugin/skills/{skill-name}/SKILL.md --json
```

Store: `beforeTokens = result.tokens`

### 2. CHECK TOKENS Phase (After Improvements)

After frontmatter improvements pass tests:
```bash
# Get current count
cd scripts && npm run tokens -- count plugin/skills/{skill-name}/SKILL.md --json

# Get suggestions
cd scripts && npm run tokens -- suggest plugin/skills/{skill-name}/SKILL.md --json
```

Store:
- `afterTokens = result.tokens`
- `tokenDelta = afterTokens - beforeTokens`
- `suggestions = suggestResult.suggestions`

### 3. SUMMARY Phase (Report)

Include in summary:
- Token count before/after
- Delta (+/- tokens)
- Suggestions not implemented (for user review)

## Optimization Patterns

For detailed optimization guidance, reference the [markdown-token-optimizer](/.github/skills/markdown-token-optimizer) skill:

- [ANTI-PATTERNS.md](/.github/skills/markdown-token-optimizer/references/ANTI-PATTERNS.md) - Token-wasting patterns to avoid
- [OPTIMIZATION-PATTERNS.md](/.github/skills/markdown-token-optimizer/references/OPTIMIZATION-PATTERNS.md) - Techniques to reduce tokens

### Quick Reference: Common Optimizations

| Pattern | Savings | Example |
|---------|---------|---------|
| Remove emojis | 1-3 tokens each | `✅` → (remove) |
| Shorten headings | 2-5 tokens | `## Step 1: Configuration` → `## Configuration` |
| Remove filler words | 1-2 tokens each | "In order to" → "To" |
| Consolidate lists | 5-10 tokens | Multiple bullets → single sentence |
| Use abbreviations | 1-2 tokens | "Application Insights" → "App Insights" |

## When to Apply Token Suggestions

Sensei captures token optimization suggestions but does **not** auto-apply them. The user decides:

**Apply immediately if:**
- Skill exceeds soft limit (500 tokens)
- Suggestions don't reduce clarity
- Changes are straightforward

**Create issue if:**
- Suggestions require careful review
- Multiple skills need same optimization
- Changes might affect functionality

**Skip if:**
- Skill is well under budget
- Suggestions trade clarity for brevity
- Time constraints

## Example Summary with Tokens

```
╔══════════════════════════════════════════════════════════════════╗
║  SENSEI SUMMARY: appinsights-instrumentation                     ║
╠══════════════════════════════════════════════════════════════════╣
║  BEFORE                          AFTER                           ║
║  ──────                          ─────                           ║
║  Score: Low                      Score: Medium-High              ║
║  Tokens: 142                     Tokens: 385                     ║
║  Triggers: 0                     Triggers: 7                     ║
║  Anti-triggers: 0                Anti-triggers: 4                ║
║                                                                  ║
║  TOKEN STATUS: ✅ Under budget (385 < 500)                       ║
║                                                                  ║
║  SUGGESTIONS NOT IMPLEMENTED:                                    ║
║  • (none - skill is under budget)                                ║
║                                                                  ║
╚══════════════════════════════════════════════════════════════════╝
```

## Related Skills

- [markdown-token-optimizer](/.github/skills/markdown-token-optimizer) - Token analysis and suggestions
- [skill-authoring](/.github/skills/skill-authoring) - Skill writing guidelines and constraints
