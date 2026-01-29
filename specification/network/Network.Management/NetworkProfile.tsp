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
 * Network profile resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Http.Private.includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model NetworkProfile extends Resource {
  properties?: NetworkProfilePropertiesFormat;

  @visibility(Lifecycle.Read)
  @path
  @key("networkProfileName")
  @segment("networkProfiles")
  name: string;

  /** A unique read-only string that changes whenever the resource is updated. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
@armResourceOperations
interface NetworkProfiles {
  /**
   * Gets the specified network profile in a specified resource group.
   */
  get is ArmResourceRead<
    NetworkProfile,
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
   * Creates or updates a network profile.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    NetworkProfile,
    Error = CloudError
  >;

  /**
   * Updates network profile tags.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<
    NetworkProfile,
    PatchModel = TagsObject,
    Error = CloudError
  >;

  /**
   * Deletes the specified network profile.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    NetworkProfile,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Gets all network profiles in a resource group.
   */
  list is ArmResourceListByParent<NetworkProfile, Error = CloudError>;

  /**
   * Gets all the network profiles in a subscription.
   */
  listAll is ArmListBySubscription<NetworkProfile, Error = CloudError>;
}

@@doc(NetworkProfile.name, "The name of the public IP prefix.");
@@doc(NetworkProfile.properties, "Network profile properties.");
@@doc(NetworkProfiles.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update network profile operation."
);
@@doc(NetworkProfiles.updateTags::parameters.properties,
  "Parameters supplied to update network profile tags."
);
