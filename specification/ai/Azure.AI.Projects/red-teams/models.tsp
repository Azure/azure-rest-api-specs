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

  @doc("Read-only result outputs. Example: { 'redTeamResultId': 'azureai://accounts/{AccountName}/projects/{myproject}/evaluationresults/{name}/{version}', 'logId': 'azureai://accounts/{AccountName}/projects/{myproject}/datasets/{dataset-name}/{dataset-version}' }")
  @visibility(Lifecycle.Read)
  outputs: Record<string>;

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
}
