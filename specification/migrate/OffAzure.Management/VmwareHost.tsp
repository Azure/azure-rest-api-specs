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
 * A host resource belonging to a site resource.
 */
@parentResource(VmwareSite)
model VmwareHost is Azure.ResourceManager.ProxyResource<VmwareHostProperties> {
  ...ResourceNameParameter<
    Resource = VmwareHost,
    KeyName = "hostName",
    SegmentName = "hosts"
  >;
}

@armResourceOperations(#{ omitTags: true })
interface VmwareHosts {
  /**
   * Get a VmwareHost
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @tag("VmwareHostController")
  @operationId("VmwareHostController_Get")
  get is ArmResourceRead<VmwareHost>;

  /**
   * List VmwareHost resources by VmwareSite
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @tag("VmwareHostController")
  @operationId("VmwareHostController_ListByVmwareSite")
  listByVmwareSite is ArmResourceListByParent<VmwareHost>;
}

@@doc(VmwareHost.name, " Hosts name");
@@doc(VmwareHost.properties,
  "The resource-specific properties for this resource."
);
