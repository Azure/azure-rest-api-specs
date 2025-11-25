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
model PrivateLinkService
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<PrivateLinkServiceProperties> {
  ...ResourceNameParameter<
    Resource = PrivateLinkService,
    KeyName = "serviceName",
    SegmentName = "privateLinkServices",
    NamePattern = ""
  >;

  /**
   * The extended location of the load balancer.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  extendedLocation?: ExtendedLocation;

  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface PrivateLinkServices {
  /**
   * Gets the specified private link service by resource group.
   */
  get is ArmResourceRead<PrivateLinkService,
    Parameters = {
      /**
       * Expands referenced resources.
       */
      @query("$expand")
      $expand?: string;
    }, Error = CloudError>;

  /**
   * Creates or updates an private link service in the specified resource group.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<PrivateLinkService, Error = CloudError>;

  /**
   * Deletes the specified private link service.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<PrivateLinkService,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,  Error = CloudError>;

  /**
   * Gets all private link services in a resource group.
   */
  list is ArmResourceListByParent<PrivateLinkService, Error = CloudError>;

  /**
   * Gets all private link service in a subscription.
   */
  listBySubscription is ArmListBySubscription<PrivateLinkService, Error = CloudError>;
}

@@doc(PrivateLinkService.name, "The name of the private link service.");
@@doc(PrivateLinkService.properties, "Properties of the private link service.");
@@doc(PrivateLinkServices.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update private link service operation."
);
