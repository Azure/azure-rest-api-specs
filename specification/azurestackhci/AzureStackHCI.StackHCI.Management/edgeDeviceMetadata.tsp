import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

import "./hciCommon.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;

@doc("A EdgeDevice")
@armProviderNamespace("Microsoft.AzureStackHCI")
namespace Microsoft.AzureStackHCI;

@doc("EdgeDevice Metadata resource")
model DeviceMetadata
  is Azure.ResourceManager.ExtensionResource<EdgeDeviceMetadataProperties> {
  ...ResourceNameParameter<
    Resource = DeviceMetadata,
    KeyName = "default",
    SegmentName = "edgeDeviceMetadata",
    NamePattern = "^[a-zA-Z0-9-]{3,24}$"
  >;
}

@armResourceOperations
interface EdgeDeviceMetadata {
  @doc("Get a EdgeDeviceMetadata")
  get is ArmResourceRead<DeviceMetadata>;

  @doc("Create a EdgeDeviceMetadata")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<DeviceMetadata>;

  @doc("Delete a EdgeDeviceMetadata")
  delete is ArmResourceDeleteWithoutOkAsync<DeviceMetadata>;

  @doc("List EdgeDeviceMetadata resources by EdgeDevice")
  listByEdgeDevice is ArmResourceListByParent<DeviceMetadata>;
}

@@doc(DeviceMetadata.name, "Name of EdgeDevice metadata");

///////////////////models///////////

@doc("Edge device metadata properties")
model EdgeDeviceMetadataProperties {
  @doc("Validated Recipe.")
  validatedRecipe?: string;

  @doc("Provisioning state")
  @visibility("read")
  provisioningState?: ProvisioningState;
}
