import "@typespec/http";
import "../common/models.tsp";

using TypeSpec.Http;

namespace Azure.AI.Projects;

/** A dimension used to partition budget consumption. */
union BudgetUsageDimension {
  string,

  /** Consumption attributed to an agent. */
  agent: "agent",

  /** Consumption attributed to an identity. */
  identity: "identity",

  /** Consumption attributed to a session. */
  session: "session",

  /** Consumption attributed to a project. */
  project: "project",
}

/** The unit in which budget consumption is measured. */
union BudgetUsageUnit {
  string,

  /** Consumption measured in United States dollars. */
  usd: "usd",
}

/** The calendar-aligned period for a recurring budget counter. */
union BudgetUsagePeriod {
  string,

  /** A one-minute period. */
  minute: "minute",

  /** A one-hour period. */
  hour: "hour",

  /** A one-day period. */
  day: "day",

  /** A one-week period. */
  week: "week",

  /** A one-month period. */
  month: "month",
}

/** The availability state of a budget counter. */
union BudgetCounterKeyState {
  string,

  /** The counter contains a current consumption measurement. */
  active: "active",

  /** The counter cannot be read from durable storage. */
  unavailable: "unavailable",
}

/** A resolved dimension value that identifies a budget counter. */
model BudgetCounterKey {
  /** The semantic type of the resolved dimension. */
  type: BudgetUsageDimension;

  /** The canonical attribution-context path used to resolve the dimension value. */
  attribute: string;

  /** The resolved value of the dimension. */
  value: string;
}

/** Current consumption for one budget policy rule, counter key, and window. */
model BudgetUsage {
  /** The stable name of the budget policy rule. */
  ruleName: string;

  /** The resolved dimensions that identify the counter. */
  @minItems(1)
  counterKey: BudgetCounterKey[];

  /** The unit in which the limit and consumption values are measured. */
  unit: BudgetUsageUnit;

  /** The reconciled consumption at the response watermark. Omitted when the counter is not durably available. */
  @minValue(0)
  consumed?: float64;

  /** The rule ceiling for this counter and window. */
  @minValueExclusive(0)
  limit: float64;

  /** The non-negative difference between the limit and consumed amount. Omitted when consumption is unavailable. */
  @minValue(0)
  remaining?: float64;

  /** Whether the budget replenishes at the start of each period. */
  recurring: boolean;

  /** The calendar-aligned period for the budget counter. */
  period: BudgetUsagePeriod;

  /** The inclusive UTC start of the current counter window, if durably available. */
  periodStart?: utcDateTime;

  /** The exclusive UTC end of the current recurring counter window. Omitted for non-recurring budgets. */
  periodEnd?: utcDateTime;

  /** The availability state of the counter measurement. */
  counterKeyState: BudgetCounterKeyState;
}

/** The current consumption view for a budget policy. */
model BudgetUsageResponse {
  /** The canonical Azure resource identifier of the budget policy. */
  policyId: string;

  /** The oldest UTC watermark represented by the returned counters. */
  asOf: utcDateTime;

  /** The maximum documented lag, in seconds, between completed usage and this view. */
  @minValue(0)
  stalenessBoundSeconds: int32;

  /** The current budget consumption rows. */
  @pageItems
  value: BudgetUsage[];

  /** The URL to retrieve the next page, if additional rows are available. */
  @nextLink
  nextLink?: url;
}

/** Parameters for retrieving current budget policy consumption. */
model BudgetUsageRequest {
  /** The stable name of the budget policy under the account identified by the request host. */
  @path
  policyName: string;

  /** The counter-key dimension to query. The policy must contain a rule keyed on this dimension. */
  @query
  dimension: BudgetUsageDimension;

  /** A specific resolved value of the requested dimension. When omitted, all recorded values are returned. */
  @query
  value?: string;

  /** The maximum total number of rows to return across all pages. Required for a session query that omits value. */
  @query
  @minValue(1)
  @maxValue(1000)
  top?: int32;

  /** The maximum number of rows to return per page. The service defaults to 100. */
  @query("maxpagesize")
  @minValue(1)
  @maxValue(1000)
  maxPageSize?: int32 = 100;

  /** An opaque, time-limited continuation token that is bound to the query that produced it. */
  @query
  @continuationToken
  skipToken?: string;
}

/** An error response from a budget usage request. */
@error
model BudgetUsageErrorResponse {
  /** The error details. */
  error: ApiError;

  /** The recommended number of seconds to wait before retrying a temporarily unavailable usage store. */
  @header("Retry-After")
  @minValue(0)
  retryAfter?: int32;
}
