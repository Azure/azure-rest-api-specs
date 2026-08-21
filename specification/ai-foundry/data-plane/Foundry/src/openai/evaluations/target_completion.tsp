using TypeSpec.Versioning;

namespace Azure.AI.Projects;

/** Runs an evaluation against a model or agent target using inputs from a JSONL source. */
model TargetCompletionEvalRunDataSource extends EvalRunDataSource {
  /** The type of data source, always `azure_ai_target_completions`. */
  type: "azure_ai_target_completions";

  /** Message template used to map each JSONL source row to target input. */
  input_messages?: OpenAI.CreateEvalCompletionsRunDataSourceInputMessagesItemReference;

  /** JSONL input items for the run. */
  #suppress "@azure-tools/typespec-autorest/union-unsupported" "This union is defined according to the Azure OpenAI API."
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Auto-suppressed warnings non-applicable rules during import."
  source: OpenAI.EvalJsonlFileContentSource | OpenAI.EvalJsonlFileIdSource;

  /** Model or agent evaluated by the run. */
  target: Target;
}