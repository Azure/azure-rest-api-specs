import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "./../common/provisioningState.tsp";
import "./../common/models/destinationModels.tsp";
import "./../common/models/fhirQueryModels.tsp";
import "./../common/models/triggerModels.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.HealthcareInterop;

@doc("The healthcare interop resource that extracts IDs from file that contains a list of delimited IDs and queries the configured EMR FHIR endpoint to retrieve the representative resources.")
@resource("fhirQueryFlatFileBatchChannels")
model FhirQueryFlatFileBatchChannel
  is TrackedResource<FhirQueryFlatFileBatchChannelProperties> {
  @doc("The name of the FhirQueryFlatFileBatchChannel resource")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("fhirQueryFlatFileBatchChannelName")
  @segment("fhirQueryFlatFileBatchChannels")
  @path
  name: string;
}

@doc("The properties to configure the FhirQueryFlatFileBatchChannel resource.")
model FhirQueryFlatFileBatchChannelProperties {
  @doc("The status of the last provisioning operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningLROState;

  @doc("The resource ID of an existing hub resource to link/associate this fhirQueryFlatFileBatchChannel resource to.")
  hubResourceId: HubResourceId;

  @doc("The settings to configure the source of the data to be ingested.")
  sourceConfiguration: FhirQueryFlatFileBatchChannelSourceProperties;

  @doc("The settings to configure the transformations to process the data.")
  transformationConfiguration: FhirQueryFlatFileBatchChannelTransformationProperties;

  @doc("The settings to configure the destination of the data to be persisted.")
  destinationConfiguration: FhirQueryBatchChannelDestinationProperties;

  @doc("The settings to configure the job executions to process the data.")
  jobConfiguration: FhirQueryFlatFileBatchChannelJobProperties;
}

// #region Source

@doc("The source configuration for the FhirQueryFlatFileBatchChannel resource.")
@discriminator("connectorType")
model FhirQueryFlatFileBatchChannelSourceProperties {
  @doc("The type of source connector to be used for this channel.")
  connectorType: FhirQueryFlatFileBatchChannelSourceConnectorType;
}

@doc("Types of source connectors supported for the FhirQueryFlatFileBatchChannel resource.")
union FhirQueryFlatFileBatchChannelSourceConnectorType {
  string,

  @doc("Storage Account connector.")
  StorageAccountConnector: "StorageAccountConnector",
}

@doc("StorageAccountConnector source properties.")
model StorageAccountConnectorSourceProperties
  extends FhirQueryFlatFileBatchChannelSourceProperties {
  @doc("The type of source connector to be used for this channel.")
  connectorType: FhirQueryFlatFileBatchChannelSourceConnectorType.StorageAccountConnector;

  @doc("The resource ID of an existing storageAccountConnector resource linked/associated to the same hub resource, to use as source.")
  storageAccountConnectorResourceId: StorageAccountConnectorResourceId;
}

// #endregion Source

// #region Transformation

@doc("The transformation configuration for the FhirQueryFlatFileBatchChannel resource.")
model FhirQueryFlatFileBatchChannelTransformationProperties {
  @doc("The FHIR Query configuration.")
  fhirQueryConfiguration: FhirQueryProperties;
}

// #endregion Transformation

// #region Destination

// Shared models in ../common/models/destinationModels.tsp

// #endregion Destination

// #region Job

@doc("Properties for Job")
model FhirQueryFlatFileBatchChannelJobProperties {
  @doc("The trigger configuration")
  trigger: BatchTriggerProperties;
}

// #endregion Job

@armResourceOperations
interface FhirQueryFlatFileBatchChannels {
  get is ArmResourceRead<FhirQueryFlatFileBatchChannel>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<FhirQueryFlatFileBatchChannel>;
  update is ArmResourcePatchAsync<
    FhirQueryFlatFileBatchChannel,
    FhirQueryFlatFileBatchChannelProperties
  >;
  delete is ArmResourceDeleteWithoutOkAsync<FhirQueryFlatFileBatchChannel>;
  listByResourceGroup is ArmResourceListByParent<FhirQueryFlatFileBatchChannel>;
  listBySubscription is ArmListBySubscription<FhirQueryFlatFileBatchChannel>;
}
