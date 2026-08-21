using TypeSpec.Versioning;

namespace Azure.AI.Projects;

/** Base class for targets with discriminator support. */
@discriminator("type")
model FoundryEvaluationTarget {
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

/** Configuration for speech-to-text transcription used during evaluation. */
model EvaluationAudioTranscriptionModelConfiguration {
  /** The transcription model. */
  `model`: EvaluationAudioTranscriptionModel;
}

/** Supported speech-to-text transcription models. The union is extensible for additional models. */
union EvaluationAudioTranscriptionModel {
  string,
  mai_transcribe_1: "mai-transcribe-1",
  azure_speech: "azure-speech",
}

/** Voice configuration used to convert text to speech for evaluation. All supported voice types use the Voice Live endpoint under the hood. */
@discriminator("type")
model EvaluationVoiceModelConfiguration {
  /** The voice kind. */
  type: string;
}

/** Configures an OpenAI built-in voice for evaluation. */
model EvaluationOpenAIVoiceModelConfiguration
  extends EvaluationVoiceModelConfiguration {
  /** The voice kind. Always `openai`. */
  type: "openai";

  /** The OpenAI built-in voice name. */
  @minLength(1)
  name: string;
}

/** Configures an Azure standard neural voice for evaluation. */
model EvaluationAzureStandardVoiceModelConfiguration
  extends EvaluationVoiceModelConfiguration {
  /** The voice kind. Always `azure-standard`. */
  type: "azure-standard";

  /** The Azure neural voice name. */
  @minLength(1)
  name: string;

  /** The synthesis temperature, from 0 to 1. When omitted, the service defaults to the underlying voice model's default temperature. */
  @minValue(0)
  @maxValue(1)
  temperature?: float32;
}

/** Configures an Azure realtime-native voice for evaluation. */
model EvaluationAzureRealtimeNativeVoiceModelConfiguration
  extends EvaluationVoiceModelConfiguration {
  /** The voice kind. Always `azure-realtime-native`. */
  type: "azure-realtime-native";

  /** The Azure realtime-native voice name. When omitted, the service defaults to `ava`. */
  @minLength(1)
  name?: string = "ava";
}

/** Configures the model that plays the simulated user. This model is separate from the evaluated `target`. */
model EvaluationModelConfiguration {
  /** Model deployment that generates simulated user turns, in the format `{connectionName}/modelDeploymentName`. */
  `model`: string;

  /** Sampling parameters applied when the simulation model produces user turns. */
  sampling_params?: ModelSamplingParams;

  /** Transcription model configuration used to convert simulated user speech to text. Omit for text-only simulation. */
  transcription_model?: EvaluationAudioTranscriptionModelConfiguration;

  /** Voice model configuration used to convert simulated user text to speech. Omit for text-only simulation. */
  voice_model?: EvaluationVoiceModelConfiguration;
}
