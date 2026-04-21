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
  @tag("RunAsAccountsController")
  get is ArmResourceRead<VmwareRunAsAccountResource>;

  /**
   * List VmwareRunAsAccountResource resources by VmwareSite
   */
  @tag("RunAsAccountsController")
  listByVmwareSite is ArmResourceListByParent<VmwareRunAsAccountResource>;
}

@@doc(VmwareRunAsAccountResource.name, " RunAsAccounts name");
@@doc(VmwareRunAsAccountResource.properties,
  "The resource-specific properties for this resource."
);
