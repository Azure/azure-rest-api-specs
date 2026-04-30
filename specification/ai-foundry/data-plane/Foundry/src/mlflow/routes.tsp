import "./models.tsp";
import "../common/models.tsp";

using TypeSpec.Http;

namespace Azure.AI.Projects.Mlflow;

@tag("MLflow Experiments")
@route("/mlflow/api/2.0/mlflow/experiments")
interface Experiments {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "MLflow compatibility route"
  @doc("Create an MLflow experiment.")
  @post
  @route("create")
  create is Azure.AI.Projects.FoundryDataPlaneOperation<
    { @bodyRoot payload: MlflowPayload },
    MlflowResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "MLflow compatibility route"
  @doc("Get an MLflow experiment by ID.")
  @get
  @route("get")
  get is Azure.AI.Projects.FoundryDataPlaneOperation<
    MlflowExperimentQueryParameters,
    MlflowResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "MLflow compatibility route"
  @doc("Get an MLflow experiment by name.")
  @get
  @route("get-by-name")
  getByName is Azure.AI.Projects.FoundryDataPlaneOperation<
    MlflowExperimentQueryParameters,
    MlflowResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "MLflow compatibility route"
  @doc("Search MLflow experiments.")
  @post
  @route("search")
  search is Azure.AI.Projects.FoundryDataPlaneOperation<
    { @bodyRoot payload: MlflowPayload },
    MlflowResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "MLflow compatibility route"
  @doc("Update MLflow experiment metadata.")
  @post
  @route("update")
  update is Azure.AI.Projects.FoundryDataPlaneOperation<
    { @bodyRoot payload: MlflowPayload },
    MlflowResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "MLflow compatibility route"
  @doc("Delete an MLflow experiment.")
  @post
  @route("delete")
  delete is Azure.AI.Projects.FoundryDataPlaneOperation<
    { @bodyRoot payload: MlflowPayload },
    MlflowResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "MLflow compatibility route"
  @doc("Restore a deleted MLflow experiment.")
  @post
  @route("restore")
  restore is Azure.AI.Projects.FoundryDataPlaneOperation<
    { @bodyRoot payload: MlflowPayload },
    MlflowResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "MLflow compatibility route"
  @doc("Set an MLflow experiment tag.")
  @post
  @route("set-experiment-tag")
  setTag is Azure.AI.Projects.FoundryDataPlaneOperation<
    { @bodyRoot payload: MlflowPayload },
    MlflowResponse
  >;
}

@tag("MLflow Runs")
@route("/mlflow/api/2.0/mlflow/runs")
interface Runs {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "MLflow compatibility route"
  @doc("Create an MLflow run.")
  @post
  @route("create")
  create is Azure.AI.Projects.FoundryDataPlaneOperation<
    { @bodyRoot payload: MlflowPayload },
    MlflowResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "MLflow compatibility route"
  @doc("Get an MLflow run.")
  @get
  @route("get")
  get is Azure.AI.Projects.FoundryDataPlaneOperation<
    MlflowRunQueryParameters,
    MlflowResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "MLflow compatibility route"
  @doc("Search MLflow runs.")
  @post
  @route("search")
  search is Azure.AI.Projects.FoundryDataPlaneOperation<
    { @bodyRoot payload: MlflowPayload },
    MlflowResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "MLflow compatibility route"
  @doc("Update MLflow run metadata or status.")
  @post
  @route("update")
  update is Azure.AI.Projects.FoundryDataPlaneOperation<
    { @bodyRoot payload: MlflowPayload },
    MlflowResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "MLflow compatibility route"
  @doc("Delete an MLflow run.")
  @post
  @route("delete")
  delete is Azure.AI.Projects.FoundryDataPlaneOperation<
    { @bodyRoot payload: MlflowPayload },
    MlflowResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "MLflow compatibility route"
  @doc("Restore a deleted MLflow run.")
  @post
  @route("restore")
  restore is Azure.AI.Projects.FoundryDataPlaneOperation<
    { @bodyRoot payload: MlflowPayload },
    MlflowResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "MLflow compatibility route"
  @doc("Log a batch of metrics, parameters, and tags to an MLflow run.")
  @post
  @route("log-batch")
  logBatch is Azure.AI.Projects.FoundryDataPlaneOperation<
    { @bodyRoot payload: MlflowPayload },
    MlflowResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "MLflow compatibility route"
  @doc("Log one metric to an MLflow run.")
  @post
  @route("log-metric")
  logMetric is Azure.AI.Projects.FoundryDataPlaneOperation<
    { @bodyRoot payload: MlflowPayload },
    MlflowResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "MLflow compatibility route"
  @doc("Log one parameter to an MLflow run.")
  @post
  @route("log-parameter")
  logParameter is Azure.AI.Projects.FoundryDataPlaneOperation<
    { @bodyRoot payload: MlflowPayload },
    MlflowResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "MLflow compatibility route"
  @doc("Set an MLflow run tag.")
  @post
  @route("set-tag")
  setTag is Azure.AI.Projects.FoundryDataPlaneOperation<
    { @bodyRoot payload: MlflowPayload },
    MlflowResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "MLflow compatibility route"
  @doc("Delete an MLflow run tag.")
  @post
  @route("delete-tag")
  deleteTag is Azure.AI.Projects.FoundryDataPlaneOperation<
    { @bodyRoot payload: MlflowPayload },
    MlflowResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "MLflow compatibility route"
  @doc("Log MLflow model metadata.")
  @post
  @route("log-model")
  logModel is Azure.AI.Projects.FoundryDataPlaneOperation<
    { @bodyRoot payload: MlflowPayload },
    MlflowResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "MLflow compatibility route"
  @doc("Log MLflow run input relationships.")
  @post
  @route("log-inputs")
  logInputs is Azure.AI.Projects.FoundryDataPlaneOperation<
    { @bodyRoot payload: MlflowPayload },
    MlflowResponse
  >;
}

@tag("MLflow Metrics")
interface Metrics {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "MLflow compatibility route"
  @doc("Get MLflow metric history.")
  @get
  @route("/mlflow/api/2.0/mlflow/metrics/get-history")
  getHistory is Azure.AI.Projects.FoundryDataPlaneOperation<
    MlflowMetricHistoryQueryParameters,
    MlflowResponse
  >;
}

@tag("MLflow Artifacts")
interface Artifacts {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "MLflow compatibility route"
  @doc("List MLflow artifacts.")
  @get
  @route("/mlflow/api/2.0/mlflow/artifacts/list")
  list is Azure.AI.Projects.FoundryDataPlaneOperation<
    MlflowArtifactListQueryParameters,
    MlflowResponse
  >;
}

@tag("MLflow Registered Models")
@route("/mlflow/api/2.0/mlflow/registered-models")
interface RegisteredModels {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "MLflow compatibility route"
  @doc("Create an MLflow registered model.")
  @post
  @route("create")
  create is Azure.AI.Projects.FoundryDataPlaneOperation<
    { @bodyRoot payload: MlflowPayload },
    MlflowResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "MLflow compatibility route"
  @doc("Update an MLflow registered model.")
  @patch
  @route("update")
  update is Azure.AI.Projects.FoundryDataPlaneOperation<
    { @bodyRoot payload: MlflowPayload },
    MlflowResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "MLflow compatibility route"
  @doc("Delete an MLflow registered model.")
  @delete
  @route("delete")
  delete is Azure.AI.Projects.FoundryDataPlaneOperation<
    MlflowRegisteredModelQueryParameters,
    MlflowResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "MLflow compatibility route"
  @doc("Get an MLflow registered model.")
  @get
  @route("get")
  get is Azure.AI.Projects.FoundryDataPlaneOperation<
    MlflowRegisteredModelQueryParameters,
    MlflowResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "MLflow compatibility route"
  @doc("List MLflow registered models.")
  @get
  @route("list")
  list is Azure.AI.Projects.FoundryDataPlaneOperation<
    MlflowPaginationQueryParameters,
    MlflowResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "MLflow compatibility route"
  @doc("Search MLflow registered models.")
  @get
  @route("search")
  search is Azure.AI.Projects.FoundryDataPlaneOperation<
    MlflowPaginationQueryParameters,
    MlflowResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "MLflow compatibility route"
  @doc("Set an MLflow registered-model tag.")
  @post
  @route("set-tag")
  setTag is Azure.AI.Projects.FoundryDataPlaneOperation<
    { @bodyRoot payload: MlflowPayload },
    MlflowResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "MLflow compatibility route"
  @doc("Delete an MLflow registered-model tag.")
  @delete
  @route("delete-tag")
  deleteTag is Azure.AI.Projects.FoundryDataPlaneOperation<
    MlflowRegisteredModelQueryParameters,
    MlflowResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "MLflow compatibility route"
  @doc("Get latest versions for an MLflow registered model.")
  @get
  @route("get-latest-versions")
  getLatestVersions is Azure.AI.Projects.FoundryDataPlaneOperation<
    MlflowRegisteredModelQueryParameters,
    MlflowResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "MLflow compatibility route"
  @doc("Rename an MLflow registered model.")
  @post
  @route("rename")
  rename is Azure.AI.Projects.FoundryDataPlaneOperation<
    { @bodyRoot payload: MlflowPayload },
    MlflowResponse
  >;
}

@tag("MLflow Model Versions")
@route("/mlflow/api/2.0/mlflow/model-versions")
interface ModelVersions {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "MLflow compatibility route"
  @doc("Create an MLflow model version.")
  @post
  @route("create")
  create is Azure.AI.Projects.FoundryDataPlaneOperation<
    { @bodyRoot payload: MlflowPayload },
    MlflowResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "MLflow compatibility route"
  @doc("Update an MLflow model version.")
  @patch
  @route("update")
  update is Azure.AI.Projects.FoundryDataPlaneOperation<
    { @bodyRoot payload: MlflowPayload },
    MlflowResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "MLflow compatibility route"
  @doc("Transition an MLflow model version stage.")
  @post
  @route("transition-stage")
  transitionStage is Azure.AI.Projects.FoundryDataPlaneOperation<
    { @bodyRoot payload: MlflowPayload },
    MlflowResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "MLflow compatibility route"
  @doc("Delete an MLflow model version.")
  @delete
  @route("delete")
  delete is Azure.AI.Projects.FoundryDataPlaneOperation<
    MlflowModelVersionQueryParameters,
    MlflowResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "MLflow compatibility route"
  @doc("Get an MLflow model version.")
  @get
  @route("get")
  get is Azure.AI.Projects.FoundryDataPlaneOperation<
    MlflowModelVersionQueryParameters,
    MlflowResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "MLflow compatibility route"
  @doc("Search MLflow model versions.")
  @get
  @route("search")
  search is Azure.AI.Projects.FoundryDataPlaneOperation<
    MlflowPaginationQueryParameters,
    MlflowResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "MLflow compatibility route"
  @doc("Get an MLflow model version download URI.")
  @get
  @route("get-download-uri")
  getDownloadUri is Azure.AI.Projects.FoundryDataPlaneOperation<
    MlflowModelVersionQueryParameters,
    MlflowResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "MLflow compatibility route"
  @doc("Set an MLflow model-version tag.")
  @post
  @route("set-tag")
  setTag is Azure.AI.Projects.FoundryDataPlaneOperation<
    { @bodyRoot payload: MlflowPayload },
    MlflowResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "MLflow compatibility route"
  @doc("Delete an MLflow model-version tag.")
  @delete
  @route("delete-tag")
  deleteTag is Azure.AI.Projects.FoundryDataPlaneOperation<
    MlflowModelVersionQueryParameters,
    MlflowResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "MLflow compatibility route"
  @doc("Get an MLflow model version storage location URI.")
  @post
  @route("get-storage-location-uri")
  getStorageLocationUri is Azure.AI.Projects.FoundryDataPlaneOperation<
    { @bodyRoot payload: MlflowPayload },
    MlflowResponse
  >;
}