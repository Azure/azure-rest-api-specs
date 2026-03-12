import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./BillingAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Billing;
/**
 * A billing subscription alias.
 */
@tenantResource
@parentResource(BillingAccount)
model BillingSubscriptionAlias
  is Azure.ResourceManager.ProxyResource<BillingSubscriptionAliasProperties> {
  ...ResourceNameParameter<
    Resource = BillingSubscriptionAlias,
    KeyName = "aliasName",
    SegmentName = "billingSubscriptionAliases",
    NamePattern = ""
  >;

  /**
   * Dictionary of metadata associated with the resource. It may not be populated for all resource types. Maximum key/value length supported of 256 characters. Keys/value should not empty value nor null. Keys can not contain < > % & \ ? /
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

alias BillingSubscriptionAliasOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** The ID that uniquely identifies a billing account. */
    @path
    @segment("billingAccounts")
    @key
    billingAccountName: string;
  },
  {
    /** The ID that uniquely identifies a subscription alias. */
    @path
    @segment("billingSubscriptionAliases")
    @key
    aliasName: string;
  }
>;

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations(#{ omitTags: true })
interface BillingSubscriptionAliases {
  /**
   * Gets a subscription by its alias ID.  The operation is supported for seat based billing subscriptions.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingSubscription")
  get is BillingSubscriptionAliasOps.Read<BillingSubscriptionAlias>;

  /**
   * Creates or updates a billing subscription by its alias ID.  The operation is supported for seat based billing subscriptions.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingSubscription")
  createOrUpdate is BillingSubscriptionAliasOps.CreateOrUpdateAsync<
    BillingSubscriptionAlias,
    Response = ArmResourceUpdatedResponse<BillingSubscriptionAlias> | ArmResourceCreatedResponse<BillingSubscriptionAlias> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = BillingSubscriptionAlias> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Lists the subscription aliases for a billing account. The operation is supported for seat based billing subscriptions.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingSubscription")
  listByBillingAccount is BillingSubscriptionAliasOps.List<
    BillingSubscriptionAlias,
    Parameters = BillingSubscriptionAliasesListByBillingAccountParameters,
    Response = ArmResponse<BillingSubscriptionAliasListResult>
  >;
}

alias BillingSubscriptionAliasesListByBillingAccountParameters = {
  /**
   * Can be used to get deleted billing subscriptions.
   */
  @query("includeDeleted")
  includeDeleted?: boolean = false;

  /**
   * The filter query option allows clients to filter a collection of resources that are addressed by a request URL.
   */
  @query("filter")
  filter?: string;

  /**
   * The orderby query option allows clients to request resources in a particular order.
   */
  @query("orderBy")
  orderBy?: string;

  /**
   * The top query option requests the number of items in the queried collection to be included in the result. The maximum supported value for top is 50.
   */
  @query("top")
  top?: int64;

  /**
   * The skip query option requests the number of items in the queried collection that are to be skipped and not included in the result.
   */
  @query("skip")
  skip?: int64;

  /**
   * The count query option allows clients to request a count of the matching resources included with the resources in the response.
   */
  @query("count")
  count?: boolean;

  /**
   * The search query option allows clients to request items within a collection matching a free-text search expression. search is only supported for string fields.
   */
  @query("search")
  search?: string;
};

@@doc(BillingSubscriptionAlias.name,
  "The ID that uniquely identifies a subscription alias."
);
@@doc(BillingSubscriptionAlias.properties,
  "The properties of a(n) BillingSubscriptionAlias"
);
@@doc(BillingSubscriptionAliases.createOrUpdate::parameters.resource,
  "A billing subscription alias."
);
