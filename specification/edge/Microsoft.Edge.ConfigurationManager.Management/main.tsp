import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./DynamicSchema.tsp";
import "./DynamicSchemaVersion.tsp";
import "./Schema.tsp";
import "./SchemaVersion.tsp";
import "./SchemaReference.tsp";
import "./Solution.tsp";
import "./SolutionVersion.tsp";
import "./Target.tsp";
import "./SolutionTemplateVersion.tsp";
import "./SolutionTemplate.tsp";
import "./Instance.tsp";
import "./InstanceHistory.tsp";
import "./ConfigTemplate.tsp";
import "./ConfigTemplateVersion.tsp";
import "./Workflow.tsp";
import "./WorkflowVersion.tsp";
import "./Execution.tsp";
import "./Job.tsp";
import "./Diagnostics.tsp";
import "./Context.tsp";
import "./SiteReference.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

/** Microsoft.Edge Resource Provider management API. */
#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Operations API is published as part of same RP in edge folder."
@armProviderNamespace
@service(#{ title: "Microsoft.Edge" })
@versioned(Versions)
namespace Microsoft.Edge;

/** The available API versions. */
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2025_06_01: "2025-06-01",
}
