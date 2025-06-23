import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./main.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

/**
 * Examples for Operations
 */
@doc("Examples for Operations")
namespace Microsoft.DevTestLab.Examples;

// Example for Operations_List
@exampleFile("./examples/2018-09-15/Operations_List.json")
@get
op OperationsList(): {
  @statusCode statusCode: 200;
  @body body: Azure.ResourceManager.CommonTypes.Versions.v3.OperationListResult;
};
