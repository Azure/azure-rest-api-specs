import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./BestPractice.tsp";
import "./ConfigurationProfile.tsp";
import "./ConfigurationProfile.tsp";
import "./ConfigurationProfileAssignment.tsp";
import "./ConfigurationProfileAssignment.tsp";
import "./ConfigurationProfileAssignment.tsp";
import "./Report.tsp";
import "./Report.tsp";
import "./Report.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "AutomanageClient",
})
@versioned(Versions)
// FIXME: Common type version v2 is not supported for now.
// @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v2)
@doc("Automanage Client")
namespace Microsoft.Automanage;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @doc("The 2022-05-04 API version.")
  v2022_05_04: "2022-05-04",
}
