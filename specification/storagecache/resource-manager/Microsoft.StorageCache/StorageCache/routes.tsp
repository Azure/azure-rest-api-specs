// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.StorageCache;

/**
 * Check that subnets will be valid for AML file system create calls.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
@operationId("checkAmlFSSubnets")
@tag("amlFilesystems")
@autoRoute
op checkAmlFSSubnets is ArmProviderActionSync<
  Request = AmlFilesystemSubnetInfo,
  Response = OkResponse,
  Scope = SubscriptionActionScope,
  Error = CloudError | BadRequestResponse,
  OptionalRequestBody = true
>;

/**
 * Get the number of available IP addresses needed for the AML file system information provided.
 */
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
@operationId("getRequiredAmlFSSubnetsSize")
@tag("amlFilesystems")
@autoRoute
op getRequiredAmlFSSubnetsSize is ArmProviderActionSync<
  Request = RequiredAmlFilesystemSubnetsSizeInfo,
  Response = RequiredAmlFilesystemSubnetsSize,
  Scope = SubscriptionActionScope,
  Error = CloudError,
  OptionalRequestBody = true
>;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface SkusOperationGroup {
  /**
   * Get the list of StorageCache.Cache SKUs available to this subscription.
   */
  @tag("SKUs")
  @autoRoute
  @get
  @list
  @action("skus")
  list is ArmProviderActionSync<
    Response = ResourceSkusResult,
    Scope = SubscriptionActionScope,
    Error = CloudError
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface UsageModelsOperationGroup {
  /**
   * Get the list of cache usage models available to this subscription.
   */
  @tag("UsageModels")
  @autoRoute
  @get
  @list
  @action("usageModels")
  list is ArmProviderActionSync<
    Response = UsageModelsResult,
    Scope = SubscriptionActionScope,
    Error = CloudError
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface AscOperationsOperationGroup {
  /**
   * Gets the status of an asynchronous operation for the Azure HPC Cache
   */
  @tag("AscOperations")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.StorageCache/locations/{location}/ascOperations/{operationId}")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...LocationResourceParameter,

    /**
     * The ID of an ongoing async operation.
     */
    @minLength(1)
    @path
    operationId: string,
  ): ArmResponse<AscOperation> | CloudError;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface AscUsagesOperationGroup {
  /**
   * Gets the quantity used and quota limit for resources
   */
  @tag("AscUsages")
  @autoRoute
  @get
  @list
  @action("usages")
  list is ArmProviderActionSync<
    Response = ResourceUsagesListResult,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter,
    Error = CloudError
  >;
}
