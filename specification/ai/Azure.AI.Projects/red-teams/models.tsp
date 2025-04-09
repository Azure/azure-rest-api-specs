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

  @doc("Represents a default set of easy complexity attacks. Easy complexity attack strategies are defined as attacks that do not require any Large Language Model to convert or orchestrate.")
  Easy: "easy",

  @doc("Represents ASCII art, a graphic design technique that uses printable characters.")
  AsciiArt: "ascii_art",

  @doc("Represents ASCII smuggling, a technique for encoding or hiding data.")
  AsciiSmuggler: "ascii_smuggler",

  @doc("Represents the Atbash cipher, a substitution cipher that reverses the alphabet.")
  Atbash: "atbash",

  @doc("Represents Base64 encoding, a method for encoding binary data as text.")
  Base64: "base64",

  @doc("Represents binary encoding, a representation of data in binary format.")
  Binary: "binary",

  @doc("Represents the Caesar cipher, a substitution cipher that shifts characters.")
  Caesar: "caesar",

  @doc("Represents character space manipulation, a technique involving spacing between characters.")
  CharacterSpace: "character_space",

  @doc("Represents character swapping, a technique for rearranging characters in text.")
  Jailbreak: "jailbreak",
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
  scanName: string;

  @doc("Number of simulation rounds.")
  numTurns: int32;

  @doc("List of attack strategies or nested lists of attack strategies.")
  attackStrategy: AttackStrategy[];

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
  Default: "Default";

  @doc("Custom persona simulation type.")
  CustomPersona: "CustomPersona";

  @doc("Harm turn generator simulation type.")
  HarmTurnGenerator: "HarmTurnGenerator";
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