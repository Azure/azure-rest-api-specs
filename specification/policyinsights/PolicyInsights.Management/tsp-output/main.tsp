import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./Remediation.tsp";
import "./PolicyMetadata.tsp";
import "./Attestation.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "PolicyInsightsClient",
})
// FIXME: Common type version v1 is not supported for now.
// @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v1)
@doc("// FIXME: (miissing-service-description) Add service description")
namespace Microsoft.PolicyInsights;
