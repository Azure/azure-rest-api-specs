# Review Date Sync to GitHub Projects

## Overview

This GitHub Action automatically syncs review dates from issue descriptions to the GitHub Projects V2 'Review Date' custom field for issues labeled with "API Review Scoping".

## How It Works

1. **Scheduled Execution**: Runs daily at 6:00 AM UTC
2. **Issue Filtering**: Scans only open issues with the "API Review Scoping" label
3. **Date Extraction**: Looks for lines matching `Review Date: MM/DD/YYYY HH:MM AM/PM PT` in issue descriptions and comments
4. **Last Date Wins**: If multiple review dates are found (e.g., rescheduled meetings), uses the last one mentioned
5. **Project Update**: Updates the 'Review Date' custom field in Azure org's Project 196
6. **PR Linking**: If a PR link is found (format: `PR: https://github.com/Azure/azure-rest-api-specs/pull/XXXXX`), links the PR to the issue

## Issue Format

To have the Review Date automatically synced, add a line in your issue description:

```
Review Date: 01/15/2026 08:00 AM PT
```

Optionally, include a PR link to automatically link the PR to the issue:

```
PR: https://github.com/Azure/azure-rest-api-specs/pull/37730
```

**Requirements:**

- The issue must have the label "API Review Scoping"
- The date must be in the format: `MM/DD/YYYY HH:MM AM/PM PT`
- Example: `Review Date: 01/15/2026 08:00 AM PT`
- The pattern is case-insensitive
- The time zone must be PT (Pacific Time)
- If the meeting is rescheduled, add a new review date line in a comment - the last date found will be used
- The date must be valid (e.g., not 2025-13-45)

## Project Configuration

- **Organization**: Azure
- **Project Number**: 196
- **Custom Field**: Review Date (must be a Date field type)

## Permissions

The workflow requires:

- `issues: read` - To fetch issue descriptions
- Access to GitHub Projects GraphQL API - To update project fields

**Note**: The default `GITHUB_TOKEN` may need to be replaced with a Personal Access Token (PAT) that has:

- `project` scope (to read/write project data)
- `read:org` scope (to access organization projects)

## Manual Execution

You can manually trigger the workflow from the Actions tab:

1. Go to Actions → "Sync Review Date to Projects"
2. Click "Run workflow"
3. Select the branch and click "Run workflow"

## Monitoring

After each run, the workflow produces a summary showing:

- Number of issues processed
- Number of issues updated
- Number of errors encountered

View the summary in the workflow run details.

## Troubleshooting

### Issue Not Updated

**Possible reasons:**

1. The issue does not have the "API Review Scoping" label
2. The issue is not added to Project 196
3. The 'Review Date' custom field doesn't exist in the project
4. The date format in the issue description is incorrect (must be MM/DD/YYYY HH:MM AM/PM PT)
5. Permission issues with the GitHub token

**Check the workflow logs** for specific error messages.

### Token Permissions

If you see errors about missing permissions:

1. Create a PAT with `project` and `read:org` scopes
2. Add it as a repository secret (e.g., `PROJECT_SYNC_TOKEN`)
3. Update the workflow file to use: `github-token: ${{ secrets.PROJECT_SYNC_TOKEN }}`

## Files

- **Workflow**: `.github/workflows/sync-review-date.yaml`
- **Script**: `.github/workflows/src/sync-review-date.js`
- **Documentation**: `.github/workflows/docs/sync-review-date.md` (this file)
