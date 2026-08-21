using TypeSpec.Versioning;

namespace Azure.AI.Projects;

/**
 * Evaluates a model or agent by simulating user conversations against it.
 *
 * Each source item defines a test scenario. Use a JSONL source or an `inline_user_conversation_simulation` source with strongly typed test cases. JSONL attributes use the inline test-case property names by default; specify `data_mapping` only when the dataset uses different names. The model specified by `model_configuration` generates the simulated user's turns and drives the conversation with `target` until it reaches the desired length or maximum turn limit. The evaluation's testing criteria are then applied to the conversation.
 */
model UserConversationSimulationEvalRunDataSource extends EvalRunDataSource {
  /** The type of data source, always `azure_ai_user_conversation_simulation_preview`. */
  type: "azure_ai_user_conversation_simulation_preview";

  /** Test scenarios supplied as JSONL rows or strongly typed inline test cases. */
  #suppress "@azure-tools/typespec-autorest/union-unsupported" "This union is defined according to the Azure OpenAI API."
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Auto-suppressed warnings non-applicable rules during import."
  source:
    | OpenAI.EvalJsonlFileContentSource
    | OpenAI.EvalJsonlFileIdSource
    | UserConversationSimulationInlineTestCasesSource;

  /** Model or agent being evaluated. It receives turns from the simulated user. */
  target: Target;

  /** Model used to simulate the user side of each conversation by generating turns sent to the evaluated `target`. */
  model_configuration: EvaluationModelConfiguration;

  /** Default configuration for generating simulated user conversations. Properties in a test case's `simulation_configuration` override the corresponding defaults. */
  default_simulation_configuration?: UserConversationSimulationConfiguration;

  /** Maps JSONL dataset attributes to user conversation simulation inputs when their names differ from the defaults. The default attribute names are `test_case_description` and `simulation_configuration`, matching `UserConversationSimulationTestCase`. Omit when the dataset uses these names or when using `inline_user_conversation_simulation`. */
  data_mapping?: Record<string>;

  /** Whether to save the simulated conversations as a versioned Foundry dataset. When enabled, the completed run includes `output_dataset`. Defaults to `false`. */
  enable_output_dataset_generation?: boolean = false;
}

/** Configures the number, length, and audio effects of simulated user conversations. */
model UserConversationSimulationConfiguration {
  /** Hard limit on turns in each conversation. Defaults to 20 when not specified at either the data-source or test-case level. */
  max_turns?: int32;

  /** Number of independent conversation repetitions for each test case. Defaults to 1 when not specified at either the data-source or test-case level. */
  conversation_repetitions?: int32;

  /** Target number of turns in each conversation. The effective value cannot exceed the effective `max_turns`. */
  desired_turns?: int32;

  /** Audio effects applied to voice conversation simulations. This property is ignored for text-only simulations. */
  audio_effects?: UserConversationSimulationAudioEffectsConfiguration;
}

/** Ambient sound that can be mixed into simulated conversation audio. The union is extensible for additional effects. */
union UserConversationSimulationAmbientEffect {
  string,
  streetTraffic: "street_traffic",
  crowdChatter: "crowd_chatter",
  backgroundTv: "background_tv",
  metroStation: "metro_station",
}

/** Configures ambient sound, telephony processing, and interruption behavior for simulated conversation audio. */
model UserConversationSimulationAudioEffectsConfiguration {
  /** Ambient sounds to mix into simulated audio. */
  ambience_effects?: UserConversationSimulationAmbientEffect[];

  /** Volume of the configured ambient sounds, as a percentage from 1 through 100. */
  @minValue(1)
  @maxValue(100)
  ambience_volume_percentage?: int32;

  /** Whether simulated speech is processed to emulate telephone audio. Defaults to `false`. */
  enable_telephonic_voice?: boolean = false;

  /** Whether the simulated user can interrupt the target while it is speaking. Defaults to `false`. */
  enable_interruption?: boolean = false;
}

/** Defines one test scenario. Simulation configuration properties specified here override the corresponding data-source defaults. */
model UserConversationSimulationTestCase {
  /** Scenario, simulated user goal, and behavioral constraints that guide the conversation. The maximum length is 2,500 characters. */
  @maxLength(2500)
  test_case_description?: string;

  /** Configuration for conversations generated from this test case. Each specified property overrides the corresponding property in `default_simulation_configuration`. */
  simulation_configuration?: UserConversationSimulationConfiguration;
}

/** Supplies strongly typed test scenarios directly in the evaluation run request. */
model UserConversationSimulationInlineTestCasesSource {
  /** The source type. Always `inline_user_conversation_simulation`. */
  type: "inline_user_conversation_simulation";

  /** Test scenarios from which user conversations are simulated. At least one test case is required. */
  @minItems(1)
  test_cases: UserConversationSimulationTestCase[];
}

