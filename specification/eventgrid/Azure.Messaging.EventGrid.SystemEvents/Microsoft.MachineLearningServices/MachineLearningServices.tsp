import "@typespec/versioning";
using TypeSpec.Versioning;
/** Describes the schema of the Azure Machine Learning Services events published to Azure Event Grid. This corresponds to the Data property of an EventGridEvent. */
namespace Microsoft.EventGrid.SystemEvents;

const MicrosoftMachineLearningServicesModelRegisteredExample: MachineLearningServicesModelRegisteredEventData = #{
  modelName: "sklearn_regression_model",
  modelVersion: "20",
  modelTags: #{ area: "diabetes", type: "regression" },
  modelProperties: #{ type: "test" },
};
/** Schema of the Data property of an EventGridEvent for a Microsoft.MachineLearningServices.ModelRegistered event. */
@example(MicrosoftMachineLearningServicesModelRegisteredExample)
model MachineLearningServicesModelRegisteredEventData {
  /** The name of the model that was registered. */
  modelName: string;

  /** The version of the model that was registered. */
  modelVersion: string;

  /** The tags of the model that was registered. */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Model tags is type object"
  modelTags?: Record<unknown>;

  /** The properties of the model that was registered. */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Model tags is type object"
  modelProperties?: Record<unknown>;
}

const MicrosoftMachineLearningServicesModelDeployedExample: MachineLearningServicesModelDeployedEventData = #{
  serviceName: "my-sklearn-service",
  serviceComputeType: "ACI",
  modelIds: "sklearn_regression_model:1,sklearn_regression_model:2",
  serviceTags: #{ area: "diabetes", type: "regression" },
  serviceProperties: #{ type: "test" },
};
/** Schema of the Data property of an EventGridEvent for a Microsoft.MachineLearningServices.ModelDeployed event. */
@example(MicrosoftMachineLearningServicesModelDeployedExample)
model MachineLearningServicesModelDeployedEventData {
  /** The name of the deployed service. */
  serviceName: string;

  /** The compute type (e.g. ACI, AKS) of the deployed service. */
  serviceComputeType: string;

  /** A common separated list of model IDs. The IDs of the models deployed in the service. */
  modelIds: string;

  /** The tags of the deployed service. */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Service tags is type any"
  serviceTags?: Record<unknown>;

  /** The properties of the deployed service. */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Service properties is type any"
  serviceProperties?: Record<unknown>;
}

const MicrosoftMachineLearningServicesRunCompletedExample: MachineLearningServicesRunCompletedEventData = #{
  experimentId: "0fa9dfaa-cba3-4fa7-b590-23e48548f5c1",
  experimentName: "automl-local-regression",
  runId: "AutoML_ad912b2d-6467-4f32-a616-dbe4af6dd8fc_5",
  runType: null,
  runTags: #{},
  runProperties: #{
    runTemplate: "automl_child",
    pipeline_id: "5adc0a4fe02504a586f09a4fcbb241f9a4012062",
    pipeline_spec: "{\"objects\": [{\"class_name\": \"StandardScaler\", \\module\\: \"sklearn.preprocessing\", \\param_args\\: [], \\param_kwargs\\: {\"with_mean\": true, \\with_std\\: false}, \\prepared_kwargs\\: {}, \\spec_class\\: \"preproc\"}, {\\class_name\\: \"LassoLars\", \\module\\: \"sklearn.linear_model\", \\param_args\\: [], \\param_kwargs\\: {\"alpha\": 0.001, \normalize\\: true}, \\prepared_kwargs\\: {}, \\spec_class\\: \"sklearn\"}], \\pipeline_id\\: \"5adc0a4fe02504a586f09a4fcbb241f9a4012062\"}",
    training_percent: "100",
    predicted_cost: "0.062226144097381045",
    iteration: "5",
    run_template: "automl_child",
    run_preprocessor: "StandardScalerWrapper",
    run_algorithm: "LassoLars",
    conda_env_data_location: "aml://artifact/ExperimentRun/dcid.AutoML_ad912b2d-6467-4f32-a616-dbe4af6dd8fc_5/outputs/conda_env_v_1_0_0.yml",
    model_name: "AutoMLad912b2d65",
    scoring_data_location: "aml://artifact/ExperimentRun/dcid.AutoML_ad912b2d-6467-4f32-a616-dbe4af6dd8fc_5/outputs/scoring_file_v_1_0_0.py",
    model_data_location: "aml://artifact/ExperimentRun/dcid.AutoML_ad912b2d-6467-4f32-a616-dbe4af6dd8fc_5/outputs/model.pkl",
  },
};
/** Schema of the Data property of an EventGridEvent for a Microsoft.MachineLearningServices.RunCompleted event. */
@example(MicrosoftMachineLearningServicesRunCompletedExample)
model MachineLearningServicesRunCompletedEventData {
  /** The ID of the experiment that the run belongs to. */
  experimentId: string;

  /** The name of the experiment that the run belongs to. */
  experimentName: string;

  /** The ID of the Run that was completed. */
  runId: string;

  /** The Run Type of the completed Run. */
  runType: string;

  /** The tags of the completed Run. */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Run tags is type any"
  runTags?: Record<unknown>;

  /** The properties of the completed Run. */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Run properties is type any"
  runProperties?: Record<unknown>;
}

const MicrosoftMachineLearningServicesDatasetDriftDetectedExample: MachineLearningServicesDatasetDriftDetectedEventData = #{
  dataDriftId: "01d29aa4-e6a4-470a-9ef3-66660d21f8ef",
  dataDriftName: "myDriftMonitor",
  runId: "01d29aa4-e6a4-470a-9ef3-66660d21f8ef_1571590300380",
  baseDatasetId: "3c56d136-0f64-4657-a0e8-5162089a88a3",
  targetDatasetId: "d7e74d2e-c972-4266-b5fb-6c9c182d2a74",
  driftCoefficient: 0.8350349068479208,
  startTime: utcDateTime.fromISO("2019-07-03T17:00:00-07:00"),
  endTime: utcDateTime.fromISO("2019-07-04T17:00:00-07:00"),
};
/** Schema of the Data property of an EventGridEvent for a Microsoft.MachineLearningServices.DatasetDriftDetected event. */
@example(MicrosoftMachineLearningServicesDatasetDriftDetectedExample)
model MachineLearningServicesDatasetDriftDetectedEventData {
  /** The ID of the data drift monitor that triggered the event. */
  dataDriftId: string;

  /** The name of the data drift monitor that triggered the event. */
  dataDriftName: string;

  /** The ID of the Run that detected data drift. */
  runId: string;

  /** The ID of the base Dataset used to detect drift. */
  baseDatasetId: string;

  /** The ID of the target Dataset used to detect drift. */
  targetDatasetId: string;

  /** The coefficient result that triggered the event. */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  driftCoefficient: float64;

  /** The start time of the target dataset time series that resulted in drift detection. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "In source code if the value is null, they stringify it to null"
  @madeRequired(ServiceApiVersions.v2024_01_01)
  startTime: utcDateTime | null;

  /** The end time of the target dataset time series that resulted in drift detection. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "In source code if the value is null, they stringify it to null"
  @madeRequired(ServiceApiVersions.v2024_01_01)
  endTime: utcDateTime | null;
}

const MicrosoftMachineLearningServicesRunStatusChangedExample: MachineLearningServicesRunStatusChangedEventData = #{
  experimentId: "0fa9dfaa-cba3-4fa7-b590-23e48548f5c1",
  experimentName: "automl-local-regression",
  runId: "AutoML_ad912b2d-6467-4f32-a616-dbe4af6dd8fc_5",
  runType: null,
  runTags: #{},
  runProperties: #{
    runTemplate: "automl_child",
    pipeline_id: "5adc0a4fe02504a586f09a4fcbb241f9a4012062",
    pipeline_spec: "{\"objects\": [{\"class_name\": \"StandardScaler\", \\module\\: \"sklearn.preprocessing\", \\param_args\\: [], \\param_kwargs\\: {\"with_mean\": true, \\with_std\\: false}, \\prepared_kwargs\\: {}, \\spec_class\\: \"preproc\"}, {\\class_name\\: \"LassoLars\", \\module\\: \"sklearn.linear_model\", \\param_args\\: [], \\param_kwargs\\: {\"alpha\": 0.001, \normalize\\: true}, \\prepared_kwargs\\: {}, \\spec_class\\: \"sklearn\"}], \\pipeline_id\\: \"5adc0a4fe02504a586f09a4fcbb241f9a4012062\"}",
    training_percent: "100",
    predicted_cost: "0.062226144097381045",
    iteration: "5",
    run_template: "automl_child",
    run_preprocessor: "StandardScalerWrapper",
    run_algorithm: "LassoLars",
    conda_env_data_location: "aml://artifact/ExperimentRun/dcid.AutoML_ad912b2d-6467-4f32-a616-dbe4af6dd8fc_5/outputs/conda_env_v_1_0_0.yml",
    model_name: "AutoMLad912b2d65",
    scoring_data_location: "aml://artifact/ExperimentRun/dcid.AutoML_ad912b2d-6467-4f32-a616-dbe4af6dd8fc_5/outputs/scoring_file_v_1_0_0.py",
    model_data_location: "aml://artifact/ExperimentRun/dcid.AutoML_ad912b2d-6467-4f32-a616-dbe4af6dd8fc_5/outputs/model.pkl",
  },
  runStatus: "failed",
};
/** Schema of the Data property of an EventGridEvent for a Microsoft.MachineLearningServices.RunStatusChanged event. */
@example(MicrosoftMachineLearningServicesRunStatusChangedExample)
model MachineLearningServicesRunStatusChangedEventData {
  /** The ID of the experiment that the Machine Learning Run belongs to. */
  experimentId: string;

  /** The name of the experiment that the Machine Learning Run belongs to. */
  experimentName: string;

  /** The ID of the Machine Learning Run. */
  runId: string;

  /** The Run Type of the Machine Learning Run. */
  runType: string;

  /** The tags of the Machine Learning Run. */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Run tags is type object"
  runTags?: Record<unknown>;

  /** The properties of the Machine Learning Run. */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Run properties is type object"
  runProperties?: Record<unknown>;

  /** The status of the Machine Learning Run. */
  runStatus: string;
}
