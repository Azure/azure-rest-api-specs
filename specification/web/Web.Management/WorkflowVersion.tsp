import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Web;
/**
 * The workflow version.
 */
@parentResource(Site)
model WorkflowVersion
  is Azure.ResourceManager.TrackedResource<WorkflowVersionProperties> {
  ...ResourceNameParameter<
    Resource = WorkflowVersion,
    KeyName = "versionId",
    SegmentName = "versions",
    NamePattern = ""
  >;
}

@armResourceOperations
interface WorkflowVersions {
  /**
   * Gets a workflow version.
   */
  get is ArmResourceRead<WorkflowVersion>;

  /**
   * Gets a list of workflow versions.
   */
  list is ArmResourceListByParent<
    WorkflowVersion,
    Parameters = {
      /**
       * The number of items to be included in the result.
       */
      @query("$top")
      $top?: int32;
    }
  >;
}

@@doc(WorkflowVersion.name, "The workflow versionId.");
@@doc(WorkflowVersion.properties, "The workflow version properties.");
