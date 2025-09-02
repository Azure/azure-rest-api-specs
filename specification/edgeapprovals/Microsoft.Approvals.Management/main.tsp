import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common.tsp";
import "./ApprovalWorkflowDefinition.tsp";
import "./ApprovalWorkflowAssignment.tsp";
import "./ApprovalWorkflowInstance.tsp";
import "./ApprovalSetting.tsp";
import "./InvokeAndFetchApprovalRequest.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.Approvals")
@service(#{ title: "Microsoft.Approvals" })
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.Approvals;

enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  `2025-05-01-preview`,
}

interface Operations extends Azure.ResourceManager.Operations {}
