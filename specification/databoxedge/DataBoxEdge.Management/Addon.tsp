import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DataBoxEdgeDevice.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataBoxEdge;
// FIXME: Addon has no properties property
/**
 * Role Addon
 */
@parentResource(DataBoxEdgeDevice)
model Addon is Azure.ResourceManager.ProxyResource<{}> {
  ...ResourceNameParameter<
    Resource = Addon,
    KeyName = "addonName",
    SegmentName = "addons",
    NamePattern = ""
  >;

  /**
   * Addon type.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  kind: AddonType;
}

@armResourceOperations
interface Addons {
  /**
   * Gets a specific addon by name.
   */
  get is ArmResourceRead<Addon>;

  /**
   * Create or update a addon.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Addon,
    Response = ArmResourceUpdatedResponse<Addon> | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader<FinalResult = Addon> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes the addon on the device.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    Addon,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all the addons configured in the role.
   */
  listByRole is ArmResourceListByParent<
    Addon,
    Response = ArmResponse<AddonList>
  >;
}

@@doc(Addon.name, "The addon name.");
@@doc(Addons.createOrUpdate::parameters.resource, "The addon properties.");
