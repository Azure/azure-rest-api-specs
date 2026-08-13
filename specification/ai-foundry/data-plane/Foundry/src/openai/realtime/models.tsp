import "@azure-tools/openai-typespec/models/realtime";
import "@azure-tools/openai-typespec/models/responses";

namespace OpenAI;

@doc("A Realtime tool-choice object that forces the model to call a specific function.")
model RealtimeToolChoiceFunction {
  ...ToolChoiceFunction;
}
