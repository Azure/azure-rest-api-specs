using TypeSpec.Versioning;

namespace Azure.AI.Projects;

/** Sources supported by user conversation simulation. */
#suppress "@azure-tools/typespec-autorest/union-unsupported" "This union is defined according to the Azure OpenAI API."
#suppress "@azure-tools/typespec-client-generator-core/use-union-hierarchy" "Pre-existing API contract; preserve the existing API and SDK union representation."
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

/** Configures default conversation behavior and optional run-wide persistence of generated conversations. */
model UserConversationSimulationDefaultConfiguration {
  ...UserConversationSimulationConfiguration;

  /** Whether to write all generated conversations to a versioned Foundry dataset. When enabled, the completed run includes a `simulated_user_conversations` entry in `output_datasets`. When omitted, the service defaults to `false`. */
  enable_conversation_dataset_generation?: boolean = false;

  /** Name of the dataset to which generated conversations are written. This property is used only when `enable_conversation_dataset_generation` is `true`. When omitted, the service generates a dataset name. */
  @minLength(1)
  output_conversation_dataset_name?: string;
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
