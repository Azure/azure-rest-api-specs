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

  @doc("Represents a default set of moderate complexity attacks. Moderate complexity attack strategies are defined as attacks that require a Large Language Model to convert or orchestrate.")
  Moderate: "moderate",

  @doc("Represents a default set of difficult complexity attacks. Difficult complexity attack strategies are defined as attacks that require a Large Language Model to convert or orchestrate.")
  Difficult: "difficult",

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

  @doc("Represents ASCII attack, a technique for encoding or hiding data.")
  AnsiiAttack: "ansii_attack",

  @doc("Represents character swapping, a technique for rearranging characters in text.")
  CharacterSwap: "character_swap",

  @doc("Represents suffix appending, a technique for adding characters to the end of text.")
  SuffixAppend: "suffix_append",

  @doc("Represents string joining, a technique for concatenating strings.")
  StringJoin: "string_join",

  @doc("Represents Unicode confusable characters, which are characters that look similar but are different.")
  UnicodeConfusable: "unicode_confusable",

  @doc("Represents Unicode substitution, a technique for replacing characters with similar-looking Unicode characters.")
  UnicodeSubstitution: "unicode_substitution",

  @doc("Represents the use of emojis in text, which can be used to convey emotions or ideas.")
  Diacritic: "diacritic",

  @doc("Represents flipping characters, a technique for reversing the order of characters.")
  Flip: "flip",

  @doc("Represents leetspeak, a form of internet slang that replaces letters with similar-looking numbers or symbols.")
  Leetspeak: "leetspeak",

  @doc("Represents the ROT13 cipher, a substitution cipher that replaces a letter with the 13th letter after it in the alphabet.")
  ROT13: "rot13",

  @doc("Represents the morse code, a method for encoding text characters as sequences of dots and dashes.")
  Morse: "morse",

  @doc("Represents the url encoding, a method for encoding special characters in URLs.")
  Url: "url",

  @doc("Represents the baseline attack strategy, which is a standard or reference point for comparison.")
  Baseline: "baseline"
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
}
