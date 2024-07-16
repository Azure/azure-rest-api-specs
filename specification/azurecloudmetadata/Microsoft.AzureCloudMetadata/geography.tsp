import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common.tsp";
import "./cloud.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.AzureCloudMetadata;

/** Geography resource. */
@tenantResource
@parentResource(Cloud)
model Geography is ProxyResource<GeographyProperties> {
  @doc("The geography short id")
  @segment("geographies")
  @key("geographyShortId")
  @visibility("read")
  @pattern("^[a-zA-Z-]{2,5}$")
  @path
  name: string;
}

/** Geography details. */
model GeographyProperties {
  ...MetadataProperties;

  /** Name of geography. */
  fullName: string;

  /** State of geography. */
  state: State;

  /** Resource Id of parent */
  cloudResourceId: ParentResourceId;

  /** The provisioning state of resource. */
  @visibility("read")
  provisioningState?: ResourceProvisioningState;
}

@armResourceOperations
interface Geographies {
  get is ArmResourceRead<Geography>;
  listByCloud is ArmResourceListByParent<Geography>;
}
