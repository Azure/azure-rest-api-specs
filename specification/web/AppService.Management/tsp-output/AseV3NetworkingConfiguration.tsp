import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AppServiceEnvironmentResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
/**
 * Full view of networking configuration for an ASE.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@singleton("networking")
@parentResource(AppServiceEnvironmentResource)
@includeInapplicableMetadataInPayload(false)
model AseV3NetworkingConfiguration extends ProxyOnlyResource {
  @key("configuration")
  @segment("configurations")
  @visibility("read")
  name: string;

  /**
   * AseV3NetworkingConfiguration resource specific properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: AseV3NetworkingConfigurationProperties;
}

@armResourceOperations
interface AseV3NetworkingConfigurations {
  /**
   * Description for Get networking configuration of an App Service Environment
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AppServiceEnvironments_GetAseV3NetworkingConfiguration")
  getAseV3NetworkingConfiguration is ArmResourceRead<AseV3NetworkingConfiguration>;

  /**
   * Description for Update networking configuration of an App Service Environment
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AppServiceEnvironments_UpdateAseNetworkingConfiguration")
  updateAseNetworkingConfiguration is ArmResourceCreateOrReplaceSync<AseV3NetworkingConfiguration>;
}

@@projectedName(AseV3NetworkingConfigurations.updateAseNetworkingConfiguration::parameters.resource,
  "json",
  "aseNetworkingConfiguration"
);
@@extension(AseV3NetworkingConfigurations.updateAseNetworkingConfiguration::parameters.resource,
  "x-ms-client-name",
  "aseNetworkingConfiguration"
);
@@doc(AseV3NetworkingConfigurations.updateAseNetworkingConfiguration::parameters.resource,
  ""
);
