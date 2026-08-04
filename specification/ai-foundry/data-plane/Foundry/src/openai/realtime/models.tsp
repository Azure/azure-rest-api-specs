import "@azure-tools/openai-typespec/models/realtime";

namespace OpenAI;

@doc("A Realtime tool-choice object that forces the model to call a specific function.")
model RealtimeToolChoiceFunction {
  @doc("The tool type. Always `function`.")
  type: "function";

  @doc("The name of the function to call.")
  name: string;
}
