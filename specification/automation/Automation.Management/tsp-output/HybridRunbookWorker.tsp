import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./HybridRunbookWorkerGroup.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Automation;
@doc("Definition of hybrid runbook worker.")
@parentResource(HybridRunbookWorkerGroup)
model HybridRunbookWorker is ProxyResource<HybridRunbookWorkerProperties> {
  @doc("The hybrid runbook worker id")
  @path
  @key("hybridRunbookWorkerId")
  @segment("hybridRunbookWorkers")
  name: string;
}

@armResourceOperations
interface HybridRunbookWorkers {
  @doc("Retrieve a hybrid runbook worker.")
  get is ArmResourceRead<HybridRunbookWorker>;
  @doc("Create a hybrid runbook worker.")
  create is ArmResourceCreateOrReplaceSync<HybridRunbookWorker>;
  @doc("Delete a hybrid runbook worker.")
  delete is ArmResourceDeleteSync<HybridRunbookWorker>;
  @doc("Retrieve a list of hybrid runbook workers.")
  listByHybridRunbookWorkerGroup is ArmResourceListByParent<
    HybridRunbookWorker,
    {
      ...BaseParameters<HybridRunbookWorker>;

      @doc("The filter to apply on the operation.")
      @query("$filter")
      $filter?: string;
    }
  >;
  @doc("Move a hybrid worker to a different group.")
  move is ArmResourceActionSync<
    HybridRunbookWorker,
    HybridRunbookWorkerMoveParameters,
    void
  >;
}
