import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AutomationAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Automation;
/**
 * Definition of the job.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(AutomationAccount)
@Azure.ResourceManager.Private.armResourceInternal(JobProperties)
@includeInapplicableMetadataInPayload(false)
model Job extends ProxyResourceBase {
  /**
   * The job name.
   */
  @path
  @key("jobName")
  @segment("jobs")
  name: string;

  /**
   * The properties of the job.
   */
  @extension("x-ms-client-flatten", true)
  properties?: JobProperties;
}

@armResourceOperations
interface Jobs {
  /**
   * Retrieve the job identified by job name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Job_Get")
  get is ArmResourceRead<
    Job,
    {
      ...BaseParameters<Job>;

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
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Job_Create")
  create is ArmResourceCreateOrReplaceSync<
    Job,
    {
      ...BaseParameters<Job>;

      /**
       * Identifies this specific client request.
       */
      @header
      clientRequestId?: string;
    }
  >;

  /**
   * Retrieve a list of jobs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Job_ListByAutomationAccount")
  listByAutomationAccount is ArmResourceListByParent<
    Job,
    {
      ...BaseParameters<Job>;

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

  /**
   * Suspend the job identified by job name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Job_Suspend")
  suspend is ArmResourceActionSync<
    Job,
    void,
    void,
    {
      ...BaseParameters<Job>;

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
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Job_Stop")
  stop is ArmResourceActionSync<
    Job,
    void,
    void,
    {
      ...BaseParameters<Job>;

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
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Job_Resume")
  resume is ArmResourceActionSync<
    Job,
    void,
    void,
    {
      ...BaseParameters<Job>;

      /**
       * Identifies this specific client request.
       */
      @header
      clientRequestId?: string;
    }
  >;

  /**
   * Retrieve the job output identified by job name.
   */
  // FIXME: Job_GetOutput could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Job_GetOutput")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/jobs/{jobName}/output")
  @get
  getOutput is Azure.Core.Foundations.Operation<
    {
      /**
       * Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * Name of an Azure Resource group.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      /**
       * The name of the automation account.
       */
      @path
      automationAccountName: string;

      /**
       * The name of the job to be created.
       */
      @path
      jobName: string;

      /**
       * Identifies this specific client request.
       */
      @header
      clientRequestId?: string;

      /**
       * Accept header
       */
      @header
      accept: "text/plain";
    },
    void
  >;

  /**
   * Retrieve the runbook content of the job identified by job name.
   */
  // FIXME: Job_GetRunbookContent could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Job_GetRunbookContent")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/jobs/{jobName}/runbookContent")
  @get
  getRunbookContent is Azure.Core.Foundations.Operation<
    {
      /**
       * Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * Name of an Azure Resource group.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      /**
       * The name of the automation account.
       */
      @path
      automationAccountName: string;

      /**
       * The job name.
       */
      @path
      jobName: string;

      /**
       * Identifies this specific client request.
       */
      @header
      clientRequestId?: string;

      /**
       * Accept header
       */
      @header
      accept: "text/powershell";
    },
    void
  >;

  /**
   * Retrieve the job stream identified by job stream id.
   */
  // FIXME: JobStream_Get could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("JobStream_Get")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/jobs/{jobName}/streams/{jobStreamId}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * Name of an Azure Resource group.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      /**
       * The name of the automation account.
       */
      @path
      automationAccountName: string;

      /**
       * The job name.
       */
      @path
      jobName: string;

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
    },
    JobStream
  >;

  /**
   * Retrieve a list of jobs streams identified by job name.
   */
  // FIXME: JobStream_ListByJob could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("JobStream_ListByJob")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/jobs/{jobName}/streams")
  @get
  listByJob is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of an Azure Resource group.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      /**
       * The name of the automation account.
       */
      @path
      automationAccountName: string;

      /**
       * The job name.
       */
      @path
      jobName: string;

      /**
       * The filter to apply on the operation.
       */
      @query("$filter")
      $filter?: string;

      /**
       * Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * Identifies this specific client request.
       */
      @header
      clientRequestId?: string;
    },
    JobStreamListResult
  >;
}

@@projectedName(Jobs.create::parameters.resource, "json", "parameters");
@@extension(Jobs.create::parameters.resource, "x-ms-client-name", "parameters");
@@doc(Jobs.create::parameters.resource,
  "The parameters supplied to the create job operation."
);
