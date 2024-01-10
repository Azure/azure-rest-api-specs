import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./HostPool.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.DesktopVirtualization;
@doc("Represents a SessionHost definition.")
@parentResource(HostPool)
model SessionHost is ProxyResource<SessionHostProperties> {
  @doc("The name of the session host within the specified host pool")
  @maxLength(48)
  @minLength(3)
  @key("sessionHostName")
  @segment("sessionHosts")
  name: string;
}

@armResourceOperations
interface SessionHosts {
  @doc("Get a session host.")
  get is ArmResourceRead<SessionHost>;

  @doc("Update a session host.")
  update is ArmCustomPatchSync<
    SessionHost,
    SessionHostPatch,
    {
      ...BaseParameters<SessionHost>;

      @doc("Force flag to update assign, unassign or reassign personal desktop.")
      @query("force")
      force?: boolean;
    }
  >;

  @doc("Remove a SessionHost.")
  delete is ArmResourceDeleteSync<
    SessionHost,
    {
      ...BaseParameters<SessionHost>;

      @doc("Force flag to force sessionHost deletion even when userSession exists.")
      @query("force")
      force?: boolean;
    }
  >;

  @doc("List sessionHosts.")
  list is ArmResourceListByParent<
    SessionHost,
    {
      ...BaseParameters<SessionHost>;

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
}
