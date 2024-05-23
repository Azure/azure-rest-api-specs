import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Autorest;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.AzureFleet;

@doc("ApiError for Fleet")
@useRef("../../../../../compute/resource-manager/Microsoft.Compute/common-types/v1/common.json#/definitions/ApiError")
model ApiError {}
