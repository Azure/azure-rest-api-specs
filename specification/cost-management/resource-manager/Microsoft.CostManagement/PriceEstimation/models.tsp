using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.CostManagement;

/** Supported decoded kinds. Clients must not submit unrecognized kinds. */
@added(Versions.v2026_10_01_preview)
union EstimateValueKind {
  string,

  /** A JSON string. */
  String: "string",

  /** A finite JSON number, not a numeric string. */
  Number: "number",

  /** A native JSON boolean. */
  Boolean: "boolean",

  /** Named typed members. */
  Object: "object",

  /** Ordered typed items. */
  Array: "array",
}

/** Resolved pricing configurations and explicitly supplied usage for a normalized month. */
@added(Versions.v2026_10_01_preview)
model EstimateContent {
  /** Charge-once entries. Position correlates results; no customer identifiers are accepted. */
  @minItems(1)
  @maxItems(100)
  @identifiers(#[])
  resources: EstimateResourceInput[];
}

/** One proposed charge entry validated against server-owned metadata. */
@added(Versions.v2026_10_01_preview)
model EstimateResourceInput {
  /** Supported resource type, matched case-insensitively. */
  @minLength(1)
  @maxLength(256)
  resourceType: string;

  /** Supported source resource API version; the service never evaluates that resource or deploys it. */
  @minLength(1)
  @maxLength(32)
  resourceApiVersion: string;

  /** Two named object inputs: resource (an allowlisted subset of the native ARM resource) and usage (consumption and purchase assumptions). Omitted values are completed only by applicable advertised defaults. */
  @maxItems(128)
  @identifiers(#["name"])
  inputs: EstimateNamedValue[];
}

/** A case-sensitive allowlisted business name and an explicitly typed value. */
@added(Versions.v2026_10_01_preview)
model EstimateNamedValue {
  /** Unique sibling business name, not a customer resource name or a path expression. */
  @minLength(1)
  @maxLength(128)
  name: string;

  /** Typed value. Null and coercion from another JSON kind are not accepted. */
  value: EstimateValue;
}

/**
 * Base for the five typed variants. The service rejects unknown kinds, unexpected
 * properties, duplicate JSON members and malformed variants. A missing value is
 * represented by omission of its named entry, not by null or a sentinel.
 */
@added(Versions.v2026_10_01_preview)
@discriminator("kind")
model EstimateValue {
  /** Exact discriminator selecting a supported typed variant. */
  kind: EstimateValueKind;
}

/** A resolved string pricing value; not a template, expression, script or secret. */
@added(Versions.v2026_10_01_preview)
model EstimateStringValue extends EstimateValue {
  /** String variant discriminator. */
  kind: "string";

  /** Text accepted only when permitted by the selected input definition. */
  @maxLength(1024)
  value: string;
}

/** A finite JSON number with at most six fractional decimal places; never string-encoded. */
@added(Versions.v2026_10_01_preview)
model EstimateNumberValue extends EstimateValue {
  /** Number variant discriminator. */
  kind: "number";

  /** Parsed using decimal arithmetic. Excess precision and out-of-range values are rejected, not rounded or coerced. */
  @minValue(-1000000000000)
  @maxValue(1000000000000)
  value: float64;
}

/** A native JSON true or false pricing value. */
@added(Versions.v2026_10_01_preview)
model EstimateBooleanValue extends EstimateValue {
  /** Boolean variant discriminator. */
  kind: "boolean";

  /** Explicit boolean; omission is distinct from false. */
  value: boolean;
}

/** A complete object represented by allowlisted named typed members. */
@added(Versions.v2026_10_01_preview)
model EstimateObjectValue extends EstimateValue {
  /** Object variant discriminator. */
  kind: "object";

  /** Unique, case-sensitive member names. Empty members is an explicit empty object, not an omitted input. */
  @maxItems(128)
  @identifiers(#["name"])
  members: EstimateNamedValue[];
}

/** A complete ordered array; individual elements cannot be supplied through separate paths. */
@added(Versions.v2026_10_01_preview)
model EstimateArrayValue extends EstimateValue {
  /** Array variant discriminator. */
  kind: "array";

  /** Explicit items, recursively validated. Empty items is distinct from an omitted array. */
  @maxItems(1024)
  @identifiers(#[])
  items: EstimateValue[];
}

/** Computed costs for submitted pricing inputs, not an ARM resource or invoice. */
@added(Versions.v2026_10_01_preview)
model EstimateResult {
  /** Subscription billing currency for every amount; never a caller-selected currency or silent fallback. */
  @visibility(Lifecycle.Read)
  @minLength(3)
  @maxLength(3)
  currency: string;

  /** UTC instant used to select applicable prices. This is not a future price guarantee. */
  @visibility(Lifecycle.Read)
  pricingAsOf: utcDateTime;

  /** Completeness applies only to submitted inputs; callers separately report template preparation and coverage gaps. */
  @visibility(Lifecycle.Read)
  coverage: "SubmittedPricingInputs";

  /** Exactly one result per input, in the same order. */
  @visibility(Lifecycle.Read)
  @minItems(1)
  @maxItems(100)
  @identifiers(#["inputIndex"])
  results: EstimateResourceResult[];

  /** Independent recurring and upfront totals. */
  @visibility(Lifecycle.Read)
  totals: EstimateTotals;

  /** Request-wide assumptions; never raw input values or customer identifiers. */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  assumptions: EstimateDiagnostic[];
}

/** Cost breakdown and explicit gaps for one input entry. */
@added(Versions.v2026_10_01_preview)
model EstimateResourceResult {
  /** Zero-based input position; not a customer resource identifier. */
  @visibility(Lifecycle.Read)
  @minValue(0)
  @maxValue(99)
  inputIndex: int32;

  /** The validated, default-completed configuration that was priced. Absent only when a catalog failure prevented complete validation. */
  @visibility(Lifecycle.Read)
  configuration?: EstimateEffectiveConfiguration;

  /** Known and unknown recurring costs for this entry. */
  @visibility(Lifecycle.Read)
  monthly: EstimateCostSummary;

  /** Known and unknown upfront charges, never included in monthly. */
  @visibility(Lifecycle.Read)
  upfront: EstimateCostSummary;

  /** Component breakdown, including components whose cost could not be determined. */
  @visibility(Lifecycle.Read)
  @identifiers(#["component"])
  components: EstimateComponentResult[];

  /** Reasons for incomplete coverage or costs. Nonempty whenever either summary is incomplete. */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  issues: EstimateDiagnostic[];

  /** Defaults and other assumptions actually applied to this entry. */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  assumptions: EstimateDiagnostic[];
}

/** The configuration actually priced for one entry, for display and revision. */
@added(Versions.v2026_10_01_preview)
model EstimateEffectiveConfiguration {
  /** The supported resource type, in its canonical spelling. */
  @visibility(Lifecycle.Read)
  resourceType: string;

  /** The supported source resource API version. */
  @visibility(Lifecycle.Read)
  resourceApiVersion: string;

  /** Decoded resource and usage objects after canonicalization and default completion. Resubmit changes in the typed input encoding. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "The decoded configuration is resource-type specific; its schema is published per resource type and API version by the pricing profile discovery service, and it mirrors the typed inputs the caller submitted."
  @visibility(Lifecycle.Read)
  inputs: Record<unknown>;

  /** JSON Pointers of configuration defaults the server applied to omitted inputs. */
  @visibility(Lifecycle.Read)
  defaultedFields: string[];

  /** JSON Pointers of usage quantities the caller omitted and the server assumed, such as /usage/storedGB. A non-empty list means the price rests on quantities the caller did not state. */
  @visibility(Lifecycle.Read)
  assumedUsageFields: string[];
}

/** A server-defined billable component, such as compute, licensing, disk capacity or bandwidth. */
@added(Versions.v2026_10_01_preview)
model EstimateComponentResult {
  /** Stable business component name, unique within the entry. */
  @visibility(Lifecycle.Read)
  component: string;

  /** Resolved internal pricing meter identifiers, distinct from customer resource IDs. Absent when unresolved or not needed. */
  @visibility(Lifecycle.Read)
  meterIds?: string[];

  /** Component's recurring monthly cost. */
  @visibility(Lifecycle.Read)
  monthly: EstimateCostSummary;

  /** Component's upfront charge. A known non-applicable charge is Complete with amount zero. */
  @visibility(Lifecycle.Read)
  upfront: EstimateCostSummary;
}

/** Separately aggregated monthly and upfront costs across submitted entries. */
@added(Versions.v2026_10_01_preview)
model EstimateTotals {
  /** Recurring monthly aggregate; an upfront payment is never included. */
  @visibility(Lifecycle.Read)
  monthly: EstimateCostSummary;

  /** Upfront aggregate, without amortization. */
  @visibility(Lifecycle.Read)
  upfront: EstimateCostSummary;
}

/**
 * A summary for exactly one charge period. Complete requires amount and forbids
 * knownAmount. Partial requires knownAmount and forbids amount. Unavailable omits
 * both. A known zero is Complete with amount zero; it is never an unknown cost.
 * Partial knownAmount may be zero only when at least one underlying cost is known.
 * Amounts are JSON numbers, not strings. Decimal calculations retain intermediate
 * precision. Component amounts are rounded once to six fractional decimal places,
 * midpoint away from zero; entry and request summaries sum reported components.
 * A rounded-zero amount is not a declaration that the underlying meter is free.
 */
@added(Versions.v2026_10_01_preview)
model EstimateCostSummary {
  /** Independent completeness of this monthly or upfront summary. */
  @visibility(Lifecycle.Read)
  status: EstimateCostStatus;

  /** Complete amount only. */
  @visibility(Lifecycle.Read)
  @minValue(0)
  @maxValue(1000000000000)
  amount?: float64;

  /** Sum of known costs only, not a total or an upper bound. Present only for Partial. */
  @visibility(Lifecycle.Read)
  @minValue(0)
  @maxValue(1000000000000)
  knownAmount?: float64;
}

/** Completeness of one charge period. Clients must not treat unknown statuses as Complete. */
@added(Versions.v2026_10_01_preview)
union EstimateCostStatus {
  string,

  /** All applicable charges are known, including explicit free or non-applicable charges. */
  Complete: "Complete",

  /** Some applicable charges are known and others are not. */
  Partial: "Partial",

  /** No applicable cost could be determined. */
  Unavailable: "Unavailable",
}

/** A safe explanation of a pricing gap or an applied assumption. */
@added(Versions.v2026_10_01_preview)
model EstimateDiagnostic {
  /** Machine-readable code, such as RateUnavailable, AllowanceContextRequired or InputCanonicalized. */
  @visibility(Lifecycle.Read)
  code: string;

  /** Explanation without input values, customer information or tokens. */
  @visibility(Lifecycle.Read)
  message: string;

  /** Optional RFC 6901 request location, using entry positions and business field names only. */
  @visibility(Lifecycle.Read)
  target?: string;

  /** Affected business component name when the issue is component-specific. */
  @visibility(Lifecycle.Read)
  component?: string;
}
