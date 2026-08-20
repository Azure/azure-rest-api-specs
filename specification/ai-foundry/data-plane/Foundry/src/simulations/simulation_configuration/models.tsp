import "../../foundry-common/models.tsp";
import "../simulations_common.tsp";

using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

model UserConversationSimulationTestCase {
  @doc("Free-form description of the test case. The maximum length is 2,500 characters.")
  @maxLength(2500)
  test_case_description?: string;

  @doc("Maximum number of turns to allow in each conversation for this test case.")
  max_turns?: int32;

  @doc("Number of conversations to run for this test case.")
  conversations_count?: int32;

  @doc("Audio environment settings for this test case. These settings override the configuration-level audio environment settings.")
  audio_environment_configuration?: AudioEnvironmentConfiguration;
}

@extension("x-ms-foundry-meta", SimulationsRequiredPreviews)
union UserConversationSimulationModality {
  string,
  audio: "audio",
  text: "text",
}

@extension("x-ms-foundry-meta", SimulationsRequiredPreviews)
model UserConversationSimulationTestCasesConfiguration {
  @doc("Type of simulation test case configuration. Must be user_conversation.")
  type: SimulationType.user_conversation;

  @doc("Conversation modality for the simulation. If omitted, the server defaults this based on the target kind.")
  conversation_modality?: UserConversationSimulationModality;

  @doc("Reference to the dataset containing test case inputs for the simulation. At least one of `id` or `name` must be supplied.")
  test_cases_dataset?: FoundryDatasetReference;

  @doc("Inline list of test cases to execute. At least one test case is required.")
  @minItems(1)
  inline_test_cases?: UserConversationSimulationTestCase[];

  @doc("Default maximum number of turns for any conversation unless overridden by a test case.")
  default_max_turns?: int32 = 20;

  @doc("Default number of conversations to run per test case unless overridden at the test case level.")
  default_conversations_count?: int32 = 1;

  @doc("Default audio environment settings for all test cases. Test case-level settings take precedence when provided.")
  default_audio_environment_configuration?: AudioEnvironmentConfiguration;
}

@extension("x-ms-foundry-meta", SimulationsRequiredPreviews)
union SimulationTestCasesConfiguration {
  UserConversationSimulationTestCasesConfiguration,
}

@extension("x-ms-foundry-meta", SimulationsRequiredPreviews)
model SimulationConfiguration {
  @doc("Unique identifier of the simulation configuration.")
  @visibility(Lifecycle.Read)
  id: string;

  @doc("Display name of the simulation configuration.")
  name: string;

  @doc("Version identifier for this simulation configuration.")
  version: string;

  @doc("Configuration describing the test cases that will be executed by the simulation.")
  test_cases_configuration: SimulationTestCasesConfiguration;

  @doc("Default model configuration for simulation runs, including sampling and audio settings. A run-level model configuration overrides this value.")
  default_model_configuration?: SimulationModelConfiguration;

  @doc("Default target configuration used when a simulation target is not explicitly specified.")
  default_target?: SimulationTargetConfiguration;

  @doc("Timestamp when the simulation configuration was created.")
  @visibility(Lifecycle.Read)
  created_at: FoundryTimestamp;

  @doc("Timestamp when the simulation configuration was last updated.")
  @visibility(Lifecycle.Read)
  updated_at?: FoundryTimestamp;
}

@extension("x-ms-foundry-meta", SimulationsRequiredPreviews)
model AudioEnvironmentConfiguration {
  @doc("Ambient effects to apply in the simulation audio environment.")
  ambience_effects?: AmbientEffect[];

  @doc("Ambient audio percentage level for the environment, between 1 and 100.")
  @minValue(1)
  @maxValue(100)
  ambience_volume_percentage?: int32;

  @doc("Whether generated speech should emulate telephonic audio. Defaults to `false`.")
  enable_telephonic_voice?: boolean = false;
}

union AmbientEffect {
  street_traffic: "street_traffic",
  crowd_chatter: "crowd_chatter",
  background_tv: "background_tv",
  metro_station: "metro_station",
  string,
}
