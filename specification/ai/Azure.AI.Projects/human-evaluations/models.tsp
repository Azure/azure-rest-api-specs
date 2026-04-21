import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "../main.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

@doc("The source of the feedback annotation.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
union FeedbackSource {
  string,

  @doc("Feedback provided by a builder or domain expert during review.")
  builder: "builder",

  @doc("Feedback provided by an end user of the application in real time.")
  endUser: "end_user",
}

@doc("The scope of the feedback annotation.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
union FeedbackIdType {
  string,

  @doc("Annotation scoped to a single invoke-agent trace span.")
  trace: "trace",

  @doc("Annotation scoped to a full multi-turn conversation/session.")
  conversation: "conversation",

  @doc("Annotation scoped to a full multi-turn session.")
  session: "session",
}

@doc("The type of scoring question in a human evaluation template.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
union QuestionType {
  string,

  @doc("Yes/No question. Maps to thumbs up/down scoring.")
  YesNo: "YesNo",

  @doc("Likert scale question (e.g., 1-5 or 1-7).")
  Likert: "Likert",

  @doc("Multiple choice question with predefined options.")
  MultiChoice: "MultiChoice",

  @doc("Free-form text response.")
  FreeFormText: "FreeFormText",
}

@doc("The source of a human evaluation template.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
union TemplateSource {
  string,

  @doc("Built-in template from the azureml registry.")
  builtin: "builtin",

  @doc("Custom template created in the workspace.")
  custom: "custom",
}

@doc("A question definition within a human evaluation template.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model FeedbackQuestion {
  @doc("The type of the question.")
  type: QuestionType;

  @doc("The text of the question presented to the reviewer.")
  questionText: string;

  @doc("The evaluation name derived from the question, used in App Insights custom dimensions.")
  evaluationName: string;
}

@doc("A human evaluation template defining scoring criteria.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model HumanEvaluationTemplate {
  @doc("The name of the template.")
  name: string;

  @doc("The display name of the template.")
  displayName?: string;

  @doc("A description of the template.")
  description?: string;

  @doc("The version of the template.")
  version: string;

  @doc("The source of the template (builtin or custom).")
  source: TemplateSource;

  @doc("The list of feedback questions defined in this template.")
  feedbackQuestions: FeedbackQuestion[];
}

@doc("A single human annotation score item for submission.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model HumanAnnotationScoreItem {
  @doc("The OTel trace ID to attach the annotation to.")
  traceId: string;

  @doc("The OTel span ID within the trace. If omitted, the annotation is attached to the root span.")
  spanId?: string;

  @doc("The name of the human evaluation template to use for scoring.")
  templateName: string;

  @doc("The scope of the annotation — trace, conversation, or session.")
  feedbackIdType: FeedbackIdType;

  @doc("Mapping of question text to answers. Keys must match the template's FeedbackQuestions questionText values.")
  templateResponse: Record<unknown>;

  @doc("Identifies who provided the annotation — builder or end_user.")
  feedbackSource: FeedbackSource;

  @doc("Optional tags for the annotation. For builder + trace submissions, 'trace-annotation' is auto-appended.")
  tags?: string[];
}

@doc("Request body for submitting human annotation scores in batch.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model SubmitHumanAnnotationScoresRequest {
  @doc("The list of score items to submit. Maximum 100 items per request.")
  @maxItems(100)
  scores: HumanAnnotationScoreItem[];
}

@doc("Error details for a failed score submission.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model HumanAnnotationErrorDetail {
  @doc("The error code.")
  code: string;

  @doc("A human-readable error message.")
  message: string;
}

@doc("Result of a single score submission within a batch.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model HumanAnnotationScoreResultItem {
  @doc("The trace ID of the submitted score.")
  traceId: string;

  @doc("The status of the submission — created or failed.")
  status: string;

  @doc("The unique identifier assigned to the score, if successfully created.")
  id?: string;

  @doc("Error details if the submission failed.")
  error?: HumanAnnotationErrorDetail;
}

@doc("Response for a batch human annotation score submission.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model SubmitHumanAnnotationScoresResponse {
  @doc("Per-item results for each submitted score.")
  results: HumanAnnotationScoreResultItem[];

  @doc("The number of scores successfully submitted.")
  succeeded: int32;

  @doc("The number of scores that failed submission.")
  failed: int32;
}

@doc("The score value of a human annotation.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model HumanAnnotationScoreValue {
  @doc("The numeric score value (e.g., 5.0 for thumbs up, 1.0 for thumbs down).")
  value: float32;

  @doc("The human-readable label for the score (e.g., 'thumbs_up', 'thumbs_down').")
  label: string;

  @doc("The kind of score (e.g., 'thumbs', 'likert', 'stars').")
  kind: string;
}

@doc("A human annotation score result returned from a query.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model HumanAnnotationScore {
  @doc("The unique identifier of the score.")
  id: string;

  @doc("The OTel trace ID the score is attached to.")
  traceId: string;

  @doc("The evaluation name derived from the scored question.")
  evaluationName: string;

  @doc("The score value, label, and kind.")
  score: HumanAnnotationScoreValue;

  @doc("Optional free-text explanation provided by the reviewer.")
  explanation?: string;

  @doc("The source of the feedback — builder or end_user.")
  feedbackSource: FeedbackSource;

  @doc("The scope of the annotation — trace, conversation, or session.")
  feedbackIdType: FeedbackIdType;

  @doc("The name of the template used for scoring.")
  templateName: string;

  @doc("Tags associated with the annotation.")
  tags?: string[];

  @doc("The identifier of the reviewer who provided the score.")
  reviewerId?: string;

  @doc("The timestamp when the score was created.")
  createdAt: utcDateTime;
}
