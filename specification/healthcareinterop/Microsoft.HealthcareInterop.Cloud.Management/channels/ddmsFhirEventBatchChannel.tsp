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

@added(Versions.v2025_10_01_preview)
@doc("The healthcare interop resource that extracts IDs from input healthcare events/messages and queries the configured EMR FHIR endpoint to retrieve the representative resources, then sends the data to DDMS for further processing.")
@resource("ddmsFhirEventBatchChannels")
model DdmsFhirEventBatchChannel
  is TrackedResource<DdmsFhirEventBatchChannelProperties> {
  @doc("The name of the DdmsFhirEventBatchChannel resource.")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("ddmsFhirEventBatchChannelName")
  @segment("ddmsFhirEventBatchChannels")
  @path
  name: string;
}

@added(Versions.v2025_10_01_preview)
@doc("The properties to configure the DdmsFhirEventBatchChannel resource.")
model DdmsFhirEventBatchChannelProperties {
  @doc("The status of the last provisioning operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningLROState;

  @doc("The resource ID of an existing hub resource to link/associate this ddmsFhirEventBatchChannel resource to.")
  hubResourceId: HubResourceId;

  @doc("The settings to configure the source of the data to be ingested.")
  sourceConfiguration: DdmsFhirEventBatchChannelSourceProperties;

  @doc("The settings to configure the transformations to process the data.")
  transformationConfiguration: DdmsFhirEventBatchChannelTransformationProperties;

  @doc("The settings to configure the destination of the data to be persisted.")
  destinationConfiguration: DdmsFhirEventBatchChannelDestinationProperties;

  @doc("The settings to configure the job executions to process the data.")
  jobConfiguration: DdmsFhirEventBatchChannelJobProperties;
}

// #region Source
@added(Versions.v2025_10_01_preview)
@doc("The source configuration for the DdmsFhirEventBatchChannel resource.")
@discriminator("connectorType")
model DdmsFhirEventBatchChannelSourceProperties {
  @doc("The type of source connector to be used for this channel.")
  connectorType: DdmsFhirEventBatchChannelSourceConnectorType;
}

@added(Versions.v2025_10_01_preview)
@doc("Types of source connectors supported for the DdmsFhirEventBatchChannel resource.")
union DdmsFhirEventBatchChannelSourceConnectorType {
  string,

  @doc("Hl7 connector.")
  Hl7Connector: "Hl7Connector",
}

@added(Versions.v2025_10_01_preview)
@doc("Hl7Connector source properties for DDMS FHIR event batch channel.")
model DdmsHl7ConnectorSourceProperties
  extends DdmsFhirEventBatchChannelSourceProperties {
  @doc("The type of source connector to be used for this channel.")
  connectorType: DdmsFhirEventBatchChannelSourceConnectorType.Hl7Connector;

  @doc("The resource ID of an existing hl7Connector resource linked to the same hub resource, to use as source.")
  hl7ConnectorResourceId: Hl7ConnectorResourceId;
}

// #endregion Source

// #region Transformation

@added(Versions.v2025_10_01_preview)
@doc("The transformation configuration for the DdmsFhirEventBatchChannel resource.")
model DdmsFhirEventBatchChannelTransformationProperties {
  @doc("The Fhir Query configuration.")
  fhirQueryConfiguration: FhirQueryProperties;
}

// #endregion Transformation

// #region Destination
@added(Versions.v2025_10_01_preview)
@doc("The destination configuration for the DdmsFhirEventBatchChannel resource.")
@discriminator("connectorType")
model DdmsFhirEventBatchChannelDestinationProperties {
  @doc("The type of destination connector to be used for this channel.")
  connectorType: DdmsFhirEventBatchChannelDestinationConnectorType;
}

@added(Versions.v2025_10_01_preview)
@doc("Types of destination connectors supported for the DdmsFhirEventBatchChannel resource.")
union DdmsFhirEventBatchChannelDestinationConnectorType {
  string,

  @doc("DDMS destination connector.")
  DdmsConnector: "DdmsConnector",
}

@added(Versions.v2025_10_01_preview)
@doc("DdmsConnector destination properties for DDMS FHIR event batch channel.")
model DdmsFhirEventBatchDdmsConnectorDestinationProperties
  extends DdmsFhirEventBatchChannelDestinationProperties {
  @doc("The type of destination connector to be used for the channel.")
  connectorType: DdmsFhirEventBatchChannelDestinationConnectorType.DdmsConnector;

  @doc("The resource ID of an existing ddmsConnector resource linked/associated to the same hub resource, to use as destination.")
  ddmsConnectorResourceId: DdmsConnectorResourceId;
}

// #endregion Destination

// #region Job
@added(Versions.v2025_10_01_preview)
@doc("Properties for DDMS FHIR event batch channel job configuration.")
model DdmsFhirEventBatchChannelJobProperties {
  @doc("The trigger configuration")
  trigger: BatchTriggerProperties;
}

// #endregion Job
@added(Versions.v2025_10_01_preview)
@armResourceOperations
interface DdmsFhirEventBatchChannels {
  get is ArmResourceRead<DdmsFhirEventBatchChannel>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<DdmsFhirEventBatchChannel>;
  update is ArmResourcePatchAsync<
    DdmsFhirEventBatchChannel,
    DdmsFhirEventBatchChannelProperties
  >;
  delete is ArmResourceDeleteWithoutOkAsync<DdmsFhirEventBatchChannel>;
  listByResourceGroup is ArmResourceListByParent<DdmsFhirEventBatchChannel>;
  listBySubscription is ArmListBySubscription<DdmsFhirEventBatchChannel>;
}
