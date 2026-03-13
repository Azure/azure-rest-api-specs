import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DataBoxEdgeDevice.tsp";
import "./VirtualResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataBoxEdge;
// FIXME: Addon has no properties property
/**
 * Role Addon
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy DiscriminatedProxyResource for back compatibility"
@discriminator("kind")
@parentResource(Role)
model Addon
  is Azure.ResourceManager.Legacy.DiscriminatedProxyResource<AddonType> {
  ...ResourceNameParameter<
    Resource = Addon,
    KeyName = "addonName",
    SegmentName = "addons",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Addons {
  /**
   * Gets a specific addon by name.
   */
  get is AddonsOps.Read<Addon, OverrideErrorType = CloudError>;

  /**
   * Create or update a addon.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is AddonsOps.CreateOrUpdateAsync<
    Addon,
    Response = ArmResourceUpdatedResponse<Addon> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = Addon> &
      Azure.Core.Foundations.RetryAfterHeader>,
    OverrideErrorType = CloudError
  >;

  /**
   * Deletes the addon on the device.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is AddonsOps.DeleteWithoutOkAsync<
    Addon,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    OverrideErrorType = CloudError
  >;

  /**
   * Lists all the addons configured in the role.
   */
  listByRole is AddonsOps.List<
    Addon,
    Response = ArmResponse<AddonList>,
    OverrideErrorType = CloudError
  >;
}

@armResourceOperations
interface AddonsOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.ProviderNamespace<Addon>,

        /**
         * The name of the device.
         */
        @path
        @segment("dataBoxEdgeDevices")
        deviceName: string,

        /**
         * The name of the role.
         */
        @path
        @segment("roles")
        roleName: string,
      },
      {
        /**
         * The name of the addon.
         */
        @path
        @segment("addons")
        addonName: string,
      }
    > {}

@@doc(Addon.name, "The addon name.");
@@doc(Addons.createOrUpdate::parameters.resource, "The addon properties.");
@@doc(Addon.kind, "Addon type.");
