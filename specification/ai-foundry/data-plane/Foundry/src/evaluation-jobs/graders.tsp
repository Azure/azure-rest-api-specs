import "@typespec/openapi";

import "../common/models.tsp";
import "../task-sets/models.tsp";

using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

/** The grader types supported by the evaluation MVP. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
union EvaluationGraderType {
  string,

  /** Compare two JSON scalars of the same type and value. */
  exact_match: "exact_match",

  /** Require an ordinal, case-sensitive substring in a text value. */
  substring_match: "substring_match",

  /** Match a regular expression anywhere in a text value. */
  regex: "regex",

  /** Check a number against inclusive bounds. */
  numeric_range: "numeric_range",

  /** Check required or disallowed tool calls in the trajectory. */
  tool_calls: "tool_calls",

  /** Ask a judge model to decide each rubric criterion. */
  rubric: "rubric",

  /** Run a supported grader from the Foundry evaluator catalog. Job graders only. */
  catalog_grader: "catalog_grader",
}

/**
 * The model that judges a rubric or LLM-based grader. Each kind of judge is its own optional
 * field and the service requires exactly one; `model` is the only kind today, so it must be set.
 */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model Judge {
  /**
   * A model deployment name in the Job's project. The `{connection}/{deployment}` form is
   * rejected with `unsupported_feature`.
   */
  `model`?: string;
}

/** A string compared as written, bypassing the guard against unbraced evidence paths. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model GraderLiteral {
  /** The literal string, such as `outputs.text`. */
  literal: string;
}

/**
 * A JSON scalar literal, a `{{inputs|expected|metadata|outputs.path}}` template, or an explicit literal
 * string. A value that is exactly one placeholder keeps the evidence's JSON type.
 */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
union GraderScalarValue {
  string,
  float64,
  boolean,
  GraderLiteral,
}

/** A string literal, a template that resolves to a string, or an explicit literal string. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
union GraderStringValue {
  string,
  GraderLiteral,
}

/** A number literal or a template that resolves to a finite number. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
union GraderNumberValue {
  float64,
  string,
}

/** Shared properties of every grader. */
@discriminator("type")
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvaluationGrader {
  /**
   * The grader name, unique within the Job list and within each Task list. A Job grader and a
   * Task grader may share a name; results are keyed by `defined_in` and `name`.
   */
  @minLength(1)
  @maxLength(64)
  @pattern("^[A-Za-z0-9_-]+$")
  name: string;

  /** The grader type. */
  type: EvaluationGraderType;
}

/** Passes when both values have the same JSON type and value; numbers compare numerically. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model ExactMatchGrader extends EvaluationGrader {
  /** The exact-match grader type. */
  type: EvaluationGraderType.exact_match;

  /** The value to check, usually an `outputs` template. */
  actual: GraderScalarValue;

  /** The value required, usually an `expected` template or a literal. */
  expected: GraderScalarValue;
}

/** Passes when `text` contains `substring`, ordinal and case-sensitive. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model SubstringMatchGrader extends EvaluationGrader {
  /** The substring-match grader type. */
  type: EvaluationGraderType.substring_match;

  /** The text to search. */
  text: GraderStringValue;

  /** The substring required in `text`. */
  substring: GraderStringValue;
}

/** Passes when `pattern` matches anywhere in `text`. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model RegexCheckGrader extends EvaluationGrader {
  /** The regular-expression grader type. */
  type: EvaluationGraderType.regex;

  /** The text to search. */
  text: GraderStringValue;

  /** The regular expression, at most 1,024 characters after resolution. */
  pattern: GraderStringValue;
}

/** Passes when `min <= actual <= max`; an absent bound is open and at least one is required. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model NumericRangeGrader extends EvaluationGrader {
  /** The numeric-range grader type. */
  type: EvaluationGraderType.numeric_range;

  /** The number to check. */
  actual: GraderNumberValue;

  /** Inclusive lower bound. */
  min?: GraderNumberValue;

  /** Inclusive upper bound. */
  max?: GraderNumberValue;
}

/**
 * Passes when every required tool was called and no disallowed tool was called. At least one
 * list is required and a name cannot appear in both. An incomplete trajectory is an `error`.
 */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model ToolCallsGrader extends EvaluationGrader {
  /** The tool-call grader type. */
  type: EvaluationGraderType.tool_calls;

  /** Tool names, or single-placeholder templates, that must all be called. */
  required?: string[];

  /** Tool names, or single-placeholder templates, that must not be called. */
  disallowed?: string[];
}

/** One rubric criterion decided by the judge. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model RubricCriterion {
  /** The criterion identifier, reported as the sub-metric name. */
  id: string;

  /** The behavior required to pass this criterion. */
  @maxLength(2048)
  description: string;
}

/** How a rubric judge rates each criterion. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
union RubricScale {
  string,

  /** The judge answers true or false for each criterion. */
  boolean: "boolean",
}

/** Passes when the judge passes every criterion; `score` is 1 when it passes and 0 when it fails. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model RubricGrader extends EvaluationGrader {
  /** The rubric grader type. */
  type: EvaluationGraderType.rubric;

  /** The criteria decided by the judge. */
  @minItems(1)
  @maxItems(20)
  criteria: RubricCriterion[];

  /** The rating scale. */
  scale?: RubricScale = RubricScale.boolean;

  /** Overrides the Job's default judge for this grader. */
  judge?: Judge;
}

/** A grader from the Foundry evaluator catalog, resolved and pinned at Run creation. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model CatalogGrader extends EvaluationGrader {
  /** The catalog grader type. */
  type: EvaluationGraderType.catalog_grader;

  /** The catalog name, such as `builtin.output_quality`. */
  grader_name: string;

  /** The catalog version; when omitted, the latest supported version is pinned at Run creation. */
  grader_version?: string;

  /** Overrides the Job's default judge for this grader. */
  judge?: Judge;

  /** The minimum 0-1 `score` that passes; defaults to the catalog adapter's threshold. */
  @minValue(0)
  @maxValue(1)
  pass_threshold?: float64;

  /** Overrides the adapter's standard mapping from evidence templates to the grader's declared inputs. */
  data_mapping?: Record<string>;

  /** Settings that this catalog grader declares. */
  settings?: Record<unknown>;
}

/** A grader allowed in a Job version or a Dataset Task. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
union InlineGrader {
  ExactMatchGrader,
  SubstringMatchGrader,
  RegexCheckGrader,
  NumericRangeGrader,
  ToolCallsGrader,
  RubricGrader,
}

/** A grader allowed in a Job version: an inline grader or a catalog grader. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
union JobGrader {
  InlineGrader,
  CatalogGrader,
}

/** How the TaskRun result is decided from its grader results. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
union EvaluationScoringType {
  string,

  /** `passed` only when no grader returned `failed` or `error` and not every grader returned `skipped`. */
  all_pass: "all_pass",
}

/** The rule that combines grader results into a TaskRun result. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvaluationScoring {
  /** The scoring rule. */
  type: EvaluationScoringType = EvaluationScoringType.all_pass;
}
