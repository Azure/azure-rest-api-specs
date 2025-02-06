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
 * Schema for SessionHostManagement properties.
 */
@parentResource(HostPool)
@singleton("default")
model SessionHostManagement
  is Azure.ResourceManager.ProxyResource<SessionHostManagementProperties> {
  ...ResourceNameParameter<
    Resource = SessionHostManagement,
    KeyName = "sessionHostManagements",
    NamePattern = "^[A-Za-z0-9@.\\-_ ]*$"
  >;
  ...ManagedServiceIdentityProperty;
  ...etagProperty;
  ...ResourceKindProperty;
  ...ManagedByProperty;
  ...ResourcePlanProperty;
  ...ResourceSkuProperty;
}

@armResourceOperations
interface InitiateSessionHostUpdate {
  /**
   * Initiates a hostpool update or schedule an update for the future.
   */
  @action("initiateSessionHostUpdate")
  post is ArmResourceActionSync<
    SessionHostManagement,
    UpdateSessionHostsRequestBody,
    {
      @statusCode _: 204;
    }
  >;
}
#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "Service doesn't allow delete"
@armResourceOperations
interface SessionHostManagements {
  /**
   * Get a SessionHostManagement.
   */
  get is ArmResourceRead<SessionHostManagement>;

  /**
   * Create or update a SessionHostManagement.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<SessionHostManagement>;

  /**
   * Update a SessionHostManagement.
   */
  @parameterVisibility
  update is ArmCustomPatchSync<
    SessionHostManagement,
    SessionHostManagementPatch
  >;

  /**
   * List SessionHostManagements.
   */
  listByHostPool is ArmResourceListByParent<
    SessionHostManagement,
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
    Response = SessionHostManagementList
  >;
}

@@maxLength(SessionHostManagement.name, 24);
@@minLength(SessionHostManagement.name, 3);
@@doc(SessionHostManagement.name, "The name of the sessionHostManagement");
@@doc(SessionHostManagement.properties,
  "Detailed properties for SessionHostManagement"
);
