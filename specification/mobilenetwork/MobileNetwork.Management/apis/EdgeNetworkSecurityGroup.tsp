import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

import "../models/EdgeNetworkSecurityGroupModels.tsp";
import "./MobileNetwork.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;

@doc("Edge Network Security Group resource. Must be created in the same location as its parent mobile network.")
@resource("edgeNetworkSecurityGroups")
@parentResource(MobileNetwork)
model EdgeNetworkSecurityGroup
  is TrackedResource<EdgeNetworkSecurityGroupPropertiesFormat> {
  @doc("The name of the Edge Network Security Group.")
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @path
  @key("edgeNetworkSecurityGroupName")
  @segment("edgeNetworkSecurityGroups")
  @visibility("read")
  name: string;
}

@armResourceOperations
interface EdgeNetworkSecurityGroups {
  @doc("Gets information about the specified Edge Network Security Group.")
  get is ArmResourceRead<EdgeNetworkSecurityGroup>;

  @doc("Creates or updates a Edge Network Security Group. Must be created in the same location as its parent mobile network.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<EdgeNetworkSecurityGroup>;

  @doc("Updates Edge Network Security Group.")
  @parameterVisibility("read")
  update is ArmCustomPatchSync<EdgeNetworkSecurityGroup, TagsObject>;

  @doc("Deletes the specified Edge Network Security Group.")
  delete is ArmResourceDeleteWithoutOkAsync<EdgeNetworkSecurityGroup>;

  @doc("Lists all Edge Network Security Groups in the mobile network.")
  listByMobileNetwork is ArmResourceListByParent<EdgeNetworkSecurityGroup>;
}

@@doc(EdgeNetworkSecurityGroups.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update Edge Network Security Group operation."
);
@@doc(EdgeNetworkSecurityGroups.update::parameters.properties,
  "Parameters supplied to update Edge Network Security Group tags."
);
