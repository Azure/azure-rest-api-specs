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
 * The IpGroups resource information.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Http.Private.includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model IpGroup extends Resource {
  properties?: IpGroupPropertiesFormat;

  @visibility(Lifecycle.Read)
  @path
  @key("ipGroupsName")
  @segment("ipGroups")
  name: string;

  /** A unique read-only string that changes whenever the resource is updated. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
@armResourceOperations
interface IpGroups {
  /**
   * Gets the specified ipGroups.
   */
  get is ArmResourceRead<
    IpGroup,
    Parameters = {
      /**
       * Expands resourceIds (of Firewalls/Network Security Groups etc.) back referenced by the IpGroups resource.
       */
      @query("$expand")
      $expand?: string;
    },
    Error = Error
  >;

  /**
   * Creates or updates an ipGroups in a specified resource group.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<IpGroup, Error = Error>;

  /**
   * Updates tags of an IpGroups resource.
   */
  @patch(#{ implicitOptionality: false })
  updateGroups is ArmCustomPatchSync<
    IpGroup,
    PatchModel = TagsObject,
    Error = Error
  >;

  /**
   * Deletes the specified ipGroups.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    IpGroup,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = Error
  >;

  /**
   * Gets all IpGroups in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<IpGroup, Error = Error>;

  /**
   * Gets all IpGroups in a subscription.
   */
  list is ArmListBySubscription<IpGroup, Error = Error>;
}

@@doc(IpGroup.name, "The name of the ipGroups.");
@@doc(IpGroup.properties, "Properties of the IpGroups.");
@@doc(IpGroups.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update IpGroups operation."
);
@@doc(IpGroups.updateGroups::parameters.properties,
  "Parameters supplied to the update ipGroups operation."
);
