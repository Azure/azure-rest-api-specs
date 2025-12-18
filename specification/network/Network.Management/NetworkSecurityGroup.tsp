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
  is Azure.ResourceManager.ProxyResource<NetworkSecurityGroupPropertiesFormat> {
  ...ResourceNameParameter<
    Resource = NetworkSecurityGroup,
    KeyName = "networkSecurityGroupName",
    SegmentName = "networkSecurityGroups",
    NamePattern = ""
  >;

  /** Resource tags. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: TagsObject;

  /** Resource location. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  location?: string;

  /** A unique read-only string that changes whenever the resource is updated. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
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
    },
    Error = CloudError
  >;

  /**
   * Creates or updates a network security group in the specified resource group.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    NetworkSecurityGroup,
    Error = CloudError
  >;

  /**
   * Updates a network security group tags.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<
    NetworkSecurityGroup,
    PatchModel = TagsObject,
    Error = CloudError
  >;

  /**
   * Deletes the specified network security group.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    NetworkSecurityGroup,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Gets all network security groups in a resource group.
   */
  list is ArmResourceListByParent<NetworkSecurityGroup, Error = CloudError>;

  /**
   * Gets all network security groups in a subscription.
   */
  listAll is ArmListBySubscription<NetworkSecurityGroup, Error = CloudError>;
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
