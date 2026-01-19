import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SessionHost.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.DesktopVirtualization;
/**
 * Represents a UserSession definition.
 */
@parentResource(SessionHost)
model UserSession
  is Azure.ResourceManager.ProxyResource<UserSessionProperties> {
  ...ResourceNameParameter<
    Resource = UserSession,
    KeyName = "userSessionId",
    SegmentName = "userSessions",
    NamePattern = ""
  >;
}

@armResourceOperations
interface UserSessions {
  /**
   * Get a userSession.
   */
  get is ArmResourceRead<UserSession>;

  /**
   * Remove a userSession.
   */
  delete is ArmResourceDeleteSync<
    UserSession,
    Parameters = {
      /**
       * Force flag to login off userSession.
       */
      @query("force")
      force?: boolean;
    }
  >;

  /**
   * List userSessions.
   */
  list is ArmResourceListByParent<
    UserSession,
    Parameters = {
      /**
       * Number of items per page.
       */
      @query("pageSize")
      pageSize?: int32;

      /**
       * Indicates whether the collection is descending.
       */
      @query("isDescending")
      isDescending?: boolean;

      /**
       * Initial number of items to skip.
       */
      @query("initialSkip")
      initialSkip?: int32;
    },
    Response = UserSessionList
  >;

  @get
  @action("userSessions")
  @list
  listByHostPool is Azure.ResourceManager.ArmResourceActionSync<
    HostPool,
    void,
    UserSessionList,
    Parameters = {
      /**
       * OData filter expression. Valid properties for filtering are userprincipalname and sessionstate.
       */
      @query("$filter")
      $filter?: string;

      /**
       * Number of items per page.
       */
      @query("pageSize")
      pageSize?: int32;

      /**
       * Indicates whether the collection is descending.
       */
      @query("isDescending")
      isDescending?: boolean;

      /**
       * Initial number of items to skip.
       */
      @query("initialSkip")
      initialSkip?: int32;
    }
  >;

  /**
   * Disconnect a userSession.
   */
  disconnect is ArmResourceActionSync<
    UserSession,
    void,
    {
      @statusCode _: 200;
    }
  >;

  /**
   * Send a message to a user.
   */
  #suppress "@azure-tools/typespec-client-generator-core/no-unnamed-types" "Backwards compatibility with existing clients."
  sendMessage is ArmResourceActionSync<
    UserSession,
    Request = {
      /**
       * Represents message sent to a UserSession.
       */
      @bodyRoot sendMessage?: SendMessage;
    },
    Response = OkResponse
  >;
}

@@maxLength(UserSession.name, 24);
@@minLength(UserSession.name, 1);
@@doc(UserSession.name,
  "The name of the user session within the specified session host"
);
@@doc(UserSession.properties, "Detailed properties for UserSession");
