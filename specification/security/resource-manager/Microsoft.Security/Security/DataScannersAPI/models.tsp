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
 * Data scanner resource properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "The data scanner is an identity-only resource; its backend contract (ScannerResource) exposes no properties beyond the managed identity, so the properties bag is intentionally empty."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "The data scanner backend (ScannerResource) is identity-only and does not expose a provisioningState; its create, read, and delete operations are synchronous."
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
