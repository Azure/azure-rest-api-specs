import "../foundry-common/models.tsp";

using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

// Common preview flags used by simulation/evaluation types.
const SimulationsRequiredPreviews = #{
  conditional_previews: #[FoundryFeaturesOptInKeys.evaluations_v1_preview],
};

@doc("Identifies the simulation workflow represented by a simulation configuration or run item. The union is extensible so future simulation workflows can add new values.")
@extension("x-ms-foundry-meta", SimulationsRequiredPreviews)
union SimulationType {
  string,
  user_conversation: "user_conversation",
}

@doc("Identifies the kind of resource targeted by a simulation. The union is extensible so future target kinds can be added.")
union SimulationTargetType {
  string,
  agent: "agent",
}

@doc("Target invoked by a simulation run. A configuration can provide a default target, and an individual run can override it. The union is extensible to support target kinds beyond Foundry agents.")
@extension("x-ms-foundry-meta", SimulationsRequiredPreviews)
union SimulationTargetConfiguration {
  SimulationAgentTargetConfiguration,
}

@doc("Identifies a Foundry agent that receives the generated user turns during a simulation.")
@extension("x-ms-foundry-meta", SimulationsRequiredPreviews)
model SimulationAgentTargetConfiguration {
  @doc("Discriminator for an agent target. The value must be `agent`.")
  target_type: SimulationTargetType.agent;

  @doc("Name of the Foundry agent invoked by the simulation.")
  agent_name: string;

  @doc("Version of the Foundry agent invoked by the simulation. When omitted, the service resolves the applicable agent version.")
  agent_version?: string;
}

@doc("Controls the model used to generate simulated user behavior and, for audio simulations, transcription and voice output. A configuration can provide a default value, and an individual run can override it.")
model SimulationModelConfiguration {
  @doc("Name of the model or model deployment used by the simulator.")
  `model`: string;

  @doc("Sampling controls applied when the simulation model generates output.")
  model_sampling_parameters?: ModelSamplingParams;

  @doc("Model settings used to transcribe generated audio. This field is relevant to audio simulations.")
  audio_transcription_configuration?: AudioTranscriptionConfiguration;

  @doc("Provider and voice settings used to synthesize simulation audio. This field is relevant to audio simulations.")
  audio_voice_configuration?: AudioVoiceConfiguration;
}

@doc("Identifies the voice provider used to synthesize simulation audio. The union is extensible so additional providers can be added.")
@extension("x-ms-foundry-meta", SimulationsRequiredPreviews)
union AudioVoiceType {
  string,
  openai: "openai",
  azure_standard: "azure-standard",
  azure_realtime_native: "azure-realtime-native",
}

@doc("Configures synthesized voice output for an audio simulation.")
@extension("x-ms-foundry-meta", SimulationsRequiredPreviews)
model AudioVoiceConfiguration {
  @doc("Voice provider used to synthesize audio output.")
  type: AudioVoiceType;

  @doc("Provider-specific voice name used to synthesize audio output. The value cannot be empty.")
  @minLength(1)
  name: string;

  @doc("Temperature controlling variability in synthesized speech, when supported by the provider. The value must be between 0.0 and 1.0.")
  @minValue(0)
  @maxValue(1)
  temperature?: float32;
}

@doc("Configures transcription of audio generated during a simulation.")
@extension("x-ms-foundry-meta", SimulationsRequiredPreviews)
model AudioTranscriptionConfiguration {
  @doc("Name of the model or model deployment used to transcribe simulation audio. The service validates that the selected model is supported.")
  `model`: string;
}
