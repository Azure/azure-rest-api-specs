# SDK Release Progress Tracker

## API Spec Branch
- **Branch Name**: `ronniegeraghty/azsdktoolsagent-demo-2`
- **Repository**: `azure-rest-api-specs`

## Changes Summary
Adding SKU support to DeidService with new API version `2026-02-01-preview`:
- Added `SkuTier` union (Free, Basic, Standard)
- Added `Sku` model (name, tier, capacity properties)
- Added `sku` property to `DeidService` (marked with `@added` for new version)
- Added `sku` property to `DeidUpdate` for PATCH operations

---

## Progress Checklist

### TypeSpec Changes
- [x] Add new API version `2026-02-01-preview`
- [x] Add `SkuTier` union with Free, Basic, Standard options
- [x] Add `Sku` model with name, tier, and capacity properties
- [x] Add `sku` property to `DeidService` (versioned)
- [x] Add `sku` property to `DeidUpdate` for PATCH operations
- [x] Validate TypeSpec specification
- [ ] Commit and push changes

### API Spec PR
- [ ] Create PR in azure-rest-api-specs
- [ ] PR Link: _pending_

### SDK Generation - .NET
- [ ] Branch created: `ronniegeraghty/azsdktoolsagent-demo-2`
- [ ] SDK generated
- [ ] SDK built successfully
- [ ] Tests passed
- [ ] Changelog updated

### SDK Generation - Python
- [ ] Branch created: `ronniegeraghty/azsdktoolsagent-demo-2`
- [ ] SDK generated
- [ ] SDK built successfully
- [ ] Tests passed
- [ ] Changelog updated

### SDK Generation - Java
- [ ] Branch created: `ronniegeraghty/azsdktoolsagent-demo-2`
- [ ] SDK generated
- [ ] SDK built successfully
- [ ] Tests passed
- [ ] Changelog updated

### SDK Generation - JavaScript
- [ ] Branch created: `ronniegeraghty/azsdktoolsagent-demo-2`
- [ ] SDK generated
- [ ] SDK built successfully
- [ ] Tests passed
- [ ] Changelog updated

### SDK Generation - Go
- [ ] Branch created: `ronniegeraghty/azsdktoolsagent-demo-2`
- [ ] SDK generated
- [ ] SDK built successfully
- [ ] Tests passed
- [ ] Changelog updated

---

## Notes
- This is a demo environment - all PRs should be prefixed with "DO NOT MERGE"
- No release plan will be created for this demo
