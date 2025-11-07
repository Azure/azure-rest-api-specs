import "../../typespec/evals/models.tsp";

using Azure.AI.Decorators;

model AzureEvalAPIModelSamplingParams {
  /** A seed value to initialize the randomness during sampling. */
  seed?: int32;

  /** A higher temperature increases randomness in the outputs. */
  temperature?: float32;

  /** The maximum number of tokens in the generated output. */
  max_tokens?: int32;

  /** An alternative to temperature for nucleus sampling; 1.0 includes all tokens. */
  top_p?: float32;

  /** Controls the level of reasoning effort applied during generation. */
  reasoning_effort?: "low" | "medium" | "high";
}

model AzureEvalAPICompletionsSamplingParams
  extends AzureEvalAPIModelSamplingParams {
  tools?: OpenAI.ChatCompletionTool[];
  parallel_tool_calls?: boolean;
  response_format?: OpenAI.ResponseTextFormatConfiguration;
}

@@changePropertyType(OpenAI.EvalCompletionsRunDataSourceParams.sampling_params,
  AzureEvalAPICompletionsSamplingParams
);

model AzureEvalAPIResponseSamplingParams
  extends AzureEvalAPIModelSamplingParams {
  tools?: OpenAI.Tool[];
  parallel_tool_calls?: boolean;
  response_format?: OpenAI.ResponseTextFormatConfiguration;
}

@@changePropertyType(OpenAI.EvalResponsesRunDataSourceParams.sampling_params,
  AzureEvalAPIResponseSamplingParams
);
