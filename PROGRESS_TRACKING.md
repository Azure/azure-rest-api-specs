# HealthDataAIServices DeidService SKU Support - Progress Tracking

## Summary
Adding SKU support to the HealthDataAIServices DeidService with a new API version `2026-02-01-preview`.

## TypeSpec Changes

| Task | Status | Notes |
|------|--------|-------|
| Add new API version `2026-02-01-preview` | ✅ Complete | Added to `Versions` enum in main.tsp |
| Create `SkuTier` union | ✅ Complete | Free, Basic, Standard options |
| Create `Sku` model | ✅ Complete | name, tier, capacity properties |
| Add `sku` to `DeidService` | ✅ Complete | Marked with `@added(Versions.v2026_02_01_preview)` |
| Add `sku` to `DeidUpdate` | ✅ Complete | For PATCH operations |
| Compile and validate TypeSpec | ✅ Complete | Validation succeeded |
| Commit and push changes | ⏳ Pending | |

## API Spec PR

| Task | Status | Notes |
|------|--------|-------|
| Create API spec PR | ⏳ Pending | Branch: `timovv/azsdktoolsagent-demo` |

## SDK Generation

| Language | Status | Branch | Package Path | Notes |
|----------|--------|--------|--------------|-------|
| .NET | ⏳ Pending | `timovv/azsdktoolsagent-demo` | sdk/healthdataaiservices/Azure.ResourceManager.HealthDataAIServices | |
| Python | ⏳ Pending | `timovv/azsdktoolsagent-demo` | sdk/healthdataaiservices/azure-mgmt-healthdataaiservices | |
| Java | ⏳ Pending | `timovv/azsdktoolsagent-demo` | sdk/healthdataaiservices/azure-resourcemanager-healthdataaiservices | |
| JavaScript | ⏳ Pending | `timovv/azsdktoolsagent-demo` | sdk/healthdataaiservices/arm-healthdataaiservices | |
| Go | ⏳ Pending | `timovv/azsdktoolsagent-demo` | sdk/resourcemanager/healthdataaiservices/armhealthdataaiservices | |

## Files Modified

- `/specification/healthdataaiservices/HealthDataAIServices.Management/main.tsp`

## Changes Made

### New API Version
```typespec
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
@doc("The 2026-02-01-preview version.")
v2026_02_01_preview: "2026-02-01-preview",
```

### SkuTier Union
```typespec
@doc("The tier of the SKU.")
@added(Versions.v2026_02_01_preview)
union SkuTier {
  string,
  Free: "Free",
  Basic: "Basic",
  Standard: "Standard",
}
```

### Sku Model
```typespec
@doc("The SKU for the DeidService resource.")
@added(Versions.v2026_02_01_preview)
model Sku {
  @doc("The name of the SKU, e.g. 'F0', 'S1'.")
  name: string;

  @doc("The tier of the SKU.")
  tier?: SkuTier;

  @doc("The capacity of the SKU.")
  capacity?: int32;
}
```

### DeidService SKU Property
```typespec
@doc("The SKU for the DeidService resource.")
@added(Versions.v2026_02_01_preview)
sku?: Sku;
```

### DeidUpdate SKU Property
```typespec
/** The SKU for the DeidService resource. */
@added(Versions.v2026_02_01_preview)
sku?: Sku;
```
