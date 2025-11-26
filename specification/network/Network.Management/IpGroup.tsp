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
model IpGroup
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<IpGroupPropertiesFormat> {
  ...ResourceNameParameter<
    Resource = IpGroup,
    KeyName = "ipGroupsName",
    SegmentName = "ipGroups",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

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
    Error = CloudError
  >;

  /**
   * Creates or updates an ipGroups in a specified resource group.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    IpGroup,
    Error = CloudError
  >;

  /**
   * Updates tags of an IpGroups resource.
   */
  @patch(#{ implicitOptionality: false })
  updateGroups is ArmCustomPatchSync<
    IpGroup,
    PatchModel = TagsObject,
    Error = CloudError
  >;

  /**
   * Deletes the specified ipGroups.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    IpGroup,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Gets all IpGroups in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<IpGroup, Error = CloudError>;

  /**
   * Gets all IpGroups in a subscription.
   */
  list is ArmListBySubscription<IpGroup, Error = CloudError>;
}

@@doc(IpGroup.name, "The name of the ipGroups.");
@@doc(IpGroup.properties, "Properties of the IpGroups.");
@@doc(IpGroups.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update IpGroups operation."
);
@@doc(IpGroups.updateGroups::parameters.properties,
  "Parameters supplied to the update ipGroups operation."
);
