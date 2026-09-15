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

/** Purpose of a dataset produced by an evaluation run. The union is extensible for additional output types. */
union EvaluationOutputDatasetType {
  string,
  simulatedUserConversations: "simulated_user_conversations",
}

/** A typed reference to a dataset produced by an evaluation run. */
model EvaluationOutputDataset {
  /** Purpose of the generated dataset. */
  type: EvaluationOutputDatasetType;

  /** Generated dataset reference. */
  dataset: EvaluationDataset;
}

/** Voice configuration used to convert text to speech for evaluation through the Voice Live endpoint. */
@discriminator("type")
model EvaluationVoiceModelConfiguration {
  /** The voice kind. */
  type: string;
}

/** Configures an Azure standard neural voice used to convert text to speech for evaluation through the Voice Live endpoint. */
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

/** Configures the model that plays the simulated user. This model is separate from the evaluated `target`. */
model EvaluationModelConfiguration {
  /** Model deployment that generates simulated user turns, in the format `{connectionName}/modelDeploymentName`. */
  `model`: string;

  /** Sampling parameters applied when the simulation model produces user turns. */
  sampling_params?: ModelSamplingParams;

  /** Voice configuration used to convert simulated user text to speech. Currently, only Azure standard voices are supported. Omit for text-only simulation. */
  voice_model?: EvaluationVoiceModelConfiguration;
}
