import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VmwareSite.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.OffAzure;
/**
 * A runasaccount resource belonging to a site resource.
 */
@parentResource(VmwareSite)
model VmwareRunAsAccountResource
  is Azure.ResourceManager.ProxyResource<RunAsAccountProperties> {
  ...ResourceNameParameter<
    Resource = VmwareRunAsAccountResource,
    KeyName = "accountName",
    SegmentName = "runAsAccounts"
  >;
}

@armResourceOperations(#{ omitTags: true })
interface VmwareRunAsAccountResources {
  /**
   * Get a VmwareRunAsAccountResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("RunAsAccountsController")
  @operationId("RunAsAccountsController_Get")
  get is ArmResourceRead<VmwareRunAsAccountResource>;

  /**
   * List VmwareRunAsAccountResource resources by VmwareSite
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("RunAsAccountsController")
  @operationId("RunAsAccountsController_ListByVmwareSite")
  listByVmwareSite is ArmResourceListByParent<VmwareRunAsAccountResource>;
}

@@doc(VmwareRunAsAccountResource.name, " RunAsAccounts name");
@@doc(VmwareRunAsAccountResource.properties,
  "The resource-specific properties for this resource."
);
