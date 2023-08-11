import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;

@armProviderNamespace
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
@service({
  title: "Microsoft.RiskReputation",
  version: "2015-02-28-preview",
  preview: true,
})
namespace Microsoft.RiskReputation;

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations(PaymentTrustScore)
interface PaymentTrustScores {
  @doc("Get the Payment Trust Score for the subscription.")
  get is ArmResourceRead<PaymentTrustScore>;
  listBySubscription is ArmListBySubscription<PaymentTrustScore>;
}

@doc("The payment trust level of the subscription's billing account, delivered by the Risk Reputation System. This is a singleton - each active Azure Subscription has one score.")
@singleton
@subscriptionResource
model PaymentTrustScore is ProxyResource<PaymentTrustScoreProperties> {
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @doc("Score name. This is always \"default\" as each active subscription only has a singleton default score.")
  @key
  @segment("paymentTrustScores")
  @path
  @visibility("query")
  name: "default";
}

/** The rp-specific properties for a PaymentTrustScore */
model PaymentTrustScoreProperties {
  @doc("The billing account ID where the subscription asset is assigned. This is a Modern Commerce API Customer Root:Organization composite identifier. RRS scores are generated at the billing account level and all subscriptions under a billing account have the same score.")
  @pattern("^[a-zA-Z0-9_:-]{36,84}$")
  billingAccountId: string;

  @doc("Segment of the payment trust score. The score range is divided into ten segments where Highly_Untrusted_1 has the greatest probability of fraud and High_Trust_10 has the lowest.")
  scoreSegment: ScoreSegment;

  @doc("Timestamp when the payment trust score was calculated.")
  updatedTimestamp: utcDateTime;

  @doc("Segment of the payment trust score when it was previously calculated.")
  previousScoreSegment: ScoreSegment;

  @doc("Timestamp when the payment trust score was previously calculated.")
  previousUpdatedTimestamp: utcDateTime;

  @doc("Resource provisioning state. Will always be Succeeded for payment trust score.")
  provisioningState: ResourceProvisioningState;
}

@doc("Trust segment of a Risk Reputation System payment score applied to a Subscription's Billing account.")
enum ScoreSegment {
  @doc("Subscription's Billing account is highly untrusted. Segment 1 of 10.")
  HighlyUntrusted1: "Highly_Untrusted_1",

  @doc("Subscription's Billing account is highly untrusted. Segment 2 of 10.")
  HighlyUntrusted2: "Highly_Untrusted_2",

  @doc("Subscription's Billing account is untrusted. Segment 3 of 10.")
  Untrusted3: "Untrusted_3",

  @doc("Subscription's Billing account is untrusted. Segment 4 of 10.")
  Untrusted4: "Untrusted_4",

  @doc("Subscription's Billing account has low trust. Segment 5 of 10.")
  LowTrust5: "Low_Trust_5",

  @doc("Subscription's Billing account has low trust. Segment 6 of 10.")
  LowTrust6: "Low_Trust_6",

  @doc("Subscription's Billing account has medium trust. Segment 7 of 10.")
  MediumTrust7: "Medium_Trust_7",

  @doc("Subscription's Billing account has medium trust. Segment 8 of 10.")
  MediumTrust8: "Medium_Trust_8",

  @doc("Subscription's Billing account has high trust. Segment 9 of 10.")
  HighTrust9: "High_Trust_9",

  @doc("Subscription's Billing account has high trust. Segment 10 of 10.")
  HighTrust10: "High_Trust_10",
}
