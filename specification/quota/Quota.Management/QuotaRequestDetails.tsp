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
 * List of quota requests with details.
 */
@extensionResource
model QuotaRequestDetails
  is Azure.ResourceManager.ExtensionResource<QuotaRequestProperties> {
  ...ResourceNameParameter<
    Resource = QuotaRequestDetails,
    KeyName = "id",
    SegmentName = "quotaRequests",
    NamePattern = ""
  >;
}

@armResourceOperations
interface QuotaRequestStatus {
  /**
   * Get the quota request details and status by quota request ID for the resources of the resource provider at a specific location. The quota request ID **id** is returned in the response of the PUT operation.
   */
  get is ArmResourceRead<
    QuotaRequestDetails,
    BaseParameters = Azure.ResourceManager.Foundations.ExtensionBaseParameters,
    Parameters = {
      /**
       * Quota request ID.
       */
      @path
      id: string;

      /**
       * The target Azure resource URI. For example, `/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/qms-test/providers/Microsoft.Batch/batchAccounts/testAccount/`. This is the target Azure resource URI for the List GET operation. If a `{resourceName}` is added after `/quotas`, then it's the target Azure resource URI in the GET operation for the specific resource.
       */
      @path
      scope: string;
    }
  >;

  /**
   * For the specified scope, get the current quota requests for a one year period ending at the time is made. Use the **oData** filter to select quota requests.
   */
  list is ArmResourceListByParent<
    QuotaRequestDetails,
    BaseParameters = Azure.ResourceManager.Foundations.ExtensionBaseParameters,
    Parameters = {
      /**
       * The target Azure resource URI. For example, `/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/qms-test/providers/Microsoft.Batch/batchAccounts/testAccount/`. This is the target Azure resource URI for the List GET operation. If a `{resourceName}` is added after `/quotas`, then it's the target Azure resource URI in the GET operation for the specific resource.
       */
      @path
      scope: string;

      /**
       * | Field                    | Supported operators
       * |---------------------|------------------------
       *
       * |requestSubmitTime | ge, le, eq, gt, lt
       *  |provisioningState eq {QuotaRequestState}
       *  |resourceName eq {resourceName}
       *
       */
      @query("$filter")
      $filter?: string;

      /**
       * Number of records to return.
       */
      @minValue(1)
      @query("$top")
      $top?: int32;

      /**
       * The **Skiptoken** parameter is used only if a previous operation returned a partial result. If a previous response contains a **nextLink** element, its value includes a **skiptoken** parameter that specifies a starting point to use for subsequent calls.
       */
      @query("$skiptoken")
      $skiptoken?: string;
    },
    Response = ArmResponse<QuotaRequestDetailsList>
  >;
}

@@doc(QuotaRequestDetails.name, "Quota request ID.");
@@doc(QuotaRequestDetails.properties, "Quota request details.");
