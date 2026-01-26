import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AutomationAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Automation;
/**
 * Definition of the job.
 */
@parentResource(AutomationAccount)
model Job is Azure.ResourceManager.ProxyResource<JobProperties> {
  ...ResourceNameParameter<
    Resource = Job,
    KeyName = "jobName",
    SegmentName = "jobs",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Jobs {
  /**
   * Retrieve the job identified by job name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Job_Get")
  get is ArmResourceRead<
    Job,
    Parameters = {
      /**
       * Identifies this specific client request.
       */
      @header
      clientRequestId?: string;
    }
  >;

  /**
   * Create a job of the runbook.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("Job_Create")
  create is Azure.ResourceManager.Legacy.CreateOrUpdateSync<
    Job,
    Request = JobCreateParameters,
    Parameters = {
      /**
       * Identifies this specific client request.
       */
      @header
      clientRequestId?: string;
    },
    Response = ArmResourceCreatedSyncResponse<Job>
  >;

  /**
   * Retrieve the job output identified by job name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Job_GetOutput")
  @get
  @action("output")
  getOutput is ArmResourceActionSync<
    Job,
    void,
    ArmResponse<stringTextPlain>,
    Parameters = {
      /**
       * Identifies this specific client request.
       */
      @header
      clientRequestId?: string;
    }
  >;

  /**
   * Retrieve the runbook content of the job identified by job name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Job_GetRunbookContent")
  @get
  @action("runbookContent")
  getRunbookContent is ArmResourceActionSync<
    Job,
    void,
    ArmResponse<stringTextPowershell>,
    Parameters = {
      /**
       * Identifies this specific client request.
       */
      @header
      clientRequestId?: string;
    }
  >;

  /**
   * Suspend the job identified by job name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Job_Suspend")
  suspend is ArmResourceActionSync<
    Job,
    void,
    OkResponse,
    Parameters = {
      /**
       * Identifies this specific client request.
       */
      @header
      clientRequestId?: string;
    }
  >;

  /**
   * Stop the job identified by jobName.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Job_Stop")
  stop is ArmResourceActionSync<
    Job,
    void,
    OkResponse,
    Parameters = {
      /**
       * Identifies this specific client request.
       */
      @header
      clientRequestId?: string;
    }
  >;

  /**
   * Resume the job identified by jobName.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Job_Resume")
  resume is ArmResourceActionSync<
    Job,
    void,
    OkResponse,
    Parameters = {
      /**
       * Identifies this specific client request.
       */
      @header
      clientRequestId?: string;
    }
  >;

  /**
   * Retrieve the job stream identified by job stream id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("JobStream_Get")
  @get
  @action("{jobStreamId}")
  jobStreamGet is ArmResourceActionSync<
    Job,
    void,
    ArmResponse<JobStream>,
    Parameters = {
      /**
       * The job stream id.
       */
      @path
      jobStreamId: string;

      /**
       * Identifies this specific client request.
       */
      @header
      clientRequestId?: string;
    }
  >;

  /**
   * Retrieve a list of jobs streams identified by job name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("JobStream_ListByJob")
  @list
  @get
  @action("streams")
  listByJob is ArmResourceActionSync<
    Job,
    void,
    ArmResponse<JobStreamListResult>,
    Parameters = {
      /**
       * The filter to apply on the operation.
       */
      @query("$filter")
      $filter?: string;

      /**
       * Identifies this specific client request.
       */
      @header
      clientRequestId?: string;
    }
  >;
}

@@doc(Job.name, "The job name.");
@@doc(Job.properties, "The properties of the job.");
@@doc(Jobs.create::parameters.resource,
  "The parameters supplied to the create job operation."
);
