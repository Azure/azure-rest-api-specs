using TypeSpec.OpenAPI;

namespace OpenAI;

union CreateFineTuningJobRequestHyperparametersBatchSizeChoiceEnum {
  auto: "auto",
}
union CreateFineTuningJobRequestHyperparametersBatchSizeOption {
  CreateFineTuningJobRequestHyperparametersBatchSizeChoiceEnum,
  int32,
}

union CreateFineTuningJobRequestHyperparametersLearningRateMultiplierChoiceEnum {
  auto: "auto",
}
union CreateFineTuningJobRequestHyperparametersLearningRateMultiplierOption {
  CreateFineTuningJobRequestHyperparametersLearningRateMultiplierChoiceEnum,
  float32,
}

union CreateFineTuningJobRequestHyperparametersNEpochsChoiceEnum {
  auto: "auto",
}
union CreateFineTuningJobRequestHyperparametersNEpochsOption {
  CreateFineTuningJobRequestHyperparametersNEpochsChoiceEnum,
  int32,
}

union CreateFineTuningJobRequestHyperparametersBetaChoiceEnum {
  auto: "auto",
}
union CreateFineTuningJobRequestHyperparametersBetaOption {
  CreateFineTuningJobRequestHyperparametersLearningRateMultiplierChoiceEnum,
  int32,
}

@discriminator("type")
model CreateFineTuningJobRequestIntegration {
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Auto-suppressed warnings non-applicable rules during import."
  type: string | "wandb";
}

model CreateFineTuningJobRequestWandbIntegration
  extends CreateFineTuningJobRequestIntegration {
  type: "wandb";
  wandb: {
    project: string;
    name?: string | null;
    entity?: string | null;
    tags?: string[];
  };
}

@discriminator("type")
model FineTuningIntegration {
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Auto-suppressed warnings non-applicable rules during import."
  type: string | "wandb";
}

model FineTuningJobsPageToken {
  limit?: int32;
  after?: string;
}
