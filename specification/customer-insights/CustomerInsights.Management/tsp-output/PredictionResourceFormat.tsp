import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Hub.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.CustomerInsights;
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
interface Predictions {
  @doc("Gets a Prediction in the hub.")
  get is ArmResourceRead<PredictionResourceFormat>;
  @doc("Creates a Prediction or updates an existing Prediction in the hub.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<PredictionResourceFormat>;
  @doc("Deletes a Prediction in the hub.")
  delete is ArmResourceDeleteAsync<PredictionResourceFormat>;
  @doc("Gets all the predictions in the specified hub.")
  listByHub is ArmResourceListByParent<PredictionResourceFormat>;
  @doc("Gets training results.")
  getTrainingResults is ArmResourceActionSync<
    PredictionResourceFormat,
    void,
    PredictionTrainingResults
  >;
  @doc("Gets model status of the prediction.")
  getModelStatus is ArmResourceActionSync<
    PredictionResourceFormat,
    void,
    PredictionModelStatus
  >;
  @doc("Creates or updates the model status of prediction.")
  modelStatus is ArmResourceActionSync<
    PredictionResourceFormat,
    PredictionModelStatus,
    void
  >;
}
