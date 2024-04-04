import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./namespace.tsp";
import "./taskHub.tsp";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ResourceManager;


#suppress "@azure-tools/typespec-azure-core/casing-style" "Can not change existing name."
@armProviderNamespace
@service({
	title: "Microsoft.DurableTask",
})
@versioned(Versions)
namespace Microsoft.DurableTask;

@doc("API Versions")
enum Versions {
	@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
	@useDependency(Azure.Core.Versions.v1_0_Preview_2)
	@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
	@doc("2024-02-01-preview")
	v2024_02_01_Preview: "2024-02-01-preview",
}