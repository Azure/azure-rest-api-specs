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
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("List of promotions")
model PromotionsList {
  @doc("Promotions that are offered to the subscription")
  @Azure.ResourceManager.identifiers(#[])
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
union State {
  string,

  @doc("Registered subscription state")
  Registered: "Registered",

  @doc("Unregistered subscription state")
  Unregistered: "Unregistered",

  @doc("Warned subscription state")
  Warned: "Warned",

  @doc("Suspended subscription state")
  Suspended: "Suspended",

  @doc("Deleted subscription state")
  Deleted: "Deleted",
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
union BillingType {
  string,

  @doc("Legacy billing type")
  Legacy: "Legacy",

  @doc("Modern billing type")
  Modern: "Modern",
}

@doc("Subscription channel type")
union ChannelType {
  string,

  @doc("None channel type")
  None: "None",

  @doc("Internal channel type")
  Internal: "Internal",

  @doc("FieldLed channel type")
  FieldLed: "FieldLed",

  @doc("CustomerLed channel type")
  CustomerLed: "CustomerLed",

  @doc("Partnerled channel type")
  PartnerLed: "PartnerLed",
}

@doc("Subscription state payment type")
union PaymentType {
  string,

  @doc("None payment type")
  None: "None",

  @doc("Paid payment type")
  Paid: "Paid",

  @doc("Free payment type")
  Free: "Free",

  @doc("Entitlement payment type")
  Entitlement: "Entitlement",

  @doc("SponsoredPlus payment type")
  SponsoredPlus: "SponsoredPlus",

  @doc("Sponsored payment type")
  Sponsored: "Sponsored",

  @doc("Benefit payment type")
  Benefit: "Benefit",
}

@doc("Subscription tier")
union Tier {
  string,

  @doc("Unknown tier")
  Unknown: "Unknown",

  @doc("Standard tier")
  Standard: "Standard",

  @doc("Premium tier")
  Premium: "Premium",

  @doc("Priority tier")
  Priority: "Priority",
}

@doc("Subscription workload type")
union WorkloadType {
  string,

  @doc("None workload type")
  None: "None",

  @doc("Development test workload type")
  DevTest: "DevTest",

  @doc("Production workload type")
  Production: "Production",
}

@doc("CostCategory for internal subscription")
union CostCategory {
  string,

  @doc("None cost category")
  None: "None",

  @doc("FR cost category")
  FR: "FR",

  @doc("FG cost category")
  FG: "FG",

  @doc("FS cost category")
  FS: "FS",

  @doc("FX cost category")
  FX: "FX",

  @doc("FB cost category")
  FB: "FB",
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
