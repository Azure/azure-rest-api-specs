import "./Configuration.tsp";
import "./Commons.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.Edge;

@removed(Versions.v2025_06_01)
@added(Versions.v2025_12_01_preview)
@doc("ArcGatewayConfigurationProperties Properties")
model ArcGatewayConfigurationProperties {
  @doc("Provisioning state of resource")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  @doc("Scenario in which this configuration is used")
  scenario: Scenario;

  @doc("ArmId to the arcGateway")
  arcGatewayUri: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.HybridCompute/Gateways";
    }
  ]>;
}

@removed(Versions.v2025_06_01)
@added(Versions.v2025_12_01_preview)
@doc("ArcGatewayConfiguration Resource")
@parentResource(Configuration)
model ArcGatewayConfiguration
  is ProxyResource<ArcGatewayConfigurationProperties> {
  ...ResourceNameParameter<
    ArcGatewayConfiguration,
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9-_]{2,22}[a-zA-Z0-9]$"
  >;
}

@removed(Versions.v2025_06_01)
@added(Versions.v2025_12_01_preview)
@armResourceOperations
interface ArcGatewayConfigurations {
  get is ArmResourceRead<ArcGatewayConfiguration>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<ArcGatewayConfiguration>;
  update is ArmResourcePatchSync<
    ArcGatewayConfiguration,
    ArcGatewayConfigurationProperties
  >;
  delete is ArmResourceDeleteSync<ArcGatewayConfiguration>;
  listByConfiguration is ArmResourceListByParent<ArcGatewayConfiguration>;
}
