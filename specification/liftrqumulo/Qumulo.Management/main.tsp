import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-providerhub";

using TypeSpec.Versioning;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;

@armProviderNamespace
@service({
  title: "Qumulo.Storage",
})
@versioned(Versions)
namespace Qumulo.Storage;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Storage Sku")
enum StorageSku {
  @doc("Standard Storage Sku")
  Standard,

  @doc("Performance Storage Sku")
  Performance,
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "https://github.com/Azure/typespec-azure/issues/3107"
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2022_06_27_preview: "2022-06-27-preview",

  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2022_10_12_preview: "2022-10-12-preview",
}

@doc("Qumulo File System resource")
model FileSystemResource is TrackedResource<FileSystemResourceProperties> {
  @key("fileSystemName")
  @segment("fileSystems")
  @doc("Name of the storage resource")
  @path
  name: string;
  ...ManagedServiceIdentity;
}

@armResourceOperations
interface FileSystems
  extends TrackedResourceOperations<
      FileSystemResource,
      FileSystemResourceProperties
    > {}

@doc("Properties specific to the Qumulo File System resource")
model FileSystemResourceProperties {
  @doc("Azure Subscription Id")
  subscriptionId: string;

  @doc("Marketplace details")
  marketplaceDetails?: MarketplaceDetails;

  @doc("Provisioning State of the resource")
  provisioningState: ProvisioningState;

  @doc("User Details")
  userDetails: UserDetails;

  @doc("Company Details")
  companyDetails: CompanyDetails;

  @doc("Delegated subnet id for Vnet injection")
  delegatedSubnetId: string;

  @doc("Qumulo admin dashboard Url")
  clusterLoginUrl: string;

  @added(Versions.v2022_10_12_preview)
  newProp: string;

  @doc("List of eNIC IPs")
  privateIPs: string[];

  @added(Versions.v2022_10_12_preview)
  @doc("Initial administrator password of the resource")
  @secret
  adminPassword: string;

  @added(Versions.v2022_10_12_preview)
  @doc("Storage capacity in TB")
  initialCapacity: int32;

  @added(Versions.v2022_10_12_preview)
  @doc("Availability zone")
  availabilityZone: string;

  @added(Versions.v2022_10_12_preview)
  @doc("Storage Sku")
  storageSku: StorageSku;
}

@doc("MarketplaceDetails of Qumulo FileSystem resource")
model MarketplaceDetails {
  @doc("Marketplace Subscription Id")
  marketplaceSubscriptionId: string;

  @doc("Plan Id")
  planId: string;

  @doc("Offer Id")
  offerId: string;

  @doc("Publisher Id")
  publisherId: string;

  @doc("Marketplace subscription status")
  marketplaceSubscriptionStatus: MarketplaceSubscriptionStatus;
}

@doc("User Details of Qumulo FileSystem resource")
model UserDetails {
  @doc("First name")
  firstName?: string;

  @doc("Last name")
  lastName?: string;

  @doc("User Email")
  email: string;

  @doc("Alternate Email address")
  alternateEmail?: string;

  @doc("UPN of user")
  upn: string;

  @doc("Address of user")
  address?: string;

  @doc("Contact phone number")
  contactPhoneNumber?: string;
}

@doc("Company details of Qumulo FileSystem resource")
model CompanyDetails {
  @doc("Company name")
  companyName: string;

  @doc("Office Address")
  officeAddress?: string;

  @doc("Country of operation")
  country: string;

  @doc("Domain of the company")
  domain: string;

  @doc("Business of the company")
  business?: string;

  @doc("Number of Employees")
  numberOfEmployees: int32;
}

@doc("Marketplace subscription status of the storage resource")
enum MarketplaceSubscriptionStatus {
  PendingFulfillmentStart,
  Subscribed,
  Suspended,
  Unsubscribed,
}

@doc("Provisioning State of the storage resource")
enum ProvisioningState {
  Accepted,
  Creating,
  Updating,
  Deleting,
  Succeeded,
  Failed,
  Canceled,
  Deleted,
  NotSpecified,
}
