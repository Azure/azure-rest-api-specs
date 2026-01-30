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
 * Defines the vCenter.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VCenter
  is Azure.ResourceManager.TrackedResource<VCenterProperties, false> {
  ...ResourceNameParameter<
    Resource = VCenter,
    KeyName = "vcenterName",
    SegmentName = "vcenters",
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

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface VCentersOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
      },
      KeysOf<ResourceNameParameter<
        Resource = VCenter,
        KeyName = "vcenterName",
        SegmentName = "vcenters",
        NamePattern = ""
      >>
    > {}

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface VCenters {
  /**
   * Implements vCenter GET method.
   */
  get is ArmResourceRead<VCenter>;

  /**
   * Create Or Update vCenter.
   */
  create is VCentersOps.CreateOrUpdateAsync<
    VCenter,
    OptionalRequestBody = true
  >;

  /**
   * API to update certain properties of the vCenter resource.
   */
  @patch(#{ implicitOptionality: false })
  update is VCentersOps.CustomPatchSync<
    VCenter,
    PatchModel = ResourcePatch,
    OptionalRequestBody = true
  >;

  /**
   * Implements vCenter DELETE method.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    VCenter,
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
   * List of vCenters in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    VCenter,
    Response = ArmResponse<VCentersList>
  >;

  /**
   * List of vCenters in a subscription.
   */
  list is ArmListBySubscription<VCenter, Response = ArmResponse<VCentersList>>;
}

@@doc(VCenter.name, "Name of the vCenter.");
@@doc(VCenter.properties, "Resource properties.");
@@doc(VCenters.create::parameters.resource, "Request payload.");
@@doc(VCenters.update::parameters.properties, "Resource properties to update.");
