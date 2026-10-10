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

  /** A grader that uses a language model to judge rubric criteria. */
  llm_judge: "llm_judge",

  /** A grader that applies a bounded deterministic operator. */
  deterministic: "deterministic",
}

/** A grader that is resolved as part of a task-set or evaluation-suite version. */
@discriminator("type")
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvaluationGrader {
  /** The grader name, unique within its task or evaluation suite. */
  name: string;

  /** The grader type. */
  type: EvaluationGraderType;
}

/** One criterion evaluated by a language-model judge. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model LlmJudgeCriterion {
  /** The criterion identifier. */
  id: string;

  /** The behavior required to pass this criterion. */
  description: string;
}

/** An inline language-model judge. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model LlmJudgeGrader extends EvaluationGrader {
  /** Indicates that this grader uses a language model. */
  type: EvaluationGraderType.llm_judge;

  /** The model deployment used by the judge. */
  model_deployment: string;

  /** The criteria evaluated by the judge. */
  @minItems(1)
  criteria: LlmJudgeCriterion[];
}

/** The supported deterministic grader operators. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
union EvaluationDeterministicOperator {
  string,

  /** The selected value must exactly equal the expected value. */
  exact_match: "exact_match",

  /** The selected value must contain the expected value. */
  contains: "contains",

  /** The selected value must match the configured regular expression. */
  regex: "regex",

  /** The selected numeric value must be greater than or equal to the expected value. */
  greater_than_or_equal: "greater_than_or_equal",

  /** The selected numeric value must be less than or equal to the expected value. */
  less_than_or_equal: "less_than_or_equal",

  /** The trajectory must contain a matching tool call. */
  tool_called: "tool_called",
}

/** An inline deterministic grader. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model DeterministicGrader extends EvaluationGrader {
  /** Indicates that this grader applies a deterministic operator. */
  type: EvaluationGraderType.deterministic;

  /** The built-in check applied to the evaluation record. */
  check: EvaluationDeterministicCheck;
}

/** A bounded check against a grader input field or a trajectory tool call. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvaluationDeterministicCheck {
  /** Dot-separated field path rooted at inputs, outputs, or context; omitted for tool_called. */
  field?: string;

  /** The operator applied to the selected value. */
  operator: EvaluationDeterministicOperator;

  /** The literal comparison value or tool function name. Provide exactly one of value and value_from. */
  value?: unknown;

  /** Path to the comparison value in the standard grader record. Provide exactly one of value and value_from. */
  value_from?: string;
}

/** The inline graders supported by the evaluation MVP. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
union InlineEvaluationGrader {
  LlmJudgeGrader,
  DeterministicGrader,
}

/** A reusable evaluation task. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model HarnessTask {
  /** The task identifier, unique within the task-set version. */
  id: string;

  /** The human-readable task name. */
  name: string;

  /** A description of the behavior being evaluated. */
  description?: string;

  /** The starting request or state provided to the harness. */
  inputs: Record<unknown>;

  /** Expected values available to deterministic and language-model graders. */
  expected?: Record<unknown>;

  /** Task-level graders applied in addition to suite-level graders. */
  graders?: InlineEvaluationGrader[];

  /** User-defined task metadata. */
  metadata?: Record<unknown>;

  /** Reserved for future multi-step tasks; rejected in the MVP. */
  steps?: unknown[];
}

/** Task definitions supplied with a one-off inline suite. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model InlineHarnessTaskSet {
  /** The tasks to execute without publishing a HarnessTaskSet. */
  @minItems(1)
  tasks: HarnessTask[];
}

/** An immutable version of a reusable evaluation task set. */
@resource("harness_task_sets")
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model HarnessTaskSetVersion {
  /** The task-set name. */
  @visibility(Lifecycle.Read)
  @key
  name: string;

  /** The immutable task-set version. */
  @visibility(Lifecycle.Read)
  version: string;

  /** The task-set description. */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  description?: string;

  /** The tasks contained in this version. */
  @minItems(1)
  tasks: HarnessTask[];

  /** User-defined tags. */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
}
