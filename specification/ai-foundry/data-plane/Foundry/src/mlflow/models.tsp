namespace Azure.AI.Projects.Mlflow;

using TypeSpec.Http;

@doc("Generic MLflow compatibility request payload.")
model MlflowPayload {
  ...Record<unknown>;
}

@doc("Generic MLflow compatibility response payload.")
model MlflowResponse {
  ...Record<unknown>;
}

alias MlflowPaginationQueryParameters = {
  @doc("Maximum number of items to return.")
  @query max_results?: int32;

  @doc("Token used to retrieve the next page of results.")
  @query page_token?: string;
};

alias MlflowExperimentQueryParameters = {
  @doc("MLflow experiment identifier.")
  @query experiment_id?: string;

  @doc("MLflow experiment name.")
  @query experiment_name?: string;
};

alias MlflowRunQueryParameters = {
  @doc("MLflow run identifier.")
  @query run_id?: string;

  @doc("MLflow run UUID.")
  @query run_uuid?: string;
};

alias MlflowRegisteredModelQueryParameters = {
  @doc("Registered model name.")
  @query name?: string;
};

alias MlflowModelVersionQueryParameters = {
  @doc("Registered model name.")
  @query name?: string;

  @doc("Model version.")
  @query version?: string;
};

alias MlflowArtifactListQueryParameters = MlflowRunQueryParameters & {
  @doc("Artifact path to list.")
  @query path?: string;
};

alias MlflowMetricHistoryQueryParameters = MlflowRunQueryParameters & {
  @doc("Metric key.")
  @query metric_key?: string;

  @doc("Maximum number of metric points to return.")
  @query max_results?: int32;

  @doc("Token used to retrieve the next page of metric points.")
  @query page_token?: string;
};