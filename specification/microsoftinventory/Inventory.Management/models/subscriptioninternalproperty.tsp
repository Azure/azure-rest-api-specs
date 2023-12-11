import "./common.tsp";

@doc("The Subscription internal properties")
model SubscriptionInternalProperties {
  @doc("Subscription Billing properties.")
  billingProperties?: BillingProperties;

  @doc("Subscription Id")
  subscriptionId: string;

  @doc("Subscription display name")
  displayName?: string;

  @doc("Subscription Entitlement start date")
  entitlementStartDate?: string;

  @doc("Subscription Offer Category")
  offerCategory?: string;

  @doc("Subscription offer Type")
  offerType?: string;

  @doc("Promotions offered to the subscription")
  promotions?: PromotionsList;

  @doc("Current state of subscription")
  state?: State;

  @doc("Subscription policies")
  subscriptionPolicies?: SubscriptionPolicies;

  @doc("Internal subscription policies")
  internalSubscriptionPolicies?: InternalSubscriptionPolicies;

  @doc("Subscription Tenant Id")
  tenantId: string;

  @doc("Subscription Created Time")
  changedTime?: utcDateTime;

  @doc("Subscription Created Time")
  createdTime?: utcDateTime;

  @doc("Subscription Provisioning state")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("List of promotions")
model PromotionsList {
  @doc("Promotions that are offered to the subscription")
  @OpenAPI.extension("x-ms-identifiers", [])
  value: PromotionData[];
}

@doc("Promotion category and end date time")
model PromotionData {
  @doc("promotion category free vs pay-as-you-go")
  category: string;

  @doc("promotion end date time")
  endDateTime: utcDateTime;
}

@doc("Subscription states")
enum State {
  @doc("Registered subscription state")
  Registered,

  @doc("Unregistered subscription state")
  Unregistered,

  @doc("Warned subscription state")
  Warned,

  @doc("Suspended subscription state")
  Suspended,

  @doc("Deleted subscription state")
  Deleted,
}

@doc("The Subscription billing properties")
model BillingProperties {
  @doc("Commerce object identifying additional state information associated with the subscription.")
  additionalStateInformation: AdditionalStateInformation;

  @doc("Billing account of the customer that holds customer payment instrument, address etc. The subscription is always linked to a billing account.")
  billingAccount: BillingAccount;

  @doc("Indicates the commerce stack that this account is on - modern or legacy")
  billingType: BillingType;

  @doc("Indicates the sales motion that this subscription type belongs to. This can be changed if a subscription moves from one channel type to another (e.g., CustomerLed to PartnerLed)")
  channelType: ChannelType;

  @doc("Differentiates how customer is paying for the subscription. This can change if customer changes from free to paid, etc.")
  paymentType: PaymentType;

  @doc("Customer segment")
  tier: Tier;

  @doc("Indicates the importance of this subscription. DevTest subscriptions get lower SLA compared to Production ones. This property can be changed later if needed as well.")
  workloadType: WorkloadType;
}

@doc("Commerce object identifying additional state information associated with the subscription.")
model AdditionalStateInformation {
  @doc("Indicates whether the Non data retention resources can be released. This is a high confidence signal that would be set to true when the subscription is already in disabled state. To learn about Azure Data Retention policy after subscription has been disabled see")
  releaseNonDataRetentionResource?: boolean;

  @doc("Indicates whether the new resource creation should be blocked. Existing resources functionality should not be impacted. This signal should be looked at when subscription state is Active. The service should be able to recover if the flag is reset to false.")
  blockNewResourceCreation?: boolean;
}

@doc("Billing account of the customer that holds customer payment instrument, address etc. The subscription is always linked to a billing account.")
model BillingAccount {
  @doc("Unique Id identifying the commerce object for the billing account.")
  id: string;
}

@doc("Subscription billing types")
enum BillingType {
  @doc("Legacy billing type")
  Legacy,

  @doc("Modern billing type")
  Modern,
}

@doc("Subscription channel type")
enum ChannelType {
  @doc("None channel type")
  None,

  @doc("Internal channel type")
  Internal,

  @doc("FieldLed channel type")
  FieldLed,

  @doc("CustomerLed channel type")
  CustomerLed,

  @doc("Partnerled channel type")
  PartnerLed,
}

@doc("Subscription state payment type")
enum PaymentType {
  @doc("None payment type")
  None,

  @doc("Paid payment type")
  Paid,

  @doc("Free payment type")
  Free,

  @doc("Entitlement payment type")
  Entitlement,

  @doc("SponsoredPlus payment type")
  SponsoredPlus,

  @doc("Sponsored payment type")
  Sponsored,

  @doc("Benefit payment type")
  Benefit,
}

@doc("Subscription tier")
enum Tier {
  @doc("Unknown tier")
  Unknown,

  @doc("Standard tier")
  Standard,

  @doc("Premium tier")
  Premium,

  @doc("Priority tier")
  Priority,
}

@doc("Subscription workload type")
enum WorkloadType {
  @doc("None workload type")
  None,

  @doc("Development test workload type")
  DevTest,

  @doc("Production workload type")
  Production,
}

@doc("CostCategory for internal subscription")
enum CostCategory {
  @doc("None cost category")
  None,

  @doc("FR cost category")
  FR,

  @doc("FG cost category")
  FG,

  @doc("FS cost category")
  FS,

  @doc("FX cost category")
  FX,

  @doc("FB cost category")
  FB,
}

@doc("The Subscription policies")
model SubscriptionPolicies {
  @doc("The placement requirement for the subscription based on its country of origin / offer type / offer category / etc. This is used in geo-fencing of certain regions or regulatory boundaries (e.g. Australia ring-fencing).")
  locationPlacementId: string;

  @doc("The quota requirement for the subscription based on the offer type / category (e.g. free vs. pay-as-you-go). This can be used to inform quota information for the subscription (e.g. max # of resource groups or max # of virtual machines.")
  quotaId: string;

  @doc("Indicates whether subscription has spending limit.")
  spendingLimit: string;
}

@doc("The Internal Subscription policies")
model InternalSubscriptionPolicies {
  @doc("Cost categorizations used for internal subscriptions.")
  costCategory: CostCategory;

  @doc("Environment for the internal subscription.")
  environment: string;

  @doc("PCCode for the internal subscription.")
  pcCode: string;
}
