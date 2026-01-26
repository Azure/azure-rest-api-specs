# SKU Support for HealthDataAIServices DeidService - Progress Tracker

## Overview
Adding SKU support to the HealthDataAIServices DeidService with a new API version `2026-02-01-preview`.

**Date Started:** January 25, 2026  
**Branch:** `ronniegeraghty/azsdktoolsagent-demo`

---

## Phase 1: TypeSpec Changes

| Task | Status | Notes |
|------|--------|-------|
| Find HealthDataAIServices TypeSpec project | ✅ Complete | Located at `specification/healthdataaiservices/HealthDataAIServices.Management/` |
| Add new API version `2026-02-01-preview` | ✅ Complete | Added to `Versions` enum with `@armCommonTypesVersion` |
| Create `SkuTier` union | ✅ Complete | Free, Basic, Standard options |
| Create `Sku` model | ✅ Complete | Properties: name, tier, capacity |
| Add `sku` property to `DeidService` | ✅ Complete | Marked with `@added(Versions.v2026_02_01_preview)` |
| Add `sku` property to `DeidUpdate` | ✅ Complete | For PATCH operations |

---

## Phase 2: Validation & API Spec PR

| Task | Status | Notes |
|------|--------|-------|
| Validate TypeSpec compilation | ✅ Complete | Passed successfully |
| Commit changes | ⏳ Pending | |
| Push to remote | ⏳ Pending | |
| Create API spec PR | ⏳ Pending | Title prefix: "DO NOT MERGE" |

---

## Phase 3: SDK Generation (Local)

| Language | Branch Created | SDK Generated | Build Status | Notes |
|----------|----------------|---------------|--------------|-------|
| .NET | ⏳ Pending | ⏳ Pending | ⏳ Pending | `azure-sdk-for-net` |
| Python | ⏳ Pending | ⏳ Pending | ⏳ Pending | `azure-sdk-for-python` |
| Java | ⏳ Pending | ⏳ Pending | ⏳ Pending | `azure-sdk-for-java` |
| JavaScript | ⏳ Pending | ⏳ Pending | ⏳ Pending | `azure-sdk-for-js` |
| Go | ⏳ Pending | ⏳ Pending | ⏳ Pending | `azure-sdk-for-go` |

---

## TypeSpec Changes Summary

### New Types Added

```typespec
// SkuTier union - pricing tier options
union SkuTier {
  string,
  Free: "Free",
  Basic: "Basic", 
  Standard: "Standard",
}

// Sku model - SKU configuration
model Sku {
  name: string;
  tier?: SkuTier;
  capacity?: int32;
}
```

### Modified Types

1. **DeidService** - Added `sku?: Sku` property (versioned for 2026-02-01-preview)
2. **DeidUpdate** - Added `sku?: Sku` property for PATCH operations

---

## Links

- **TypeSpec Project:** `specification/healthdataaiservices/HealthDataAIServices.Management/`
- **API Spec PR:** _TBD_
- **SDK PRs:**
  - .NET: _TBD_
  - Python: _TBD_
  - Java: _TBD_
  - JavaScript: _TBD_
  - Go: _TBD_

---

## Notes

- This is a demo environment - all PRs prefixed with "DO NOT MERGE"
- Release plan creation skipped per demo requirements
