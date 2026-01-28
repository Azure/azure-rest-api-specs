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
 * Private link service resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
@Http.Private.includeInapplicableMetadataInPayload(false)
model PrivateLinkService extends Resource {
  properties?: PrivateLinkServiceProperties;

  @visibility(Lifecycle.Read)
  @path
  @key("serviceName")
  @segment("privateLinkServices")
  name: string;

  /**
   * The extended location of the load balancer.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  extendedLocation?: ExtendedLocation;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

@armResourceOperations
interface PrivateLinkServices {
  /**
   * Gets the specified private link service by resource group.
   */
  get is ArmResourceRead<
    PrivateLinkService,
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
   * Creates or updates an private link service in the specified resource group.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    PrivateLinkService,
    Error = Error
  >;

  /**
   * Deletes the specified private link service.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    PrivateLinkService,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = Error
  >;

  /**
   * Gets all private link services in a resource group.
   */
  list is ArmResourceListByParent<PrivateLinkService, Error = Error>;

  /**
   * Gets all private link service in a subscription.
   */
  listBySubscription is ArmListBySubscription<
    PrivateLinkService,
    Error = Error
  >;
}

@@doc(PrivateLinkService.name, "The name of the private link service.");
@@doc(PrivateLinkService.properties, "Properties of the private link service.");
@@doc(PrivateLinkServices.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update private link service operation."
);
