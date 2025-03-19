import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@typespec/openapi";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

namespace Azure.AI.Projects;

@doc("Strategies for attacks.")
enum AttackStrategy {
    Easy: "easy";
    Moderate: "moderate";
    Difficult: "difficult";
    AnsiAttack: "ansi_attack";
    AsciiArt: "ascii_art";
    AsciiSmuggler: "ascii_smuggler";
    Atbash: "atbash";
    Base64: "base64";
    Binary: "binary";
    Caesar: "caesar";
    CharacterSpace: "character_space";
    CharSwap: "char_swap";
    Diacritic: "diacritic";
    Flip: "flip";
    Leetspeak: "leetspeak";
    MaliciousQuestion: "malicious_question";
    Math: "math";
    Morse: "morse";
    Persuasion: "persuasion";
    ROT13: "rot13";
    RepeatToken: "repeat_token";
    SuffixAppend: "suffix_append";
    StringJoin: "string_join";
    Tense: "tense";
    Tone: "tone";
    Translation: "translation";
    UnicodeConfusable: "unicode_confusable";
    UnicodeSubstitution: "unicode_substitution";
    Url: "url";
    Variation: "variation";
    Baseline: "baseline";
    Jailbreak: "jailbreak";
}

@doc("Risk category for the attack objective.")
enum RiskCategory {
  HateUnfairness: "HateUnfairness",
  Violence: "Violence",
  Sexual: "Sexual",
  SelfHarm: "SelfHarm",
  ProtectedMaterial: "ProtectedMaterial",
  CodeVulnerability: "CodeVulnerability",
  UngroundedAttributes: "UngroundedAttributes"
}


@doc("Red team details.")
model RedTeam {
    @doc("Identifier of the red team.")
    @key("name")
    @visibility("read")
    id: string;

    @doc("Name of the red-team scan.")
    scanName: string;

    @doc("Number of simulation rounds.")
    numTurns: int;

    @doc("List of attack strategies or nested lists of attack strategies.")
    attackStrategy: AttackStrategy[];

    @doc("Simulation-only or Simulation + Evaluation. Default false, if true the scan outputs conversation not evaluation result.")
    simulationOnly: boolean;

    @doc("Output EvaluationResult json in the EvaluationResult asset. Example - azureml://project/azureml/evaluationresults/myevaluationresult1")
    outputId: string;

    @doc("List of risk categories to generate attack objectives for.")
    riskCategories: RiskCategories[];

    @doc("Application scenario for the red team operation, to generate scenario specific attacks.")
    applicationScenario?: string;

    @doc("Red team's tags. Unlike properties, tags are fully mutable.")
    tags?: Record<string>;

    @doc("Red team's properties. Unlike tags, properties are add-only. Once added, a property cannot be removed.")
    properties?: Record<string>;

    @doc("Metadata containing createdBy and modifiedBy information.")
    @visibility("read")
    systemData?: SystemData;

    @doc("Status of the red team. It is set by service and is read-only.")
    @visibility("read")
    status?: string;
}
