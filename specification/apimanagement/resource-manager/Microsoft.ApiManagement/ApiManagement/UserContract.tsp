import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ApiManagementServiceResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ApiManagement;
/**
 * User details.
 */
@parentResource(ApiManagementServiceResource)
model UserContract
  is Azure.ResourceManager.ProxyResource<UserContractProperties> {
  ...ResourceNameParameter<
    Resource = UserContract,
    KeyName = "userId",
    SegmentName = "users",
    NamePattern = ""
  >;
}

@armResourceOperations
interface UserContracts {
  /**
   * Gets the details of the user specified by its identifier.
   */
  get is ArmResourceRead<
    UserContract,
    Response = ArmResponse<UserContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Gets the entity state (Etag) version of the user specified by its identifier.
   */
  getEntityTag is ArmResourceCheckExistence<
    UserContract,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Creates or Updates a user.
   */
  createOrUpdate is Azure.ResourceManager.Legacy.CreateOrUpdateSync<
    UserContract,
    Request = UserCreateParameters,
    Parameters = {
      /**
       * Send an Email notification to the User.
       */
      @query("notify")
      notify?: boolean;

      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response = (ArmResponse<UserContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }) | (ArmCreatedResponse<UserContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    })
  >;

  /**
   * Updates the details of the user specified by its identifier.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    UserContract,
    PatchModel = UserUpdateParameters,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    },
    Response = ArmResponse<UserContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Deletes specific user.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    UserContract,
    Parameters = {
      /**
       * Whether to delete user's subscription or not.
       */
      @query("deleteSubscriptions")
      deleteSubscriptions?: boolean;

      /**
       * Send an Account Closed Email notification to the User.
       */
      @query("notify")
      notify?: boolean;

      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;

      /**
       * Determines the type of application which send the create user request. Default is legacy publisher portal.
       */
      @query("appType")
      appType?: AppType;
    },
    Response = ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = void>> | NoContentResponse
  >;

  /**
   * Lists a collection of registered users in the specified service instance.
   */
  listByService is ArmResourceListByParent<
    UserContract,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| name | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| firstName | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| lastName | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| email | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| state | filter | eq |     |</br>| registrationDate | filter | ge, le, eq, ne, gt, lt |     |</br>| note | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| groups | expand |     |     |</br>
       */
      @query("$filter")
      $filter?: string;

      /**
       * Number of records to return.
       */
      @minValue(1)
      @query("$top")
      $top?: int32;

      /**
       * Number of records to skip.
       */
      @minValue(0)
      @query("$skip")
      $skip?: int32;

      /**
       * Detailed Group in response.
       */
      @query("expandGroups")
      expandGroups?: boolean;
    },
    Response = ArmResponse<UserCollection>
  >;

  /**
   * Retrieves a redirection URL containing an authentication token for signing a given user into the developer portal.
   */
  generateSsoUrl is ArmResourceActionSync<
    UserContract,
    void,
    ArmResponse<GenerateSsoUrlResult>
  >;

  /**
   * Gets the Shared Access Authorization Token for the User.
   */
  @action("token")
  getSharedAccessToken is ArmResourceActionSync<
    UserContract,
    UserTokenParameters,
    ArmResponse<UserTokenResult>
  >;

  /**
   * Lists all user groups.
   */
  @get
  @action("groups")
  @list
  list is ArmResourceActionSync<
    UserContract,
    void,
    ArmResponse<GroupCollection>,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|------------------------|-----------------------------------|</br>| name | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| displayName | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| description | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>
       */
      @query("$filter")
      $filter?: string;

      /**
       * Number of records to return.
       */
      @minValue(1)
      @query("$top")
      $top?: int32;

      /**
       * Number of records to skip.
       */
      @minValue(0)
      @query("$skip")
      $skip?: int32;
    }
  >;

  /**
   * List of all user identities.
   */
  @get
  @action("identities")
  @list
  userIdentitiesList is ArmResourceActionSync<
    UserContract,
    void,
    ArmResponse<UserIdentityCollection>
  >;

  /**
   * Sends confirmation
   */
  @action("confirmations/password/send")
  send is ArmResourceActionSync<
    UserContract,
    void,
    NoContentResponse,
    Parameters = {
      /**
       * Determines the type of application which send the create user request. Default is legacy publisher portal.
       */
      @query("appType")
      appType?: AppType;
    }
  >;
}

@@maxLength(UserContract.name, 80);
@@minLength(UserContract.name, 1);
@@doc(UserContract.name,
  "User identifier. Must be unique in the current API Management service instance."
);
@@doc(UserContract.properties, "User entity contract properties.");
@@doc(UserContracts.createOrUpdate::parameters.resource,
  "Create or update parameters."
);
@@doc(UserContracts.update::parameters.properties, "Update parameters.");
@@doc(UserContracts.getSharedAccessToken::parameters.body,
  "Create Authorization Token parameters."
);
