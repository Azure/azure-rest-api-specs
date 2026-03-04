# SKU Support for HealthDataAIServices - Progress Tracker

## Plan

### Phase 1: TypeSpec Changes
1. Add `...ResourceSkuProperty` to the `DeidService` resource model
2. Add `sku?: Azure.ResourceManager.CommonTypes.Sku` to the `DeidUpdate` patch model
3. Update example JSON files to include SKU data
4. Validate TypeSpec compilation

### Phase 2: Spec PR
1. Create branch, commit, push
2. Create draft PR with "DO NOT MERGE" prefix

### Phase 3: SDK Generation (Python, JS, Go, .NET, Java)
For each language:
1. Generate SDK locally from local TypeSpec changes
2. Build and test
3. Update changelog/metadata
4. Run validation checks
5. Create draft PR with "DO NOT MERGE" prefix

### Phase 4: CI Validation & Fixes
1. Monitor CI on all PRs
2. Fix any CI failures
3. Re-verify all PRs pass

---

## Final Status

| PR | Repo | CI Status |
|----|------|-----------|
| [#40984](https://github.com/Azure/azure-rest-api-specs/pull/40984) | Spec | ⚠️ Expected: LintDiff (common-types v5 warnings), BreakingChange (VersioningReviewRequired for new property). TypeSpec Validation ✅ |
| [#45499](https://github.com/Azure/azure-sdk-for-python/pull/45499) | Python | ✅ All checks passed |
| [#37446](https://github.com/Azure/azure-sdk-for-js/pull/37446) | JavaScript | ✅ All checks passed |
| [#26108](https://github.com/Azure/azure-sdk-for-go/pull/26108) | Go | ✅ All checks passed |
| [#56726](https://github.com/Azure/azure-sdk-for-net/pull/56726) | .NET | ⚠️ Compliance job cancelled (transient ADO issue). All build/analyze/test jobs ✅ |
| [#48213](https://github.com/Azure/azure-sdk-for-java/pull/48213) | Java | ✅ All checks passed |

## CI Fixes Applied
- **Spec**: Regenerated OpenAPI/example files via `tsp compile .`
- **JS**: Bumped `package.json` version from 1.0.0 to 1.1.0 to match CHANGELOG
- **Go**: Downgraded `go.mod` from Go 1.25.0 to 1.24.0 with compatible deps
- **.NET**: Regenerated SDK code via `tsp-client update` and regenerated API surface files
- **Python**: Bumped `_version.py` from 1.0.0 to 1.1.0 to match CHANGELOG
