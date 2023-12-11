import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AppServiceEnvironment.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppService;
@doc("Full view of networking configuration for an ASE.")
@parentResource(AppServiceEnvironment)
@singleton("networking")
model AseV3NetworkingConfiguration
  is ProxyResource<AseV3NetworkingConfigurationProperties> {
  @key("networking")
  @segment("configurations")
  name: string;
}

@armResourceOperations
interface AseV3NetworkingConfigurations {
  @doc("Description for Get networking configuration of an App Service Environment")
  getAseV3NetworkingConfiguration is ArmResourceRead<AseV3NetworkingConfiguration>;
  @doc("Description for Update networking configuration of an App Service Environment")
  updateAseNetworkingConfiguration is ArmResourceCreateOrReplaceSync<AseV3NetworkingConfiguration>;
}
