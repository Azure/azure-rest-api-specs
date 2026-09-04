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
  source: UserConversationSimulationSource;

  /** Model or agent being evaluated. It receives turns from the simulated user. */
  target: FoundryEvaluationTarget;

  /** Model used to simulate the user side of each conversation by generating turns sent to the evaluated `target`. */
  model_configuration: EvaluationModelConfiguration;

  /** Default configuration for generating simulated user conversations. Properties in a test case's `simulation_configuration` override the corresponding defaults. */
  default_simulation_configuration?: UserConversationSimulationConfiguration;

  /** Maps JSONL dataset attributes to user conversation simulation inputs when their names differ from the defaults. The default attribute names are `test_case_id`, `test_case_category`, `test_case_description`, and `simulation_configuration`, matching `UserConversationSimulationTestCase`. Omit when the dataset uses these names or when using `inline_user_conversation_simulation`. */
  data_mapping?: Record<string>;

  /** Whether to write all generated conversations to a file in a versioned Foundry dataset, providing visibility into the generated conversations. The dataset can be reused in future evaluation runs. When enabled, the completed run includes `output_dataset`. When omitted, the service defaults to `false`. */
  enable_conversation_dataset_generation?: boolean = false;
}

/** Sources supported by user conversation simulation. */
#suppress "@azure-tools/typespec-autorest/union-unsupported" "This union is defined according to the Azure OpenAI API."
union UserConversationSimulationSource {
  evalJsonlFileContent: OpenAI.EvalJsonlFileContentSource,
  evalJsonlFileId: OpenAI.EvalJsonlFileIdSource,
  inlineTestCases: UserConversationSimulationInlineTestCasesSource,
}

/** Configures the number, length, audio effects, and simulated user behavior of conversations. */
model UserConversationSimulationConfiguration {
  /** Hard limit on turns in each conversation. When omitted, the service defaults to 20. */
  @minValue(1)
  max_num_turns?: int32 = 20;

  /** Number of independent conversation repetitions for each test case. Defaults to 1 when not specified at either the data-source or test-case level. */
  @minValue(1)
  conversation_repetitions?: int32 = 1;

  /** Target number of turns in each conversation. The effective value cannot exceed the effective `max_num_turns`. When omitted, no target is set and the simulation model determines the conversation length dynamically from the scenario. */
  @minValue(1)
  desired_num_turns?: int32;

  /** Audio effects applied to voice conversation simulations. This property is ignored for text-only simulations. */
  audio_effects?: UserConversationSimulationAudioEffectsConfiguration;

  /** Conversation behavior of the simulated user. */
  user_behavior?: UserConversationSimulationUserBehaviorConfiguration;
}

/** Effect that can be applied to simulated conversation audio. The union is extensible for additional effects. */
union UserConversationSimulationAudioEffect {
  string,
  streetTraffic: "street_traffic",
  crowdChatter: "crowd_chatter",
  backgroundTv: "background_tv",
  metroStation: "metro_station",
  telephonicVoice: "telephonic_voice",
}

/** Configures effects applied to simulated conversation audio. */
model UserConversationSimulationAudioEffectsConfiguration {
  /** Effects to apply to simulated audio. */
  effects?: UserConversationSimulationAudioEffect[];

  /** Volume of the configured audio effects, as a percentage from 1 through 100. When omitted, the service defaults to 15. */
  @minValue(1)
  @maxValue(100)
  volume_percentage?: int32 = 15;
}

/** Configures conversation behavior for the simulated user. */
model UserConversationSimulationUserBehaviorConfiguration {
  /** Configures how the simulated user interrupts the target while it is speaking. Omit to disable interruption. */
  interruption?: UserConversationSimulationInterruptionConfiguration;
}

/** Configuration for simulated user interruption behavior. */
@discriminator("type")
model UserConversationSimulationInterruptionConfiguration {
  /** The interruption type. */
  type: string;
}

/** Configures the default interruption behavior for the simulated user. */
model UserConversationSimulationDefaultInterruptionConfiguration
  extends UserConversationSimulationInterruptionConfiguration {
  /** The interruption type, always `default`. */
  type: "default";
}

/** Defines one test scenario. Simulation configuration properties specified here override the corresponding data-source defaults. */
model UserConversationSimulationTestCase {
  /** Identifier for the test case. When omitted, the service generates a random identifier. */
  test_case_id?: string;

  /** Category used to group related test cases. When omitted, the service leaves the category null. */
  test_case_category?: string;

  /** Scenario, simulated user goal, and behavioral constraints that guide the conversation. The length must be from 1 through 2,500 characters. */
  @minLength(1)
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
