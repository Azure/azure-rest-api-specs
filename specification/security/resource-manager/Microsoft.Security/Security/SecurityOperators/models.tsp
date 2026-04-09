import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../Common/main.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Common;

namespace Microsoft.Security;

/**
 * List of SecurityOperator response.
 */
model SecurityOperatorList {
  /**
   * List of SecurityOperator configurations
   */
  @pageItems
  value: SecurityOperator[];
}
