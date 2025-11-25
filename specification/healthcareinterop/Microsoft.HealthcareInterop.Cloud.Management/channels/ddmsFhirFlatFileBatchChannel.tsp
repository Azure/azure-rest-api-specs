import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "./../common/provisioningState.tsp";
import "./../common/resourceIds.tsp";
import "./../common/models/destinationModels.tsp";
import "./../common/models/fhirQueryModels.tsp";
import "./../common/models/triggerModels.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.HealthcareInterop;

@added(Versions.v2025_11_01_preview)
@doc("A healthcare interop channel that reads patient IDs from a flat file containing delimited identifiers, queries an Electronic Medical Record (EMR) Fast Healthcare Interoperability Resources (FHIR) endpoint to retrieve the corresponding resources, and sends the retrieved data to the Diagnostic Data Management Service (DDMS) for further processing.")
@resource("ddmsFhirFlatFileBatchChannels")
model DdmsFhirFlatFileBatchChannel
  is TrackedResource<DdmsFhirFlatFileBatchChannelProperties> {
  @doc("The name of the DdmsFhirFlatFileBatchChannel resource.")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("ddmsFhirFlatFileBatchChannelName")
  @segment("ddmsFhirFlatFileBatchChannels")
  @path
  name: string;
}

@added(Versions.v2025_11_01_preview)
@doc("The properties to configure the DdmsFhirFlatFileBatchChannel resource.")
model DdmsFhirFlatFileBatchChannelProperties {
  @doc("The status of the last provisioning operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningLROState;

  @doc("The resource ID of an existing hub resource to link/associate this DdmsFhirFlatFileBatchChannel resource to.")
  hubResourceId: HubResourceId;

  @doc("The settings to configure the source of the data to be ingested.")
  sourceConfiguration: DdmsFhirFlatFileBatchChannelSourceProperties;

  @doc("The settings to configure the transformations to process the data.")
  transformationConfiguration: DdmsFhirFlatFileBatchChannelTransformationProperties;

  @doc("The settings to configure the destination of the data to be persisted.")
  destinationConfiguration: DdmsFhirFlatFileBatchChannelDestinationProperties;

  @doc("The settings to configure the job executions to process the data.")
  jobConfiguration: DdmsFhirFlatFileBatchChannelJobProperties;
}

// #region Source
@added(Versions.v2025_11_01_preview)
@doc("The source configuration for the DdmsFhirFlatFileBatchChannel resource.")
@discriminator("connectorType")
model DdmsFhirFlatFileBatchChannelSourceProperties {
  @doc("The type of source connector to be used for this channel.")
  connectorType: DdmsFhirFlatFileBatchChannelSourceConnectorType;
}

@added(Versions.v2025_11_01_preview)
@doc("Types of source connectors supported for the DdmsFhirFlatFileBatchChannel resource.")
union DdmsFhirFlatFileBatchChannelSourceConnectorType {
  string,

  @doc("Storage Account connector.")
  StorageAccountConnector: "StorageAccountConnector",
}

@added(Versions.v2025_11_01_preview)
@doc("StorageAccountConnector source properties.")
model DdmsFhirFlatFileBatchChannelStorageAccountConnectorSourceProperties
  extends DdmsFhirFlatFileBatchChannelSourceProperties {
  @doc("The type of source connector to be used for this channel.")
  connectorType: DdmsFhirFlatFileBatchChannelSourceConnectorType.StorageAccountConnector;

  @doc("The resource ID of an existing storageAccountConnector resource linked/associated to the same hub resource, to use as source.")
  storageAccountConnectorResourceId: StorageAccountConnectorResourceId;
}

// #endregion Source

// #region Transformation
@added(Versions.v2025_11_01_preview)
@doc("The transformation configuration for the DdmsFhirFlatFileBatchChannel resource.")
model DdmsFhirFlatFileBatchChannelTransformationProperties {
  @doc("The FHIR Query configuration.")
  fhirQueryConfiguration: FhirQueryProperties;
}

// #endregion Transformation

// #region Destination
@added(Versions.v2025_11_01_preview)
@doc("The destination configuration for the DdmsFhirFlatFileBatchChannel resource.")
@discriminator("connectorType")
model DdmsFhirFlatFileBatchChannelDestinationProperties {
  @doc("The type of destination connector to be used for this channel.")
  connectorType: DdmsFhirFlatFileBatchChannelDestinationConnectorType;
}

@added(Versions.v2025_11_01_preview)
@doc("Types of destination connectors supported for the DdmsFhirFlatFileBatchChannel resource.")
union DdmsFhirFlatFileBatchChannelDestinationConnectorType {
  string,

  @doc("DDMS destination connector.")
  DdmsConnector: "DdmsConnector",
}

@added(Versions.v2025_11_01_preview)
@doc("DdmsConnector destination properties for DDMS Flat File batch channel.")
model DdmsFhirFlatFileBatchChannelDdmsConnectorDestinationProperties
  extends DdmsFhirFlatFileBatchChannelDestinationProperties {
  @doc("The type of destination connector to be used for the channel.")
  connectorType: DdmsFhirFlatFileBatchChannelDestinationConnectorType.DdmsConnector;

  @doc("The resource ID of an existing ddmsConnector resource linked/associated to the same hub resource, to use as destination.")
  ddmsConnectorResourceId: DdmsConnectorResourceId;
}

// #endregion Destination

// #region Job
@added(Versions.v2025_11_01_preview)
@doc("Properties for Job")
model DdmsFhirFlatFileBatchChannelJobProperties {
  @doc("The trigger configuration")
  trigger: BatchTriggerProperties;
}

// #endregion Job
@added(Versions.v2025_11_01_preview)
@armResourceOperations
interface DdmsFhirFlatFileBatchChannels {
  get is ArmResourceRead<DdmsFhirFlatFileBatchChannel>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<DdmsFhirFlatFileBatchChannel>;
  update is ArmResourcePatchAsync<
    DdmsFhirFlatFileBatchChannel,
    DdmsFhirFlatFileBatchChannelProperties
  >;
  delete is ArmResourceDeleteWithoutOkAsync<DdmsFhirFlatFileBatchChannel>;
  listByResourceGroup is ArmResourceListByParent<DdmsFhirFlatFileBatchChannel>;
  listBySubscription is ArmListBySubscription<DdmsFhirFlatFileBatchChannel>;
}
