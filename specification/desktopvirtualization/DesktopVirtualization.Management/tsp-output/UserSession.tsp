import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./SessionHost.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.DesktopVirtualization;
@doc("Represents a UserSession definition.")
@parentResource(SessionHost)
model UserSession is ProxyResource<UserSessionProperties> {
  @doc("The name of the user session within the specified session host")
  @maxLength(24)
  @minLength(1)
  @key("userSessionId")
  @segment("userSessions")
  name: string;
}

@armResourceOperations
interface UserSessions {
  @doc("Get a userSession.")
  get is ArmResourceRead<UserSession>;

  @doc("Remove a userSession.")
  delete is ArmResourceDeleteSync<
    UserSession,
    {
      ...BaseParameters<UserSession>;

      @doc("Force flag to login off userSession.")
      @query("force")
      force?: boolean;
    }
  >;

  @doc("List userSessions.")
  list is ArmResourceListByParent<
    UserSession,
    {
      ...BaseParameters<UserSession>;

      @doc("Number of items per page.")
      @query("pageSize")
      pageSize?: int32;

      @doc("Indicates whether the collection is descending.")
      @query("isDescending")
      isDescending?: boolean;

      @doc("Initial number of items to skip.")
      @query("initialSkip")
      initialSkip?: int32;
    }
  >;

  @doc("Disconnect a userSession.")
  disconnect is ArmResourceActionSync<UserSession, void, void>;

  @doc("Send a message to a user.")
  sendMessage is ArmResourceActionSync<UserSession, SendMessage, void>;
}
