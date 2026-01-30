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
interface WorkflowVersionsOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Site name. */
        @path
        @segment("sites")
        @key
        name: string,

        /** undefined */
        @path
        @segment("hostruntime")
        @key
        runtime: "runtime",

        /** undefined */
        @path
        @segment("webhooks")
        @key
        workflow: "workflow",

        /** undefined */
        @path
        @segment("api")
        @key
        management: "management",

        /** The workflow name. */
        @path
        @segment("workflows")
        @key
        workflowName: string,
      },
      {
        /** The workflow versionId. */
        @path
        @segment("versions")
        @key
        versionId: string,
      }
    > {}

@armResourceOperations
interface WorkflowVersions {
  /**
   * Gets a workflow version.
   */
  get is WorkflowVersionsOps.Read<
    WorkflowVersion,
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Gets a list of workflow versions.
   */
  list is WorkflowVersionsOps.List<
    WorkflowVersion,
    Parameters = {
      /**
       * The number of items to be included in the result.
       */
      @query("$top")
      $top?: int32;
    },
    OverrideErrorType = ErrorResponse
  >;
}

@@doc(WorkflowVersion.name, "The workflow versionId.");
@@doc(WorkflowVersion.properties, "The workflow version properties.");
