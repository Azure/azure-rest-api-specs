import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@typespec/openapi";
import "../common/models.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

namespace Azure.AI.Projects;

@doc("Strategies for attacks.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v_latest)
union AttackStrategy {
  string,

  @doc("Represents a default set of easy complexity attacks. Easy complexity attacks require less effort, such as translation of a prompt into some encoding, and does not require any Large Language Model to convert or orchestrate.")
  Easy: "easy",

  @doc("Represents a default set of moderate complexity attacks. Moderate complexity attacks require having access to resources such as another generative AI model.")
  Moderate: "moderate",

  @doc("Represents a default set of difficult complexity attacks. Difficult complexity attacks include attacks that require access to significant resources and effort to execute an attack such as knowledge of search-based algorithms in addition to a generative AI model.")
  Difficult: "difficult",

  @doc("Generates visual art using ASCII characters, often used for creative or obfuscation purposes.")
  AsciiArt: "ascii_art",

  @doc("Conceals data within ASCII characters, making it harder to detect.")
  AsciiSmuggler: "ascii_smuggler",

  @doc("Implements the Atbash cipher, a simple substitution cipher where each letter is mapped to its reverse.")
  Atbash: "atbash",

  @doc("Encodes binary data into a text format using Base64, commonly used for data transmission.")
  Base64: "base64",

  @doc("Converts text into binary code, representing data in a series of 0s and 1s.")
  Binary: "binary",

  @doc("Applies the Caesar cipher, a substitution cipher that shifts characters by a fixed number of positions.")
  Caesar: "caesar",

  @doc("Alters text by adding spaces between characters, often used for obfuscation.")
  CharacterSpace: "character_space",

  @doc("Injects specially crafted prompts to bypass AI safeguards, known as User Injected Prompt Attacks (UPIA).")
  Jailbreak: "jailbreak",

  @doc("Utilizes ANSI escape sequences to manipulate text appearance and behavior.")
  AnsiiAttack: "ansii_attack",

  @doc("Swaps characters within text to create variations or obfuscate the original content.")
  CharacterSwap: "character_swap",

  @doc("Appends an adversarial suffix to the prompt.")
  SuffixAppend: "suffix_append",

  @doc("Joins multiple strings together, often used for concatenation or obfuscation.")
  StringJoin: "string_join",

  @doc("Uses Unicode characters that look similar to standard characters, creating visual confusion.")
  UnicodeConfusable: "unicode_confusable",

  @doc("Substitutes standard characters with Unicode equivalents, often for obfuscation.")
  UnicodeSubstitution: "unicode_substitution",

  @doc("Adds diacritical marks to characters, changing their appearance and sometimes their meaning.")
  Diacritic: "diacritic",

  @doc("Flips characters from front to back, creating a mirrored effect.")
  Flip: "flip",

  @doc("Transforms text into Leetspeak, a form of encoding that replaces letters with similar-looking numbers or symbols.")
  Leetspeak: "leetspeak",

  @doc("Applies the ROT13 cipher, a simple substitution cipher that shifts characters by 13 positions.")
  ROT13: "rot13",

  @doc("Encodes text into Morse code, using dots and dashes to represent characters.")
  Morse: "morse",

  @doc("Encodes text into URL format.")
  Url: "url",

  @doc("Represents the baseline direct adversarial probing, which is used by attack strategies as the attack objective.")
  Baseline: "baseline",
}

@doc("Risk category for the attack objective.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v_latest)
union RiskCategory {
  string,

  @doc("Represents content related to hate or unfairness.")
  HateUnfairness: "HateUnfairness",

  @doc("Represents content related to violence.")
  Violence: "Violence",

  @doc("Represents content of a sexual nature.")
  Sexual: "Sexual",

  @doc("Represents content related to self-harm.")
  SelfHarm: "SelfHarm",

  @doc("Represents content involving protected material.")
  ProtectedMaterial: "ProtectedMaterial",

  @doc("Represents content related to code vulnerabilities.")
  CodeVulnerability: "CodeVulnerability",

  @doc("Represents content with ungrounded attributes.")
  UngroundedAttributes: "UngroundedAttributes",
}

@doc("Azure OpenAI model configuration. The API version would be selected by the service for querying the model.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v_latest)
model AzureOpenAIModelConfiguration extends TargetConfig {
  @visibility(Lifecycle.Read)
  type: "AzureOpenAIModel";

  @doc("Deployment name for AOAI model. Example: gpt-4o if in AIServices or connection based `connection_name/deployment_name` (i.e. `my-aoai-connection/gpt-4o`.")
  modelDeploymentName: string;
}

@doc("Abstract class for target configuration.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v_latest)
@discriminator("type")
model TargetConfig {
  @doc("Type of the model configuration.")
  type: string;
}

@doc("Red team details.")
@resource("runs")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v_latest)
model RedTeam {
  @doc("Identifier of the red team.")
  @key("name")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  id: string;

  @doc("Display name of the red-team scan.")
  displayName?: string;

  @doc("Number of simulation rounds.")
  numTurns: int32;

  @doc("List of attack strategies or nested lists of attack strategies.")
  attackStrategies: AttackStrategy[];

  @doc("Simulation-only or Simulation + Evaluation. Default false, if true the scan outputs conversation not evaluation result.")
  simulationOnly: boolean;

  @doc("List of risk categories to generate attack objectives for.")
  riskCategories: RiskCategory[];

  @doc("Application scenario for the red team operation, to generate scenario specific attacks.")
  applicationScenario?: string;

  @doc("Red team's tags. Unlike properties, tags are fully mutable.")
  tags?: Record<string>;

  @doc("Red team's properties. Unlike tags, properties are add-only. Once added, a property cannot be removed.")
  properties?: Record<string>;

  @doc("Status of the red-team. It is set by service and is read-only.")
  @visibility(Lifecycle.Read)
  status?: string;

  @doc("Read-only result outputs. Example: { 'evaluationResultId': 'azureai://accounts/{AccountName}/projects/{myproject}/evaluationresults/{name}/versions/{version}', 'logId': 'azureai://accounts/{AccountName}/projects/{myproject}/datasets/{dataset-name}/versions/{dataset-version}' }")
  @visibility(Lifecycle.Read)
  outputs: Record<string>;

  @doc("Metadata containing createdBy and modifiedBy information.")
  @visibility(Lifecycle.Read)
  systemData?: SystemData;

  @doc("Target configuration for the red-team run.")
  target: TargetConfig;
}

// private red-team upload
#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
@doc("Metadata")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v_latest)
model Metadata {
  @doc("List of target harms.")
  TargetHarms: Array<TargetHarm>;

  @doc("The language")
  Language: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
@doc("Message")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v_latest)
model Message {
  @doc("The role.")
  Role?: string;

  @doc("The content.")
  Content?: string;

  @doc("The context.")
  Context?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
@doc("Target Harm")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v_latest)
model TargetHarm {
  @doc("The risk type.")
  RiskType?: string;

  @doc("The risk sub type.")
  RiskSubType?: string;
}

@doc("Red team details.")
@resource("runs")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v_latest)
model RedTeamUpload {
  @doc("Identifier of the red team.")
  @key("name")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  id: string;

  @doc("Display name of the red-team scan.")
  displayName?: string;

  @doc("Number of simulation rounds.")
  numTurns?: int32;

  @doc("List of attack strategies or nested lists of attack strategies.")
  attackStrategies?: AttackStrategy[];

  @doc("Simulation-only or Simulation + Evaluation. Default false, if true the scan outputs conversation not evaluation result.")
  simulationOnly?: boolean;

  @doc("List of risk categories to generate attack objectives for.")
  riskCategories?: RiskCategory[];

  @doc("Application scenario for the red team operation, to generate scenario specific attacks.")
  applicationScenario?: string;

  @doc("Red team's tags. Unlike properties, tags are fully mutable.")
  tags?: Record<string>;

  @doc("Red team's properties. Unlike tags, properties are add-only. Once added, a property cannot be removed.")
  properties?: Record<string>;

  @doc("Status of the red-team. It is set by service and is read-only.")
  status?: string;

  @doc("Read-only result outputs. Example: { 'evaluationResultId': 'azureai://accounts/{AccountName}/projects/{myproject}/evaluationresults/{name}/versions/{version}' }")
  outputs?: Record<string>;

  @doc("Metadata containing createdBy and modifiedBy information.")
  @visibility(Lifecycle.Read)
  systemData?: SystemData;

  @doc("Target configuration for the red-team run.")
  target?: TargetConfig;
}

// Simulation Private Dto
#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
@doc("Attack Objective")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v_latest)
model AttackObjective {
  @doc("The unique identifier.")
  Id: string;

  @doc("The metadata.")
  Metadata?: Metadata;

  @doc("List of sources.")
  Source: Array<string>;

  @doc("The modality.")
  Modality: string;

  @doc("The messages.")
  Messages: Array<Message>;
}

@doc("Simulation type.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v_latest)
union SimulationType {
  string,

  @doc("Default simulation type.")
  Default: "Default",

  @doc("Custom persona simulation type.")
  CustomPersona: "CustomPersona",

  @doc("Harm turn generator simulation type.")
  HarmTurnGenerator: "HarmTurnGenerator",
}

@doc("Customization Parameters")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v_latest)
model CustomizationParameters {
  @doc("Application scenario.")
  ApplicationScenario?: string;

  @doc("List of harm categories.")
  HarmCategories: Array<string>;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
@doc("Customization Parameters")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v_latest)
model SimulationDTO {
  @doc("Additional headers.")
  Headers?: Record<string>;

  @doc("Parameters.")
  Params?: Record<string>;

  @doc("Template parameters.")
  TemplateParameters?: Record<string>;

  @doc("Customization parameters.")
  CustomizationParameters?: CustomizationParameters;

  @doc("Json.")
  Json?: string;

  @doc("Url.")
  Url?: string;

  @doc("Template key.")
  TemplateKey?: string;

  @doc("Type of Simulation.")
  SimulationType?: SimulationType;

  @doc("'True' if Microsoft internal tenant and 'False' otherwise.")
  IsMicrosoftTenant?: boolean;

  @doc("Azure subscription id.")
  SubscriptionId?: string;

  @doc("Resource group name.")
  ResourceGroupName?: string;

  @doc("Workspace name.")
  WorkspaceName?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
@doc("Simulation Result")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v_latest)
model SimulationResultDTO {
  @doc("Status Code.")
  StatusCode: int32;

  @doc("Content.")
  Content: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
#suppress "@azure-tools/typespec-azure-core/no-unknown"
@doc("Long Running Response")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v_latest)
model LongRunningResponse {
  @doc("The location.")
  Location: string;

  @doc("The OperationResult.")
  OperationResult: unknown;
}

#suppress "@azure-tools/typespec-providerhub/no-inline-model" "Need to create reponses correctly"
alias ResourceCreatedOrOkResponse<T extends TypeSpec.Reflection.Model> = TypeSpec.Http.Response<202> &
  T;

alias ChatChoiceCommon = {
  @doc("The ordered index associated with this chat completions choice.")
  index: int32;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "The operation already returns nulls"
  #suppress "@azure-tools/typespec-autorest/union-unsupported" "OpenAPI v2 support deferred"
  @doc("The reason that this chat completions choice completed its generated.")
  @visibility(Lifecycle.Read)
  finish_reason: CompletionsFinishReason | null;
};

@doc("A description of the intended purpose of a message within a chat completions interaction.")
union ChatRole {
  string,

  @doc("The role that instructs or sets the behavior of the assistant.")
  system: "system",

  @doc("The role that provides instructions to the model prioritized ahead of user messages.")
  developer: "developer",

  @doc("The role that provides input for chat completions.")
  user: "user",

  @doc("The role that provides responses to system-instructed, user-prompted input.")
  assistant: "assistant",

  @doc("The role that represents extension tool activity within a chat completions operation.")
  tool: "tool",
}

@doc("""
  Representation of the manner in which a completions response concluded.
  """)
union CompletionsFinishReason {
  string,

  @doc("Completions ended normally and reached its end of token generation.")
  stopped: "stop",

  @doc("Completions exhausted available token limits before generation could complete.")
  tokenLimitReached: "length",

  @doc("""
    Completions generated a response that was identified as potentially sensitive per content
    moderation policies.
    """)
  contentFiltered: "content_filter",

  @doc("Completion ended with the model calling a provided tool for output.")
  toolCalls: "tool_calls",
}

@doc("A representation of a chat message as received in a response.")
model ChatResponseMessage {
  @doc("The chat role associated with the message.")
  @visibility(Lifecycle.Read)
  role: ChatRole;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "explicitly nullable in mirrored API"
  @doc("The content of the message.")
  @visibility(Lifecycle.Read)
  content: string | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "explicitly nullable in mirrored API"
  @doc("The reasoning content the model used for generating the response")
  @visibility(Lifecycle.Read)
  reasoning_content?: string;
}

@doc("""
  The representation of a single prompt completion as part of an overall chat completions request.
  Generally, `n` choices are generated per provided prompt with a default value of 1.
  Token limits and other settings may limit the number of choices generated.
  """)
model ChatChoice {
  ...ChatChoiceCommon;

  @doc("The chat message for a given chat completions prompt.")
  @visibility(Lifecycle.Read)
  message: ChatResponseMessage;
}
#suppress "@azure-tools/typespec-providerhub/no-inline-model" "Need to create reponses correctly"
alias ChatCompletionsCommon = {
  @doc("A unique identifier associated with this chat completions response.")
  id: string;

  @doc("The response object type")
  object: string;

  #suppress "@microsoft/azure-openapi-validator/IntegerTypeMustHaveFormat" "Format is present but rule only allow int32 or int64."
  @doc("""
    The first timestamp associated with generation activity for this completions response,
    represented as seconds since the beginning of the Unix epoch of 00:00 on 1 Jan 1970.
    """)
  @encode(DateTimeKnownEncoding.unixTimestamp, int64)
  @visibility(Lifecycle.Read)
  created: utcDateTime;

  @doc("The model used for the chat completion.")
  @visibility(Lifecycle.Read)
  `model`: string;
};

@doc("""
  Representation of the response data from a chat completions request.
  Completions support a wide variety of tasks and generate text that continues from or "completes"
  provided prompt data.
  """)
model ChatCompletions {
  ...ChatCompletionsCommon;

  @doc("""
    The collection of completions choices associated with this completions response.
    Generally, `n` choices are generated per provided prompt with a default value of 1.
    Token limits and other settings may limit the number of choices generated.
    """)
  @visibility(Lifecycle.Read)
  choices: ChatChoice[];

  @doc("""
      Usage information for tokens processed and generated as part of this completions operation.
    """)
  @visibility(Lifecycle.Read)
  usage: CompletionsUsage;
}

@doc("""
  Representation of the token counts processed for a completions request.
  Counts consider all tokens across prompts, choices, choice alternates, best_of generations, and
  other consumers.
  """)
model CompletionsUsage {
  @doc("The number of tokens generated across all completions emissions.")
  @visibility(Lifecycle.Read)
  completion_tokens: int32;

  @doc("The number of tokens in the provided prompts for the completions request.")
  @visibility(Lifecycle.Read)
  prompt_tokens: int32;

  @doc("The total number of tokens processed for the completions request and response.")
  @visibility(Lifecycle.Read)
  total_tokens: int32;

  @doc("Breakdown of tokens used in a completion.")
  @visibility(Lifecycle.Read)
  completion_tokens_details?: CompletionsUsageDetails;

  @doc("Breakdown of tokens used in the prompt/chat history.")
  @visibility(Lifecycle.Read)
  prompt_tokens_details?: PromptUsageDetails;
}

@doc("A breakdown of tokens used in a completion.")
model CompletionsUsageDetails {
  @doc("The number of tokens corresponding to audio input.")
  @visibility(Lifecycle.Read)
  audio_tokens: int32;

  @doc("The number of tokens corresponding to reasoning.")
  @visibility(Lifecycle.Read)
  reasoning_tokens: int32;

  @doc("The total number of tokens processed for the completions request and response.")
  @visibility(Lifecycle.Read)
  total_tokens: int32;
}

@doc("A breakdown of tokens used in the prompt/chat history.")
model PromptUsageDetails {
  @doc("The number of tokens corresponding to audio input.")
  @visibility(Lifecycle.Read)
  audio_tokens: int32;

  @doc("The total number of tokens cached.")
  @visibility(Lifecycle.Read)
  cached_tokens: int32;
}
