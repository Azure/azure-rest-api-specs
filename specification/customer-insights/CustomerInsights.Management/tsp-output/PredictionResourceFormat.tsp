import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Hub.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CustomerInsights;
@doc("The prediction resource format.")
@parentResource(Hub)
model PredictionResourceFormat is ProxyResource<Prediction> {
  @doc("The name of the Prediction.")
  @path
  @key("predictionName")
  @segment("predictions")
  name: string;
}

@armResourceOperations
interface PredictionResourceFormats {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets a Prediction in the hub.")
  @operationId("Predictions_Get")
  get is ArmResourceRead<PredictionResourceFormat>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates a Prediction or updates an existing Prediction in the hub.")
  @operationId("Predictions_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<PredictionResourceFormat>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes a Prediction in the hub.")
  @operationId("Predictions_Delete")
  delete is ArmResourceDeleteAsync<PredictionResourceFormat>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets all the predictions in the specified hub.")
  @operationId("Predictions_ListByHub")
  listByHub is ArmResourceListByParent<PredictionResourceFormat>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets training results.")
  @operationId("Predictions_GetTrainingResults")
  getTrainingResults is ArmResourceActionSync<
    PredictionResourceFormat,
    void,
    PredictionTrainingResults
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets model status of the prediction.")
  @operationId("Predictions_GetModelStatus")
  getModelStatus is ArmResourceActionSync<
    PredictionResourceFormat,
    void,
    PredictionModelStatus
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates or updates the model status of prediction.")
  @operationId("Predictions_ModelStatus")
  modelStatus is ArmResourceActionSync<
    PredictionResourceFormat,
    PredictionModelStatus,
    void
  >;
}

@@projectedName(PredictionResourceFormats.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(PredictionResourceFormats.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(PredictionResourceFormats.createOrUpdate::parameters.resource,
  "Parameters supplied to the create/update Prediction operation."
);
@@projectedName(PredictionResourceFormats.modelStatus::parameters.body,
  "json",
  "parameters"
);
@@extension(PredictionResourceFormats.modelStatus::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(PredictionResourceFormats.modelStatus::parameters.body,
  "Parameters supplied to the create/update prediction model status operation."
);
