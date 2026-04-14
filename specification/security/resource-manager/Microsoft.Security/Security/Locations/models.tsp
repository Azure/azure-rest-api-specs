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

namespace LocationsAPI;

/**
 * List of locations where ASC saves your data
 */
model AscLocationList {
  /** List of locations */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: AscLocation[];

  /** The URI to fetch the next page. */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}
