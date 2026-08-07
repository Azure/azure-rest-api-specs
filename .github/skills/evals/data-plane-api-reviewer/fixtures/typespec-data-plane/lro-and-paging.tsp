import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

@service(#{ title: "Model Trainer" })
@versioned(Versions)
@useAuth(
  OAuth2Auth<[
    {
      type: OAuth2FlowType.clientCredentials,
      tokenUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/token",
      scopes: ["https://modeltrainer.azure.com/.default"],
    }
  ]>
)
@server("https://{endpoint}", "Model Trainer service", { endpoint: string })
namespace ModelTrainer;

enum Versions {
  v2026_01_01: "2026-01-01",
}

@doc("A trained model.")
model TrainedModel {
  @doc("The unique name of the model.")
  name: string;

  @doc("Location from which the trained model artifacts can be downloaded.")
  artifactUri: url;
}

@doc("Status of a training job.")
model TrainingStatus {
  @doc("The unique identifier of the training job.")
  jobId: string;

  @doc("Current state of the training job.")
  state: TrainingState;
}

@doc("State of a training job.")
union TrainingState {
  string,

  @doc("Training is in progress.")
  Running: "Running",

  @doc("Training completed successfully.")
  Succeeded: "Succeeded",

  @doc("Training failed.")
  Failed: "Failed",
}

@doc("A training dataset.")
model Dataset {
  @doc("The unique name of the dataset.")
  name: string;

  @doc("Number of labeled examples in the dataset.")
  exampleCount: int32;
}

@doc("A page of datasets using a service-specific continuation shape.")
model DatasetPage {
  @doc("The datasets in this page.")
  datasets: Dataset[];

  @doc("Opaque token to pass to the next call to continue enumeration.")
  continuationToken?: string;
}

interface Training {
  @doc("Starts training a model.")
  @pollingOperation(Training.getModel)
  @route("/models:train")
  @post
  train(@body body: TrainingRequest): AcceptedResponse;

  @doc("Gets a trained model.")
  @route("/models/{name}")
  @get
  getModel(@path name: string): TrainedModel;

  @doc("Gets the status of a training job.")
  @route("/trainingJobs/{jobId}")
  @get
  getTrainingStatus(@path jobId: string): TrainingStatus;

  @doc("Cancels a training job.")
  @route("/trainingJobs/{jobId}:cancel")
  @post
  cancelTraining(@path jobId: string): void;

  @doc("Lists all trained models.")
  @route("/models")
  @get
  listModels(): TrainedModel[];

  @doc("Lists datasets.")
  @route("/datasets")
  @get
  listDatasets(@query pageSize?: int32, @query skip?: int32): DatasetPage;
}

@doc("Request to start a training job.")
model TrainingRequest {
  @doc("Name of the dataset to train on.")
  datasetName: string;
}
