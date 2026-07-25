// FIXTURE (positive): LRO and pagination shape. Seeded violations: DP-LRO-01,
// DP-LRO-03, DP-LRO-04, DP-PAGE-01, DP-PAGE-02, DP-PAGE-03.
// Not a real service. Not under specification/; not compiled by CI.

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
@server("https://{endpoint}", "Model Trainer service", { endpoint: string })
namespace ModelTrainer;

enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2026_01_01: "2026-01-01",
}

@doc("A trained model.")
model TrainedModel {
  @doc("The unique name of the model.")
  name: string;

  @doc("Location from which the trained model artifacts can be downloaded.")
  artifactUri: url;
}

// VIOLATION (DP-LRO-01): the status monitor has no `error` member, so a caller
// that polls to `Failed` has no way to learn why. It also omits `Canceled`
// while a cancel operation exists (DP-LRO-03), and offers no way to reach the
// result.
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

  @doc("Number of labelled examples in the dataset.")
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
  // VIOLATION (DP-LRO-04): `@pollingOperation` points at `getModel`, which
  // returns the model rather than the status monitor. An SDK poller built from
  // this never terminates.
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

  // VIOLATION (DP-LRO-03): a cancel operation exists, but `Canceled` is not a
  // reachable state in TrainingState.
  @doc("Cancels a training job.")
  @route("/trainingJobs/{jobId}:cancel")
  @post
  cancelTraining(@path jobId: string): void;

  // VIOLATION (DP-PAGE-01): unbounded, customer-populated collection returned
  // as a bare array with no paging.
  @doc("Lists all trained models.")
  @route("/models")
  @get
  listModels(): TrainedModel[];

  // VIOLATION (DP-PAGE-02): a sibling list in the same service uses a
  // completely different paging shape.
  // VIOLATION (DP-PAGE-03): `pageSize` and `skip` instead of `maxpagesize`,
  // over a mutable collection.
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
