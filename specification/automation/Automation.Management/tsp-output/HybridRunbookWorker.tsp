import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./HybridRunbookWorkerGroup.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Automation;
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

@@projectedName(HybridRunbookWorkers.create::parameters.resource,
  "json",
  "HybridRunbookWorkerCreationParameters"
);
@@extension(HybridRunbookWorkers.create::parameters.resource,
  "x-ms-client-name",
  "HybridRunbookWorkerCreationParameters"
);
@@doc(HybridRunbookWorkers.create::parameters.resource,
  "The create or update parameters for hybrid runbook worker."
);
@@projectedName(HybridRunbookWorkers.move::parameters.body,
  "json",
  "HybridRunbookWorkerMoveParameters"
);
@@extension(HybridRunbookWorkers.move::parameters.body,
  "x-ms-client-name",
  "HybridRunbookWorkerMoveParameters"
);
@@doc(HybridRunbookWorkers.move::parameters.body,
  "The hybrid runbook worker move parameters"
);
