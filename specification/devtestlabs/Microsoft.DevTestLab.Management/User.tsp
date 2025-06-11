import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevTestLab;
/**
 * Profile of a lab user.
 */
model LabUser is Azure.ResourceManager.TrackedResource<UserProperties> {
  ...ResourceNameParameter<
    Resource = LabUser,
    KeyName = "labUserName",
    SegmentName = "users"
  >;
}

@armResourceOperations
interface LabUsers {
  /**
   * Get user profile.
   */
  get is ArmResourceRead<
    LabUser,
    Parameters = {
      /**
       * Specify the $expand query. Example: 'properties($select=identity)'
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * Create or replace an existing user profile. This operation can take a while to complete.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    LabUser,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Allows modifying tags of user profiles. All other properties will be ignored.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<LabUser, PatchModel = UpdateResource>;

  /**
   * Delete user profile. This operation can take a while to complete.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    LabUser,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List user profiles in a given lab.
   */
  list is ArmResourceListByParent<
    LabUser,
    Parameters = {
      /**
       * Specify the $expand query. Example: 'properties($select=identity)'
       */
      @query("$expand")
      $expand?: string;

      /**
       * The filter to apply to the operation. Example: '$filter=contains(name,'myName')'
       */
      @query("$filter")
      $filter?: string;

      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'
       */
      @query("$top")
      $top?: int32;

      /**
       * The ordering expression for the results, using OData notation. Example: '$orderby=name desc'
       */
      @query("$orderby")
      $orderby?: string;
    },
    Response = ArmResponse<UserList>
  >;
}

@@doc(LabUser.name, "The name of the user profile.");
@@doc(LabUser.properties, "The properties of the resource.");
@@doc(LabUsers.createOrUpdate::parameters.resource, "Profile of a lab user.");
@@doc(LabUsers.update::parameters.properties,
  "Allows modifying tags of user profiles. All other properties will be ignored."
);
