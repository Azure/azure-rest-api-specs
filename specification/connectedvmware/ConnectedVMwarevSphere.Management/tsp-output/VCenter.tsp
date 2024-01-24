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
 * Defines the vCenter.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@Azure.ResourceManager.Private.armResourceInternal(VCenterProperties)
@includeInapplicableMetadataInPayload(false)
model VCenter extends TrackedResourceBase {
  /**
   * Name of the vCenter.
   */
  @path
  @key("vcenterName")
  @segment("vcenters")
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
  properties: VCenterProperties;
}

@armResourceOperations
interface VCenters {
  /**
   * Implements vCenter GET method.
   */
  get is ArmResourceRead<VCenter>;

  /**
   * Create Or Update vCenter.
   */
  create is ArmResourceCreateOrReplaceAsync<
    VCenter,
    BaseParameters<VCenter>,
    ArmAsyncOperationHeader
  >;

  /**
   * API to update certain properties of the vCenter resource.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<VCenter, ResourcePatch>;

  /**
   * Implements vCenter DELETE method.
   */
  delete is ArmResourceDeleteAsync<
    VCenter,
    {
      ...BaseParameters<VCenter>;

      /**
       * Whether force delete was specified.
       */
      @query("force")
      force?: boolean;
    }
  >;

  /**
   * List of vCenters in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("VCenters_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<VCenter>;

  /**
   * List of vCenters in a subscription.
   */
  list is ArmListBySubscription<VCenter>;
}

@@projectedName(VCenters.create::parameters.resource, "json", "body");
@@extension(VCenters.create::parameters.resource, "x-ms-client-name", "body");
@@doc(VCenters.create::parameters.resource, "Request payload.");
@@projectedName(VCenters.update::parameters.properties, "json", "body");
@@extension(VCenters.update::parameters.properties, "x-ms-client-name", "body");
@@doc(VCenters.update::parameters.properties, "Resource properties to update.");
