# Current Status: ARM Swagger Equivalency Checker

**Last Updated**: 2025-01-13

## Summary

The semantic equivalency checker has been successfully migrated from data-plane to ARM resource-manager orientation. The tool now compares hand-authored ARM swagger against TSP-compiled ARM swagger.

### Test Results (Latest Run)

Comparison of Search Service ARM swagger:
- **148 differences found** (down from 156 after global parameter resolution)
- **107 parameter differences** (mostly false positives due to external common-types refs)
- **41 definition differences** (mostly inline vs ref differences)

## ✅ Completed Tasks

1. **Configuration Updated**
   - Changed from 4-file data-plane structure to flexible ARM structure
   - `hand_authored.files: Dict[str, str]` supports any number of ARM files

2. **Data-Plane Code Removed**
   - Cleared `known_def_match.py` (33 → 0 renames)
   - Cleared `known_fp_def.py` (80+ → 0 definitions)
   - Removed 8 data-plane false positive matchers
   - Removed hardcoded swagger source detection patterns

3. **Common-Types Pattern Updated**
   - Changed from `data-plane/2020-06-30/` to `resource-management/v6/`

4. **Global Parameter Resolution Added**
   - New `resolve_global_parameters()` function in canonicalize.py
   - Inlines local `#/parameters/*` references before comparison
   - **Impact**: Resolves references like `#/parameters/ApiVersionParameter` to inline definitions

5. **Bug Fixes**
   - Fixed `frozenset.discard()` error in compare.py (converted to set first)

## ⚠️ Known Issues & Root Causes

### Issue #1: External Common-Types Parameter References (~96 differences)

**Root Cause**: TSP uses external `$ref` to common-types while hand-authored uses local global params.

**Hand-authored swagger**:
```json
{
  "parameters": {
    "ApiVersionParameter": {
      "name": "api-version",
      "in": "query",
      "required": true,
      "type": "string"
    }
  },
  "paths": {
    "/some/path": {
      "get": {
        "parameters": [
          { "$ref": "#/parameters/ApiVersionParameter" }  // LOCAL reference
        ]
      }
    }
  }
}
```

**TSP-compiled swagger**:
```json
{
  "paths": {
    "/some/path": {
      "get": {
        "parameters": [
          {  // EXTERNAL reference to common-types
            "$ref": "../../../../../../common-types/resource-management/v6/types.json#/parameters/ApiVersionParameter"
          }
        ]
      }
    }
  }
}
```

**Current Solution**: `resolve_global_parameters()` only resolves local `#/parameters/*` refs, not external refs.

**Remaining Work**:
- Option A: Load external common-types files and inline those refs too
- Option B: Add false positive filter to ignore parameter differences where TSP has external `$ref` and hand-authored has inline param with matching schema

**Why ~96 differences?**
- 21 operations × ~4-5 standard ARM params per operation = ~96 parameter diffs
- Standard ARM params: `api-version`, `subscriptionId`, `resourceGroupName`, `searchServiceName`, plus operation-specific params

### Issue #2: Inline vs Reference Definitions (~29 extra definitions)

**Root Cause**: TSP creates separate type definitions for enums/unions/nested objects, hand-authored inlines them.

**Examples**:

**Enum inline vs ref**:
```json
// Hand-authored (inline)
{
  "type": "string",
  "enum": ["value1", "value2", "value3"]
}

// TSP (separate definition + ref)
{
  "$ref": "#/definitions/MyEnumType"
}
// + definitions section:
{
  "MyEnumType": {
    "type": "string",
    "enum": ["value1", "value2", "value3"]
  }
}
```

**Nested object inline vs ref**:
```json
// Hand-authored (inline nested object)
{
  "PrivateEndpointConnectionProperties": {
    "type": "object",
    "properties": {
      "privateEndpoint": {
        "type": "object",
        "properties": {
          "id": { "type": "string" }
        }
      }
    }
  }
}

// TSP (separate definition for nested object)
{
  "PrivateEndpointConnectionProperties": {
    "type": "object",
    "properties": {
      "privateEndpoint": {
        "$ref": "#/definitions/PrivateEndpointConnectionPropertiesPrivateEndpoint"
      }
    }
  },
  "PrivateEndpointConnectionPropertiesPrivateEndpoint": {
    "type": "object",
    "properties": {
      "id": { "type": "string" }
    }
  }
}
```

**Impact**:
- 29 extra definitions in TSP
- Property type mismatches (inline vs ref)
- Definition comparison shows "schema structure differs"

**Potential Solutions**:
1. **Definition Inlining**: Recursively inline all `$ref` definitions before comparison
2. **Smart Schema Comparison**: Treat inline enum as equivalent to ref'd enum with same values
3. **Accept as Expected**: Mark these as false positives since they're semantically equivalent

### Issue #3: Empty Parameter Names (, query)

**Status**: ⚠️ **UNDER INVESTIGATION**

**Symptom**: Comparison shows parameters with empty names like `, query` in TSP.

**Example from logs**:
```
Extra parameter in tsp: , query
Missing parameter in tsp: api-version, query
```

**Hypothesis**: When TSP has unresolved `$ref` to external common-types, the comparison logic extracts `(name, location)` tuple but `name` is empty because the `$ref` object doesn't have a `name` field.

**Code Location**: `utils.py` line ~260
```python
hand_params = {
    (p.get("name", ""), p.get("in", "query")): p  # <-- Empty name for $ref objects!
    for p in hand_op.get("parameters", [])
}
```

**Fix**: Filter out `$ref` objects before building parameter dict, or resolve all `$ref` first.

## 📊 Difference Breakdown (148 total)

### Parameter Differences (107)
- **71** Missing in TSP (hand-authored has inline, TSP has unresolved external $ref)
- **25** Extra in TSP (empty-named parameters from unresolved $refs)
- **2** Parameter type/constraint mismatches
- **9** Missing global parameter in TSP

### Definition Differences (41)
- **29** Extra definitions in TSP (enums, nested objects extracted)
- **8** Schema structure differs (inline vs ref)
- **4** Property type mismatches (inline vs ref for enums)

### Other Differences
- **3** Path case differences (`Microsoft.Search` vs `microsoft.Search`)
- **2** Response header differences (LRO headers: `Location`, `Retry-After`)
- **1** Response status code difference (202 for async operations)

## 🎯 Recommended Next Steps

### Priority 1: Fix Empty Parameter Names
1. Update parameter extraction in `utils.py` to skip or resolve `$ref` objects
2. Or: Add `resolve_external_refs()` function to load and inline common-types params

### Priority 2: Decide on Definition Comparison Strategy
**Option A**: Inline all definitions before comparison
- Pros: Truly semantic comparison
- Cons: Complex implementation, loses type name information

**Option B**: Enhanced schema comparison to handle inline-vs-ref
- Pros: Simpler, preserves structure
- Cons: Requires many special cases

**Option C**: Mark as expected false positives
- Pros: Quick, acknowledges TSP pattern
- Cons: Clutters diff report

**Recommendation**: **Option B** - Add schema equivalence logic:
```python
def schemas_equivalent(schema1, schema2, definitions1, definitions2):
    # If one is $ref and other is inline, resolve and compare
    # If both inline enums, compare enum values
    # etc.
```

### Priority 3: False Positive Filters
Add filters for known benign differences:
1. LRO response headers (`Location`, `Retry-After`)
2. Path case differences for ARM providers
3. Extra 202 status codes for async operations
4. `readOnly` flag differences

## 📈 Progress Metrics

| Metric | Before | After Global Param Resolution | Target |
|--------|--------|-------------------------------|--------|
| Total Differences | 156 | 148 | <10 |
| Parameter Diffs | 107 | 107 | 0 |
| Definition Diffs | 45 | 41 | <5 |
| False Positive % | ~90% | ~85% | <10% |

**Note**: Parameter diffs stayed at 107 because external common-types refs are still unresolved.

## 🧪 Testing Approach

Current manual test:
```bash
cd E:\repos\azure-rest-api-specs\specification\search\swagger_equiv_rp\semantic_equiv
python cli.py
# Check .output/diff_v2_*.xlsx
```

**TODO**: Create automated regression tests
- Load test swagger pairs
- Assert expected difference counts
- Verify false positive filtering works

## 📚 References

- Hand-authored: `specification/search/resource-manager/Microsoft.Search/Search/stable/2025-05-01/rp-2025-05-01-search.json`
- TSP-compiled: `specification/search/resource-manager/Microsoft.Search/stable/2025-05-01/search.json`
- Common-types: `specification/common-types/resource-management/v6/types.json`

---

## Questions for Review

1. **Should we inline external common-types parameters or filter them as false positives?**
   - Inlining is more correct but requires loading additional files
   - Filtering is simpler but hides the comparison logic

2. **How should we handle TSP's pattern of extracting enums/nested objects?**
   - This seems to be TSP's intended code generation optimization
   - Should we consider this semantically equivalent?

3. **What's the acceptable false positive rate?**
   - Currently ~85% of differences are false positives
   - Is <10% realistic or should we aim for 0%?
