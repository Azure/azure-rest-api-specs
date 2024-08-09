import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";

using Azure.ResourceManager;
using TypeSpec.Versioning;
using TypeSpec.Reflection;

@versioned(LiftrBase.Versions)
namespace LiftrBase;

@doc("Supported versions for LiftrBase resource model")
enum Versions {
  @doc("Dependent on Azure.ResourceManager.Versions.v1_0_Preview_1")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v1_preview: "2023-06-01-preview",

  @doc("Dependent on Azure.ResourceManager.Versions.v1_0_Preview_1")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2_preview: "2024-06-01-preview",

  @doc("Dependent on Azure.ResourceManager.Versions.v1_0_Preview_1")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v3_preview: "2024-08-01-preview",
}

@doc("Marketplace subscription status of a resource.")
union MarketplaceSubscriptionStatus {
  /** Purchased but not yet activated */
  PendingFulfillmentStart: "PendingFulfillmentStart",

  /** Marketplace subscription is activated */
  Subscribed: "Subscribed",

  /** This state indicates that a customer's payment for the Marketplace service was not received */
  Suspended: "Suspended",

  /** Customer has cancelled the subscription */
  Unsubscribed: "Unsubscribed",

  string,
}

@doc("A string that represents a URI.")
scalar Uri extends string;

@doc("Marketplace details of a resource.")
model MarketplaceDetails {
  @doc("Marketplace Subscription Id.")
  @visibility("read")
  subscriptionId?: string;

  @doc("Marketplace subscription status")
  subscriptionStatus?: MarketplaceSubscriptionStatus;

  @doc("Offer details for the marketplace that is selected by the user")
  offerDetails: OfferDetails;
}

@added(Versions.v2_preview)
@doc("Marketplace plan details")
model MarketplacePlanUpdate {
  @doc("The plan id to change to.")
  planId: string;
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

  @doc("Term Unit for the marketplace offer")
  termUnit?: string;

  @doc("Term ID for the marketplace offer")
  termId?: string;
}

@doc("Reusable representation of an email address.")
@pattern("^[A-Za-z0-9._%+-]+@(?:[A-Za-z0-9-]+\\.)+[A-Za-z]{2,}$")
scalar email extends string;

@doc("Company details.")
model CompanyDetails {
  @doc("Company name.")
  companyName: string;

  @doc("Company address.")
  address?: Address;
}

@doc("Address details.")
model Address {
  @doc("Address line 1")
  addressLine1: string;

  @doc("Address line 2")
  addressLine2?: string;

  @doc("Name of the city")
  city: string;

  @doc("Name of the state")
  state: string;

  @doc("Name of the country")
  country: string;

  @doc("Postal code")
  postalCode: string;
}

@doc("User company details.")
model UserCompanyDetails {
  @doc("Company details of the user.")
  companyDetails?: CompanyDetails;
}

alias UserDetailsDefaultExtraProperties = UserCompanyDetails;

@doc("Details of the User.")
@friendlyName("UserDetails")
model UserDetails<TExtraProperties extends Model = UserDetailsDefaultExtraProperties> {
  @doc("First name of the user")
  firstName: string;

  @doc("Last name of the user")
  lastName: string;

  @doc("Email address of the user")
  emailAddress: email;

  @doc("User's principal name")
  upn?: string;

  @doc("User's phone number")
  phoneNumber?: string;

  ...TExtraProperties;
}

@doc("Base resource properties that can be extended for arm resources.")
model BaseResourceProperties<TUserDetailsExtraProperties extends Model = UserDetailsDefaultExtraProperties> {
  @doc("Marketplace details of the resource.")
  @visibility("create", "read")
  marketplace: MarketplaceDetails;

  @doc("Details of the user.")
  user: UserDetails<TUserDetailsExtraProperties>;

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
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

  @visibility("read")
  @doc("Provisioning State of the resource")
  provisioningState?: ProvisioningState;
}

@doc("Various states of the SSO resource")
union SingleSignOnStates {
  /** Initial state of the SSO resource */
  Initial: "Initial",

  /** State of the SSO resource when it is enabled */
  Enable: "Enable",

  /** State of the SSO resource when it is disabled */
  Disable: "Disable",

  string,
}

@doc("The status of the current operation.")
@Azure.Core.lroStatus
union ProvisioningState {
  ResourceProvisioningState,

  /** Deletion in progress */
  Deleting: "Deleting",

  /** Change accepted for processing */
  Accepted: "Accepted",

  string,
}
