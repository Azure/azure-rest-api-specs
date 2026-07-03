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
  nextLink?: string;
}
