import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./HostPool.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.DesktopVirtualization;
/**
 * Represents a SessionHost definition.
 */
@parentResource(HostPool)
model SessionHost
  is Azure.ResourceManager.ProxyResource<SessionHostProperties> {
  ...ResourceNameParameter<
    Resource = SessionHost,
    KeyName = "sessionHostName",
    SegmentName = "sessionHosts",
    NamePattern = "^[A-Za-z0-9@.\\-_ ]*$"
  >;
}

@armResourceOperations
interface SessionHosts {
  /**
   * Get a session host.
   */
  get is ArmResourceRead<SessionHost>;

  /**
   * Update a session host.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    SessionHost,
    SessionHostPatch,
    Request = {
      /**
       * The resource properties to be updated
       */
      @bodyRoot sessionHost?: SessionHostPatch;

      /**
       * Force flag to update assign, unassign or reassign personal desktop.
       */
      @query("force")
      force?: boolean;
    }
  >;

  /**
   * Remove a SessionHost.
   */
  delete is ArmResourceDeleteSync<
    SessionHost,
    Parameters = {
      /**
       * Force flag to force sessionHost deletion even when userSession exists.
       */
      @query("force")
      force?: boolean;
    }
  >;

  /**
   * List sessionHosts.
   */
  list is ArmResourceListByParent<
    SessionHost,
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

      /**
       * The path to the VM.
       */
      @query("vmPath")
      @maxLength(1092)
      @minLength(3)
      @pattern("^[A-Z][a-z][0-9][@./-_ ]*$")
      vmPath?: string;
    },
    Response = SessionHostList
  >;

  /**
   * Retry provisioning on a SessionHost.
   */
  retryProvisioning is ArmResourceActionSync<SessionHost, void, OkResponse>;
}

@@maxLength(SessionHost.name, 48);
@@minLength(SessionHost.name, 3);
@@doc(SessionHost.name,
  "The name of the session host within the specified host pool"
);
@@doc(SessionHost.properties, "Detailed properties for SessionHost");
