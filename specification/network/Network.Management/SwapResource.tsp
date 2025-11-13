import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * SwapResource to represent slot type on the specified cloud service.
 */
@singleton("default")
model SwapResource
  is Azure.ResourceManager.ProxyResource<SwapResourceProperties> {
  ...ResourceNameParameter<
    Resource = SwapResource,
    KeyName = "cloudServiceSlot",
    SegmentName = "cloudServiceSlots",
    NamePattern = ""
  >;
}

alias cloudServiceExternalResource = Extension.ExternalResource<
  "Microsoft.Compute",
  "cloudServices",
  "{resourceName}"
>;

@armResourceOperations
interface SwapResources {
  /**
   * Gets the SwapResource which identifies the slot type for the specified cloud service. The slot type on a cloud service can either be Staging or Production
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VipSwap_Get")
  get is ArmResourceRead<SwapResource>;

  /**
   * Performs vip swap operation on swappable cloud services.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("VipSwap_Create")
  create is ArmResourceCreateOrReplaceAsync<
    SwapResource,
    Response = OkResponse | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Gets the list of SwapResource which identifies the slot type for the specified cloud service. The slot type on a cloud service can either be Staging or Production
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VipSwap_List")
  list is ArmResourceListByParent<
    SwapResource,
    Response = ArmResponse<SwapResourceListResult>
  >;
}

@@doc(SwapResource.name, "");
@@doc(SwapResource.properties, "Swap resource properties");
@@doc(SwapResources.create::parameters.resource,
  "SwapResource object where slot type should be the target slot after vip swap for the specified cloud service."
);
