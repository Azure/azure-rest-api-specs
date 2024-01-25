import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Job.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
// FIXME: JobVersion has no properties property
/**
 * A job version.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Job)
@includeInapplicableMetadataInPayload(false)
model JobVersion extends ProxyResource {
  /**
   * The version of the job to get.
   */
  @path
  @key("jobVersion")
  @segment("versions")
  @visibility("read")
  name: int32;

  @extension("x-ms-client-flatten", true)
  @visibility("read,create")
  properties?: {};
}

@armResourceOperations
interface JobVersions {
  /**
   * Gets a job version.
   */
  get is ArmResourceRead<JobVersion>;

  /**
   * Gets all versions of a job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("JobVersions_ListByJob")
  listByJob is ArmResourceListByParent<JobVersion>;
}
