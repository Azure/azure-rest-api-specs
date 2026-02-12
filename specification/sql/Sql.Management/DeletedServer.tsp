import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A deleted server.
 */
@subscriptionResource
model DeletedServer
  is Azure.ResourceManager.ProxyResource<DeletedServerProperties> {
  ...ResourceNameParameter<
    Resource = DeletedServer,
    KeyName = "deletedServerName",
    SegmentName = "deletedServers",
    NamePattern = ""
  >;
}

@armResourceOperations
interface DeletedServers {
  /**
   * Gets a deleted server.
   */
  get is ArmResourceRead<
    DeletedServer,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Gets a list of deleted servers for a location.
   */
  listByLocation is ArmResourceListByParent<
    DeletedServer,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Recovers a deleted server.
   */
  recover is ArmResourceActionAsync<
    DeletedServer,
    void,
    ArmResponse<DeletedServer>,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;
}

@@doc(DeletedServer.name, "The name of the deleted server.");
@@doc(DeletedServer.properties, "Resource properties.");
