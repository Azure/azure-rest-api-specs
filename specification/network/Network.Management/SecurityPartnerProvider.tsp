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
 * Security Partner Provider resource.
 */
model SecurityPartnerProvider
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<SecurityPartnerProviderPropertiesFormat> {
  ...ResourceNameParameter<
    Resource = SecurityPartnerProvider,
    KeyName = "securityPartnerProviderName",
    SegmentName = "securityPartnerProviders",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface SecurityPartnerProviders {
  /**
   * Gets the specified Security Partner Provider.
   */
  get is ArmResourceRead<SecurityPartnerProvider, Error = CloudError>;

  /**
   * Creates or updates the specified Security Partner Provider.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    SecurityPartnerProvider,
    Error = CloudError
  >;

  /**
   * Updates tags of a Security Partner Provider resource.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<
    SecurityPartnerProvider,
    PatchModel = TagsObject,
    Error = CloudError
  >;

  /**
   * Deletes the specified Security Partner Provider.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    SecurityPartnerProvider,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Lists all Security Partner Providers in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    SecurityPartnerProvider,
    Error = CloudError
  >;

  /**
   * Gets all the Security Partner Providers in a subscription.
   */
  list is ArmListBySubscription<SecurityPartnerProvider, Error = CloudError>;
}

@@doc(SecurityPartnerProvider.name,
  "The name of the Security Partner Provider."
);
@@doc(SecurityPartnerProvider.properties,
  "Properties of the Security Partner Provider."
);
@@doc(SecurityPartnerProviders.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update Security Partner Provider operation."
);
@@doc(SecurityPartnerProviders.updateTags::parameters.properties,
  "Parameters supplied to update Security Partner Provider tags."
);
