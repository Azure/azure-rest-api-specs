import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "./../common/provisioningState.tsp";
import "./../common/resourceIds.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.HealthcareInterop;

@doc("The healthcare interop resource that transfers DICOM files.")
@resource("dicomDirectChannels")
@added(Versions.v2025_06_01_preview)
model DicomDirectChannel is TrackedResource<DicomDirectChannelProperties> {
  @doc("The name of the DicomDirectChannel resource.")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("dicomDirectChannelName")
  @segment("dicomDirectChannels")
  @path
  name: string;
}

@doc("The properties to configure the DicomDirectChannel resource.")
@added(Versions.v2025_06_01_preview)
model DicomDirectChannelProperties {
  @doc("The status of the last provisioning operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningLROState;

  @doc("The resource ID of an existing hub resource to link/associate this dicomDirectChannel resource to.")
  hubResourceId: HubResourceId;

  @doc("The settings to configure the source of the data to be ingested.")
  sourceConfiguration: DicomDirectChannelSourceProperties;

  @doc("The settings to configure the destination of the data to be persisted.")
  destinationConfiguration: DicomDirectChannelDestinationProperties;
}

// #region Source

@doc("The source configuration for the DicomDirectChannel resource.")
@added(Versions.v2025_06_01_preview)
model DicomDirectChannelSourceProperties {
  @doc("The resource ID of an existing dicomConnector resource linked/associated to the same hub resource, to use as source.")
  dicomConnectorResourceId: DicomConnectorResourceId;
}

// #endregion Source

// #region Destination

@doc("The destination configuration for the channel resources.")
@discriminator("connectorType")
@added(Versions.v2025_06_01_preview)
model DicomDirectChannelDestinationProperties {
  @doc("The type of destination connector.")
  connectorType: DicomDirectChannelDestinationConnectorType;
}

@doc("Types of destination connectors supported for the channel resources.")
@added(Versions.v2025_06_01_preview)
union DicomDirectChannelDestinationConnectorType {
  string,

  @doc("Storage Account destination connector.")
  StorageAccountConnector: "StorageAccountConnector",
}

@doc("StorageAccountConnector destination properties.")
@added(Versions.v2025_06_01_preview)
model DicomDirectStorageAccountConnectorDestinationProperties
  extends DicomDirectChannelDestinationProperties {
  @doc("The type of destination connector to be used for the channel.")
  connectorType: DicomDirectChannelDestinationConnectorType.StorageAccountConnector;

  @doc("The resource ID of an existing storageAccountConnector resource linked/associated to the same hub resource, to use as destination.")
  storageAccountConnectorResourceId: StorageAccountConnectorResourceId;
}

// #endregion Destination

@added(Versions.v2025_06_01_preview)
@armResourceOperations
interface DicomDirectChannels {
  get is ArmResourceRead<DicomDirectChannel>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<DicomDirectChannel>;
  update is ArmResourcePatchAsync<
    DicomDirectChannel,
    DicomDirectChannelProperties
  >;
  delete is ArmResourceDeleteWithoutOkAsync<DicomDirectChannel>;
  listByResourceGroup is ArmResourceListByParent<DicomDirectChannel>;
  listBySubscription is ArmListBySubscription<DicomDirectChannel>;
}
