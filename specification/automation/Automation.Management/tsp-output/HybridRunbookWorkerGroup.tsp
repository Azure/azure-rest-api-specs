import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AutomationAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Automation;
@doc("Definition of hybrid runbook worker group.")
@parentResource(AutomationAccount)
model HybridRunbookWorkerGroup
  is ProxyResource<HybridRunbookWorkerGroupProperties> {
  @doc("The hybrid runbook worker group name")
  @path
  @key("hybridRunbookWorkerGroupName")
  @segment("hybridRunbookWorkerGroups")
  name: string;
}

@armResourceOperations
interface HybridRunbookWorkerGroup {
  @doc("Retrieve a hybrid runbook worker group.")
  get is ArmResourceRead<HybridRunbookWorkerGroup>;
  @doc("Create a hybrid runbook worker group.")
  create is ArmResourceCreateOrReplaceSync<HybridRunbookWorkerGroup>;
  @doc("Update a hybrid runbook worker group.")
  update is ArmResourcePatchSync<
    HybridRunbookWorkerGroup,
    HybridRunbookWorkerGroupProperties
  >;
  @doc("Delete a hybrid runbook worker group.")
  delete is ArmResourceDeleteSync<HybridRunbookWorkerGroup>;
  @doc("Retrieve a list of hybrid runbook worker groups.")
  listByAutomationAccount is ArmResourceListByParent<
    HybridRunbookWorkerGroup,
    {
      ...BaseParameters<HybridRunbookWorkerGroup>;

      @doc("The filter to apply on the operation.")
      @query("$filter")
      $filter?: string;
    }
  >;
}
