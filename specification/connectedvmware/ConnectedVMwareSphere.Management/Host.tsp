import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ConnectedVMwarevSphere;
/**
 * Define the host.
 */
model Host is Azure.ResourceManager.TrackedResource<HostProperties, false> {
  ...ResourceNameParameter<
    Resource = Host,
    KeyName = "hostName",
    SegmentName = "hosts",
    NamePattern = ""
  >;

  /**
   * Gets or sets the extended location.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  extendedLocation?: ExtendedLocation;

  /**
   * Metadata used by portal/tooling/etc to render different UX experiences for resources of the same type; e.g. ApiApps are a kind of Microsoft.Web/sites type.  If supported, the resource provider must validate and persist this value.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;
}

@armResourceOperations
interface HostsOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
      },
      KeysOf<ResourceNameParameter<
        Resource = Host,
        KeyName = "hostName",
        SegmentName = "hosts",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface Hosts {
  /**
   * Implements host GET method.
   */
  get is ArmResourceRead<Host>;

  /**
   * Create Or Update host.
   */
  create is HostsOps.CreateOrUpdateAsync<Host, OptionalRequestBody = true>;

  /**
   * API to update certain properties of the host resource.
   */
  @patch(#{ implicitOptionality: false })
  update is HostsOps.CustomPatchSync<
    Host,
    PatchModel = ResourcePatch,
    OptionalRequestBody = true
  >;

  /**
   * Implements host DELETE method.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    Host,
    Parameters = {
      /**
       * Whether force delete was specified.
       */
      @query("force")
      force?: boolean;
    },
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List of hosts in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    Host,
    Response = ArmResponse<HostsList>
  >;

  /**
   * List of hosts in a subscription.
   */
  list is ArmListBySubscription<Host, Response = ArmResponse<HostsList>>;
}

@@doc(Host.name, "Name of the host.");
@@doc(Host.properties, "Resource properties.");
@@doc(Hosts.create::parameters.resource, "Request payload.");
@@doc(Hosts.update::parameters.properties, "Resource properties to update.");
