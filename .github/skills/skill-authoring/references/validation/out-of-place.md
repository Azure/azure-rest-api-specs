# Out-of-Place Guidance Detection

Identify guidance that seems misplaced - typically when generic content contains very specific technology or service references.

## Indicators

- Generic workflow steps with service-specific workarounds embedded
- Platform-agnostic instructions mentioning a particular Azure service
- General azd commands followed by special handling for one service
- Troubleshooting for a specific resource type in a general skill
- Service-specific environment variables in generic setup docs

## Examples

| Context | Misplaced Content | Why It's Misplaced |
|---------|-------------------|-------------------|
| Generic `azd up` workflow | "Note: For Cosmos DB, add `--no-prompt` flag" | Service-specific workaround in generic flow |
| General authentication docs | "If using Azure SQL, also grant db_owner role" | SQL-specific step in auth overview |
| Container Apps deployment | "Redis requires minimum 1GB memory allocation" | Redis-specific detail in general deploy |
| Generic error handling | "PostgreSQL connections may timeout after 30s" | DB-specific behavior in general errors |

## Procedure

1. Review skill content for technology/service keywords
2. Check if the surrounding context is generic or service-specific
3. Flag content where specificity level mismatches context
4. Determine if the content should be moved or the skill scope narrowed

## When out-of-place guidance found, ask user:

- a) **Extract to service-specific reference** - Move to `references/services/<service>.md`
- b) **Create new skill** - If content warrants its own skill
- c) **Add conditional section** - Create "Service-Specific Notes" section
- d) **Keep as-is** - If the specificity is justified in context
- e) **Something else** - User provides alternative action

## Extraction pattern

```markdown
# Before (in generic workflow)
## Deploy Application
1. Run `azd up`
2. Wait for provisioning
3. Note: For Cosmos DB deployments, set throughput before deploy
4. Verify deployment

# After
## Deploy Application
1. Run `azd up`
2. Wait for provisioning
3. Verify deployment

See [Service-Specific Notes](references/services/README.md) for service-specific considerations.
```
