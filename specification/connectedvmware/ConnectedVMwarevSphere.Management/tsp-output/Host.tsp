import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ConnectedVMwarevSphere;
/**
 * Define the host.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(HostProperties)
model Host extends TrackedResourceBase {
  /**
   * Name of the host.
   */
  @path
  @key("hostName")
  @segment("hosts")
  @visibility("read")
  name: string;

  /**
   * Gets or sets the extended location.
   */
  extendedLocation?: ExtendedLocation;

  /**
   * Metadata used by portal/tooling/etc to render different UX experiences for resources of the same type; e.g. ApiApps are a kind of Microsoft.Web/sites type.  If supported, the resource provider must validate and persist this value.
   */
  kind?: string;

  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: HostProperties;
}

@armResourceOperations
interface Hosts {
  /**
   * Implements host GET method.
   */
  get is ArmResourceRead<Host>;

  /**
   * Create Or Update host.
   */
  create is ArmResourceCreateOrReplaceAsync<
    Host,
    BaseParameters<Host>,
    ArmAsyncOperationHeader
  >;

  /**
   * API to update certain properties of the host resource.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<Host, ResourcePatch>;

  /**
   * Implements host DELETE method.
   */
  delete is ArmResourceDeleteAsync<
    Host,
    {
      ...BaseParameters<Host>;

      /**
       * Whether force delete was specified.
       */
      @query("force")
      force?: boolean;
    }
  >;

  /**
   * List of hosts in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Hosts_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<Host>;

  /**
   * List of hosts in a subscription.
   */
  list is ArmListBySubscription<Host>;
}

@@projectedName(Hosts.create::parameters.resource, "json", "body");
@@extension(Hosts.create::parameters.resource, "x-ms-client-name", "body");
@@doc(Hosts.create::parameters.resource, "Request payload.");
@@projectedName(Hosts.update::parameters.properties, "json", "body");
@@extension(Hosts.update::parameters.properties, "x-ms-client-name", "body");
@@doc(Hosts.update::parameters.properties, "Resource properties to update.");
