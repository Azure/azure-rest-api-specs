import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.AzureCloudMetadata;

/** Cloud resource. */
@tenantResource
model Cloud is ProxyResource<CloudProperties> {
  @doc("The cloud name")
  @segment("clouds")
  @key("cloudName")
  @visibility("read")
  @pattern("^[a-zA-Z-]{3,24}$")
  @path
  name: string;
}

/** Cloud details. */
model CloudProperties {
  ...MetadataProperties;

  /** Environment type of cloud. */
  environmentType: EnvironmentType;

  /** State of cloud. */
  state: State;

  /** The provisioning state of resource. */
  @visibility("read")
  provisioningState?: ResourceProvisioningState;
}

/** The cloud environment type. */
union EnvironmentType {
  /** This is a Public cloud */
  Public: "Public",

  /** This is a Sovereign cloud */
  Sovereign: "Sovereign",

  /** This is an Airgapped cloud */
  Airgapped: "Airgapped",

  string,
}

@armResourceOperations
interface Clouds {
  get is ArmResourceRead<Cloud>;
  list is ArmResourceListByParent<Cloud>;
}
