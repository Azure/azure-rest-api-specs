import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./DatabaseAccountGetResults.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.DocumentDB;
/**
 * A request object to enable/disable the chaos fault
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/resource-name" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(DatabaseAccountGetResults)
model chaosFaultResource
  is Azure.ResourceManager.ProxyResource<chaosFaultProperties> {
  ...ResourceNameParameter<
    Resource = chaosFaultResource,
    KeyName = "chaosFault",
    SegmentName = "chaosFaults",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@added(Versions.v2026_04_01_preview)
@armResourceOperations(#{ omitTags: true })
interface ChaosFaultResources {
  /**
   * Get Chaos Fault for a CosmosdB account for a particular Chaos Fault.
   */
  get is ArmResourceRead<chaosFaultResource>;

  /**
   * Enable, disable Chaos Fault in a CosmosDB account.
   */
  enableDisable is ArmResourceCreateOrReplaceAsync<
    chaosFaultResource,
    LroHeaders = ArmLroLocationHeader<FinalResult = chaosFaultResource> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * List Chaos Faults for CosmosDB account.
   */
  list is ArmResourceListByParent<
    chaosFaultResource,
    Response = ArmResponse<chaosFaultListResponse>
  >;
}

@@doc(chaosFaultResource.name, "The name of the ChaosFault.");
@@doc(chaosFaultResource.properties,
  "A request object to enable/disable the chaos fault."
);
@@doc(ChaosFaultResources.enableDisable::parameters.resource,
  "A request object to enable/disable the chaos fault."
);
