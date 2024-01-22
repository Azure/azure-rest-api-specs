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
@singleton("networking")
@parentResource(AppServiceEnvironmentResource)
model AseV3NetworkingConfiguration
  is ProxyResource<AseV3NetworkingConfigurationProperties> {
  @key("configuration")
  @segment("configurations")
  name: string;
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
