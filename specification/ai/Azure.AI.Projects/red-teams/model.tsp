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
  ProtectedMaterial: "ProtectedMaterial",,
  IndirectJailbreak: "IndirectJailbreak",
  DirectJailbreak: "DirectJailbreak",
  Codevulnerability: "Codevulnerability",
  InferenceSensitiveAttributes: "InferenceSensitiveAttributess"
}

// Todo how we map this to the service needs more work, especially for dynamic. Right now we can just this be a placeholder for static.
model AttackObjective {
  @doc("List of risk categories to generate attack objectives for.")
  riskCategories: RiskCategories[];

  @doc("The number of objectives per risk category.")
  numObjectives: int;
}

// orchestration APIs - todo find this: red_team_operation 
@doc("Customization Parameters")
model RedTeam {
    // one idea is to integrate this with the PyRIT target: https://azure.github.io/PyRIT/code/architecture.html#target
    // todo - how would this map to c#?
    @doc("Target configuration for the red team operation.")
    target: Callable | AzureOpenAIModelConfiguration | OpenAIModelConfiguration | PromptChatTarget;

    // TODO needs to be reconstructed given the service integration.
    @doc("Name of the evaluation for the run when you upload the result.")
    evaluationName: string;

    @doc("Number of simulation rounds.")
    numTurns: int;

    // todo - how would this map to c#?
    @doc("List of attack strategies or nested lists of attack strategies.")
    attackStrategy: AttackStrategy | AttackStrategy[][];

    //todo what is this?
    @doc("data only.")
    dataOnly: boolean;

    // TODO this needs to align with EvaluationResult asset type - which is going to map to this json.
    // https://github.com/Azure/azureml_run_specification/blob/3ac2cf1cb5eb80d929898c1be5800667e066cd1c/specs/rai/Automated-Redteaming.md#sample-evaluation-results-json
    // RedTeamAgentResult | Record<string, string | PathLike> - is actually going to get lumped into this
    @doc("Output EvaluationResult json.")
    outputPath: string;

    // Todo - attack ObjectiveGenerator - this would be better as a data pointer...the object doesn't give much
    @doc("Attack ObjectiveGenerator.")
    attackObjectiveGenerator: AttackObjectiveGenerator;


    // application_scenario: Optional[str] = None) -> Union[RedTeamAgentResult, Dict[str, Union[str, os.PathLike]]]:
    // todo can't we lump this into target?
    @doc("Application scenario for the red team operation.")
    applicationScenario?: string;
}
