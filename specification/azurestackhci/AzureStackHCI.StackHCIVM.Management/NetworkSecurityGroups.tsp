import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.AzureStackHCI;
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@doc("NetworkSecurityGroup resource.")
model NetworkSecurityGroup is TrackedResource<NetworkSecurityGroupProperties> {
  @doc("Name of the network security group")
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-._a-zA-Z0-9]{0,62}[a-zA-Z0-9]$")
  @path
  @key("networkSecurityGroupName")
  @segment("networkSecurityGroups")
  @visibility("read")
  name: string;

  @doc("The extendedLocation of the resource.")
  extendedLocation?: ExtendedLocation;

  ...EntityTagProperty;
}

@armResourceOperations
interface NetworkSecurityGroups {
  @doc("Gets the specified network security group.")
  get is ArmResourceRead<NetworkSecurityGroup>;

  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @doc("Creates or updates a network security group in the specified resource group.")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    NetworkSecurityGroup,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  @doc("Updates a network security group tags.")
  updateTags is ArmTagsPatchAsync<NetworkSecurityGroup, TagsObject>;

  @doc("Deletes the specified network security group.")
  delete is ArmResourceDeleteWithoutOkAsync<NetworkSecurityGroup>;

  @doc("Gets all network security groups in a resource group.")
  listByResourceGroup is ArmResourceListByParent<NetworkSecurityGroup>;

  @doc("Gets all network security groups in a subscription.")
  listAll is ArmListBySubscription<NetworkSecurityGroup>;
}
