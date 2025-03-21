model OpenAIAgentModel extends AgentModel {
  provider: "openai";
  options: OpenAIModelOptions;
}

model OpenAIModelOptions {
    // TODO: Add back once these are supported
    /*
    @doc("The maximum number of tokens to generate.")
    maxOutputTokens?: int32;
    */

    @doc("""
      The sampling temperature to use that controls the apparent creativity of generated completions.
      Higher values will make output more random while lower values will make results more focused
      and deterministic.
      It is not recommended to modify temperature and topP for the same completions request as the
      interaction of these two settings is difficult to predict.
      """)
    temperature?: float32;

    @doc("""
      An alternative to sampling with temperature called nucleus sampling. This value causes the
      model to consider the results of tokens with the provided probability mass. As an example, a
      value of 0.15 will cause only the tokens comprising the top 15% of probability mass to be
      considered.
      It is not recommended to modify temperature and topP for the same completions request as the
      interaction of these two settings is difficult to predict.
      """)
    topP?: float32;

    // TODO: Add back once these are supported
    /*
    @doc("""
      A map between GPT token IDs and bias scores that influences the probability of specific tokens
      appearing in a completions response. Token IDs are computed via external tokenizer tools, while
      bias scores reside in the range of -100 to 100 with minimum and maximum values corresponding to
      a full ban or exclusive selection of a token, respectively. The exact behavior of a given bias
      score varies by model.
      """)
    logitBias?: Record<int32>;

    @doc("""
      A collection of textual sequences that will end completions generation.
      """)
    stop?: string[];

    @doc("""
      A value that influences the probability of generated tokens appearing based on their existing
      presence in generated text.
      Positive values will make tokens less likely to appear when they already exist and increase the
      model's likelihood to output new topics.
      """)
    presencePenalty?: float32;

    @doc("""
      A value that influences the probability of generated tokens appearing based on their cumulative
      frequency in generated text.
      Positive values will make tokens less likely to appear as their frequency increases and
      decrease the likelihood of the model repeating the same statements verbatim.
      """)
    frequencyPenalty?: float32;

    @doc("""
      A value that controls how many completions will be internally generated prior to response
      formulation.
      When used together with n, bestOf controls the number of candidate completions and must be
      greater than n.
      Because this setting can generate many completions, it may quickly consume your token quota.
      Use carefully and ensure reasonable settings for maxTokens and stop.
      """)
    bestOf?: int32;

    seed?: int32;

    parallelToolCalls?: boolean;

    reasoningEffort?: OpenAIReasoningConfig;

    text?: OpenAITextConfig;*/
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