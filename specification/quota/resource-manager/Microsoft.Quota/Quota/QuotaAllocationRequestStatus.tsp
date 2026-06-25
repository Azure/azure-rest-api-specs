import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Quota;
/**
 * The subscription quota allocation status.
 */
model QuotaAllocationRequestStatus
  is Azure.ResourceManager.ExtensionResource<QuotaAllocationRequestStatusProperties> {
  ...ResourceNameParameter<
    Resource = QuotaAllocationRequestStatus,
    KeyName = "allocationId",
    SegmentName = "quotaAllocationRequests",
    NamePattern = ""
  >;
}

alias QuotaAllocationRequestStatusesOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Management";

    /**
     * The management group ID.
     */
    @path
    @segment("managementGroups")
    @key
    @minLength(3)
    @maxLength(63)
    managementGroupId: string;

    ...SubscriptionIdParameter;
  },
  {
    ...Extension.ExtensionProviderNamespace<QuotaAllocationRequestStatus>;
  },
  {
    ...Extension.ExtensionProviderNamespace<QuotaAllocationRequestStatus>;

    /**
     * The GroupQuota name. The name should be unique for the provided context tenantId/MgId.
     */
    @path
    @segment("groupQuotas")
    @minLength(3)
    @maxLength(63)
    @key
    @pattern("^[a-z][a-z0-9]*$")
    groupQuotaName: string;

    /**
     * The resource provider name, such as - Microsoft.Compute. Currently only Microsoft.Compute resource provider supports this API.
     */
    @path
    @key
    @segment("resourceProviders")
    @pattern("^((?!-)[a-zA-Z0-9-]{1,63}(?<!-)\\.)+[a-zA-Z]{2,63}$")
    resourceProviderName: string;
  }
>;

#suppress "@azure-tools/typespec-azure-resource-manager/improper-subscription-list-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface QuotaAllocationRequestStatuses {
  /**
   * Get the quota allocation request status for the subscriptionId by allocationId.
   */
  get is QuotaAllocationRequestStatusesOps.Read<
    QuotaAllocationRequestStatus,
    Parameters = {
      /**
       * Request Id.
       */
      @path
      @segment("quotaAllocationRequests")
      allocationId: string;
    }
  >;

  /**
   * Get all the quotaAllocationRequests for a resourceProvider/location. The filter paramter for location is required.
   */
  list is QuotaAllocationRequestStatusesOps.List<
    QuotaAllocationRequestStatus,
    Parameters = {
      /**
       * The GroupQuota name. The name should be unique for the provided context tenantId/MgId.
       */
      @path
      @segment("groupQuotas")
      @minLength(3)
      @maxLength(63)
      @pattern("^[a-z][a-z0-9]*$")
      groupQuotaName: string;

      /**
       * The resource provider name, such as - Microsoft.Compute. Currently only Microsoft.Compute resource provider supports this API.
       */
      @path
      @segment("resourceProviders")
      @pattern("^((?!-)[a-zA-Z0-9-]{1,63}(?<!-)\\.)+[a-zA-Z]{2,63}$")
      resourceProviderName: string;

      /**
       * | Field | Supported operators
       * |---------------------|------------------------
       *
       *  location eq {location}
       *  Example: $filter=location eq eastus
       */
      @minLength(12)
      @query("$filter")
      $filter: string;
    },
    Response = ArmResponse<QuotaAllocationRequestStatusList>
  >;
}

@@doc(QuotaAllocationRequestStatus.name, "Request Id.");
@@doc(QuotaAllocationRequestStatus.properties, "");

alias QuotaAllocationRequestsBySubscriptionOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Management";

    /**
     * The management group ID.
     */
    @path
    @segment("managementGroups")
    @key
    @minLength(3)
    @maxLength(63)
    managementGroupId: string;

    ...SubscriptionIdParameter;
  },
  {
    ...Extension.ExtensionProviderNamespace<QuotaAllocationRequestStatus>;
  },
  {
    /**
     * The resource provider name, such as - Microsoft.Compute. Currently only Microsoft.Compute resource provider supports this API.
     */
    @path
    @key
    @segment("resourceProviders")
    @pattern("^((?!-)[a-zA-Z0-9-]{1,63}(?<!-)\\.)+[a-zA-Z]{2,63}$")
    resourceProviderName: string;
  }
>;

alias QuotaAllocationRequestsByGroupQuotaOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Management";

    /**
     * The management group ID.
     */
    @path
    @segment("managementGroups")
    @key
    @minLength(3)
    @maxLength(63)
    managementGroupId: string;
  },
  {
    ...Extension.ExtensionProviderNamespace<QuotaAllocationRequestStatus>;
  },
  {
    ...Extension.ExtensionProviderNamespace<QuotaAllocationRequestStatus>;

    /**
     * The GroupQuota name. The name should be unique for the provided context tenantId/MgId.
     */
    @path
    @segment("groupQuotas")
    @minLength(3)
    @maxLength(63)
    @key
    @pattern("^[a-z][a-z0-9]*$")
    groupQuotaName: string;

    /**
     * The resource provider name, such as - Microsoft.Compute. Currently only Microsoft.Compute resource provider supports this API.
     */
    @path
    @key
    @segment("resourceProviders")
    @pattern("^((?!-)[a-zA-Z0-9-]{1,63}(?<!-)\\.)+[a-zA-Z]{2,63}$")
    resourceProviderName: string;
  }
>;

@armResourceOperations
@added(Versions.v2026_05_01_preview)
interface QuotaAllocationRequests {
  /**
   * Get all the quotaAllocationRequests for a resourceProvider/location scoped to a subscription.
   * The filter parameter for location is optional.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/improper-subscription-list-operation" "listBySubscription is a subscription-context enumeration under a managementGroup parent rather than a true subscription-scope list, so the rule's heuristic does not apply."
  @added(Versions.v2026_05_01_preview)
  listBySubscription is QuotaAllocationRequestsBySubscriptionOps.List<
    QuotaAllocationRequestStatus,
    Parameters = {
      /**
       * The resource provider name, such as - Microsoft.Compute. Currently only Microsoft.Compute resource provider supports this API.
       */
      @path
      @segment("resourceProviders")
      @pattern("^((?!-)[a-zA-Z0-9-]{1,63}(?<!-)\\.)+[a-zA-Z]{2,63}$")
      resourceProviderName: string;

      /**
       * | Field | Supported operators
       * |---------------------|------------------------
       *
       *  location eq {location}
       *  Example: $filter=location eq eastus
       */
      @query("$filter")
      filter?: string;

      /**
       * Number of records to return.
       */
      @query("$top")
      top?: int32;

      /**
       * The skiptoken that is used for paginated results.
       */
      @query("$skiptoken")
      skiptoken?: string;
    },
    Response = ArmResponse<QuotaAllocationRequestStatusList>
  >;

  /**
   * Get all the quotaAllocationRequests for a resourceProvider/location scoped to a group quota.
   * The filter parameter for location is optional.
   */
  @added(Versions.v2026_05_01_preview)
  listByGroupQuota is QuotaAllocationRequestsByGroupQuotaOps.List<
    QuotaAllocationRequestStatus,
    Parameters = {
      /**
       * The GroupQuota name. The name should be unique for the provided context tenantId/MgId.
       */
      @path
      @segment("groupQuotas")
      @minLength(3)
      @maxLength(63)
      @pattern("^[a-z][a-z0-9]*$")
      groupQuotaName: string;

      /**
       * The resource provider name, such as - Microsoft.Compute. Currently only Microsoft.Compute resource provider supports this API.
       */
      @path
      @segment("resourceProviders")
      @pattern("^((?!-)[a-zA-Z0-9-]{1,63}(?<!-)\\.)+[a-zA-Z]{2,63}$")
      resourceProviderName: string;

      /**
       * | Field | Supported operators
       * |---------------------|------------------------
       *
       *  location eq {location}
       *  Example: $filter=location eq eastus
       */
      @query("$filter")
      filter?: string;

      /**
       * Number of records to return.
       */
      @query("$top")
      top?: int32;

      /**
       * The skiptoken that is used for paginated results.
       */
      @query("$skiptoken")
      skiptoken?: string;
    },
    Response = ArmResponse<QuotaAllocationRequestStatusList>
  >;
}
