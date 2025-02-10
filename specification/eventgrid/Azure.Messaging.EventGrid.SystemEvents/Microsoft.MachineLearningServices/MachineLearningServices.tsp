/** Describes the schema of the Azure Machine Learning Services events published to Azure Event Grid. This corresponds to the Data property of an EventGridEvent. */
namespace Microsoft.EventGrid.SystemEvents;

/** Schema of the Data property of an EventGridEvent for a Microsoft.MachineLearningServices.ModelRegistered event. */
model MachineLearningServicesModelRegisteredEventData {
  /** The name of the model that was registered. */
  modelName?: string;

  /** The version of the model that was registered. */
  modelVersion?: string;

  /** The tags of the model that was registered. */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Model tags is type object"
  modelTags: Record<unknown>;

  /** The properties of the model that was registered. */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Model tags is type object"
  modelProperties: Record<unknown>;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.MachineLearningServices.ModelDeployed event. */
model MachineLearningServicesModelDeployedEventData {
  /** The name of the deployed service. */
  serviceName?: string;

  /** The compute type (e.g. ACI, AKS) of the deployed service. */
  serviceComputeType?: string;

  /** A common separated list of model IDs. The IDs of the models deployed in the service. */
  modelIds?: string;

  /** The tags of the deployed service. */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Service tags is type any"
  serviceTags: Record<unknown>;

  /** The properties of the deployed service. */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Service properties is type any"
  serviceProperties: Record<unknown>;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.MachineLearningServices.RunCompleted event. */
model MachineLearningServicesRunCompletedEventData {
  /** The ID of the experiment that the run belongs to. */
  experimentId?: string;

  /** The name of the experiment that the run belongs to. */
  experimentName?: string;

  /** The ID of the Run that was completed. */
  runId?: string;

  /** The Run Type of the completed Run. */
  runType?: string;

  /** The tags of the completed Run. */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Run tags is type any"
  runTags: Record<unknown>;

  /** The properties of the completed Run. */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Run properties is type any"
  runProperties: Record<unknown>;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.MachineLearningServices.DatasetDriftDetected event. */
model MachineLearningServicesDatasetDriftDetectedEventData {
  /** The ID of the data drift monitor that triggered the event. */
  dataDriftId?: string;

  /** The name of the data drift monitor that triggered the event. */
  dataDriftName?: string;

  /** The ID of the Run that detected data drift. */
  runId?: string;

  /** The ID of the base Dataset used to detect drift. */
  baseDatasetId?: string;

  /** The ID of the target Dataset used to detect drift. */
  targetDatasetId?: string;

  /** The coefficient result that triggered the event. */
  driftCoefficient?: float64;

  /** The start time of the target dataset time series that resulted in drift detection. */
  startTime: utcDateTime;

  /** The end time of the target dataset time series that resulted in drift detection. */
  endTime: utcDateTime;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.MachineLearningServices.RunStatusChanged event. */
model MachineLearningServicesRunStatusChangedEventData {
  /** The ID of the experiment that the Machine Learning Run belongs to. */
  experimentId?: string;

  /** The name of the experiment that the Machine Learning Run belongs to. */
  experimentName?: string;

  /** The ID of the Machine Learning Run. */
  runId?: string;

  /** The Run Type of the Machine Learning Run. */
  runType?: string;

  /** The tags of the Machine Learning Run. */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Run tags is type object"
  runTags: Record<unknown>;

  /** The properties of the Machine Learning Run. */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Run properties is type object"
  runProperties: Record<unknown>;

  /** The status of the Machine Learning Run. */
  runStatus?: string;
}
