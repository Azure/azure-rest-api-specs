import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./HostPool.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DesktopVirtualization;
/**
 * Represents a ActiveSessionHostConfiguration definition. This has all of the sessionHostConfiguration properties except provisioningState
 */
@singleton("default")
@parentResource(HostPool)
model ActiveSessionHostConfiguration
  is Azure.ResourceManager.ProxyResource<
    ActiveSessionHostConfigurationProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = ActiveSessionHostConfiguration,
    KeyName = "activeSessionHostConfiguration",
    SegmentName = "activeSessionHostConfigurations",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ActiveSessionHostConfigurations {
  /**
   * Get the ActiveSessionHostConfiguration for the hostPool that is currently being used for update operations.
   */
  get is ArmResourceRead<ActiveSessionHostConfiguration>;

  /**
   * List activeSessionHostConfigurations.
   */
  listByHostPool is ArmResourceListByParent<
    ActiveSessionHostConfiguration,
    Response = ArmResponse<ActiveSessionHostConfigurationList>
  >;
}

@@doc(ActiveSessionHostConfiguration.name, "");
@@doc(ActiveSessionHostConfiguration.properties,
  "Detailed properties for SessionHostConfiguration"
);
