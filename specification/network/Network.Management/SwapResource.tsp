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
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Http.Private.includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
@singleton("default")
model SwapResource extends ProxyResourceWithReadOnlyID {
  /**
   * Properties of the SwapResource.
   */
  properties?: SwapResourceProperties;

  /**
   * The name of the resource.
   */
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  @path
  @key("singletonResource")
  @segment("cloudServiceSlots")
  name: string;
}

@@doc(SwapResource.name, "Resource name.");

alias CloudServiceOps = Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;

    #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @path
    @segment("resourceGroups")
    groupName: string;

    #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
@armResourceOperations
interface SwapResources {
  /**
   * Gets the SwapResource which identifies the slot type for the specified cloud service. The slot type on a cloud service can either be Staging or Production
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("VipSwap_Get")
  get is CloudServiceOps.Read<SwapResource, ErrorType = CloudError>;

  /**
   * Performs vip swap operation on swappable cloud services.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("VipSwap_Create")
  create is CloudServiceOps.CreateOrUpdateAsync<
    SwapResource,
    Response = {
      @body body: void;
    } | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader,
    ErrorType = CloudError
  >;

  /**
   * Gets the list of SwapResource which identifies the slot type for the specified cloud service. The slot type on a cloud service can either be Staging or Production
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
