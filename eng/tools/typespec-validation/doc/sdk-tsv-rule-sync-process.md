# TypeSpec Validation Rule Updates: Breaking and Non-Breaking Changes Guide

This document describes the process for updating TypeSpec validation rules in the azure-rest-api-specs repository, covering both breaking and non-breaking changes.

## Table of Contents

- [Overview](#overview)
- [Types of Changes](#types-of-changes)
- [Process for Small Impact Changes](#process-for-small-impact-changes)
- [Process for Large Impact Changes](#process-for-large-impact-changes)
- [Standard Update Sequence](#standard-update-sequence)
- [Best Practices](#best-practices)

## Overview

TypeSpec validation rules ensure consistency and quality across Azure API specifications. When updating these rules, it's critical to follow the proper process to avoid breaking existing specifications across both public and private repositories.

**Why This Process Matters:**
When TypeSpec validation (TSV) rule changes are merged to `Public/Main`, they are **automatically mirrored** to `Private/RPSaaSMaster`. However, **specification files are NOT automatically mirrored**—each repository maintains its own specs. This means spec failures will differ between repositories, requiring separate fixes in `private/rpsaasmaster`. This automatic synchronization of rules (but not specs) is why we need this careful process—to prevent validation failures from cascading across both repositories and blocking ongoing work.

### Key Repositories

- **Public/Main**: `Azure/azure-rest-api-specs` (public GitHub repository)
- **Private/RPSaaSMaster**: `Azure/azure-rest-api-specs-pr` (RPSaaSMaster branch) - Private repository that mirrors public specs

## Types of Changes

### Non-Breaking Changes

Non-breaking changes include:

- Adding a new **optional** validation rule
- Changing a required rule to optional (relaxing requirements)
- Modifying an existing rule to be less restrictive

These changes should not cause existing valid specifications to fail validation.

### Breaking Changes

Breaking changes include:

- Adding a new **required** validation rule (may cause existing specs to fail)
- Making an optional rule required (stricter requirements)
- Modifying an existing rule to be more restrictive
- Changing rule behavior that may invalidate previously valid specs

## Process for Small Impact Changes

Use this process when the validation rule change affects only a small number of specifications.

### Steps

1. **Prepare Rule in Public/Main**
   - Develop and test the new or updated rule
   - Create a PR with the rule changes
   - Keep the PR in draft status initially

2. **CI Autorun Validation**
   - The CI pipeline will automatically run validation against all specifications in public/main
   - Review the validation results

3. **Fix Failures in Rule PR**
   - If validation failures occur, determine if they are legitimate issues
   - Fix any false positives or unexpected failures directly in the rule PR
   - Iterate until validation passes

4. **Review Rule Readiness**
   - Ensure the rule is working as expected
   - Get necessary approvals from team members

5. **Assess Impact on Both Repositories**
   - Check the rule PR's CI results on `public/main`
   - Create a test/draft PR to `private/rpsaasmaster` to identify additional failures
   - **Note**: This draft PR is for assessment only—do not merge it

6. **Fix Spec Failures in Both Repositories**
   - Fix spec failures in `public/main` by creating separate PRs
   - Fix spec failures in `private/rpsaasmaster` by creating separate PRs
   - These spec fixes should be merged **before** the rule change is merged
   - Coordinate with spec owners in both repositories to ensure all fixes are ready

7. **Merge Rule Change**
   - Once all spec fixes are merged to `public/main` and mirrored
   - Merge the rule PR to `public/main`
   - The rule change will automatically mirror to `private/rpsaasmaster`
   - All validation should pass in both repositories

## Process for Large Impact Changes

Use this process when the validation rule change affects a majority of specifications.

### Steps

1. **Disable the Rule Initially**
   - Add the new rule but keep it disabled in a PR to `public/main`
   - Merge to `public/main`, which will automatically mirror to `private/rpsaasmaster`

2. **Update Specifications in Both Repositories**
   - Create dedicated PRs to update affected specifications in `public/main`
   - Create **separate** PRs to update specifications in `private/rpsaasmaster`
   - Review and merge spec update PRs in both repositories before enabling the rule

3. **Enable the Rule**
   - Once all (or most) specifications are updated in both repositories
   - Create a PR to enable the rule in `public/main`
   - Validation should pass for the majority of specs
   - Merge to `public/main`, which will automatically mirror to `private/rpsaasmaster`
   - Handle any remaining edge cases as needed

## Standard Update Sequence

Follow this sequence for all rule updates:

### 1. Create Draft PRs for Assessment

```
Create draft PRs to both:
├── public/main
└── private/rpsaasmaster
```

This reveals which specifications need updating.

### 2. Update Specifications (When Possible)

**For New Rules (Non-Breaking):**

- Update specs in `public/main` first
- Create **separate** PRs to update specs in `RPSaaSMaster`
- Enable the new rule only after all specs are updated in both repositories

**Why:** When adding a new rule (not modifying an existing one), you can update specifications proactively before enabling the rule. Only TSV rules are auto-mirrored; specs must be updated separately in each repository.

### 3. Merge Rule Change to Public/Main

- Everything should already pass validation at this point in both repositories
- Merge the rule change to `public/main`
- The change will automatically mirror to `private/rpsaasmaster`
- All validation should continue to pass in the private repo

### 4. Handle Auto-Mirror Gaps

If there's a delay before auto-mirroring occurs:

- A spec might slip into `rpsaasmaster` that doesn't comply with the new rule
- Fix these cases reactively as they arise
- This should be rare if the process is followed correctly

## Best Practices

### Before Making Changes

- [ ] Assess the impact: How many specs will be affected?
- [ ] Determine if the change is breaking or non-breaking
- [ ] Choose the appropriate process (small impact vs. large impact)

### During Implementation

- [ ] Test the rule thoroughly before creating PRs
- [ ] Document the rule's purpose and expected behavior
- [ ] Communicate with spec owners about upcoming changes
- [ ] Create draft PRs early to identify all affected specs in both repositories
- [ ] Remember: Only TSV rules auto-mirror; specs must be fixed separately in each repository
- [ ] Create separate spec fix PRs for both `public/main` and `private/rpsaasmaster`

### After Merging

- [ ] Monitor CI pipelines for unexpected failures
- [ ] Be available to help fix any issues that arise
- [ ] Document any lessons learned for future updates

### Communication

- Notify relevant teams when making breaking changes
- Provide clear migration guidance for spec authors
- Set reasonable timelines for large-scale updates
- Use draft PRs to gather feedback before final implementation

## Example Scenarios

### Scenario 1: Adding a New Optional Rule (Small Impact)

1. Create rule in draft PR to `public/main`
2. CI runs validation - 5 specs fail in `public/main`
3. Fix the 5 specs in separate PRs to `public/main`
4. Create draft PR to `private/rpsaasmaster` - identifies 3 specs that fail there
5. Create separate PRs to fix those 3 specs in `private/rpsaasmaster` (specs are NOT auto-mirrored)
6. Merge all spec fix PRs in both repositories
7. Merge rule PR to `public/main`
8. TSV rule auto-mirrors to `private/rpsaasmaster`
9. Validation passes in both repositories

### Scenario 2: Making a Rule Required (Large Impact)

1. Add the new rule as disabled
2. Merge to `public/main` (TSV rule auto-mirrors to private)
3. Create bulk update PRs to fix specs in both `public/main` and `private/rpsaasmaster` (specs are NOT auto-mirrored, so separate PRs needed)
4. Once 90%+ of specs are updated in both repositories, enable the rule
5. Merge enable-rule PR to `public/main` (auto-mirrors to private)
6. Handle remaining edge cases individually in each repository

### Scenario 3: Relaxing a Rule (No Breaking Change)

1. Make the rule optional in a PR
2. Create draft PRs to assess impact (should be none)
3. Merge to `public/main`
4. Auto-mirror to `private/rpsaasmaster`
5. Done!

## Troubleshooting

### Validation Fails After Rule Merge

**Problem:** Specs fail validation after rule is merged.

**Solution:**

- Check if specs were added to `rpsaasmaster` during the auto-mirror gap
- Create a hotfix PR to update the failing specs
- Consider temporarily disabling the rule if critical

### Auto-Mirror Delay

**Problem:** Changes don't appear in `private/rpsaasmaster` immediately.

**Solution:**

- Wait for the scheduled mirror (usually within 24 hours)
- If urgent, contact the repository administrators
- Have fixes ready for any specs that slip through

### Unexpected Spec Failures

**Problem:** Specs fail that shouldn't based on the rule description.

**Solution:**

- Review the rule logic for edge cases
- Check if there are unintended side effects
- Create a follow-up PR to refine the rule
- Consider temporarily reverting if the impact is severe

## Related Documentation

- [TypeSpec Validation Tools](./SwaggerValidationTools.md)
- [CI Fix Guidelines](./ci-fix.md)
- [Getting Started with TypeSpec](./Getting-started-with-TypeSpec-specifications.md)

## Questions?

For questions about this process, contact the Azure API Governance team or file an issue in the azure-rest-api-specs repository.
