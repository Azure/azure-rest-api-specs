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

namespace Microsoft.Quota;
/**
 * List of quota requests with details.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@extensionResource
@includeInapplicableMetadataInPayload(false)
model QuotaRequestDetails {
  /**
   * Quota request ID.
   */
  @path
  @key("id")
  @segment("quotaRequests")
  @visibility("read")
  name: string;

  /**
   * Quota request ID.
   */
  @visibility("read")
  id?: string;

  /**
   * Resource type. "Microsoft.Quota/quotas".
   */
  @visibility("read")
  type?: string;

  /**
   * Quota request details.
   */
  @extension("x-ms-client-flatten", true)
  properties?: QuotaRequestProperties;
}

@armResourceOperations
@projectedName("client", "QuotaRequestDetails")
interface QuotaRequestDetailsOperationGroup {
  /**
   * Get the quota request details and status by quota request ID for the resources of the resource provider at a specific location. The quota request ID **id** is returned in the response of the PUT operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("QuotaRequestStatus_Get")
  get is ArmResourceRead<QuotaRequestDetails>;

  /**
   * For the specified scope, get the current quota requests for a one year period ending at the time is made. Use the **oData** filter to select quota requests.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("QuotaRequestStatus_List")
  list is ArmResourceListByParent<
    QuotaRequestDetails,
    {
      ...BaseParameters<QuotaRequestDetails>;

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
    }
  >;
}
