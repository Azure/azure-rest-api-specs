namespace Azure.AI.Projects.Agents;

/**
 * A specialized AgentModel for OpenAI-based providers.
 * Contains the provider-specific identifier and options.
 */
@doc("A specialized AgentModel for OpenAI-based providers.")
model OpenAIAgentModel extends AgentModel {
  /**
   * Identifies this model as originating from OpenAI.
   */
  provider: "openai";

  /**
   * Provider-specific options for this OpenAI-based model.
   */
  options: OpenAIModelOptions;
}

/**
 * A set of provider-specific configuration and behavior options for OpenAI.
 */
@doc("A set of provider-specific configuration and behavior options for OpenAI.")
model OpenAIModelOptions {
  /*
   * (Uncomment once supported)
   * @doc("The maximum number of tokens to generate.")
   * maxOutputTokens?: int32;
   */

  /**
   * The sampling temperature to use, controlling the apparent creativity.
   * Higher values => more random output; lower values => more deterministic.
   * Avoid changing temperature and topP concurrently, as their effects may be hard to predict.
   */
  @doc("""
    The sampling temperature to use that controls the apparent creativity of generated completions.
    Higher values will make output more random while lower values will make results more focused
    and deterministic.
    It is not recommended to modify temperature and topP for the same completions request as the
    interaction of these two settings is difficult to predict.
    """)
  temperature?: float32;

  /**
   * An alternative sampling method known as nucleus sampling.
   * If set, only tokens within the provided probability mass are considered.
   * Avoid changing temperature and topP concurrently, as their effects may be hard to predict.
   */
  @doc("""
    An alternative to sampling with temperature called nucleus sampling. This value causes the
    model to consider the results of tokens with the provided probability mass. As an example, a
    value of 0.15 will cause only the tokens comprising the top 15% of probability mass to be
    considered.
    It is not recommended to modify temperature and topP for the same completions request as the
    interaction of these two settings is difficult to predict.
    """)
  topP?: float32;

  /*
   * (Uncomment once supported)
   * @doc("A map between GPT token IDs and bias scores influencing the probability of specific tokens.")
   * logitBias?: Record<int32>;
   *
   * @doc("A collection of textual sequences that will end completions generation.")
   * stop?: string[];
   *
   * @doc("A value that influences the probability of generated tokens based on their presence in the text.")
   * presencePenalty?: float32;
   *
   * @doc("A value that influences the probability of generated tokens based on their frequency in the text.")
   * frequencyPenalty?: float32;
   *
   * @doc("A value controlling how many completions are internally generated prior to finalizing a response.")
   * bestOf?: int32;
   *
   * seed?: int32;
   *
   * parallelToolCalls?: boolean;
   *
   * reasoningEffort?: OpenAIReasoningConfig;
   *
   * text?: OpenAITextConfig;
   */
}

/*
union OpenAIReasoningConfigEffort {
  low: "low",
  medium: "medium",
  high: "high"
}

union OpenAIReasoningConfigGenerateSummary {
  concise: "concise",
  detailed: "detailed"
}

model OpenAIReasoningConfig {
  effort?: OpenAIReasoningConfigEffort;
  generateSummary?: OpenAIReasoningConfigGenerateSummary;
}

union OpenAITextConfigFormat {
  text: "text",
  jsonObject: "jsonObject",
  jsonSchema: "jsonSchema"
}

model OpenAITextConfig {
  format: {
      type: OpenAITextConfigFormat;
  };
}
*/
