import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./HostPool.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.DesktopVirtualization;
/**
 * Schema for SessionHostConfiguration properties.
 */
@parentResource(HostPool)
@singleton("default")
model SessionHostConfiguration
  is Azure.ResourceManager.ProxyResource<
    SessionHostConfigurationProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = SessionHostConfiguration,
    KeyName = "SessionHostConfigurations",
    NamePattern = "^[A-Za-z0-9@.\\-_ ]*$"
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "Service doesn't allow delete"
@armResourceOperations
interface SessionHostConfigurations {
  /**
   * Get a SessionHostConfiguration.
   */
  get is ArmResourceRead<SessionHostConfiguration>;

  /**
   * Update a SessionHostConfiguration.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    SessionHostConfiguration,
    SessionHostConfigurationPatch,
    Request = {
      /**
       * The resource properties to be updated
       */
      @bodyRoot sessionHostConfiguration?: SessionHostConfigurationPatch;
    }
  >;

  /**
   * Create or update a SessionHostConfiguration.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<SessionHostConfiguration>;

  /**
   * List SessionHostConfigurations.
   */
  listByHostPool is ArmResourceListByParent<
    SessionHostConfiguration,
    Response = SessionHostConfigurationList
  >;
}

@@maxLength(SessionHostConfiguration.name, 24);
@@minLength(SessionHostConfiguration.name, 3);
@@doc(SessionHostConfiguration.name,
  "The name of the SessionHostConfiguration"
);
@@doc(SessionHostConfiguration.properties,
  "Detailed properties for SessionHostConfiguration"
);
