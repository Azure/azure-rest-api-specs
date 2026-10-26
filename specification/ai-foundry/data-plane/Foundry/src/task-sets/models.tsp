import "@typespec/openapi";

import "../common/models.tsp";
import "../common/servicepatterns.tsp";
import "../evaluation-jobs/graders.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Rest;

namespace Azure.AI.Projects;

const EvaluationServiceV2RequiredPreviews = #{
  conditional_previews: #[FoundryFeaturesOptInKeys.evaluations_v1_preview],
};

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

  /** Inline graders run for this Task in addition to the Job's graders. */
  @maxItems(32)
  graders?: InlineGrader[];

  /** Per-attempt deadline including invocation and grading. */
  constraints?: EvaluationTaskConstraints;

  /** Caller-defined JSON annotations visible to graders. */
  metadata?: Record<unknown>;
}
