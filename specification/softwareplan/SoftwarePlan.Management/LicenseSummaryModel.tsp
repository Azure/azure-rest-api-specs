import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.SoftwarePlan;

/** LicenseSummary resource - provides license summary information for a billing account */
model LicenseSummaryResource is ProxyResource<LicenseSummaryProperties> {
  /** Name of the license summary - always 'default' */
  @key("licenseSummaryName")
  @path
  @segment("licenseSummary")
  @pattern("default")
  name: string;
}

/** LicenseSummary properties */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "LicenseSummary is a proxy resource"
model LicenseSummaryProperties {
  /** Billing account identifier */
  @visibility(Lifecycle.Read)
  @pattern("^([0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}(:[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}_[0-9]{4}(-[0-9]{2}){2})?)$")
  billingAccountName?: string;

  /** Billing profile identifier */
  @visibility(Lifecycle.Read)
  @pattern("^[a-zA-Z\\d-_]{1,128}$")
  billingProfileName?: string;

  /** Name of the product */
  @visibility(Lifecycle.Read)
  productName?: string;

  /** Catalog product Id */
  @visibility(Lifecycle.Read)
  @pattern("\\b[BCDFGHJKLMNPQRSTVWXZbcdfghjklmnpqrstvwxz\\d]{12}\\b")
  productId?: string;

  /** Version of the product */
  @visibility(Lifecycle.Read)
  productVersion?: string;

  /** Number of licenses */
  @visibility(Lifecycle.Read)
  licenseQuantity?: int32;

  /** Number of active software assurance */
  @visibility(Lifecycle.Read)
  softwareAssuranceQuantity?: int32;

  /** Time when the license summary was last refreshed */
  @visibility(Lifecycle.Read)
  lastRefreshedAt?: utcDateTime;
}

/** The response of a LicenseSummary by Billing Account operation */
model LicenseSummaryResult {
  /** The LicenseSummary items on this page */
  value: LicenseSummaryResource[];

  /** The link to the next page of items */
  #suppress "@azure-tools/typespec-azure-core/no-format" "specify format for nextLink"
  @format("uri")
  nextLink?: string;
}
