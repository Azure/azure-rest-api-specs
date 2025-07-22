import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Quota;
/**
 * Resource usage.
 */
@extensionResource
model CurrentUsagesBase
  is Azure.ResourceManager.ExtensionResource<UsagesProperties> {
  ...ResourceNameParameter<
    Resource = CurrentUsagesBase,
    KeyName = "resourceName",
    SegmentName = "usages",
    NamePattern = ""
  >;
}

@armResourceOperations
interface CurrentUsagesBases {
  /**
   * Get the current usage of a resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Usages_Get")
  get is ArmResourceRead<
    CurrentUsagesBase,
    BaseParameters = Azure.ResourceManager.Foundations.ExtensionBaseParameters,
    Parameters = {
      /**
       * Resource name for a given resource provider. For example:
       * - SKU name for Microsoft.Compute
       * - SKU or TotalLowPriorityCores for Microsoft.MachineLearningServices
       *  For Microsoft.Network PublicIPAddresses.
       */
      @path
      resourceName: string;

      /**
       * The target Azure resource URI. For example, `/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/qms-test/providers/Microsoft.Batch/batchAccounts/testAccount/`. This is the target Azure resource URI for the List GET operation. If a `{resourceName}` is added after `/quotas`, then it's the target Azure resource URI in the GET operation for the specific resource.
       */
      @path
      scope: string;
    }
  >;

  /**
   * Get a list of current usage for all resources for the scope specified.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Usages_List")
  list is ArmResourceListByParent<
    CurrentUsagesBase,
    BaseParameters = Azure.ResourceManager.Foundations.ExtensionBaseParameters,
    Parameters = {
      /**
       * The target Azure resource URI. For example, `/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/qms-test/providers/Microsoft.Batch/batchAccounts/testAccount/`. This is the target Azure resource URI for the List GET operation. If a `{resourceName}` is added after `/quotas`, then it's the target Azure resource URI in the GET operation for the specific resource.
       */
      @path
      scope: string;
    },
    Response = ArmResponse<UsagesLimits>
  >;
}

@@doc(CurrentUsagesBase.name,
  """
    Resource name for a given resource provider. For example:
    - SKU name for Microsoft.Compute
    - SKU or TotalLowPriorityCores for Microsoft.MachineLearningServices
     For Microsoft.Network PublicIPAddresses.
    """
);
@@doc(CurrentUsagesBase.properties,
  "Usage properties for the specified resource."
);
