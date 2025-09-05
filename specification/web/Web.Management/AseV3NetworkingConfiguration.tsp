import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AppServiceEnvironmentResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Web;
/**
 * Full view of networking configuration for an ASE.
 */
@singleton("networking")
@parentResource(AppServiceEnvironmentResource)
model AseV3NetworkingConfiguration
  is Azure.ResourceManager.ProxyResource<AseV3NetworkingConfigurationProperties> {
  ...ResourceNameParameter<
    Resource = AseV3NetworkingConfiguration,
    KeyName = "configuration",
    SegmentName = "configurations",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface AseV3NetworkingConfigurations {
  /**
   * Description for Get networking configuration of an App Service Environment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AppServiceEnvironments_GetAseV3NetworkingConfiguration")
  getAseV3NetworkingConfiguration is ArmResourceRead<AseV3NetworkingConfiguration>;

  /**
   * Description for Update networking configuration of an App Service Environment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("AppServiceEnvironments_UpdateAseNetworkingConfiguration")
  updateAseNetworkingConfiguration is ArmResourceCreateOrReplaceSync<
    AseV3NetworkingConfiguration,
    Response = ArmResourceUpdatedResponse<AseV3NetworkingConfiguration>
  >;
}

@@doc(AseV3NetworkingConfiguration.name, "");
@@doc(AseV3NetworkingConfiguration.properties,
  "AseV3NetworkingConfiguration resource specific properties"
);
@@doc(AseV3NetworkingConfigurations.updateAseNetworkingConfiguration::parameters.resource,
  ""
);
