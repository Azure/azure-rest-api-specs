import "@typespec/openapi";

import "../common/models.tsp";
import "../common/servicepatterns.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Rest;

namespace Azure.AI.Projects;

const EvaluationServiceV2RequiredPreviews = #{
  conditional_previews: #[FoundryFeaturesOptInKeys.evaluations_v1_preview],
};

/** The supported inline grader types. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
union EvaluationGraderType {
  string,

  /** One model call evaluates all rubric criteria. */
  rubric: "rubric",

  /** Compare JSON scalar values. */
  exact_match: "exact_match",

  /** Require a substring in the answer. */
  substring_match: "substring_match",

  /** Match a regular expression in the answer. */
  regex: "regex",

  /** Check inclusive numeric bounds. */
  numeric_range: "numeric_range",

  /** Check required or disallowed ATIF tool calls. */
  tool_calls: "tool_calls",

  /** Run a compatible, versioned Foundry Evaluator. */
  foundry_evaluator: "foundry_evaluator",
}

/** A grader resolved from a Dataset Task or an EvalJob definition. */
@discriminator("type")
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvaluationGrader {
  /** The grader name, unique among graders applicable to the same task. */
  name: string;

  /** The grader type. */
  type: EvaluationGraderType;
}

/** One criterion evaluated by a rubric judge. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model RubricCriterion {
  /** The criterion identifier. */
  id: string;

  /** The behavior required to pass this criterion. */
  description: string;
}

/** A rubric judged in one model call. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model RubricGrader extends EvaluationGrader {
  type: EvaluationGraderType.rubric;

  /** The model selected to judge this grader. */
  model_config: EvaluationJudgeModelConfig;

  /** The criteria evaluated by the judge. */
  @minItems(1)
  criteria: RubricCriterion[];
}

/** The model chosen for one language-model grader. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvaluationJudgeModelConfig {
  /** The model to use when evaluating the grader. */
  `model`: string;
}

/** A path in the transient grader evidence view. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvaluationPathSource {
  /** Dot-separated path rooted at inputs or outputs. */
  path: string;
}

/** A literal value compared with evidence. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvaluationLiteralSource {
  /** JSON value to compare. */
  literal: unknown;
}

/** Exactly one of a path or a literal. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
union EvaluationValueSource {
  EvaluationPathSource,
  EvaluationLiteralSource,
}

@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model ExactMatchConfig {
  /** Observed JSON scalar. */
  actual: EvaluationValueSource;

  /** Expected JSON scalar. */
  expected: EvaluationValueSource;
}

@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model SubstringMatchConfig {
  /** Observed text. */
  text: EvaluationValueSource;

  /** Required substring. */
  substring: EvaluationValueSource;
}

@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model RegexCheckConfig {
  /** Observed text. */
  text: EvaluationValueSource;

  /** Regular expression to match. */
  pattern: EvaluationValueSource;
}

@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model NumericRangeConfig {
  /** Observed numeric value. */
  actual: EvaluationValueSource;

  /** Inclusive lower bound; at least one bound is required. */
  min?: EvaluationValueSource;

  /** Inclusive upper bound; at least one bound is required. */
  max?: EvaluationValueSource;
}

/** A literal tool name or a path to one in the grader evidence view. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
union EvaluationToolNameSource {
  string,
  EvaluationPathSource,
}

@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model ToolCallsConfig {
  /** Tool names or reference paths, all of which must occur. */
  required?: EvaluationToolNameSource[];

  /** Tool names or reference paths, none of which may occur. */
  disallowed?: EvaluationToolNameSource[];
}

@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model ExactMatchGrader extends EvaluationGrader {
  /** The exact-match grader type. */
  type: EvaluationGraderType.exact_match;

  /** Observed and expected values. */
  config: ExactMatchConfig;
}

@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model SubstringMatchGrader extends EvaluationGrader {
  /** The substring-match grader type. */
  type: EvaluationGraderType.substring_match;

  /** Observed text and required substring. */
  config: SubstringMatchConfig;
}

@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model RegexCheckGrader extends EvaluationGrader {
  /** The regular-expression grader type. */
  type: EvaluationGraderType.regex;

  /** Observed text and pattern. */
  config: RegexCheckConfig;
}

@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model NumericRangeGrader extends EvaluationGrader {
  /** The numeric-range grader type. */
  type: EvaluationGraderType.numeric_range;

  /** Observed number and inclusive bounds. */
  config: NumericRangeConfig;
}

@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model ToolCallsGrader extends EvaluationGrader {
  /** The tool-call grader type. */
  type: EvaluationGraderType.tool_calls;

  /** Required or disallowed tool names. */
  config: ToolCallsConfig;
}

/** An exact version in the existing Foundry Evaluator catalog. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model FoundryEvaluatorReference {
  /** The evaluator name. */
  name: string;

  /** The evaluator version selected for this grader. */
  version: string;
}

/** A supported catalog evaluator with a service-defined evidence and verdict adapter. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model FoundryEvaluatorGrader extends EvaluationGrader {
  /** Identifies the catalog adapter. */
  type: EvaluationGraderType.foundry_evaluator;

  /** The pinned catalog evaluator; no caller-supplied input mapping is accepted. */
  evaluator: FoundryEvaluatorReference;
}

/** The inline graders supported by the evaluation MVP. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
union InlineEvaluationGrader {
  RubricGrader,
  ExactMatchGrader,
  SubstringMatchGrader,
  RegexCheckGrader,
  NumericRangeGrader,
  ToolCallsGrader,
  FoundryEvaluatorGrader,
}

/** Text content supplied to a task or its graders. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvaluationTextContent {
  /** Indicates text content. */
  type: "text";

  /** The text value. */
  value: string;
}

/** JSON content supplied to a task or its graders. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvaluationJsonContent {
  /** Indicates JSON content. */
  type: "json";

  /** The JSON value. */
  value: unknown;
}

/** Task content, including shorthand strings and JSON objects. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
union EvaluationTaskContent {
  /** A text value without a content wrapper. */
  shorthand_text: string,

  /** A JSON object without a content wrapper. */
  shorthand_json: Record<unknown>,

  /** A typed text value. */
  text: EvaluationTextContent,

  /** A typed JSON value. */
  json: EvaluationJsonContent,
}

/** The single-prompt input mode supported in the MVP. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model PromptTaskInput {
  /** Indicates a single prompt invocation. */
  type: "prompt";

  /** The prompt delivered to the agent. */
  @minLength(1)
  instruction: string;

  /** Additional named context visible to the agent. */
  data?: Record<EvaluationTaskContent>;
}

/** Optional deadline for the entire task attempt, including grading. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvaluationTaskConstraints {
  /** Maximum attempt duration in seconds. */
  @minValue(1)
  maxDurationSeconds?: int32;
}

/** A reusable evaluation task. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model Task {
  /** The task identifier, unique within the Dataset task manifest. */
  @minLength(1)
  id: string;

  /** A description of the behavior being evaluated. */
  description?: string;

  /** The prompt and optional context provided to the agent. */
  inputs: PromptTaskInput;

  /** Reference values visible to graders but not to the agent. */
  expected?: Record<unknown>;

  /** When present, replaces all job-level graders for this task; an empty list is not runnable. */
  graders?: InlineEvaluationGrader[];

  /** Per-attempt deadline including invocation and grading. */
  constraints?: EvaluationTaskConstraints;

  /** Caller-defined JSON annotations visible to graders. */
  metadata?: Record<unknown>;
}
