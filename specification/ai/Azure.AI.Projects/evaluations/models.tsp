import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "../common/models.tsp";
import "../main.tsp";
import "@typespec/openapi";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

namespace Azure.AI.Projects;

@doc("Evaluator Configuration")
model EvaluatorConfiguration {
  @doc("Identifier of the evaluator.")
  id: string;

  @doc("Initialization parameters of the evaluator.")
  initParams?: Record<unknown>;

  @doc("Data parameters of the evaluator.")
  dataMapping?: Record<string>;
}

#suppress "@azure-tools/typespec-azure-core/no-string-discriminator"
@doc("Abstract data class.")
@discriminator("type")
model InputData {
  @doc("Type of the data")
  type: string;
}

@doc("Dataset as source for evaluation.")
model InputDataset extends InputData {
  type: "dataset";

  @doc("Evaluation input data")
  id: string;
}

@doc("Dataset as source for evaluation.")
model RawDataset extends InputData {
  type: "dataset";

  @doc("Evaluation input raw data batch id")
  id: string;

  @doc("The collection of context messages associated with this chat completions that need to be evaluated.")
  @minItems(1)
  value: ChatCompletions[];
}

@doc("Evaluation Definition")
@resource("runs")
model Evaluation {
  @doc("Identifier of the evaluation.")
  @key("name")
  @visibility("read")
  id: string;

  @doc("Data for evaluation.")
  data: InputData;

  @doc("Display Name for evaluation. It helps to find the evaluation easily in AI Foundry. It does not need to be unique.")
  displayName?: string;

  @doc("Description of the evaluation. It can be used to store additional information about the evaluation and is mutable.")
  description?: string;

  @doc("Metadata containing createdBy and modifiedBy information.")
  @visibility("read")
  systemData?: SystemData;

  @doc("Status of the evaluation. It is set by service and is read-only.")
  @visibility("read")
  status?: string;

  @doc("Evaluation's tags. Unlike properties, tags are fully mutable.")
  tags?: Record<string>;

  @doc("Evaluation's properties. Unlike tags, properties are add-only. Once added, a property cannot be removed.")
  properties?: Record<string>;

  @doc("Evaluators to be used for the evaluation.")
  evaluators: Record<EvaluatorConfiguration>;
}

model ChatCompletions {
  @doc("The collection of context messages associated with this chat completions that need to be evaluated.")
  @minItems(1)
  messages: ChatRequestMessage[];
}


@doc("A description of the intended purpose of a message within a chat completions interaction.")
union ChatRole {
  string,

  @doc("The role that instructs or sets the behavior of the assistant.")
  system: "system",

  @doc("The role that provides input for chat completions.")
  user: "user",

  @doc("The role that provides responses to system-instructed, user-prompted input.")
  assistant: "assistant",
}

@doc("An abstract representation of a structured content item within a chat message.")
model ChatMessageContentItem {
  @doc("The discriminated object type.")
  type: string;
}

@doc("A structured chat content item containing plain text.")
model ChatMessageTextContentItem extends ChatMessageContentItem {
  @doc("The discriminated object type: always 'text' for this type.")
  type: "text";

  @doc("The content of the message.")
  text: string;
}

@doc("A structured chat content item containing an image reference.")
model ChatMessageImageContentItem extends ChatMessageContentItem {
  @doc("The discriminated object type: always 'image_url' for this type.")
  type: "image_url";

  @doc("An internet location, which must be accessible to the model,from which the image may be retrieved.")
  @encodedName("application/json", "image_url")
  imageUrl: ChatMessageImageUrl;
}

@doc("An internet location from which the model may retrieve an image.")
model ChatMessageImageUrl {
  @doc("The URL of the image.")
  url: string;

  @doc("""
    The evaluation quality setting to use, which controls relative prioritization of speed, token consumption, and
    accuracy.
    """)
  detail?: ChatMessageImageDetailLevel;
}

@doc("A representation of the possible image detail levels for image-based chat completions message content.")
union ChatMessageImageDetailLevel {
  string,

  @doc("Specifies that the model should determine which detail level to apply using heuristics like image size.")
  auto: "auto",

  @doc("""
    Specifies that image evaluation should be constrained to the 'low-res' model that may be faster and consume fewer
    tokens but may also be less accurate for highly detailed images.
    """)
  low: "low",

  @doc("""
    Specifies that image evaluation should enable the 'high-res' model that may be more accurate for highly detailed
    images but may also be slower and consume more tokens.
    """)
  high: "high",
}

@doc("An abstract representation of a chat message as provided in a request.")
model ChatRequestMessage {
  @doc("The chat role associated with this message.")
  role: ChatRole;
}

@doc("""
  A request chat message containing system instructions that influence how the model will generate a chat completions
  response.
  """)
model ChatRequestSystemMessage extends ChatRequestMessage {
  @doc("The chat role associated with this message, which is always 'system' for system messages.")
  role: ChatRole.system;

  @doc("The contents of the system message.")
  content: string;
}

@doc("A request chat message representing user input to the assistant.")
model ChatRequestUserMessage extends ChatRequestMessage {
  @doc("The chat role associated with this message, which is always 'user' for user messages.")
  role: ChatRole.user;

  #suppress "@azure-tools/typespec-autorest/union-unsupported" "External API shape is defined in OpenAPI 3.0 as oneOf."
  @doc("The contents of the user message, with available input types varying by selected model.")
  content: string | ChatMessageContentItem[];
}

@doc("A request chat message representing response or action from the assistant.")
model ChatRequestAssistantMessage extends ChatRequestMessage {
  @doc("The chat role associated with this message, which is always 'assistant' for assistant messages.")
  role: ChatRole.assistant;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "explicitly nullable in mirrored API"
  @doc("The content of the message.")
  content?: string | ChatMessageContentItem[];
}
