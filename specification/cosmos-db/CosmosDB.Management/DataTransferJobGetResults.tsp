import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DatabaseAccountGetResults.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DocumentDB;
/**
 * A Cosmos DB Data Transfer Job
 */
@parentResource(DatabaseAccountGetResults)
model DataTransferJobGetResults
  is Azure.ResourceManager.ProxyResource<DataTransferJobProperties> {
  ...ResourceNameParameter<
    Resource = DataTransferJobGetResults,
    KeyName = "jobName",
    SegmentName = "dataTransferJobs",
    NamePattern = "^[a-zA-Z0-9]+(-[a-zA-Z0-9]+)*$"
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface DataTransferJobs {
  /**
   * Get a Data Transfer Job.
   */
  get is ArmResourceRead<DataTransferJobGetResults, Error = CloudError>;

  /**
   * Creates a Data Transfer Job.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  create is Azure.ResourceManager.Legacy.CreateOrUpdateSync<
    DataTransferJobGetResults,
    Request = CreateJobRequest,
    Response = ArmResourceUpdatedResponse<DataTransferJobGetResults>,
    Error = CloudError
  >;

  /**
   * Get a list of Data Transfer jobs.
   */
  listByDatabaseAccount is ArmResourceListByParent<
    DataTransferJobGetResults,
    Response = ArmResponse<DataTransferJobFeedResults>,
    Error = CloudError
  >;

  /**
   * Pause a Data Transfer Job.
   */
  pause is ArmResourceActionSync<
    DataTransferJobGetResults,
    void,
    ArmResponse<DataTransferJobGetResults>,
    Error = CloudError
  >;

  /**
   * Resumes a Data Transfer Job.
   */
  resume is ArmResourceActionSync<
    DataTransferJobGetResults,
    void,
    ArmResponse<DataTransferJobGetResults>,
    Error = CloudError
  >;

  /**
   * Cancels a Data Transfer Job.
   */
  cancel is ArmResourceActionSync<
    DataTransferJobGetResults,
    void,
    ArmResponse<DataTransferJobGetResults>,
    Error = CloudError
  >;

  /**
   * Completes a Data Transfer Online Job.
   */
  complete is ArmResourceActionSync<
    DataTransferJobGetResults,
    void,
    ArmResponse<DataTransferJobGetResults>,
    Error = CloudError
  >;
}

@@doc(DataTransferJobGetResults.name, "Name of the Data Transfer Job");
@@doc(DataTransferJobGetResults.properties,
  "The properties of a DataTransfer Job"
);
@@doc(DataTransferJobs.create::parameters.resource, "");
