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

@doc("Red team details.")
@resource("runs")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v_latest)
model RedTeam {
  @doc("Identifier of the red team.")
  @key("name")
  @visibility(Lifecycle.Read)
  id: string;

  @doc("Name of the red-team scan.")
  scanName?: string;

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
  @visibility(Lifecycle.Read)
  id: string;

  @doc("Name of the red-team scan.")
  scanName?: string;

  @doc("Number of simulation rounds.")
  numTurns?: int32;

  @doc("List of attack strategies or nested lists of attack strategies.")
  attackStrategy?: AttackStrategy[];

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
  @visibility(Lifecycle.Read)
  status?: string;

  @doc("Read-only result outputs. Example: { 'evaluationResultId': 'azureai://accounts/{AccountName}/projects/{myproject}/evaluationresults/{name}/versions/{version}' }")
  @visibility(Lifecycle.Read)
  outputs?: Record<string>;

  @doc("Metadata containing createdBy and modifiedBy information.")
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
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
