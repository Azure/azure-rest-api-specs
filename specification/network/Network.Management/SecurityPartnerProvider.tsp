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
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Http.Private.includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model SecurityPartnerProvider extends Resource {
  properties?: SecurityPartnerProviderPropertiesFormat;

  @visibility(Lifecycle.Read)
  @path
  @key("securityPartnerProviderName")
  @segment("securityPartnerProviders")
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
