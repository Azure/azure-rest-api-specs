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
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Http.Private.includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model VirtualRouter extends Resource {
  properties?: VirtualRouterPropertiesFormat;

  @visibility(Lifecycle.Read)
  @path
  @key("virtualRouterName")
  @segment("virtualRouters")
  name: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
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
    Error = Error
  >;

  /**
   * Creates or updates the specified Virtual Router.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    VirtualRouter,
    Error = Error
  >;

  /**
   * Deletes the specified Virtual Router.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    VirtualRouter,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = Error
  >;

  /**
   * Lists all Virtual Routers in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<VirtualRouter, Error = Error>;

  /**
   * Gets all the Virtual Routers in a subscription.
   */
  list is ArmListBySubscription<VirtualRouter, Error = Error>;
}

@@doc(VirtualRouter.name, "The name of the Virtual Router.");
@@doc(VirtualRouter.properties, "Properties of the Virtual Router.");
@@doc(VirtualRouters.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update Virtual Router."
);
