import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Site)
@includeInapplicableMetadataInPayload(false)
model WebSiteInstanceStatus extends ProxyOnlyResource {
  @path
  @key("instanceId")
  @segment("instances")
  @visibility("read")
  name: string;

  /**
   * WebSiteInstanceStatus resource specific properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: WebSiteInstanceStatusProperties;
}

@armResourceOperations
interface WebSiteInstanceStatuses {
  /**
   * Description for Gets all scale-out instances of an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_GetInstanceInfo")
  getInstanceInfo is ArmResourceRead<WebSiteInstanceStatus>;

  /**
   * Description for Gets all scale-out instances of an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_ListInstanceIdentifiers")
  listInstanceIdentifiers is ArmResourceListByParent<WebSiteInstanceStatus>;
}
