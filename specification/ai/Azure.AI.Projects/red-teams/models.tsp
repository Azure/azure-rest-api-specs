import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@typespec/openapi";
import "../common/models.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

@doc("Strategies for attacks.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
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
@removed(Versions.v1)
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
}

@doc("Azure OpenAI model configuration. The API version would be selected by the service for querying the model.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model AzureOpenAIModelConfiguration extends TargetConfig {
  type: "AzureOpenAIModel";

  @doc("Deployment name for AOAI model. Example: gpt-4o if in AIServices or connection based `connection_name/deployment_name` (e.g. `my-aoai-connection/gpt-4o`).")
  modelDeploymentName: string;
}

@doc("Abstract class for target configuration.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
@discriminator("type")
model TargetConfig {
  @doc("Type of the model configuration.")
  type: string;
}

@doc("Red team details.")
@resource("runs")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model RedTeam {
  @doc("Identifier of the red team run.")
  @key("name")
  @encodedName("application/json", "id")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("Name of the red-team run.")
  displayName?: string;

  @doc("Number of simulation rounds.")
  numTurns?: int32;

  @doc("List of attack strategies or nested lists of attack strategies.")
  attackStrategies?: AttackStrategy[];

  @doc("Simulation-only or Simulation + Evaluation. Default false, if true the scan outputs conversation not evaluation result.")
  simulationOnly?: boolean = false;

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

  @doc("Target configuration for the red-team run.")
  target: TargetConfig;
}
