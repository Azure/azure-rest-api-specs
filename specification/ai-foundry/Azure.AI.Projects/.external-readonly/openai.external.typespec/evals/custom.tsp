import "../graders/models.tsp";

using TypeSpec.OpenAPI;

namespace OpenAI;

union EvalItemContentType {
  input_text: "input_text",
  output_text: "output_text",
}

@discriminator("type")
model EvalItemContent {
  type: EvalItemContentType;
}

model EvalItemContentInputText extends EvalItemContent {
  type: EvalItemContentType.input_text;
  text: string;
}

model EvalItemContentOutputText extends EvalItemContent {
  type: EvalItemContentType.output_text;
  text: string;
}

union EvalDataSourceConfigType {
  custom: "custom",
  logs: "logs",
  stored_completions: "stored_completions",
}

@discriminator("type")
model EvalDataSourceConfigParams {
  type: EvalDataSourceConfigType;
}

@discriminator("type")
model EvalDataSourceConfigResource {
  type: EvalDataSourceConfigType;
}

union EvalRunDataContentSourceType {
  file_id: "file_id",
  file_content: "file_content",
  stored_completions: "stored_completions",
  responses: "responses",
}

@discriminator("type")
model EvalRunDataContentSource {
  type: EvalRunDataContentSourceType;
}

union EvalRunDataSourceType {
  jsonl: "jsonl",
  completions: "completions",
  responses: "responses",
}

@discriminator("type")
model EvalRunDataSourceParams {
  type: EvalRunDataSourceType;
}

@discriminator("type")
model EvalRunDataSourceResource {
  type: EvalRunDataSourceType;
}

model EvalRunDataSourceJsonlResource extends EvalRunDataSourceResource {
  type: EvalRunDataSourceType.jsonl;
}

model EvalRunDataSourceCompletionsResource extends EvalRunDataSourceResource {
  type: EvalRunDataSourceType.completions;
}

model EvalRunDataSourceResponsesResource extends EvalRunDataSourceResource {
  type: EvalRunDataSourceType.responses;
}

@discriminator("type")
model EvalGraderParams {
  type: GraderType;
}

@discriminator("type")
model EvalGraderResource {
  type: GraderType;
}

// Customization note: as of 2025-05-21, the origin specification only formally splits input (request) and output
// (response) models for the [Create]EvalLabelModelGrader component[s]. For compatibility and clarity, this
// reprojection chooses to split all EvalGrader components into input and output models, sharing details via
// spread.

model EvalGraderStringCheckParams extends EvalGraderParams {
  ...EvalGraderStringCheckResource;
}

model EvalGraderTextSimilarityParams extends EvalGraderParams {
  ...EvalGraderTextSimilarityResource;
}

model EvalGraderPythonParams extends EvalGraderParams {
  ...EvalGraderPythonResource;
}

model EvalGraderScoreModelParams extends EvalGraderParams {
  ...EvalGraderScoreModelResource;
}
