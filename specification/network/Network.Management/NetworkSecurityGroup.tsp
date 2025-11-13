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
 * NetworkSecurityGroup resource.
 */
model NetworkSecurityGroup
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<NetworkSecurityGroupPropertiesFormat> {
  ...ResourceNameParameter<
    Resource = NetworkSecurityGroup,
    KeyName = "networkSecurityGroupName",
    SegmentName = "networkSecurityGroups",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface NetworkSecurityGroups {
  /**
   * Gets the specified network security group.
   */
  get is ArmResourceRead<
    NetworkSecurityGroup,
    Parameters = {
      /**
       * Expands referenced resources.
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * Creates or updates a network security group in the specified resource group.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<NetworkSecurityGroup>;

  /**
   * Updates a network security group tags.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<
    NetworkSecurityGroup,
    PatchModel = TagsObject
  >;

  /**
   * Deletes the specified network security group.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    NetworkSecurityGroup,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets all network security groups in a resource group.
   */
  list is ArmResourceListByParent<NetworkSecurityGroup>;

  /**
   * Gets all network security groups in a subscription.
   */
  listAll is ArmListBySubscription<NetworkSecurityGroup>;
}

@@doc(NetworkSecurityGroup.name, "The name of the network security group.");
@@doc(NetworkSecurityGroup.properties,
  "Properties of the network security group."
);
@@doc(NetworkSecurityGroups.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update network security group operation."
);
@@doc(NetworkSecurityGroups.updateTags::parameters.properties,
  "Parameters supplied to update network security group tags."
);
