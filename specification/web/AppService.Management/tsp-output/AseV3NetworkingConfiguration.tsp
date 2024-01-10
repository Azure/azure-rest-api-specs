import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AppServiceEnvironmentResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.CertificateRegistration;
@doc("Full view of networking configuration for an ASE.")
@singleton("networking")
@parentResource(AppServiceEnvironmentResource)
model AseV3NetworkingConfiguration
  is ProxyResource<AseV3NetworkingConfigurationProperties> {
  @key("configuration")
  @segment("configurations")
  name: string;
}

@armResourceOperations
@projectedName("client", "AppServiceEnvironments")
interface AseV3NetworkingConfigurations_AppServiceEnvironments {
  @doc("Description for Get networking configuration of an App Service Environment")
  getAseV3NetworkingConfiguration is ArmResourceRead<AseV3NetworkingConfiguration>;

  @doc("Description for Update networking configuration of an App Service Environment")
  updateAseNetworkingConfiguration is ArmResourceCreateOrReplaceSync<AseV3NetworkingConfiguration>;
}
