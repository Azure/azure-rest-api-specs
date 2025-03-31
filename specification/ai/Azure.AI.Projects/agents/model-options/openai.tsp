namespace Azure.AI.Projects;

@doc("A specialized AgentModel for OpenAI-based providers.")
model OpenAIAgentModel extends AgentModel {
  @doc("Identifies this model as coming from an OpenAI-based provider.")
  provider: "openai";

  @doc("The provider-specific options for this OpenAI-based model.")
  options: OpenAIModelOptions;
}

@doc("A set of provider-specific configuration and behavior options for OpenAI.")
model OpenAIModelOptions {
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
}
