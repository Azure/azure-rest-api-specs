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
/**
 * Description of the parameters of Private Access for a Web Site.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@singleton("virtualNetworks")
@parentResource(Site)
@includeInapplicableMetadataInPayload(false)
model PrivateAccess extends ProxyOnlyResource {
  @key("privateAccess")
  @segment("privateAccess")
  @visibility("read")
  name: string;

  /**
   * PrivateAccess resource specific properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: PrivateAccessProperties;
}

@armResourceOperations
interface PrivateAccesses {
  /**
   * Description for Gets data around private site access enablement and authorized Virtual Networks that can access the site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_GetPrivateAccess")
  getPrivateAccess is ArmResourceRead<PrivateAccess>;

  /**
   * Description for Sets data around private site access enablement and authorized Virtual Networks that can access the site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_PutPrivateAccessVnet")
  putPrivateAccessVnet is ArmResourceCreateOrReplaceSync<PrivateAccess>;
}

@@projectedName(PrivateAccesses.putPrivateAccessVnet::parameters.resource,
  "json",
  "access"
);
@@extension(PrivateAccesses.putPrivateAccessVnet::parameters.resource,
  "x-ms-client-name",
  "access"
);
@@doc(PrivateAccesses.putPrivateAccessVnet::parameters.resource,
  "The information for the private access"
);
