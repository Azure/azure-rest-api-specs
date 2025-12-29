import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DatabaseAccountGetResults.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DocumentDB;
/**
 * A request object to enable/disable the chaos fault
 */
@parentResource(DatabaseAccountGetResults)
model ChaosFaultResource
  is Azure.ResourceManager.ProxyResource<ChaosFaultProperties> {
  ...ResourceNameParameter<
    Resource = ChaosFaultResource,
    KeyName = "chaosFault",
    SegmentName = "chaosFaults",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface ChaosFaultResources {
  /**
   * Get Chaos Fault for a CosmosdB account for a particular Chaos Fault.
   */
  get is ArmResourceRead<ChaosFaultResource>;

  /**
   * Enable, disable Chaos Fault in a CosmosDB account.
   */
  enableDisable is ArmResourceCreateOrReplaceAsync<
    ChaosFaultResource,
    LroHeaders = ArmLroLocationHeader<FinalResult = ChaosFaultResource> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * List Chaos Faults for CosmosDB account.
   */
  list is ArmResourceListByParent<
    ChaosFaultResource,
    Response = ArmResponse<ChaosFaultListResponse>
  >;
}

@@doc(ChaosFaultResource.name, "The name of the ChaosFault.");
@@doc(ChaosFaultResource.properties,
  "A request object to enable/disable the chaos fault."
);
@@doc(ChaosFaultResources.enableDisable::parameters.resource,
  "A request object to enable/disable the chaos fault."
);
