---
name: markdown-token-optimizer
description: "Analyzes markdown files for token efficiency. TRIGGERS: optimize markdown, reduce tokens, token count, token bloat, too many tokens, make concise, shrink file, file too large, optimize for AI, token efficiency, verbose markdown, reduce file size"
---

# Markdown Token Optimizer

This skill analyzes markdown files and suggests optimizations to reduce token consumption while maintaining clarity.

## When to Use

- Optimize markdown files for token efficiency
- Reduce SKILL.md file size or check for bloat
- Make documentation more concise for AI consumption

## Workflow

1. **Count** - Calculate tokens (~4 chars = 1 token), report totals
2. **Scan** - Find patterns: emojis, verbosity, duplication, large blocks
3. **Suggest** - Table with location, issue, fix, savings estimate
4. **Summary** - Current/potential/savings with top recommendations

See [ANTI-PATTERNS.md](references/ANTI-PATTERNS.md) for detection patterns and [OPTIMIZATION-PATTERNS.md](references/OPTIMIZATION-PATTERNS.md) for techniques.

## Rules

- Suggest only (no auto-modification)  
- Preserve clarity in all optimizations
- SKILL.md target: <500 tokens, references: <1000 tokens

## References

- [OPTIMIZATION-PATTERNS.md](references/OPTIMIZATION-PATTERNS.md) - Optimization techniques
- [ANTI-PATTERNS.md](references/ANTI-PATTERNS.md) - Token-wasting patterns
