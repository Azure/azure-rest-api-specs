import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./IntegrationAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Logic;
@doc("The integration account map.")
@parentResource(IntegrationAccount)
model IntegrationAccountMap
  is Azure.ResourceManager.TrackedResource<
    IntegrationAccountMapProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = IntegrationAccountMap,
    KeyName = "mapName",
    SegmentName = "maps",
    NamePattern = ""
  >;
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
    Parameters = {
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
    ArmResponse<WorkflowTriggerCallbackUrl>
  >;
}

@@doc(IntegrationAccountMap.name, "The integration account map name.");
@@doc(IntegrationAccountMap.properties,
  "The integration account map properties."
);
@@doc(IntegrationAccountMaps.createOrUpdate::parameters.resource,
  "The integration account map."
);
@@doc(IntegrationAccountMaps.listContentCallbackUrl::parameters.body, "");
