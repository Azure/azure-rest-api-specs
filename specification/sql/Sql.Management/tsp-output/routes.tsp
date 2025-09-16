import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Sql;

interface JobStepExecutionsOperations {
  /**
   * Lists the step executions of a job execution.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/executions/{jobExecutionId}/steps")
  @get
  listByJobExecution is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the server.
       */
      @path
      serverName: string;

      /**
       * The name of the job agent.
       */
      @path
      jobAgentName: string;

      /**
       * The name of the job to get.
       */
      @path
      jobName: string;

      /**
       * The id of the job execution
       */
      @path
      jobExecutionId: string;

      /**
       * If specified, only job executions created at or after the specified time are included.
       */
      @query("createTimeMin")
      createTimeMin?: utcDateTime;

      /**
       * If specified, only job executions created before the specified time are included.
       */
      @query("createTimeMax")
      createTimeMax?: utcDateTime;

      /**
       * If specified, only job executions completed at or after the specified time are included.
       */
      @query("endTimeMin")
      endTimeMin?: utcDateTime;

      /**
       * If specified, only job executions completed before the specified time are included.
       */
      @query("endTimeMax")
      endTimeMax?: utcDateTime;

      /**
       * If specified, only active or only completed job executions are included.
       */
      @query("isActive")
      isActive?: boolean;

      /**
       * The number of elements in the collection to skip.
       */
      @query("$skip")
      $skip?: int32;

      /**
       * The number of elements to return from the collection.
       */
      @query("$top")
      $top?: int32;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<JobExecution>
  >;

  /**
   * Gets a step execution of a job execution.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/executions/{jobExecutionId}/steps/{stepName}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the server.
       */
      @path
      serverName: string;

      /**
       * The name of the job agent.
       */
      @path
      jobAgentName: string;

      /**
       * The name of the job to get.
       */
      @path
      jobName: string;

      /**
       * The unique id of the job execution
       */
      @path
      jobExecutionId: string;

      /**
       * The name of the step.
       */
      @path
      stepName: string;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    JobExecution
  >;
}

interface JobStepsOperations {
  /**
   * Gets all job steps for a job's current version.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/steps")
  @get
  listByJob is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the server.
       */
      @path
      serverName: string;

      /**
       * The name of the job agent.
       */
      @path
      jobAgentName: string;

      /**
       * The name of the job to get.
       */
      @path
      jobName: string;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<JobStep>
  >;

  /**
   * Gets a job step in a job's current version.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/steps/{stepName}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the server.
       */
      @path
      serverName: string;

      /**
       * The name of the job agent.
       */
      @path
      jobAgentName: string;

      /**
       * The name of the job.
       */
      @path
      jobName: string;

      /**
       * The name of the job step.
       */
      @path
      stepName: string;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    JobStep
  >;

  /**
   * Creates or updates a job step. This will implicitly create a new job version.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/steps/{stepName}")
  @put
  createOrUpdate is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the server.
       */
      @path
      serverName: string;

      /**
       * The name of the job agent.
       */
      @path
      jobAgentName: string;

      /**
       * The name of the job.
       */
      @path
      jobName: string;

      /**
       * The name of the job step.
       */
      @path
      stepName: string;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;

      /**
       * The requested state of the job step.
       */
      @body
      parameters: JobStep;
    },
    JobStep
  >;

  /**
   * Deletes a job step. This will implicitly create a new job version.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/steps/{stepName}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the server.
       */
      @path
      serverName: string;

      /**
       * The name of the job agent.
       */
      @path
      jobAgentName: string;

      /**
       * The name of the job.
       */
      @path
      jobName: string;

      /**
       * The name of the job step to delete.
       */
      @path
      stepName: string;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    void
  >;
}

interface JobTargetExecutionsOperations {
  /**
   * Lists target executions for all steps of a job execution.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/executions/{jobExecutionId}/targets")
  @get
  listByJobExecution is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the server.
       */
      @path
      serverName: string;

      /**
       * The name of the job agent.
       */
      @path
      jobAgentName: string;

      /**
       * The name of the job to get.
       */
      @path
      jobName: string;

      /**
       * The id of the job execution
       */
      @path
      jobExecutionId: string;

      /**
       * If specified, only job executions created at or after the specified time are included.
       */
      @query("createTimeMin")
      createTimeMin?: utcDateTime;

      /**
       * If specified, only job executions created before the specified time are included.
       */
      @query("createTimeMax")
      createTimeMax?: utcDateTime;

      /**
       * If specified, only job executions completed at or after the specified time are included.
       */
      @query("endTimeMin")
      endTimeMin?: utcDateTime;

      /**
       * If specified, only job executions completed before the specified time are included.
       */
      @query("endTimeMax")
      endTimeMax?: utcDateTime;

      /**
       * If specified, only active or only completed job executions are included.
       */
      @query("isActive")
      isActive?: boolean;

      /**
       * The number of elements in the collection to skip.
       */
      @query("$skip")
      $skip?: int32;

      /**
       * The number of elements to return from the collection.
       */
      @query("$top")
      $top?: int32;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<JobExecution>
  >;

  /**
   * Lists the target executions of a job step execution.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/executions/{jobExecutionId}/steps/{stepName}/targets")
  @get
  listByStep is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the server.
       */
      @path
      serverName: string;

      /**
       * The name of the job agent.
       */
      @path
      jobAgentName: string;

      /**
       * The name of the job to get.
       */
      @path
      jobName: string;

      /**
       * The id of the job execution
       */
      @path
      jobExecutionId: string;

      /**
       * The name of the step.
       */
      @path
      stepName: string;

      /**
       * If specified, only job executions created at or after the specified time are included.
       */
      @query("createTimeMin")
      createTimeMin?: utcDateTime;

      /**
       * If specified, only job executions created before the specified time are included.
       */
      @query("createTimeMax")
      createTimeMax?: utcDateTime;

      /**
       * If specified, only job executions completed at or after the specified time are included.
       */
      @query("endTimeMin")
      endTimeMin?: utcDateTime;

      /**
       * If specified, only job executions completed before the specified time are included.
       */
      @query("endTimeMax")
      endTimeMax?: utcDateTime;

      /**
       * If specified, only active or only completed job executions are included.
       */
      @query("isActive")
      isActive?: boolean;

      /**
       * The number of elements in the collection to skip.
       */
      @query("$skip")
      $skip?: int32;

      /**
       * The number of elements to return from the collection.
       */
      @query("$top")
      $top?: int32;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<JobExecution>
  >;

  /**
   * Gets a target execution.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/executions/{jobExecutionId}/steps/{stepName}/targets/{targetId}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the server.
       */
      @path
      serverName: string;

      /**
       * The name of the job agent.
       */
      @path
      jobAgentName: string;

      /**
       * The name of the job to get.
       */
      @path
      jobName: string;

      /**
       * The unique id of the job execution
       */
      @path
      jobExecutionId: string;

      /**
       * The name of the step.
       */
      @path
      stepName: string;

      /**
       * The target id.
       */
      @path
      targetId: string;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    JobExecution
  >;
}

interface CapabilitiesOperations {
  /**
   * Gets the subscription capabilities available for the specified location.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/capabilities")
  @get
  listByLocation is Azure.Core.Foundations.Operation<
    {
      /**
       * The location name whose capabilities are retrieved.
       */
      @path
      locationName: string;

      /**
       * If specified, restricts the response to only include the selected item.
       */
      @query("include")
      include?: CapabilityGroup;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    LocationCapabilities
  >;
}

interface ManagedDatabaseColumnsOperations {
  /**
   * List managed database columns
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns")
  @get
  listByTable is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the managed instance.
       */
      @path
      managedInstanceName: string;

      /**
       * The name of the database.
       */
      @path
      databaseName: string;

      /**
       * The name of the schema.
       */
      @path
      schemaName: string;

      /**
       * The name of the table.
       */
      @path
      tableName: string;

      /**
       * An OData filter expression that filters elements in the collection.
       */
      @query("$filter")
      $filter?: string;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<DatabaseColumn>
  >;

  /**
   * Get managed database column
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the managed instance.
       */
      @path
      managedInstanceName: string;

      /**
       * The name of the database.
       */
      @path
      databaseName: string;

      /**
       * The name of the schema.
       */
      @path
      schemaName: string;

      /**
       * The name of the table.
       */
      @path
      tableName: string;

      /**
       * The name of the column.
       */
      @path
      columnName: string;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    DatabaseColumn
  >;
}

interface ManagedDatabaseSchemasOperations {
  /**
   * List managed database schemas
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas")
  @get
  listByDatabase is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the managed instance.
       */
      @path
      managedInstanceName: string;

      /**
       * The name of the database.
       */
      @path
      databaseName: string;

      /**
       * An OData filter expression that filters elements in the collection.
       */
      @query("$filter")
      $filter?: string;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<DatabaseSchema>
  >;

  /**
   * Get managed database schema
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas/{schemaName}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the managed instance.
       */
      @path
      managedInstanceName: string;

      /**
       * The name of the database.
       */
      @path
      databaseName: string;

      /**
       * The name of the schema.
       */
      @path
      schemaName: string;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    DatabaseSchema
  >;
}

interface ManagedDatabaseTablesOperations {
  /**
   * List managed database tables
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas/{schemaName}/tables")
  @get
  listBySchema is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the managed instance.
       */
      @path
      managedInstanceName: string;

      /**
       * The name of the database.
       */
      @path
      databaseName: string;

      /**
       * The name of the schema.
       */
      @path
      schemaName: string;

      /**
       * An OData filter expression that filters elements in the collection.
       */
      @query("$filter")
      $filter?: string;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<DatabaseTable>
  >;

  /**
   * Get managed database table
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the managed instance.
       */
      @path
      managedInstanceName: string;

      /**
       * The name of the database.
       */
      @path
      databaseName: string;

      /**
       * The name of the schema.
       */
      @path
      schemaName: string;

      /**
       * The name of the table.
       */
      @path
      tableName: string;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    DatabaseTable
  >;
}

interface ManagedDatabaseVulnerabilityAssessmentRuleBaselinesOperations {
  /**
   * Gets a database's vulnerability assessment rule baseline.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/rules/{ruleId}/baselines/{baselineName}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the managed instance.
       */
      @path
      managedInstanceName: string;

      /**
       * The name of the database for which the vulnerability assessment rule baseline is defined.
       */
      @path
      databaseName: string;

      /**
       * The name of the vulnerability assessment.
       */
      @path
      vulnerabilityAssessmentName: VulnerabilityAssessmentName;

      /**
       * The vulnerability assessment rule ID.
       */
      @path
      ruleId: string;

      /**
       * The name of the vulnerability assessment rule baseline (default implies a baseline on a database level rule and master for server level rule).
       */
      @path
      baselineName: VulnerabilityAssessmentPolicyBaselineName;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    DatabaseVulnerabilityAssessmentRuleBaseline
  >;

  /**
   * Creates or updates a database's vulnerability assessment rule baseline.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/rules/{ruleId}/baselines/{baselineName}")
  @put
  createOrUpdate is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the managed instance.
       */
      @path
      managedInstanceName: string;

      /**
       * The name of the database for which the vulnerability assessment rule baseline is defined.
       */
      @path
      databaseName: string;

      /**
       * The name of the vulnerability assessment.
       */
      @path
      vulnerabilityAssessmentName: VulnerabilityAssessmentName;

      /**
       * The vulnerability assessment rule ID.
       */
      @path
      ruleId: string;

      /**
       * The name of the vulnerability assessment rule baseline (default implies a baseline on a database level rule and master for server level rule).
       */
      @path
      baselineName: VulnerabilityAssessmentPolicyBaselineName;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;

      /**
       * The requested rule baseline resource.
       */
      @body
      parameters: DatabaseVulnerabilityAssessmentRuleBaseline;
    },
    DatabaseVulnerabilityAssessmentRuleBaseline
  >;

  /**
   * Removes the database's vulnerability assessment rule baseline.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/rules/{ruleId}/baselines/{baselineName}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the managed instance.
       */
      @path
      managedInstanceName: string;

      /**
       * The name of the database for which the vulnerability assessment rule baseline is defined.
       */
      @path
      databaseName: string;

      /**
       * The name of the vulnerability assessment.
       */
      @path
      vulnerabilityAssessmentName: VulnerabilityAssessmentName;

      /**
       * The vulnerability assessment rule ID.
       */
      @path
      ruleId: string;

      /**
       * The name of the vulnerability assessment rule baseline (default implies a baseline on a database level rule and master for server level rule).
       */
      @path
      baselineName: VulnerabilityAssessmentPolicyBaselineName;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    void
  >;
}

interface ManagedDatabaseVulnerabilityAssessmentsOperations {
  /**
   * Gets the database's vulnerability assessment.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the managed instance.
       */
      @path
      managedInstanceName: string;

      /**
       * The name of the database for which the vulnerability assessment is defined.
       */
      @path
      databaseName: string;

      /**
       * The name of the vulnerability assessment.
       */
      @path
      vulnerabilityAssessmentName: VulnerabilityAssessmentName;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    DatabaseVulnerabilityAssessment
  >;

  /**
   * Creates or updates the database's vulnerability assessment.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}")
  @put
  createOrUpdate is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the managed instance.
       */
      @path
      managedInstanceName: string;

      /**
       * The name of the database for which the vulnerability assessment is defined.
       */
      @path
      databaseName: string;

      /**
       * The name of the vulnerability assessment.
       */
      @path
      vulnerabilityAssessmentName: VulnerabilityAssessmentName;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;

      /**
       * The requested resource.
       */
      @body
      parameters: DatabaseVulnerabilityAssessment;
    },
    DatabaseVulnerabilityAssessment
  >;

  /**
   * Removes the database's vulnerability assessment.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the managed instance.
       */
      @path
      managedInstanceName: string;

      /**
       * The name of the database for which the vulnerability assessment is defined.
       */
      @path
      databaseName: string;

      /**
       * The name of the vulnerability assessment.
       */
      @path
      vulnerabilityAssessmentName: VulnerabilityAssessmentName;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Lists the vulnerability assessments of a managed database.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments")
  @get
  listByDatabase is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the managed instance.
       */
      @path
      managedInstanceName: string;

      /**
       * The name of the database for which the vulnerability assessment is defined.
       */
      @path
      databaseName: string;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<DatabaseVulnerabilityAssessment>
  >;
}

interface ManagedDatabaseVulnerabilityAssessmentScansOperations {
  /**
   * Executes a Vulnerability Assessment database scan.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/scans/{scanId}/initiateScan")
  @post
  initiateScan is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the managed instance.
       */
      @path
      managedInstanceName: string;

      /**
       * The name of the database.
       */
      @path
      databaseName: string;

      /**
       * The name of the vulnerability assessment.
       */
      @path
      vulnerabilityAssessmentName: VulnerabilityAssessmentName;

      /**
       * The vulnerability assessment scan Id of the scan to retrieve.
       */
      @path
      scanId: string;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Convert an existing scan result to a human readable format. If already exists nothing happens
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/scans/{scanId}/export")
  @post
  export is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the managed instance.
       */
      @path
      managedInstanceName: string;

      /**
       * The name of the scanned database.
       */
      @path
      databaseName: string;

      /**
       * The name of the vulnerability assessment.
       */
      @path
      vulnerabilityAssessmentName: VulnerabilityAssessmentName;

      /**
       * The vulnerability assessment scan Id.
       */
      @path
      scanId: string;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    DatabaseVulnerabilityAssessmentScansExport
  >;

  /**
   * Lists the vulnerability assessment scans of a database.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/scans")
  @get
  listByDatabase is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the managed instance.
       */
      @path
      managedInstanceName: string;

      /**
       * The name of the database.
       */
      @path
      databaseName: string;

      /**
       * The name of the vulnerability assessment.
       */
      @path
      vulnerabilityAssessmentName: VulnerabilityAssessmentName;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<VulnerabilityAssessmentScanRecord>
  >;

  /**
   * Gets a vulnerability assessment scan record of a database.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/scans/{scanId}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the managed instance.
       */
      @path
      managedInstanceName: string;

      /**
       * The name of the database.
       */
      @path
      databaseName: string;

      /**
       * The name of the vulnerability assessment.
       */
      @path
      vulnerabilityAssessmentName: VulnerabilityAssessmentName;

      /**
       * The vulnerability assessment scan Id of the scan to retrieve.
       */
      @path
      scanId: string;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    VulnerabilityAssessmentScanRecord
  >;
}

interface ManagedRestorableDroppedDatabaseBackupShortTermRetentionPoliciesOperations {
  /**
   * Gets a dropped database's short term retention policy.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/restorableDroppedDatabases/{restorableDroppedDatabaseId}/backupShortTermRetentionPolicies/{policyName}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the managed instance.
       */
      @path
      managedInstanceName: string;

      @path
      restorableDroppedDatabaseId: string;

      /**
       * The policy name.
       */
      @path
      policyName: ManagedShortTermRetentionPolicyName;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    ManagedBackupShortTermRetentionPolicy
  >;

  /**
   * Sets a database's short term retention policy.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/restorableDroppedDatabases/{restorableDroppedDatabaseId}/backupShortTermRetentionPolicies/{policyName}")
  @put
  createOrUpdate is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the managed instance.
       */
      @path
      managedInstanceName: string;

      @path
      restorableDroppedDatabaseId: string;

      /**
       * The policy name. Should always be "default".
       */
      @path
      policyName: ManagedShortTermRetentionPolicyName;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;

      /**
       * The short term retention policy info.
       */
      @body
      parameters: ManagedBackupShortTermRetentionPolicy;
    },
    ManagedBackupShortTermRetentionPolicy | void
  >;

  /**
   * Sets a database's short term retention policy.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/restorableDroppedDatabases/{restorableDroppedDatabaseId}/backupShortTermRetentionPolicies/{policyName}")
  @patch
  update is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the managed instance.
       */
      @path
      managedInstanceName: string;

      @path
      restorableDroppedDatabaseId: string;

      /**
       * The policy name. Should always be "default".
       */
      @path
      policyName: ManagedShortTermRetentionPolicyName;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;

      /**
       * The short term retention policy info.
       */
      @body
      parameters: ManagedBackupShortTermRetentionPolicy;
    },
    ManagedBackupShortTermRetentionPolicy | void
  >;

  /**
   * Gets a dropped database's short term retention policy list.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/restorableDroppedDatabases/{restorableDroppedDatabaseId}/backupShortTermRetentionPolicies")
  @get
  listByRestorableDroppedDatabase is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the managed instance.
       */
      @path
      managedInstanceName: string;

      @path
      restorableDroppedDatabaseId: string;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<ManagedBackupShortTermRetentionPolicy>
  >;
}

interface ServerAdvisorsOperations {
  /**
   * Gets a list of server advisors.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/advisors")
  @get
  listByServer is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the server.
       */
      @path
      serverName: string;

      /**
       * The child resources to include in the response.
       */
      @query("$expand")
      $expand?: string;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Gets a server advisor.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/advisors/{advisorName}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the server.
       */
      @path
      serverName: string;

      /**
       * The name of the Server Advisor.
       */
      @path
      advisorName: string;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    Advisor
  >;

  /**
   * Updates a server advisor.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/advisors/{advisorName}")
  @patch
  update is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the server.
       */
      @path
      serverName: string;

      /**
       * The name of the Server Advisor.
       */
      @path
      advisorName: string;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;

      /**
       * The requested advisor resource state.
       */
      @body
      parameters: Advisor;
    },
    Advisor
  >;
}

interface LongTermRetentionBackupsOperations {
  /**
   * Lists the long term retention backups for a given location.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionBackups")
  @get
  listByLocation is Azure.Core.Foundations.Operation<
    {
      /**
       * The location of the database
       */
      @path
      locationName: string;

      /**
       * Whether or not to only get the latest backup for each database.
       */
      @query("onlyLatestPerDatabase")
      onlyLatestPerDatabase?: boolean;

      /**
       * Whether to query against just live databases, just deleted databases, or all databases.
       */
      @query("databaseState")
      databaseState?: DatabaseState;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<LongTermRetentionBackup>
  >;

  /**
   * Lists the long term retention backups for a given server.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionBackups")
  @get
  listByServer is Azure.Core.Foundations.Operation<
    {
      /**
       * The location of the database
       */
      @path
      locationName: string;

      /**
       * The name of the server
       */
      @path
      longTermRetentionServerName: string;

      /**
       * Whether or not to only get the latest backup for each database.
       */
      @query("onlyLatestPerDatabase")
      onlyLatestPerDatabase?: boolean;

      /**
       * Whether to query against just live databases, just deleted databases, or all databases.
       */
      @query("databaseState")
      databaseState?: DatabaseState;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<LongTermRetentionBackup>
  >;

  /**
   * Copy an existing long term retention backup to a different server.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/copy")
  @post
  copyByResourceGroup is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The location of the database.
       */
      @path
      locationName: string;

      /**
       * The name of the server
       */
      @path
      longTermRetentionServerName: string;

      /**
       * The name of the database
       */
      @path
      longTermRetentionDatabaseName: string;

      /**
       * The backup name.
       */
      @path
      backupName: string;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;

      /**
       * The parameters needed for long term retention copy request
       */
      @body
      parameters: CopyLongTermRetentionBackupParameters;
    },
    LongTermRetentionBackupOperationResult | void
  >;

  /**
   * Updates an existing long term retention backup.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/update")
  @post
  updateByResourceGroup is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The location of the database.
       */
      @path
      locationName: string;

      /**
       * The name of the server
       */
      @path
      longTermRetentionServerName: string;

      /**
       * The name of the database
       */
      @path
      longTermRetentionDatabaseName: string;

      /**
       * The backup name.
       */
      @path
      backupName: string;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;

      /**
       * The requested backup resource state
       */
      @body
      parameters: UpdateLongTermRetentionBackupParameters;
    },
    LongTermRetentionBackupOperationResult | void
  >;

  /**
   * Gets a long term retention backup.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}")
  @get
  getByResourceGroup is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The location of the database.
       */
      @path
      locationName: string;

      /**
       * The name of the server
       */
      @path
      longTermRetentionServerName: string;

      /**
       * The name of the database
       */
      @path
      longTermRetentionDatabaseName: string;

      /**
       * The backup name.
       */
      @path
      backupName: string;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    LongTermRetentionBackup
  >;

  /**
   * Deletes a long term retention backup.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}")
  @delete
  deleteByResourceGroup is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The location of the database
       */
      @path
      locationName: string;

      /**
       * The name of the server
       */
      @path
      longTermRetentionServerName: string;

      /**
       * The name of the database
       */
      @path
      longTermRetentionDatabaseName: string;

      /**
       * The backup name.
       */
      @path
      backupName: string;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Lists all long term retention backups for a database.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups")
  @get
  listByResourceGroupDatabase is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The location of the database
       */
      @path
      locationName: string;

      /**
       * The name of the server
       */
      @path
      longTermRetentionServerName: string;

      /**
       * The name of the database
       */
      @path
      longTermRetentionDatabaseName: string;

      /**
       * Whether or not to only get the latest backup for each database.
       */
      @query("onlyLatestPerDatabase")
      onlyLatestPerDatabase?: boolean;

      /**
       * Whether to query against just live databases, just deleted databases, or all databases.
       */
      @query("databaseState")
      databaseState?: DatabaseState;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<LongTermRetentionBackup>
  >;

  /**
   * Lists the long term retention backups for a given location.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionBackups")
  @get
  listByResourceGroupLocation is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The location of the database
       */
      @path
      locationName: string;

      /**
       * Whether or not to only get the latest backup for each database.
       */
      @query("onlyLatestPerDatabase")
      onlyLatestPerDatabase?: boolean;

      /**
       * Whether to query against just live databases, just deleted databases, or all databases.
       */
      @query("databaseState")
      databaseState?: DatabaseState;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<LongTermRetentionBackup>
  >;

  /**
   * Lists the long term retention backups for a given server.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionBackups")
  @get
  listByResourceGroupServer is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The location of the database
       */
      @path
      locationName: string;

      /**
       * The name of the server
       */
      @path
      longTermRetentionServerName: string;

      /**
       * Whether or not to only get the latest backup for each database.
       */
      @query("onlyLatestPerDatabase")
      onlyLatestPerDatabase?: boolean;

      /**
       * Whether to query against just live databases, just deleted databases, or all databases.
       */
      @query("databaseState")
      databaseState?: DatabaseState;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<LongTermRetentionBackup>
  >;
}

interface LongTermRetentionManagedInstanceBackupsOperations {
  /**
   * Lists the long term retention backups for a given managed instance.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionManagedInstances/{managedInstanceName}/longTermRetentionManagedInstanceBackups")
  @get
  listByInstance is Azure.Core.Foundations.Operation<
    {
      /**
       * The location of the database
       */
      @path
      locationName: string;

      /**
       * The name of the managed instance.
       */
      @path
      managedInstanceName: string;

      /**
       * Whether or not to only get the latest backup for each database.
       */
      @query("onlyLatestPerDatabase")
      onlyLatestPerDatabase?: boolean;

      /**
       * Whether to query against just live databases, just deleted databases, or all databases.
       */
      @query("databaseState")
      databaseState?: DatabaseState;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<ManagedInstanceLongTermRetentionBackup>
  >;

  /**
   * Lists the long term retention backups for managed databases in a given location.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionManagedInstanceBackups")
  @get
  listByLocation is Azure.Core.Foundations.Operation<
    {
      /**
       * The location of the database.
       */
      @path
      locationName: string;

      /**
       * Whether or not to only get the latest backup for each database.
       */
      @query("onlyLatestPerDatabase")
      onlyLatestPerDatabase?: boolean;

      /**
       * Whether to query against just live databases, just deleted databases, or all databases.
       */
      @query("databaseState")
      databaseState?: DatabaseState;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<ManagedInstanceLongTermRetentionBackup>
  >;

  /**
   * Gets a long term retention backup for a managed database.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionManagedInstances/{managedInstanceName}/longTermRetentionDatabases/{databaseName}/longTermRetentionManagedInstanceBackups/{backupName}")
  @get
  getByResourceGroup is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The location of the database.
       */
      @path
      locationName: string;

      /**
       * The name of the managed instance.
       */
      @path
      managedInstanceName: string;

      /**
       * The name of the managed database.
       */
      @path
      databaseName: string;

      /**
       * The backup name.
       */
      @path
      backupName: string;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    ManagedInstanceLongTermRetentionBackup
  >;

  /**
   * Deletes a long term retention backup.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionManagedInstances/{managedInstanceName}/longTermRetentionDatabases/{databaseName}/longTermRetentionManagedInstanceBackups/{backupName}")
  @delete
  deleteByResourceGroup is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The location of the database
       */
      @path
      locationName: string;

      /**
       * The name of the managed instance.
       */
      @path
      managedInstanceName: string;

      /**
       * The name of the managed database.
       */
      @path
      databaseName: string;

      /**
       * The backup name.
       */
      @path
      backupName: string;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Lists all long term retention backups for a managed database.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionManagedInstances/{managedInstanceName}/longTermRetentionDatabases/{databaseName}/longTermRetentionManagedInstanceBackups")
  @get
  listByResourceGroupDatabase is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The location of the database
       */
      @path
      locationName: string;

      /**
       * The name of the managed instance.
       */
      @path
      managedInstanceName: string;

      /**
       * The name of the managed database.
       */
      @path
      databaseName: string;

      /**
       * Whether or not to only get the latest backup for each database.
       */
      @query("onlyLatestPerDatabase")
      onlyLatestPerDatabase?: boolean;

      /**
       * Whether to query against just live databases, just deleted databases, or all databases.
       */
      @query("databaseState")
      databaseState?: DatabaseState;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<ManagedInstanceLongTermRetentionBackup>
  >;

  /**
   * Lists the long term retention backups for a given managed instance.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionManagedInstances/{managedInstanceName}/longTermRetentionManagedInstanceBackups")
  @get
  listByResourceGroupInstance is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The location of the database.
       */
      @path
      locationName: string;

      /**
       * The name of the managed instance.
       */
      @path
      managedInstanceName: string;

      /**
       * Whether or not to only get the latest backup for each database.
       */
      @query("onlyLatestPerDatabase")
      onlyLatestPerDatabase?: boolean;

      /**
       * Whether to query against just live databases, just deleted databases, or all databases.
       */
      @query("databaseState")
      databaseState?: DatabaseState;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<ManagedInstanceLongTermRetentionBackup>
  >;

  /**
   * Lists the long term retention backups for managed databases in a given location.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionManagedInstanceBackups")
  @get
  listByResourceGroupLocation is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The location of the database.
       */
      @path
      locationName: string;

      /**
       * Whether or not to only get the latest backup for each database.
       */
      @query("onlyLatestPerDatabase")
      onlyLatestPerDatabase?: boolean;

      /**
       * Whether to query against just live databases, just deleted databases, or all databases.
       */
      @query("databaseState")
      databaseState?: DatabaseState;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<ManagedInstanceLongTermRetentionBackup>
  >;
}

interface ManagedDatabaseSensitivityLabelsOperations {
  /**
   * Disables sensitivity recommendations on a given column
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}/sensitivityLabels/{sensitivityLabelSource}/disable")
  @post
  disableRecommendation is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the managed instance.
       */
      @path
      managedInstanceName: string;

      /**
       * The name of the database.
       */
      @path
      databaseName: string;

      /**
       * The name of the schema.
       */
      @path
      schemaName: string;

      /**
       * The name of the table.
       */
      @path
      tableName: string;

      /**
       * The name of the column.
       */
      @path
      columnName: string;

      @path
      sensitivityLabelSource: "recommended";

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Enables sensitivity recommendations on a given column (recommendations are enabled by default on all columns)
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}/sensitivityLabels/{sensitivityLabelSource}/enable")
  @post
  enableRecommendation is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the managed instance.
       */
      @path
      managedInstanceName: string;

      /**
       * The name of the database.
       */
      @path
      databaseName: string;

      /**
       * The name of the schema.
       */
      @path
      schemaName: string;

      /**
       * The name of the table.
       */
      @path
      tableName: string;

      /**
       * The name of the column.
       */
      @path
      columnName: string;

      @path
      sensitivityLabelSource: "recommended";

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    void
  >;
}

interface SensitivityLabelsOperations {
  /**
   * Gets the sensitivity label of a given column
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}/sensitivityLabels/{sensitivityLabelSource}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the server.
       */
      @path
      serverName: string;

      /**
       * The name of the database.
       */
      @path
      databaseName: string;

      /**
       * The name of the schema.
       */
      @path
      schemaName: string;

      /**
       * The name of the table.
       */
      @path
      tableName: string;

      /**
       * The name of the column.
       */
      @path
      columnName: string;

      /**
       * The source of the sensitivity label.
       */
      @path
      sensitivityLabelSource: SensitivityLabelSource;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    SensitivityLabel
  >;

  /**
   * Creates or updates the sensitivity label of a given column
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}/sensitivityLabels/{sensitivityLabelSource}")
  @put
  createOrUpdate is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the server.
       */
      @path
      serverName: string;

      /**
       * The name of the database.
       */
      @path
      databaseName: string;

      /**
       * The name of the schema.
       */
      @path
      schemaName: string;

      /**
       * The name of the table.
       */
      @path
      tableName: string;

      /**
       * The name of the column.
       */
      @path
      columnName: string;

      /**
       * The source of the sensitivity label.
       */
      @path
      sensitivityLabelSource: "current";

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;

      /**
       * The column sensitivity label resource.
       */
      @body
      parameters: SensitivityLabel;
    },
    SensitivityLabel
  >;

  /**
   * Deletes the sensitivity label of a given column
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}/sensitivityLabels/{sensitivityLabelSource}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the server.
       */
      @path
      serverName: string;

      /**
       * The name of the database.
       */
      @path
      databaseName: string;

      /**
       * The name of the schema.
       */
      @path
      schemaName: string;

      /**
       * The name of the table.
       */
      @path
      tableName: string;

      /**
       * The name of the column.
       */
      @path
      columnName: string;

      /**
       * The source of the sensitivity label.
       */
      @path
      sensitivityLabelSource: "current";

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    void
  >;
}

interface DatabaseSqlVulnerabilityAssessmentBaselinesOperations {
  /**
   * Gets a list of database's sql vulnerability assessment rule baselines.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines")
  @get
  listBySqlVulnerabilityAssessment is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the server.
       */
      @path
      serverName: string;

      /**
       * The name of the database.
       */
      @path
      databaseName: string;

      /**
       * The name of the vulnerability assessment.
       */
      @path
      vulnerabilityAssessmentName: VulnerabilityAssessmentName;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<DatabaseSqlVulnerabilityAssessmentBaselineSet>
  >;

  /**
   * Gets a list of database's sql vulnerability assessment rule baselines.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the server.
       */
      @path
      serverName: string;

      /**
       * The name of the database.
       */
      @path
      databaseName: string;

      /**
       * The name of the vulnerability assessment.
       */
      @path
      vulnerabilityAssessmentName: VulnerabilityAssessmentName;

      @path
      baselineName: BaselineName;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    DatabaseSqlVulnerabilityAssessmentBaselineSet
  >;

  /**
   * Add a database's vulnerability assessment rule baseline list.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}")
  @put
  createOrUpdate is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the server.
       */
      @path
      serverName: string;

      /**
       * The name of the database.
       */
      @path
      databaseName: string;

      /**
       * The name of the vulnerability assessment.
       */
      @path
      vulnerabilityAssessmentName: VulnerabilityAssessmentName;

      @path
      baselineName: BaselineName;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;

      /**
       * The requested rule baseline resource.
       */
      @body
      parameters: DatabaseSqlVulnerabilityAssessmentRuleBaselineListInput;
    },
    DatabaseSqlVulnerabilityAssessmentBaselineSet
  >;
}

interface DatabaseSqlVulnerabilityAssessmentExecuteScanOperations {
  /**
   * Executes a Vulnerability Assessment database scan.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/initiateScan")
  @post
  execute is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the server.
       */
      @path
      serverName: string;

      /**
       * The name of the database.
       */
      @path
      databaseName: string;

      /**
       * The name of the vulnerability assessment.
       */
      @path
      vulnerabilityAssessmentName: VulnerabilityAssessmentName;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    void
  >;
}

interface DatabaseSqlVulnerabilityAssessmentRuleBaselinesOperations {
  /**
   * Gets a list of database's sql vulnerability assessment rule baselines.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}/rules")
  @get
  listByBaseline is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the server.
       */
      @path
      serverName: string;

      /**
       * The name of the database.
       */
      @path
      databaseName: string;

      /**
       * The name of the vulnerability assessment.
       */
      @path
      vulnerabilityAssessmentName: VulnerabilityAssessmentName;

      @path
      baselineName: BaselineName;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<DatabaseSqlVulnerabilityAssessmentRuleBaseline>
  >;

  /**
   * Gets a database's sql vulnerability assessment rule baseline.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}/rules/{ruleId}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the server.
       */
      @path
      serverName: string;

      /**
       * The name of the database.
       */
      @path
      databaseName: string;

      /**
       * The name of the vulnerability assessment.
       */
      @path
      vulnerabilityAssessmentName: VulnerabilityAssessmentName;

      @path
      baselineName: BaselineName;

      /**
       * The vulnerability assessment rule ID.
       */
      @path
      ruleId: string;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    DatabaseSqlVulnerabilityAssessmentRuleBaseline
  >;

  /**
   * Creates or updates a database's vulnerability assessment rule baseline.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}/rules/{ruleId}")
  @put
  createOrUpdate is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the server.
       */
      @path
      serverName: string;

      /**
       * The name of the database.
       */
      @path
      databaseName: string;

      /**
       * The name of the vulnerability assessment.
       */
      @path
      vulnerabilityAssessmentName: VulnerabilityAssessmentName;

      @path
      baselineName: BaselineName;

      /**
       * The vulnerability assessment rule ID.
       */
      @path
      ruleId: string;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;

      /**
       * The requested rule baseline resource.
       */
      @body
      parameters: DatabaseSqlVulnerabilityAssessmentRuleBaselineInput;
    },
    DatabaseSqlVulnerabilityAssessmentRuleBaseline
  >;

  /**
   * Removes the database's vulnerability assessment rule baseline.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}/rules/{ruleId}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the server.
       */
      @path
      serverName: string;

      /**
       * The name of the database.
       */
      @path
      databaseName: string;

      /**
       * The name of the vulnerability assessment.
       */
      @path
      vulnerabilityAssessmentName: VulnerabilityAssessmentName;

      @path
      baselineName: BaselineName;

      /**
       * The vulnerability assessment rule ID.
       */
      @path
      ruleId: string;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    void
  >;
}

interface DatabaseSqlVulnerabilityAssessmentScanResultOperations {
  /**
   * Gets a vulnerability assessment scan record of a database.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/scans/{scanId}/scanResults")
  @get
  listByScan is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the server.
       */
      @path
      serverName: string;

      /**
       * The name of the database.
       */
      @path
      databaseName: string;

      /**
       * The name of the SQL Vulnerability Assessment.
       */
      @path
      vulnerabilityAssessmentName: VulnerabilityAssessmentName;

      /**
       * The scan id of the SQL Vulnerability Assessment scan to retrieve result from.
       */
      @path
      scanId: string;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<SqlVulnerabilityAssessmentScanResults>
  >;

  /**
   * Gets a vulnerability assessment scan record of a database.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/scans/{scanId}/scanResults/{scanResultId}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the server.
       */
      @path
      serverName: string;

      /**
       * The name of the database.
       */
      @path
      databaseName: string;

      /**
       * The name of the SQL Vulnerability Assessment.
       */
      @path
      vulnerabilityAssessmentName: VulnerabilityAssessmentName;

      /**
       * The scan id of the SQL Vulnerability Assessment scan to retrieve result from.
       */
      @path
      scanId: string;

      /**
       * The scan result id of the specific result to retrieve.
       */
      @path
      scanResultId: string;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    SqlVulnerabilityAssessmentScanResults
  >;
}

interface DatabaseSqlVulnerabilityAssessmentScansOperations {
  /**
   * Lists the vulnerability assessment scans of a database.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/scans")
  @get
  listBySqlVulnerabilityAssessments is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the server.
       */
      @path
      serverName: string;

      /**
       * The name of the database.
       */
      @path
      databaseName: string;

      /**
       * The name of the vulnerability assessment.
       */
      @path
      vulnerabilityAssessmentName: VulnerabilityAssessmentName;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<SqlVulnerabilityAssessmentScanRecord>
  >;

  /**
   * Get a database vulnerability assessment scan result.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/scans/{scanId}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the server.
       */
      @path
      serverName: string;

      /**
       * The name of the database.
       */
      @path
      databaseName: string;

      /**
       * The name of the vulnerability assessment.
       */
      @path
      vulnerabilityAssessmentName: VulnerabilityAssessmentName;

      /**
       * The vulnerability assessment scan Id of the scan to retrieve.
       */
      @path
      scanId: string;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    SqlVulnerabilityAssessmentScanRecord
  >;
}

interface DatabaseSqlVulnerabilityAssessmentsSettingsOperations {
  /**
   * Lists SQL Vulnerability Assessment policies associated with a database.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments")
  @get
  listByDatabase is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the server.
       */
      @path
      serverName: string;

      /**
       * The name of the database.
       */
      @path
      databaseName: string;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<SqlVulnerabilityAssessment>
  >;

  /**
   * Gets SQL Vulnerability Assessment policy for database.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the server.
       */
      @path
      serverName: string;

      /**
       * The name of the database.
       */
      @path
      databaseName: string;

      /**
       * The name of the SQL Vulnerability Assessment.
       */
      @path
      vulnerabilityAssessmentName: VulnerabilityAssessmentName;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    SqlVulnerabilityAssessment
  >;
}
