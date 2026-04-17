import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "../Common/ApplicationSecurityGroup.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Common;

namespace Microsoft.Network;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
@armResourceOperations(#{ omitTags: true })
interface ApplicationSecurityGroups {
  /**
   * Gets information about the specified application security group.
   */
  @tag("ApplicationSecurityGroups")
  get is ArmResourceRead<ApplicationSecurityGroup, Error = CloudError>;

  /**
   * Creates or updates an application security group.
   */
  @tag("ApplicationSecurityGroups")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ApplicationSecurityGroup,
    Error = CloudError
  >;

  /**
   * Updates an application security group's tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-patch" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("applicationSecurityGroups")
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<
    ApplicationSecurityGroup,
    PatchModel = TagsObject,
    Error = CloudError
  >;

  /**
   * Deletes the specified application security group.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("ApplicationSecurityGroups")
  delete is ArmResourceDeleteWithoutOkAsync<
    ApplicationSecurityGroup,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Gets all the application security groups in a resource group.
   */
  @tag("ApplicationSecurityGroups")
  list is ArmResourceListByParent<ApplicationSecurityGroup, Error = CloudError>;

  /**
   * Gets all application security groups in a subscription.
   */
  @tag("ApplicationSecurityGroups")
  listAll is ArmListBySubscription<
    ApplicationSecurityGroup,
    Error = CloudError
  >;
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
