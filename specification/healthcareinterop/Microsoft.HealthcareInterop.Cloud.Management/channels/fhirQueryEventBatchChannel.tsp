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
using Azure.ResourceManager;

namespace Microsoft.HealthcareInterop;

@doc("The healthcare interop resource that extracts IDs from input healthcare events/messages and queries the configured EMR FHIR endpoint to retrieve the representative resources.")
@resource("fhirQueryEventBatchChannels")
model FhirQueryEventBatchChannel
  is TrackedResource<FhirQueryEventBatchChannelProperties> {
  @doc("The name of the FhirQueryEventBatchChannel resource.")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("fhirQueryEventBatchChannelName")
  @segment("fhirQueryEventBatchChannels")
  @path
  name: string;
}

@doc("The properties to configure the FhirQueryEventBatchChannel resource.")
model FhirQueryEventBatchChannelProperties {
  @doc("The status of the last provisioning operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningLROState;

  @doc("The resource ID of an existing hub resource to link/associate this fhirQueryEventBatchChannel resource to.")
  hubResourceId: HubResourceId;

  @doc("The settings to configure the source of the data to be ingested.")
  sourceConfiguration: FhirQueryEventBatchChannelSourceProperties;

  @doc("The settings to configure the transformations to process the data.")
  transformationConfiguration: FhirQueryEventBatchChannelTransformationProperties;

  @doc("The settings to configure the destination of the data to be persisted.")
  destinationConfiguration: FhirQueryBatchChannelDestinationProperties;

  @doc("The settings to configure the job executions to process the data.")
  jobConfiguration: FhirQueryEventBatchChannelJobProperties;
}

// #region Source

@doc("The source configuration for the FhirQueryEventBatchChannel resource.")
@discriminator("connectorType")
model FhirQueryEventBatchChannelSourceProperties {
  @doc("The type of source connector to be used for this channel.")
  connectorType: FhirQueryEventBatchChannelSourceConnectorType;
}

@doc("Types of source connectors supported for the FhirQueryEventBatchChannel resource.")
union FhirQueryEventBatchChannelSourceConnectorType {
  string,

  @doc("Hl7 connector.")
  Hl7Connector: "Hl7Connector",
}

@doc("Hl7Connector source properties.")
model Hl7ConnectorSourceProperties
  extends FhirQueryEventBatchChannelSourceProperties {
  @doc("The type of source connector to be used for this channel.")
  connectorType: FhirQueryEventBatchChannelSourceConnectorType.Hl7Connector;

  @doc("The resource ID of an existing hl7Connector resource linked/associated to the same hub resource, to use as source.")
  hl7ConnectorResourceId: Hl7ConnectorResourceId;
}

// #endregion Source

// #region Transformation

@doc("The transformation configuration for the FhirQueryEventBatchChannel resource.")
model FhirQueryEventBatchChannelTransformationProperties {
  @doc("The Fhir Query configuration.")
  fhirQueryConfiguration: FhirQueryProperties;
}

// #endregion Transformation

// #region Destination

// Shared models in ../common/models/destinationModels.tsp

// #endregion Destination

// #region Job

@doc("Properties for Job")
model FhirQueryEventBatchChannelJobProperties {
  @doc("The trigger configuration")
  trigger: BatchTriggerProperties;
}

// #endregion Job

@armResourceOperations
interface FhirQueryEventBatchChannels {
  get is ArmResourceRead<FhirQueryEventBatchChannel>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<FhirQueryEventBatchChannel>;
  update is ArmResourcePatchAsync<
    FhirQueryEventBatchChannel,
    FhirQueryEventBatchChannelProperties
  >;
  delete is ArmResourceDeleteWithoutOkAsync<FhirQueryEventBatchChannel>;
  listByResourceGroup is ArmResourceListByParent<FhirQueryEventBatchChannel>;
  listBySubscription is ArmListBySubscription<FhirQueryEventBatchChannel>;
}
