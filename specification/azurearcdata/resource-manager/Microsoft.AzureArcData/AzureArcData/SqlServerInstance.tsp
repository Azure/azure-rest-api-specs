import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureArcData;
/**
 * A SqlServerInstance.
 */
model SqlServerInstance
  is Azure.ResourceManager.TrackedResource<SqlServerInstanceProperties> {
  ...ResourceNameParameter<
    Resource = SqlServerInstance,
    KeyName = "sqlServerInstanceName",
    SegmentName = "sqlServerInstances",
    NamePattern = ""
  >;
}

@armResourceOperations
interface SqlServerInstances {
  /**
   * Retrieves a SQL Server Instance resource
   */
  get is ArmResourceRead<SqlServerInstance>;

  /**
   * Creates or replaces a SQL Server Instance resource
   */
  create is ArmResourceCreateOrReplaceAsync<SqlServerInstance>;

  /**
   * Updates a SQL Server Instance resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    SqlServerInstance,
    PatchModel = SqlServerInstanceUpdate,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = SqlServerInstance> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes a SQL Server Instance resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    SqlServerInstance,
    Response =
      | ArmDeletedResponse
      | ArmDeleteAcceptedLroResponse
      | ArmDeletedNoContentResponse
  >;

  /**
   * Gets all sqlServerInstances in a resource group.
   */
  @summary("List sqlServerInstance resources in the resource group")
  listByResourceGroup is ArmResourceListByParent<
    SqlServerInstance,
    Response = ArmResponse<SqlServerInstanceListResult>
  >;

  /**
   * List sqlServerInstance resources in the subscription
   */
  @summary("List sqlServerInstance resources in the subscription")
  list is ArmListBySubscription<
    SqlServerInstance,
    Response = ArmResponse<SqlServerInstanceListResult>
  >;

  /**
   * Retrieves SQL Server instance telemetry
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("SqlServerInstances_getTelemetry")
  @list
  @Azure.Core.useFinalStateVia("azure-async-operation")
  getTelemetry is ArmResourceActionAsync<
    SqlServerInstance,
    SqlServerInstanceTelemetryRequest,
    ArmResponse<SqlServerInstanceTelemetryResponse>,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = SqlServerInstanceTelemetryResponse> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Retrieves SQL best practices assessment results for the SQL Server instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("SqlServerInstances_getBestPracticesAssessment")
  @list
  @Azure.Core.useFinalStateVia("azure-async-operation")
  getBestPracticesAssessment is ArmResourceActionAsync<
    SqlServerInstance,
    SqlServerInstanceBpaRequest,
    ArmResponse<SqlServerInstanceBpaResponse>,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = SqlServerInstanceBpaResponse> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Runs migration assessment for SQL Server instance
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("SqlServerInstances_runMigrationAssessment")
  runMigrationAssessment is ArmResourceActionSync<
    SqlServerInstance,
    void,
    ArmResponse<SqlServerInstanceRunMigrationAssessmentResponse>
  >;

  /**
   * Starts a target recommendation job for the SQL Server instance. Only one job can run at a time. If the previous job is in a non-terminal state (NotStarted or InProgress), calling this operation again returns the existing job status without creating a new job. A new job is created only when the previous job has reached a terminal state (Succeeded or Failed). This operation does not return recommendations directly. Use the GetTargetRecommendationReports API to check the job status and retrieve the target recommendation report if the jobStatus is Succeeded.
   */
  @Azure.Core.useFinalStateVia("azure-async-operation")
  runTargetRecommendationJob is ArmResourceActionAsync<
    SqlServerInstance,
    SqlServerInstanceRunTargetRecommendationJobRequest,
    ArmResponse<SqlServerInstanceRunTargetRecommendationJobResponse>,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = SqlServerInstanceRunTargetRecommendationJobResponse> &
      Azure.Core.Foundations.RetryAfterHeader,
    OptionalRequestBody = true
  >;

  /**
   * Retrieves the current job status and the latest target recommendation report for the SQL Server instance. The response always includes the jobStatus field, which indicates the state of the most recent target recommendation job (NotStarted, InProgress, Succeeded, or Failed). The report data is included in the response only when the jobStatus is Succeeded. A target recommendation job must be started using the RunTargetRecommendationJob API before calling this API. Only the most recent report is returned. If the report contains more sections than can be returned in a single response, use the nextReportOffset and nextSectionOffset values from the response to retrieve the remaining data.
   */
  @Azure.Core.useFinalStateVia("azure-async-operation")
  getTargetRecommendationReports is ArmResourceActionAsync<
    SqlServerInstance,
    SqlServerInstanceTargetRecommendationReportsRequest,
    ArmResponse<SqlServerInstanceTargetRecommendationReportsResponse>,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = SqlServerInstanceTargetRecommendationReportsResponse> &
      Azure.Core.Foundations.RetryAfterHeader,
    OptionalRequestBody = true
  >;

  /**
   * Retrieves the migration readiness report for the SQL Server instance. The report contains an assessment of the instance's readiness for migration to Azure SQL targets.
   */
  @Azure.Core.useFinalStateVia("azure-async-operation")
  getMigrationReadinessReport is ArmResourceActionAsync<
    SqlServerInstance,
    void,
    ArmResponse<SqlServerInstanceMigrationReadinessReportResponse>,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = SqlServerInstanceMigrationReadinessReportResponse> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * The request to run SQL best practices assessment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("SqlServerInstances_runBestPracticesAssessment")
  runBestPracticesAssessment is ArmResourceActionSync<
    SqlServerInstance,
    void,
    ArmResponse<SqlServerInstanceRunBestPracticesAssessmentResponse>
  >;

  /**
   * The request to run SQL best practices assessment asynchronously.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("SqlServerInstances_runBestPracticeAssessment")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  runBestPracticeAssessment is ArmResourceActionAsync<
    SqlServerInstance,
    void,
    ArmResponse<SqlServerInstanceRunBestPracticesAssessmentResponse>,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = SqlServerInstanceRunBestPracticesAssessmentResponse> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * The request to run migration readiness assessment asynchronously.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("SqlServerInstances_runMigrationReadinessAssessment")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  runMigrationReadinessAssessment is ArmResourceActionAsync<
    SqlServerInstance,
    void,
    ArmResponse<SqlServerInstanceRunMigrationReadinessAssessmentResponse>,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = SqlServerInstanceRunMigrationReadinessAssessmentResponse> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Gets jobs status details for sql arc resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("SqlServerInstances_getJobsStatus")
  getJobsStatus is ArmResourceActionSync<
    SqlServerInstance,
    SqlServerInstanceJobsStatusRequest,
    ArmResponse<SqlServerInstanceJobsStatusResponse>,
    OptionalRequestBody = true
  >;

  /**
   * Gets job details for sql arc resource asynchronously
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("SqlServerInstances_getJobs")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  getJobs is ArmResourceActionAsync<
    SqlServerInstance,
    SqlServerInstanceJobsRequest,
    ArmResponse<SqlServerInstanceJobsResponse>,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = SqlServerInstanceJobsResponse> &
      Azure.Core.Foundations.RetryAfterHeader,
    OptionalRequestBody = true
  >;

  /**
   * Request Upgrade Permission before upgrading.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("SqlServerInstances_preUpgrade")
  preUpgrade is ArmResourceActionSync<
    SqlServerInstance,
    void,
    ArmResponse<SqlServerInstance>
  >;

  /**
   * Clean up after upgrading.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("SqlServerInstances_postUpgrade")
  postUpgrade is ArmResourceActionSync<
    SqlServerInstance,
    void,
    ArmResponse<SqlServerInstance>
  >;

  /**
   * Runs Managed Instance Link assessment for SQL Server instance
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("SqlServerInstances_runManagedInstanceLinkAssessment")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  runManagedInstanceLinkAssessment is ArmResourceActionAsync<
    SqlServerInstance,
    SqlServerInstanceManagedInstanceLinkAssessmentRequest,
    ArmResponse<SqlServerInstanceManagedInstanceLinkAssessmentResponse>,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = SqlServerInstanceManagedInstanceLinkAssessmentResponse> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Retrieves full properties of all the Availability Groups in a SQL Server instance.
   */
  @list
  getAllAvailabilityGroups is ArmResourceActionSync<
    SqlServerInstance,
    AvailabilityGroupRetrievalFilters,
    ArmResponse<ArcSqlServerAvailabilityGroupListResult>,
    OptionalRequestBody = true
  >;

  /**
   * Create a SQL Server availability group
   */
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createAvailabilityGroup is ArmResourceActionAsync<
    SqlServerInstance,
    AvailabilityGroupCreateUpdateConfiguration,
    ArmResponse<SqlServerAvailabilityGroupResource>,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = SqlServerAvailabilityGroupResource> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Create a SQL Server distributed availability group
   */
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createDistributedAvailabilityGroup is ArmResourceActionAsync<
    SqlServerInstance,
    DistributedAvailabilityGroupCreateUpdateConfiguration,
    ArmResponse<SqlServerAvailabilityGroupResource>,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = SqlServerAvailabilityGroupResource> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Create an Managed Instance Link
   */
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createManagedInstanceLink is ArmResourceActionAsync<
    SqlServerInstance,
    ManagedInstanceLinkCreateUpdateConfiguration,
    ArmResponse<SqlServerAvailabilityGroupResource>,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = SqlServerAvailabilityGroupResource> &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}

@@doc(SqlServerInstance.name, "Name of SQL Server Instance");
@@doc(SqlServerInstance.properties, "null");
@@doc(
  SqlServerInstances.create::parameters.resource,
  "The SQL Server Instance to be created or updated."
);
@@doc(
  SqlServerInstances.update::parameters.properties,
  "The SQL Server Instance."
);
@@doc(
  SqlServerInstances.getTelemetry::parameters.body,
  "Contains the parameters to get SQL Server instance telemetry."
);
@@doc(
  SqlServerInstances.getBestPracticesAssessment::parameters.body,
  "The request to fetch the SQL best practices assessment results."
);
@@doc(
  SqlServerInstances.runTargetRecommendationJob::parameters.body,
  "Contains the parameters to run SQL Server instance target recommendation job."
);
@@doc(
  SqlServerInstances.getTargetRecommendationReports::parameters.body,
  "Contains the parameters to get SQL Server instance target recommendation reports."
);
@@doc(
  SqlServerInstances.getJobsStatus::parameters.body,
  "Contains the parameters to get SQL Server instance agent jobs status."
);
@@doc(
  SqlServerInstances.getJobs::parameters.body,
  "Contains the parameters to get SQL Server instance agent jobs status."
);
@@doc(
  SqlServerInstances.runManagedInstanceLinkAssessment::parameters.body,
  "Contains the parameters to run SQL Server instance MI link assessment."
);
@@doc(SqlServerInstances.getAllAvailabilityGroups::parameters.body, "");
@@doc(
  SqlServerInstances.createAvailabilityGroup::parameters.body,
  "The configuration for the new SQL Server availability group resource."
);
@@doc(
  SqlServerInstances.createDistributedAvailabilityGroup::parameters.body,
  "The configuration for the new SQL Server availability group resource."
);
@@doc(
  SqlServerInstances.createManagedInstanceLink::parameters.body,
  "The configuration for the new Managed Instance Link resource."
);
