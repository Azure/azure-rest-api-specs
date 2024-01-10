import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./IntegrationAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Logic;
@doc("The integration account map.")
@parentResource(IntegrationAccount)
model IntegrationAccountMap
  is TrackedResource<IntegrationAccountMapProperties> {
  @doc("The integration account map name.")
  @key("mapName")
  @segment("maps")
  name: string;
}

@armResourceOperations
interface IntegrationAccountMaps {
  @doc("Gets an integration account map.")
  get is ArmResourceRead<IntegrationAccountMap>;

  @doc("Creates or updates an integration account map. If the map is larger than 4 MB, you need to store the map in an Azure blob and use the blob's Shared Access Signature (SAS) URL as the 'contentLink' property value.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<IntegrationAccountMap>;

  @doc("Deletes an integration account map.")
  delete is ArmResourceDeleteSync<IntegrationAccountMap>;

  @doc("Gets a list of integration account maps.")
  list is ArmResourceListByParent<
    IntegrationAccountMap,
    {
      ...BaseParameters<IntegrationAccountMap>;

      @doc("The number of items to be included in the result.")
      @query("$top")
      $top?: int32;

      @doc("The filter to apply on the operation. Options for filters include: MapType.")
      @query("$filter")
      $filter?: string;
    }
  >;

  @doc("Get the content callback url.")
  listContentCallbackUrl is ArmResourceActionSync<
    IntegrationAccountMap,
    GetCallbackUrlParameters,
    WorkflowTriggerCallbackUrl
  >;
}
