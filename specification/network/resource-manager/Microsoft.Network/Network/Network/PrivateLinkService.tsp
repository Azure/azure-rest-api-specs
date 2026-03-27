import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "../Common/PrivateLinkService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
@armResourceOperations(#{ omitTags: true })
interface PrivateLinkServices {
  /**
   * Gets the specified private link service by resource group.
   */
  @tag("PrivateLinkServices")
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
  @tag("PrivateLinkService")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    PrivateLinkService,
    Error = Error
  >;

  /**
   * Deletes the specified private link service.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("PrivateLinkServices")
  delete is ArmResourceDeleteWithoutOkAsync<
    PrivateLinkService,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = Error
  >;

  /**
   * Gets all private link services in a resource group.
   */
  @tag("PrivateLinkServices")
  list is ArmResourceListByParent<PrivateLinkService, Error = Error>;

  /**
   * Gets all private link service in a subscription.
   */
  @tag("PrivateLinkServices")
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
