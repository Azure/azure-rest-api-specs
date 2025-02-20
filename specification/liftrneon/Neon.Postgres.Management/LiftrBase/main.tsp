import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/versioning";

using Azure.ResourceManager;
using TypeSpec.Versioning;

@versioned(LiftrBase.Versions)
namespace LiftrBase;

@doc("Supported versions for LiftrBase resource model")
enum Versions {
  @doc("Dependent on Azure.ResourceManager.Versions.v1_0_Preview_1")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v1_preview: "2024-08-01-preview",
}

@doc("Marketplace subscription status of a resource.")
union MarketplaceSubscriptionStatus {
  string,

  @doc("Purchased but not yet activated")
  PendingFulfillmentStart: "PendingFulfillmentStart",

  @doc("Marketplace subscription is activated")
  Subscribed: "Subscribed",

  @doc("This state indicates that a customer's payment for the Marketplace service was not received")
  Suspended: "Suspended",

  @doc("Customer has cancelled the subscription")
  Unsubscribed: "Unsubscribed",
}

@doc("A string that represents a URI.")
scalar Uri extends string;

@doc("Marketplace details for an organization")
model MarketplaceDetails {
  @doc("SaaS subscription id for the the marketplace offer")
  subscriptionId?: string;

  @doc("Marketplace subscription status")
  subscriptionStatus?: MarketplaceSubscriptionStatus;

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

  @doc("Term Name for the marketplace offer")
  termUnit?: string;

  @doc("Term Id for the marketplace offer")
  termId?: string;
}

@doc("Reusable representation of an email address.")
@pattern("^[A-Za-z0-9._%+-]+@(?:[A-Za-z0-9-]+\\.)+[A-Za-z]{2,}$")
scalar email extends string;

@doc("User details for an organization")
model UserDetails {
  @doc("First name of the user")
  firstName?: string;

  @doc("Last name of the user")
  lastName?: string;

  @doc("Email address of the user")
  emailAddress?: email;

  @doc("User's principal name")
  upn?: string;

  @doc("User's phone number")
  phoneNumber?: string;
}

@doc("Company details for an organization")
model CompanyDetails {
  @doc("Company name")
  companyName?: string;

  @doc("Country name of the company")
  country?: string;

  @doc("Office address of the company")
  officeAddress?: string;

  @doc("Business phone number of the company")
  businessPhone?: string;

  @doc("Domain of the user")
  domain?: string;

  @doc("Number of employees in the company")
  numberOfEmployees?: int64;
}

@doc("Base resource properties that can be extended for arm resources.")
model BaseResourceProperties {
  @doc("Marketplace details of the resource.")
  @visibility("create", "read")
  marketplaceDetails: MarketplaceDetails;

  @doc("Details of the user.")
  userDetails: UserDetails;

  @doc("Details of the company.")
  companyDetails: CompanyDetails;

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ResourceProvisioningState;
}

@doc("Properties specific to Single Sign On Resource")
model SingleSignOnProperties {
  @doc("State of the Single Sign On for the organization")
  singleSignOnState?: SingleSignOnStates;

  @doc("AAD enterprise application Id used to setup SSO")
  enterpriseAppId?: string;

  @doc("URL for SSO to be used by the partner to redirect the user to their system")
  singleSignOnUrl?: Uri;

  @doc("List of AAD domains fetched from Microsoft Graph for user.")
  aadDomains?: string[];
}

@doc("Various states of the SSO resource")
union SingleSignOnStates {
  string,

  @doc("Initial state of the SSO resource")
  Initial: "Initial",

  @doc("SSO is enabled for the organization")
  Enable: "Enable",

  @doc("SSO is disabled for the organization")
  Disable: "Disable",
}
