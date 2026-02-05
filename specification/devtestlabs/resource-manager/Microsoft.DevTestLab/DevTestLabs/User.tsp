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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
@Azure.ResourceManager.Legacy.customAzureResource
@Http.Private.includeInapplicableMetadataInPayload(false)
model User extends Resource {
  @visibility(Lifecycle.Read)
  @path
  @key
  @segment("users")
  name: string;

  properties: UserProperties;
}

@armResourceOperations
interface UserOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of the lab. */
        @path @segment("labs") labName: string,
      },
      KeysOf<ResourceNameParameter<
        Resource = User,
        KeyName = "name",
        SegmentName = "users",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface Users {
  /**
   * Get user profile.
   */
  get is UserOps.Read<
    User,
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
  createOrUpdate is UserOps.CreateOrUpdateAsync<
    User,
    LroHeaders = ArmLroLocationHeader<FinalResult = User> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Allows modifying tags of user profiles. All other properties will be ignored.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-patch" "Already contains tags"
  @patch(#{ implicitOptionality: false })
  update is UserOps.CustomPatchSync<User, PatchModel = UserFragment>;

  /**
   * Delete user profile. This operation can take a while to complete.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is UserOps.DeleteWithoutOkAsync<
    User,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List user profiles in a given lab.
   */
  list is UserOps.List<
    User,
    Parameters = {
      /**
       * Specify the $expand query. Example: 'properties($select=identity)'
       */
      @query("$expand")
      $expand?: string;

      /**
       * The filter to apply to the operation. Example: '$filter=contains(name,'myName')
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

@@doc(User.name, "The name of the user profile.");
@@doc(User.properties, "The properties of the resource.");
@@doc(Users.createOrUpdate::parameters.resource, "Profile of a lab user.");
@@doc(Users.update::parameters.properties, "Profile of a lab user.");
