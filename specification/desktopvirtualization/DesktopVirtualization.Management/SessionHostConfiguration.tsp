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
 * Represents a SessionHostConfiguration definition.
 */
@singleton("default")
@parentResource(HostPool)
model SessionHostConfiguration
  is Azure.ResourceManager.ProxyResource<
    SessionHostConfigurationProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = SessionHostConfiguration,
    KeyName = "sessionHostConfiguration",
    SegmentName = "sessionHostConfigurations",
    NamePattern = ""
  >;
}

@armResourceOperations
interface SessionHostConfigurations {
  /**
   * Get a SessionHostConfiguration.
   */
  get is ArmResourceRead<SessionHostConfiguration>;

  /**
   * Create or update a SessionHostConfiguration.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<SessionHostConfiguration>;

  /**
   * Update a SessionHostConfiguration.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    SessionHostConfiguration,
    PatchModel = SessionHostConfigurationPatch
  >;

  /**
   * List sessionHostConfigurations.
   */
  listByHostPool is ArmResourceListByParent<
    SessionHostConfiguration,
    Response = ArmResponse<SessionHostConfigurationList>
  >;
}

@@doc(SessionHostConfiguration.name, "");
@@doc(SessionHostConfiguration.properties,
  "Detailed properties for SessionHostConfiguration"
);
@@doc(SessionHostConfigurations.createOrUpdate::parameters.resource,
  "Object containing SessionHostConfiguration definitions."
);
@@doc(SessionHostConfigurations.update::parameters.properties,
  "Object containing SessionHostConfiguration definitions."
);
