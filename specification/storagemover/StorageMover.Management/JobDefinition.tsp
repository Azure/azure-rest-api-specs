import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Project.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.StorageMover;
/**
 * The Job Definition resource.
 */
@parentResource(Project)
model JobDefinition
  is Azure.ResourceManager.ProxyResource<JobDefinitionProperties, false> {
  ...ResourceNameParameter<
    Resource = JobDefinition,
    KeyName = "jobDefinitionName",
    SegmentName = "jobDefinitions",
    NamePattern = ""
  >;
}

@armResourceOperations
interface JobDefinitions {
  /**
   * Gets a Job Definition resource.
   */
  get is ArmResourceRead<JobDefinition>;

  /**
   * Creates or updates a Job Definition resource, which contains configuration for a single unit of managed data transfer.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    JobDefinition,
    Response = ArmResourceUpdatedResponse<JobDefinition>
  >;

  /**
   * Updates properties for a Job Definition resource. Properties not specified in the request body will be unchanged.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    JobDefinition,
    PatchModel = JobDefinitionUpdateParameters
  >;

  /**
   * Deletes a Job Definition resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    JobDefinition,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all Job Definitions in a Project.
   */
  list is ArmResourceListByParent<
    JobDefinition,
    Response = ArmResponse<JobDefinitionList>
  >;

  /**
   * Creates a new Job Run resource for the specified Job Definition and passes it to the Agent for execution.
   */
  startJob is ArmResourceActionSync<
    JobDefinition,
    void,
    ArmResponse<JobRunResourceId>
  >;

  /**
   * Requests the Agent of any active instance of this Job Definition to stop.
   */
  stopJob is ArmResourceActionSync<
    JobDefinition,
    void,
    ArmResponse<JobRunResourceId>
  >;
}

@@doc(JobDefinition.name, "The name of the Job Definition resource.");
@@doc(JobDefinition.properties, "Job definition properties.");
@@doc(JobDefinitions.createOrUpdate::parameters.resource, "");
@@doc(JobDefinitions.update::parameters.properties, "");
