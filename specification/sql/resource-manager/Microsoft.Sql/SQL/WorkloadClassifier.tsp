import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./WorkloadGroup.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * Workload classifier operations for a data warehouse
 */
@parentResource(WorkloadGroup)
model WorkloadClassifier
  is Azure.ResourceManager.ProxyResource<WorkloadClassifierProperties> {
  ...ResourceNameParameter<
    Resource = WorkloadClassifier,
    KeyName = "workloadClassifierName",
    SegmentName = "workloadClassifiers",
    NamePattern = ""
  >;
}

@armResourceOperations
interface WorkloadClassifiers {
  /**
   * Gets a workload classifier
   */
  get is ArmResourceRead<WorkloadClassifier>;

  /**
   * Creates or updates a workload classifier.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    WorkloadClassifier,
    Response = ArmResourceUpdatedResponse<WorkloadClassifier> | ArmResourceCreatedResponse<
      WorkloadClassifier,
      ArmLroLocationHeader<FinalResult = WorkloadClassifier> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedLroResponse
  >;

  /**
   * Deletes a workload classifier.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    WorkloadClassifier,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets the list of workload classifiers for a workload group
   */
  listByWorkloadGroup is ArmResourceListByParent<WorkloadClassifier>;
}

@@doc(WorkloadClassifier.name, "The name of the workload classifier.");
@@doc(WorkloadClassifier.properties, "Resource properties.");
@@doc(WorkloadClassifiers.createOrUpdate::parameters.resource,
  "The properties of the workload classifier."
);
