import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./HostPool.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DesktopVirtualization;
/**
 * Represents a SessionHost definition.
 */
@parentResource(HostPool)
model SessionHost is ProxyResource<SessionHostProperties> {
  /**
   * The name of the session host within the specified host pool
   */
  @maxLength(48)
  @minLength(3)
  @path
  @key("sessionHostName")
  @segment("sessionHosts")
  name: string;
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
  @parameterVisibility("read")
  update is ArmCustomPatchSync<
    SessionHost,
    SessionHostPatch,
    {
      ...BaseParameters<SessionHost>;

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
    {
      ...BaseParameters<SessionHost>;

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
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SessionHosts_List")
  list is ArmResourceListByParent<
    SessionHost,
    {
      ...BaseParameters<SessionHost>;

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
}

@@projectedName(SessionHosts.update::parameters.properties,
  "json",
  "sessionHost"
);
@@extension(SessionHosts.update::parameters.properties,
  "x-ms-client-name",
  "sessionHost"
);
@@doc(SessionHosts.update::parameters.properties,
  "Object containing SessionHost definitions."
);
