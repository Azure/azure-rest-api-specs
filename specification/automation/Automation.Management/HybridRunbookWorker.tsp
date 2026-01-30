import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./HybridRunbookWorkerGroup.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Automation;
/**
 * Definition of hybrid runbook worker.
 */
@parentResource(HybridRunbookWorkerGroup)
model HybridRunbookWorker
  is Azure.ResourceManager.TrackedResource<HybridRunbookWorkerProperties> {
  ...ResourceNameParameter<
    Resource = HybridRunbookWorker,
    KeyName = "hybridRunbookWorkerId",
    SegmentName = "hybridRunbookWorkers",
    NamePattern = ""
  >;
}

@armResourceOperations
interface HybridRunbookWorkers {
  /**
   * Retrieve a hybrid runbook worker.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/hybridrunbookworkeroperations")
  get is ArmResourceRead<HybridRunbookWorker>;

  /**
   * Create a hybrid runbook worker.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/hybridrunbookworkeroperations")
  create is Azure.ResourceManager.Legacy.CreateOrUpdateSync<
    HybridRunbookWorker,
    Request = HybridRunbookWorkerCreateParameters
  >;

  /**
   * Update a hybrid runbook worker.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/hybridrunbookworkeroperations")
  @patch(#{ implicitOptionality: false })
  patch is Azure.ResourceManager.Legacy.CustomPatchSync<
    HybridRunbookWorker,
    PatchModel = HybridRunbookWorkerCreateParameters,
    OptionalRequestBody = true
  >;

  /**
   * Delete a hybrid runbook worker.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/hybridrunbookworkeroperations")
  delete is ArmResourceDeleteSync<HybridRunbookWorker>;

  /**
   * Retrieve a list of hybrid runbook workers.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/hybridrunbookworkeroperations")
  listByHybridRunbookWorkerGroup is ArmResourceListByParent<
    HybridRunbookWorker,
    Parameters = {
      /**
       * The filter to apply on the operation.
       */
      @query("$filter")
      $filter?: string;
    },
    Response = ArmResponse<HybridRunbookWorkersListResult>
  >;

  /**
   * Move a hybrid worker to a different group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/hybridrunbookworkeroperations")
  move is ArmResourceActionSync<
    HybridRunbookWorker,
    HybridRunbookWorkerMoveParameters,
    OkResponse
  >;
}

@@doc(HybridRunbookWorker.name, "The hybrid runbook worker id");
@@doc(HybridRunbookWorker.properties,
  "Gets or sets the hybrid worker group properties."
);
@@doc(HybridRunbookWorkers.create::parameters.resource,
  "The create or update parameters for hybrid runbook worker."
);
@@doc(HybridRunbookWorkers.patch::parameters.properties,
  "The create or update parameters for hybrid runbook worker."
);
@@doc(HybridRunbookWorkers.move::parameters.body,
  "The hybrid runbook worker move parameters"
);
