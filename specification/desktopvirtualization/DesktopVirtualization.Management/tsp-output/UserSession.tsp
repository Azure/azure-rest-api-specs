import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SessionHost.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DesktopVirtualization;
/**
 * Represents a UserSession definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(SessionHost)
@Azure.ResourceManager.Private.armResourceInternal(UserSessionProperties)
@includeInapplicableMetadataInPayload(false)
model UserSession extends ProxyResourceBase {
  /**
   * The name of the user session within the specified session host
   */
  @maxLength(24)
  @minLength(1)
  @path
  @key("userSessionId")
  @segment("userSessions")
  name: string;

  /**
   * Detailed properties for UserSession
   */
  @extension("x-ms-client-flatten", true)
  properties?: UserSessionProperties;
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
    {
      ...BaseParameters<UserSession>;

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
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("UserSessions_List")
  list is ArmResourceListByParent<
    UserSession,
    {
      ...BaseParameters<UserSession>;

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
  disconnect is ArmResourceActionSync<UserSession, void, void>;

  /**
   * Send a message to a user.
   */
  sendMessage is ArmResourceActionSync<UserSession, SendMessage, void>;
}

@@projectedName(UserSessions.sendMessage::parameters.body,
  "json",
  "sendMessage"
);
@@extension(UserSessions.sendMessage::parameters.body,
  "x-ms-client-name",
  "sendMessage"
);
@@doc(UserSessions.sendMessage::parameters.body,
  "Object containing message includes title and message body"
);
