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
/**
 * Definition of hybrid runbook worker.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(HybridRunbookWorkerGroup)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(
  HybridRunbookWorkerProperties
)
model HybridRunbookWorker extends ProxyResourceBase {
  /**
   * The hybrid runbook worker id
   */
  @path
  @key("hybridRunbookWorkerId")
  @segment("hybridRunbookWorkers")
  @visibility("read")
  name: string;

  /**
   * Gets or sets the hybrid worker group properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: HybridRunbookWorkerProperties;
}

@armResourceOperations
interface HybridRunbookWorkers {
  /**
   * Retrieve a hybrid runbook worker.
   */
  get is ArmResourceRead<HybridRunbookWorker>;

  /**
   * Create a hybrid runbook worker.
   */
  create is ArmResourceCreateOrReplaceSync<HybridRunbookWorker>;

  /**
   * Delete a hybrid runbook worker.
   */
  delete is ArmResourceDeleteSync<HybridRunbookWorker>;

  /**
   * Retrieve a list of hybrid runbook workers.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("HybridRunbookWorkers_ListByHybridRunbookWorkerGroup")
  listByHybridRunbookWorkerGroup is ArmResourceListByParent<
    HybridRunbookWorker,
    {
      ...BaseParameters<HybridRunbookWorker>;

      /**
       * The filter to apply on the operation.
       */
      @query("$filter")
      $filter?: string;
    }
  >;

  /**
   * Move a hybrid worker to a different group.
   */
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
