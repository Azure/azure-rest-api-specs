import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureStackHCI;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "x-ms-azure-resource legacy"
@doc("The logical network resource definition.")
@extension("x-ms-azure-resource", true)
model LogicalNetwork is TrackedResource<LogicalNetworkProperties> {
  @doc("Name of the logical network")
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-._a-zA-Z0-9]{0,62}[a-zA-Z0-9]$")
  @path
  @key("logicalNetworkName")
  @segment("logicalNetworks")
  @visibility("read")
  name: string;

  @doc("The extendedLocation of the resource.")
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
interface LogicalNetworks {
  @doc("The operation to get a logical network.")
  get is ArmResourceRead<LogicalNetwork>;

  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @doc("The operation to create or update a logical network. Please note some properties can be set only during logical network creation.")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    LogicalNetwork,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  @doc("The operation to update a logical network.")
  @parameterVisibility
  update is ArmCustomPatchAsync<LogicalNetwork, LogicalNetworksUpdateRequest>;

  @doc("The operation to delete a logical network.")
  delete is ArmResourceDeleteWithoutOkAsync<LogicalNetwork>;

  @doc("Lists all of the logical networks in the specified resource group. Use the nextLink property in the response to get the next page of logical networks.")
  listByResourceGroup is ArmResourceListByParent<LogicalNetwork>;

  @doc("Lists all of the logical networks in the specified subscription. Use the nextLink property in the response to get the next page of logical networks.")
  listAll is ArmListBySubscription<LogicalNetwork>;
}
