import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/versioning";

using Azure.ResourceManager;
using TypeSpec.Versioning;

@versioned(LiftrBase.Versions)
namespace LiftrBase;

@doc("Namespace version enum.")
enum Versions {
  @doc("Version 1 preview.")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v1_preview: "2023-06-01-preview"
}

@doc("Marketplace subscription status of a resource.")
enum MarketplaceSubscriptionStatus {

  @doc("PendingFulfillmentStart status.")
  PendingFulfillmentStart: "PendingFulfillmentStart",

  @doc("Subscribed status.")
  Subscribed: "Subscribed",

  @doc("Suspended status.")
  Suspended: "Suspended",

  @doc("Unsubscribed status.")
  Unsubscribed: "Unsubscribed"
}

@doc("Marketplace details of a resource.")
model MarketplaceDetails {

  @doc("Marketplace Subscription Id")
  subscriptionId: string;

  @doc("Offer details for the marketplace that is selected by the user")
  offerDetails: OfferDetails;
}

@doc("Offer details for the marketplace that is selected by the user")
model OfferDetails {
  @doc("Publisher Id for the marketplace offer")
  publisherId: string;

  @doc("Offer Id for the marketplace offer")
  offerId: string;

  @doc("Plan Id for the marketplace offer")
  planId: string;

  @doc("Plan Name for the marketplace offer")
  planName?: string;

  @doc("Plan Display Name for the marketplace offer")
  termUnit?: string;

  @doc("Plan Display Name for the marketplace offer")
  termId?: string;
}

@doc("Reusable representation of an email address.")
@pattern("^[A-Za-z0-9._%+-]+@(?:[A-Za-z0-9-]+\\.)+[A-Za-z]{2,}$")
scalar email extends string;

@doc("Details of the User.")
model UserDetails {
  @doc("User first name.")
  firstName: string;

  @doc("User last name.")
  lastName: string;

  @doc("User email address.")
  emailAddress: email;

  @doc("User's principal name")
  upn?: string;

  @doc("User's phone number")
  phoneNumber?: string;
}

@doc("Base resource properties that can be extended for arm resources.")
model BaseResourceProperties {

  @doc("Marketplace details of the resource.")
  @visibility("create", "read")
  marketplace: MarketplaceDetails;

  @doc("Details of the user.")
  user: UserDetails;

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ResourceProvisioningState;
}

@doc("IP/port pair.")
model Ip {

  @doc("IP address.")
  address: string;

  @doc("Port number.")
  @minValue(1)
  @maxValue(65535)
  port?: int32;
}