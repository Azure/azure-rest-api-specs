import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./HostPool.tsp";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.DesktopVirtualization;
/**
 * Schema for ActiveSessionHostConfiguration properties.
 */
@parentResource(HostPool)
@singleton("default")
model ActiveSessionHostConfiguration
  is Azure.ResourceManager.ProxyResource<
    ActiveSessionHostConfigurationProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = ActiveSessionHostConfiguration,
    SegmentName = "activeSessionHostConfigurations",
    NamePattern = "^[A-Za-z0-9@.\\-_ ]*$"
  >;
}

@armResourceOperations
interface ActiveSessionHostConfigurations {
  /**
   * Get a ActiveSessionHostConfiguration.
   */
  get is ArmResourceRead<ActiveSessionHostConfiguration>;

  /**
   * Operation to list the ActiveSessionHostConfigurations associated with the HostPool
   */
  @action("activeSessionHostConfigurations")
  @get
  @list
  listByHostPool is Azure.ResourceManager.ArmResourceActionSync<
    HostPool,
    void,
    ActiveSessionHostConfigurationList
  >;
}

@@maxLength(ActiveSessionHostConfiguration.name, 24);
@@minLength(ActiveSessionHostConfiguration.name, 3);
@@doc(ActiveSessionHostConfiguration.name,
  "The name of the ActiveSessionHostConfiguration within the specified ActiveSessionHostConfiguration group"
);
@@doc(ActiveSessionHostConfiguration.properties,
  "Detailed properties for ActiveSessionHostConfiguration"
);
