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
 * A Cosmos DB Copy Job
 */
@parentResource(DatabaseAccountGetResults)
model CopyJobGetResults
  is Azure.ResourceManager.ProxyResource<CopyJobProperties, false> {
  ...ResourceNameParameter<
    Resource = CopyJobGetResults,
    KeyName = "jobName",
    SegmentName = "copyJobs",
    NamePattern = "^[a-zA-Z0-9]+(-[a-zA-Z0-9]+)*$"
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface CopyJobs {
  /**
   * Get a Copy Job.
   */
  get is ArmResourceRead<CopyJobGetResults, Error = CloudError>;

  /**
   * Creates a Copy Job.
   */
  create is ArmResourceCreateOrReplaceSync<
    CopyJobGetResults,
    Error = CloudError
  >;

  /**
   * Get a list of Copy jobs.
   */
  listByDatabaseAccount is ArmResourceListByParent<
    CopyJobGetResults,
    Response = ArmResponse<CopyJobFeedResults>,
    Error = CloudError
  >;

  /**
   * Pause a Copy Job.
   */
  pause is ArmResourceActionSync<
    CopyJobGetResults,
    void,
    ArmResponse<CopyJobGetResults>,
    Error = CloudError
  >;

  /**
   * Resumes a Copy Job.
   */
  resume is ArmResourceActionSync<
    CopyJobGetResults,
    void,
    ArmResponse<CopyJobGetResults>,
    Error = CloudError
  >;

  /**
   * Cancels a Copy Job.
   */
  cancel is ArmResourceActionSync<
    CopyJobGetResults,
    void,
    ArmResponse<CopyJobGetResults>,
    Error = CloudError
  >;

  /**
   * Completes an Online Copy Job.
   */
  complete is ArmResourceActionSync<
    CopyJobGetResults,
    void,
    ArmResponse<CopyJobGetResults>,
    Error = CloudError
  >;
}

@@doc(CopyJobGetResults.name, "Name of the Copy Job");
@@doc(CopyJobGetResults.properties, "The properties of a Copy Job");
@@doc(CopyJobs.create::parameters.resource, "");
