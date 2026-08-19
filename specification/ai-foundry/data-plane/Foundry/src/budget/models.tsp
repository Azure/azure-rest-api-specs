using TypeSpec.Http;
using TypeSpec.Rest;

namespace Azure.AI.Projects;

/** The dimension used to select budget usage counters. */
union BudgetUsageDimension {
  /** Counters keyed by Foundry agent identifier. */
  Agent: "agent",

  /** Counters keyed by identity object identifier. */
  Identity: "identity",

  /** Counters keyed by session identifier. */
  Session: "session",

  /** Counters keyed by Foundry project identifier. */
  Project: "project",
}

/** The unit used for budget values. */
union BudgetUnit {
  string,

  /** Budget values expressed in United States dollars. */
  Usd: "usd",
}

/** The recurrence period for budget evaluation. */
union BudgetPeriod {
  string,

  /** A calendar-aligned minute. */
  Minute: "minute",

  /** A calendar-aligned hour. */
  Hour: "hour",

  /** A calendar-aligned day. */
  Day: "day",

  /** A calendar-aligned week. */
  Week: "week",

  /** A calendar-aligned month. */
  Month: "month",
}

/** The availability state of a budget counter key. */
union BudgetCounterKeyState {
  string,

  /** The row contains a durable counter measurement. */
  Active: "active",

  /** The rule's window is not durably persisted. */
  Unavailable: "unavailable",
}

/** A component of a potentially composite budget counter key. */
model BudgetCounterKeyPart {
  /** The counter key dimension type. */
  type: string;

  /** The canonical attribute used to resolve the counter key. */
  attribute: string;

  /** The resolved value of the counter key attribute. */
  value: string;
}

/** The consumption recorded for a budget rule, counter key, and window. */
model BudgetUsage {
  /** The stable name of the budget policy rule. */
  ruleName: string;

  /** The resolved counter key associated with this usage. */
  counterKey: BudgetCounterKeyPart[];

  /** The unit used by the consumed, limit, and remaining values. */
  unit: BudgetUnit;

  /** The reconciled consumption at the response watermark, if available. */
  @minValue(0)
  consumed?: float64;

  /** The configured budget ceiling for this counter and window. */
  @minValue(0)
  limit: float64;

  /** The non-negative difference between the limit and consumed values, if available. */
  @minValue(0)
  remaining?: float64;

  /** Whether the budget replenishes on a recurring window. */
  recurring: boolean;

  /** The calendar-aligned period used by the budget rule. */
  period: BudgetPeriod;

  /** The inclusive UTC start of the active window, if available. */
  periodStart?: utcDateTime;

  /** The exclusive UTC end of the active window, if the budget recurs. */
  periodEnd?: utcDateTime;

  /** Indicates whether this row contains a durable counter measurement. */
  counterKeyState: BudgetCounterKeyState;
}

/** The parameters for listing usage for a budget policy. */
model BudgetUsageListRequest {
  /** The stable name of the budget policy under the owning account. */
  @path
  policyName: string;

  /** The dimension used to select budget usage counters. */
  @query
  dimension: BudgetUsageDimension;

  /** A specific resolved value of the selected dimension. If omitted, the response reports every value of dimension that has consumption. */
  @query
  value?: string;

  /** The caller-accepted maximum number of rows to return across all pages. If omitted, the service defaults to returning all rows. */
  @query
  @minValue(1)
  @maxValue(1000)
  top?: int32;

  /** The maximum number of rows to return in one page. If omitted, the service defaults to 100. */
  @query
  @minValue(1)
  @maxValue(1000)
  maxpagesize?: int32 = 100;

  /** The opaque continuation token from a previous response. */
  @query
  skipToken?: string;
}

/** A page of budget policy usage. */
model BudgetUsageListResult {
  /** The canonical Azure resource identifier of the budget policy. */
  policyId: string;

  /** The oldest UTC watermark represented by the usage rows. */
  asOf: utcDateTime;

  /** The maximum documented lag of this view, in seconds. */
  @minValue(duration.fromISO("PT0S"))
  @encode(DurationKnownEncoding.seconds, int32)
  stalenessBoundSeconds: duration;

  /** The budget usage rows in this page. */
  @pageItems
  value: BudgetUsage[];

  /** The path-relative link to the next page of results. */
  @nextLink
  nextLink?: string;
}
