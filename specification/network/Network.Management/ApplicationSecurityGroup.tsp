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
 * An application security group in a resource group.
 */
model ApplicationSecurityGroup
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<ApplicationSecurityGroupPropertiesFormat> {
  ...ResourceNameParameter<
    Resource = ApplicationSecurityGroup,
    KeyName = "applicationSecurityGroupName",
    SegmentName = "applicationSecurityGroups",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface ApplicationSecurityGroups {
  /**
   * Gets information about the specified application security group.
   */
  get is ArmResourceRead<ApplicationSecurityGroup>;

  /**
   * Creates or updates an application security group.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ApplicationSecurityGroup>;

  /**
   * Updates an application security group's tags.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<
    ApplicationSecurityGroup,
    PatchModel = TagsObject
  >;

  /**
   * Deletes the specified application security group.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    ApplicationSecurityGroup,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets all the application security groups in a resource group.
   */
  list is ArmResourceListByParent<ApplicationSecurityGroup>;

  /**
   * Gets all application security groups in a subscription.
   */
  listAll is ArmListBySubscription<ApplicationSecurityGroup>;
}

@@doc(ApplicationSecurityGroup.name,
  "The name of the application security group."
);
@@doc(ApplicationSecurityGroup.properties,
  "Properties of the application security group."
);
@@doc(ApplicationSecurityGroups.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update ApplicationSecurityGroup operation."
);
@@doc(ApplicationSecurityGroups.updateTags::parameters.properties,
  "Parameters supplied to update application security group tags."
);
