using TypeSpec.Versioning;

namespace Azure.AI.Projects;

/** Base class for targets with discriminator support. */
@discriminator("type")
model Target {
  /** The type of target. */
  type: string;
}

/** Identifies a versioned Foundry dataset associated with an evaluation. */
model EvaluationDataset {
  /** Service-assigned identifier of the dataset. */
  id: string;

  /** Name of the dataset. */
  name: string;

  /** Version of the dataset. */
  version: string;
}

/** Configures the transcription model that converts speech to text for evaluation. */
model EvaluationTranscriptionModelConfiguration {
  /** Model or model deployment used for speech-to-text transcription. */
  `model`: string;
}

/** Provider used to convert text to speech. The union is extensible for additional providers. */
union EvaluationVoiceModelType {
  string,
  openai: "openai",
  azureStandard: "azure-standard",
  azureRealtimeNative: "azure-realtime-native",
}

/** Configures the voice model that converts text to speech for evaluation. */
model EvaluationVoiceModelConfiguration {
  /** Provider used to synthesize the voice. */
  type: EvaluationVoiceModelType;

  /** Provider-specific voice name, such as an OpenAI voice or Azure Speech voice name. */
  @minLength(1)
  name: string;

  /** Variability in synthesized speech, from 0.0 through 1.0, when supported by the provider. */
  @minValue(0)
  @maxValue(1)
  temperature?: float32;
}

/** Configures the model that plays the simulated user. This model is separate from the evaluated `target`. */
model EvaluationModelConfiguration {
  /** Model deployment that generates simulated user turns, in the format `{connectionName}/modelDeploymentName`. */
  `model`: string;

  /** Sampling parameters applied when the simulation model produces user turns. */
  sampling_params?: ModelSamplingParams;

  /** Transcription model configuration used to convert simulated user speech to text. Omit for text-only simulation. */
  transcription_model?: EvaluationTranscriptionModelConfiguration;

  /** Voice model configuration used to convert simulated user text to speech. Omit for text-only simulation. */
  voice_model?: EvaluationVoiceModelConfiguration;
}