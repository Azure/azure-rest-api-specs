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
    KeyName = "singletonResource",
    SegmentName = "cloudServiceSlots",
    NamePattern = ""
  >;
}

alias CloudServiceOps = Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;

    @path
    @segment("resourceGroups")
    groupName: string;

    @path
    @segment("providers")
    providerName: "microsoft.Compute";

    /** The name of the cloud service. */
    @path
    @segment("cloudServices")
    @key
    resourceName: string;
  },
  {
    ...Extension.ExtensionProviderNamespace<SwapResource>;
    ...ParentKeysOf<SwapResource>;
  },
  {
    ...Extension.ExtensionProviderNamespace<SwapResource>;

    /**
     * The name of the singleton resource.
     */
    @path
    @segment("cloudServiceSlots")
    @key
    singletonResource: SingletonResource;
  }
>;

@armResourceOperations
interface SwapResources {
  /**
   * Gets the SwapResource which identifies the slot type for the specified cloud service. The slot type on a cloud service can either be Staging or Production
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VipSwap_Get")
  get is CloudServiceOps.Read<SwapResource, ErrorType = CloudError>;

  /**
   * Performs vip swap operation on swappable cloud services.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("VipSwap_Create")
  create is CloudServiceOps.CreateOrUpdateAsync<
    SwapResource,
    Response = OkResponse | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader,
    ErrorType = CloudError
  >;

  /**
   * Gets the list of SwapResource which identifies the slot type for the specified cloud service. The slot type on a cloud service can either be Staging or Production
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VipSwap_List")
  list is CloudServiceOps.List<
    SwapResource,
    Response = ArmResponse<SwapResourceListResult>,
    ErrorType = CloudError
  >;
}

@@doc(SwapResource.name, "");
@@doc(SwapResource.properties, "Swap resource properties");
@@doc(SwapResources.create::parameters.resource,
  "SwapResource object where slot type should be the target slot after vip swap for the specified cloud service."
);
