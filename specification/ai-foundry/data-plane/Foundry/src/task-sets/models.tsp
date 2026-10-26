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

/** A typed text value. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvaluationTextContent {
  /** Indicates text content. */
  type: "text";

  /** The text value. */
  value: string;
}

/** A typed JSON value. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvaluationJsonContent {
  /** Indicates JSON content. */
  type: "json";

  /** The JSON value. */
  value: unknown;
}

/** The single-prompt input mode; other input modes are Later. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model PromptTaskInput {
  /** Indicates a single prompt invocation. */
  type: "prompt";

  /** The prompt sent to the agent. */
  @minLength(1)
  instruction: string;

  /** A JSON object sent to the agent with the instruction. */
  data?: Record<unknown>;
}

/** Optional limits for one TaskRun attempt. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvaluationTaskConstraints {
  /** Deadline in seconds for the whole TaskRun attempt, including grading. */
  @minValue(1)
  max_duration_seconds?: int32;
}

/**
 * One evaluation Task: a prompt for the agent, optional reference values and context for graders,
 * and optional Task-specific graders. Unknown fields are invalid. Graders read Task values through
 * `{{inputs.*}}`, `{{expected.*}}` and `{{metadata.*}}`, and the agent's answer through
 * `{{outputs.text}}` and `{{outputs.data.*}}`.
 */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model Task {
  /**
   * Caller-chosen ID, unique within the version and compared case-sensitively. Starts with a
   * letter or digit and does not end with `.`.
   */
  @minLength(1)
  @maxLength(128)
  @pattern("^[A-Za-z0-9][A-Za-z0-9._-]*$")
  id: string;

  /** A description for people; never sent to the agent or graders. */
  @maxLength(1024)
  description?: string;

  /** The prompt and optional data sent to the agent. */
  inputs: PromptTaskInput;

  /** Reference values that graders read; the agent never sees them. */
  expected?: Record<unknown>;

  /** Context that graders read; the agent never sees it. */
  metadata?: Record<unknown>;

  /** Inline graders that run in addition to the Job's graders. */
  @maxItems(32)
  graders?: InlineGrader[];

  /** Limits for each TaskRun attempt of this Task. */
  constraints?: EvaluationTaskConstraints;
}
