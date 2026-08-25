<!-- NOTE: This comment is for file maintainers only and is not rendered.
     Upstream alignment: 2026-06-05
     Derived from:
       - Azure REST API Guidelines (vNext) — URLs
       - ARM Wiki: api_contracts/guidelines/api_best_practices_and_design_choices.md (RPC-BestPractice-03)
       - Security analysis of Unicode/UTF-8 denylist bypass in JSON string validation
     The upstream documents always take precedence if there is a conflict. -->

# Pattern Constraint Validation (OAPI-PATTERN-ALLOWLIST)

> **Canonical rule ID:** `OAPI-PATTERN-ALLOWLIST`. When citing this
> rule in any review finding, posted PR comment, or report, use this
> exact string verbatim.

Every `pattern` constraint on a string property or parameter **MUST**
use allowlist (positive character class) syntax. Denylist (negated
character class) syntax **MUST NOT** be used as the primary
character-matching construct.

**Authoritative references:**

- [Azure REST API Guidelines — URLs](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#uniform-resource-locators-urls)
- [Azure Resource Provider Contract — Resource API Reference](https://github.com/cloud-and-ai-microsoft/resource-provider-contract/blob/master/v1.0/resource-api-reference.md)

---

## Definitions

### Allowlist Pattern (Acceptable)

A pattern where the primary character-matching construct is a
**positive character class** that explicitly states which characters
are permitted:

```
[A-Za-z0-9_.-]        ← specifies allowed characters
[a-z][a-z0-9-]*       ← specifies allowed characters
[A-Za-z][A-Za-z0-9]*  ← specifies allowed characters
```

A **negative lookahead** (`(?!...)`) used _alongside_ a positive
character class is also acceptable, because the positive class still
defines what is permitted:

```
^(?![.-])[A-Za-z0-9_.-]{1,128}$   ← acceptable: lookahead + positive class
^(?!default$)[A-Za-z][A-Za-z0-9-]{0,62}$  ← acceptable: reserved-word guard + positive class
```

### Denylist Pattern (Prohibited)

A pattern where the primary character-matching construct is a
**negated character class** (`[^...]`) that lists characters which are
_not_ allowed, with all other characters implicitly permitted:

```
[^<>*%&]       ← denylist: anything except these chars is allowed
[^<>%&:\\?/]   ← denylist: anything except these chars is allowed
[^\s]          ← denylist: anything except whitespace is allowed
```

A denylist pattern is identified by the presence of `[^...]` as the
dominant class in the expression. If the pattern is anchored
(`^...$`) and the body consists primarily of a negated class (with
optional quantifiers), it is a denylist.

---

## Why Denylist Patterns Are Problematic

JSON is encoded as UTF-8, and the regex engine operates over the full
Unicode code space. A denylist such as `[^<>%&:\\?/]` excludes only
the characters explicitly listed — every other Unicode code point
(including emoji, control characters, null bytes, newlines, and
non-Latin scripts) passes validation unchecked.

This creates a gap between what the spec permits and what the service
actually accepts, because backend validation routinely rejects such
inputs. Practical consequences:

| Input                        | Denylist `^[^<>%&:\\?/]+$` | Allowlist `^[A-Za-z0-9_.-]+$` |
| ---------------------------- | -------------------------- | ----------------------------- |
| `my-policy_v1`               | ✅ Matches                 | ✅ Matches                    |
| `my🎉policy` (emoji)         | ✅ Matches                 | ❌ Does not match             |
| `policy\x00name` (null byte) | ✅ Matches                 | ❌ Does not match             |
| `policy\tname` (tab)         | ✅ Matches                 | ❌ Does not match             |
| `политика` (Cyrillic)        | ✅ Matches                 | ❌ Does not match             |

An overly permissive spec pattern leads to:

- **SDK validation bypass** — generated client code validates against
  the pattern before sending; a denylist lets through strings the
  service will reject, causing runtime errors instead of early
  client-side failures.
- **ARM preflight bypass** — ARM static validation uses the spec
  pattern; inputs rejected by the service can pass ARM preflight.
- **Security surface expansion** — null bytes and control characters
  can cause unexpected behavior in backend systems and logging
  infrastructure.
- **Broken What-If** — resource names that the service rejects are
  accepted in What-If planning, creating noise and incorrect
  change-impact predictions.

---

## Scope

This rule applies to **all** `pattern` constraints in the
specification, without exception:

- Path parameters (e.g., `{widgetName}` in the URL path)
- Query parameters with string type
- Body string properties in request and response models
- TypeSpec `@pattern` decorator values on any `string` scalar or
  property
- TypeSpec `NamePattern` constraints in ARM resource definitions
- Parameters defined in the global `parameters` section

---

## Severity

Severity depends on whether the property or parameter is **new** (not
present in the previous API version) or **existing** (carried forward
from a prior version):

| Context                                                                                  | Severity     | Rationale                                                                                               |
| ---------------------------------------------------------------------------------------- | ------------ | ------------------------------------------------------------------------------------------------------- |
| **New** property/parameter with a denylist pattern                                       | **Blocking** | No backward-compatibility concern; use an allowlist from the start.                                     |
| **Existing** property/parameter carrying a denylist pattern forward from a prior version | **Warning**  | Changing to an allowlist may reject values that existing resources were created with (regression risk). |

### Regression Risk for Existing Properties

When an existing property already has a denylist pattern, the service
team **MUST** audit existing resources before tightening the
constraint. If any customer resource was created with a value that the
new allowlist rejects (e.g., a name containing a Unicode character
that the denylist permitted), a GET on that resource would succeed but
any PUT to update it would fail. The service team **SHOULD**:

1. Query their backend to determine whether any existing resource
   names contain characters outside the intended allowlist.
2. If no such resources exist, migrate to an allowlist immediately.
3. If such resources exist, document the migration plan and timeline.

---

## Detection Guidance

When reviewing a spec, scan every `pattern` value and apply the
following test:

1. **Strip anchors**: remove leading `^` and trailing `$`.
2. **Identify the dominant character class**: the class that
   determines which characters are matched for the bulk of the
   string.
3. **Check for negation**: if that class starts with `[^`, the
   pattern is a denylist.

**Quick heuristic**: any `pattern` value whose body contains `[^`
outside of a lookahead is a candidate for this rule. Confirm by
checking that `[^...]` is the primary matching construct rather than
an incidental exclusion inside a lookahead.

### Examples of Each Class

**Denylist (flag as `OAPI-PATTERN-ALLOWLIST` violation):**

```
^[^<>*%&:\\?.+/]*[^<>*%&:\\?.+/ ]+$
^[^<>%&:\\?/]+$
^[^\s]+$
^[^\\/]+$
^[^"]+$
```

**Allowlist (acceptable):**

```
^[A-Za-z0-9_.-]{1,128}$
^(?![.-])[A-Za-z0-9_.-]{1,128}$
^[a-z][a-z0-9-]{0,62}$
^[A-Za-z][A-Za-z0-9]{0,127}$
^[a-zA-Z0-9][a-zA-Z0-9-_.]{0,259}$
^(?!default$)[A-Za-z][A-Za-z0-9-]{0,62}$
```

---

## Required Action

### For New Properties/Parameters (Blocking)

Replace the denylist pattern with an allowlist derived from the
service's actual server-side validation rules.

1. **Determine the exact allowlist** from the service team's
   validation code. Do not guess; the spec must reflect reality.
2. **Include a length constraint** (e.g., `{1,64}`) to prevent
   excessively long names.
3. **Guard leading characters** if the service rejects names starting
   with `.`, `-`, or a digit (e.g., `^(?![.-])...`).
4. **If the exact allowlist is unknown**, the service team **MUST**
   determine it from their validation code before the spec can
   proceed. Do not accept "we'll figure it out later."

### For Existing Properties/Parameters (Warning)

Flag the denylist as a warning with a recommendation to migrate:

> ⚠️ **OAPI-PATTERN-ALLOWLIST (Warning):** The `pattern` constraint
> `^[^<>%&:\\?/]+$` on `{propertyName}` uses a denylist (negated
> character class `[^...]`). Because JSON is UTF-8, this permits
> Unicode characters (emoji, control characters, non-Latin scripts)
> that the service almost certainly rejects. This property existed in
> a prior API version, so changing the pattern carries regression
> risk. The service team should audit existing resources and migrate
> to an allowlist (e.g., `^[A-Za-z0-9_.-]{1,128}$`) when safe to
> do so.

---

## Fix Examples

### OpenAPI JSON — Path Parameter

**Before (denylist — violation):**

```json
"WidgetNameParameter": {
  "name": "widgetName",
  "in": "path",
  "required": true,
  "type": "string",
  "description": "The name of the widget.",
  "pattern": "^[^<>%&:\\?/]+$",
  "maxLength": 260
}
```

**After (allowlist — compliant):**

```json
"WidgetNameParameter": {
  "name": "widgetName",
  "in": "path",
  "required": true,
  "type": "string",
  "description": "The name of the widget.",
  "pattern": "^[a-zA-Z0-9][a-zA-Z0-9-_.]{0,259}$",
  "maxLength": 260
}
```

### OpenAPI JSON — Body Property

**Before (denylist — violation):**

```json
"displayName": {
  "type": "string",
  "description": "The display name of the resource.",
  "pattern": "^[^\\s][^\"']{0,254}[^\\s]$"
}
```

**After (allowlist — compliant):**

```json
"displayName": {
  "type": "string",
  "description": "The display name of the resource.",
  "pattern": "^[A-Za-z0-9][A-Za-z0-9 _.-]{0,253}[A-Za-z0-9]$",
  "maxLength": 255
}
```

### TypeSpec — `@pattern` Decorator

**Before (denylist — violation):**

```typespec
@pattern("^[^<>%&:\\?/]+$")
@maxLength(260)
name: string;
```

**After (allowlist — compliant):**

```typespec
@pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{0,259}$")
@maxLength(260)
name: string;
```

### TypeSpec — `NamePattern` in ARM Resource Definition

**Before (denylist — violation):**

```typespec
@segment("widgets")
model Widget is TrackedResource<WidgetProperties> {
  @key("widgetName")
  @pattern("^[^<>%&:\\?/]*$")
  name: string;
}
```

**After (allowlist — compliant):**

```typespec
@segment("widgets")
model Widget is TrackedResource<WidgetProperties> {
  @key("widgetName")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{0,259}$")
  @maxLength(260)
  name: string;
}
```

---

## Automated Linter Coverage

> ❌ **No automated linter rule** currently exists for this check in
> `@azure-tools/typespec-azure-core`, `@microsoft.azure/openapi-validator`,
> or `@azure-tools/typespec-azure-resource-manager`.
>
> This rule is enforced by the ARM API Reviewer agent during manual
> and automated code review. A follow-up issue should be filed to add
> an automated linter rule to `@azure-tools/typespec-azure-core` and
> the OpenAPI validator packages.

The existing `ResourceNameRestriction` linter rule (`--`) validates
that resource name parameters _have_ a pattern constraint, but does
not validate whether the pattern is an allowlist or a denylist.
(Instruction coverage: `arm-api-review.instructions.md` §15.7,
PREFLIGHT-005.)
