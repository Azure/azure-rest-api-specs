import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * VirtualRouter Resource.
 */
model VirtualRouter
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<VirtualRouterPropertiesFormat> {
  ...ResourceNameParameter<
    Resource = VirtualRouter,
    KeyName = "virtualRouterName",
    SegmentName = "virtualRouters",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface VirtualRouters {
  /**
   * Gets the specified Virtual Router.
   */
  get is ArmResourceRead<
    VirtualRouter,
    Parameters = {
      /**
       * Expands referenced resources.
       */
      @query("$expand")
      $expand?: string;
    },
    Error = CloudError
  >;

  /**
   * Creates or updates the specified Virtual Router.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    VirtualRouter,
    Error = CloudError
  >;

  /**
   * Deletes the specified Virtual Router.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    VirtualRouter,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Lists all Virtual Routers in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    VirtualRouter,
    Error = CloudError
  >;

  /**
   * Gets all the Virtual Routers in a subscription.
   */
  list is ArmListBySubscription<VirtualRouter, Error = CloudError>;
}

@@doc(VirtualRouter.name, "The name of the Virtual Router.");
@@doc(VirtualRouter.properties, "Properties of the Virtual Router.");
@@doc(VirtualRouters.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update Virtual Router."
);
