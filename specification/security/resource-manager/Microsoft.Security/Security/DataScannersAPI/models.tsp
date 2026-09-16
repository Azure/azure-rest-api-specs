import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../Common/main.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Common;

namespace DataScannersAPI;

/**
 * Data scanner resource properties. The data scanner is an identity-only resource defined solely by its assigned managed identity.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "The data scanner is an identity-only resource that exposes no properties beyond the managed service identity, so the properties bag is intentionally empty."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "The data scanner is an identity-only resource and does not expose a provisioningState; its create, read, and delete operations are synchronous."
model DataScannerProperties {}

/**
 * List of data scanner resources.
 */
model DataScannerList {
  /**
   * The list of data scanner resources.
   */
  @pageItems
  value: DataScanner[];

  /**
   * The URI to fetch the next page.
   */
  @nextLink
  nextLink?: url;
}
