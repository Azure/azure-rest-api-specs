import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/versioning";
import "./versions.tsp";

using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.SaaSHub;

interface Operations extends Azure.ResourceManager.Operations {
  /**
   * Lists the available SaaSHub REST API operations.
   */
  @doc("Lists the available SaaSHub REST API operations.")
  list is Azure.ResourceManager.Operations.list;
}
