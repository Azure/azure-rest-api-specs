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
 * Schema for SessionHostConfiguration properties.
 */
@parentResource(HostPool)
@singleton("default")
model SessionHostConfiguration
  is Azure.ResourceManager.ProxyResource<SessionHostConfigurationProperties> {
  ...ResourceNameParameter<
    Resource = SessionHostConfiguration,
    KeyName = "SessionHostConfigurations",
    NamePattern = "^[A-Za-z0-9@.\\-_ ]*$"
  >;
  ...ManagedServiceIdentityProperty;
  ...etagProperty;
  ...ResourceKindProperty;
  ...ManagedByProperty;
  ...ResourcePlanProperty;
  ...ResourceSkuProperty;
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
  @parameterVisibility
  update is ArmCustomPatchSync<
    SessionHostConfiguration,
    SessionHostConfigurationPatch
  >;

  /**
   * Create or update a SessionHostConfiguration.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<SessionHostConfiguration>;

  /**
   * List SessionHostConfigurations.
   */
  listByHostPool is ArmResourceListByParent<
    SessionHostConfiguration,
    Parameters = {
      /**
       * Number of items per page.
       */
      @query("pageSize")
      pageSize?: int32;

      /**
       * Indicates whether the collection is descending.
       */
      @query("isDescending")
      isDescending?: boolean;

      /**
       * Initial number of items to skip.
       */
      @query("initialSkip")
      initialSkip?: int32;
    },
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
