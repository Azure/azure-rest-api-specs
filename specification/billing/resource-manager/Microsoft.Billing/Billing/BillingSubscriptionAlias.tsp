import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./BillingAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

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
    NamePattern = GuidPattern
  >;

  /**
   * Dictionary of metadata associated with the resource. It may not be populated for all resource types. Maximum key/value length supported of 256 characters. Keys/value should not empty value nor null. Keys can not contain < > % & \ ? /
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing documentation to provide tags like this. Same type as types.tsp/TrackedResource."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing documentation to provide tags like this. Same type as types.tsp/TrackedResource."
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
    @pattern(BillingAccountNamePattern)
    billingAccountName: string;
  },
  {
    /** The ID that uniquely identifies a subscription alias. */
    @path
    @segment("billingSubscriptionAliases")
    @key
    @pattern(GuidPattern)
    aliasName: string;
  }
>;

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "A Billing Subscription Alias is not a distinct resource, just another means to reference a billing subscription."
@armResourceOperations(#{ omitTags: true })
interface BillingSubscriptionAliases {
  /**
   * Gets a subscription by its alias ID.  The operation is supported for seat based billing subscriptions.
   */
  @tag("BillingSubscription")
  get is BillingSubscriptionAliasOps.Read<BillingSubscriptionAlias>;

  /**
   * Creates or updates a billing subscription by its alias ID.  The operation is supported for seat based billing subscriptions.
   */
  @tag("BillingSubscription")
  createOrUpdate is BillingSubscriptionAliasOps.CreateOrUpdateAsync<
    BillingSubscriptionAlias,
    Response =
      | ArmResourceUpdatedResponse<BillingSubscriptionAlias>
      | ArmResourceCreatedResponse<BillingSubscriptionAlias>
      | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = BillingSubscriptionAlias> &
          Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Lists the subscription aliases for a billing account. The operation is supported for seat based billing subscriptions.
   */
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

  ...DefaultODataParameters;
};

@@doc(
  BillingSubscriptionAlias.name,
  "The ID that uniquely identifies a subscription alias."
);
@@doc(
  BillingSubscriptionAlias.properties,
  "The properties of a(n) BillingSubscriptionAlias"
);
@@doc(
  BillingSubscriptionAliases.createOrUpdate::parameters.resource,
  "A billing subscription alias."
);
