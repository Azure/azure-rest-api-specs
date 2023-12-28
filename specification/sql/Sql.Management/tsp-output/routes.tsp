import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Azure.ResourceManager.Sql;

interface JobStepExecutionsOperations {
  @doc("Lists the step executions of a job execution.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/executions/{jobExecutionId}/steps")
  @get
  ListByJobExecution is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the server.")
      @path
      serverName: string;

      @doc("The name of the job agent.")
      @path
      jobAgentName: string;

      @doc("The name of the job to get.")
      @path
      jobName: string;

      @doc("The id of the job execution")
      @path
      jobExecutionId: string;

      @doc("If specified, only job executions created at or after the specified time are included.")
      @query("createTimeMin")
      createTimeMin?: utcDateTime;

      @doc("If specified, only job executions created before the specified time are included.")
      @query("createTimeMax")
      createTimeMax?: utcDateTime;

      @doc("If specified, only job executions completed at or after the specified time are included.")
      @query("endTimeMin")
      endTimeMin?: utcDateTime;

      @doc("If specified, only job executions completed before the specified time are included.")
      @query("endTimeMax")
      endTimeMax?: utcDateTime;

      @doc("If specified, only active or only completed job executions are included.")
      @query("isActive")
      isActive?: boolean;

      @doc("The number of elements in the collection to skip.")
      @query("$skip")
      $skip?: int32;

      @doc("The number of elements to return from the collection.")
      @query("$top")
      $top?: int32;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    ResourceListResult<JobExecution>
  >;

  @doc("Gets a step execution of a job execution.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/executions/{jobExecutionId}/steps/{stepName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the server.")
      @path
      serverName: string;

      @doc("The name of the job agent.")
      @path
      jobAgentName: string;

      @doc("The name of the job to get.")
      @path
      jobName: string;

      @doc("The unique id of the job execution")
      @path
      jobExecutionId: string;

      @doc("The name of the step.")
      @path
      stepName: string;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    JobExecution
  >;
}

interface JobStepsOperations {
  @doc("Gets all job steps for a job's current version.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/steps")
  @get
  ListByJob is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the server.")
      @path
      serverName: string;

      @doc("The name of the job agent.")
      @path
      jobAgentName: string;

      @doc("The name of the job to get.")
      @path
      jobName: string;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    ResourceListResult<JobStep>
  >;

  @doc("Gets a job step in a job's current version.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/steps/{stepName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the server.")
      @path
      serverName: string;

      @doc("The name of the job agent.")
      @path
      jobAgentName: string;

      @doc("The name of the job.")
      @path
      jobName: string;

      @doc("The name of the job step.")
      @path
      stepName: string;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    JobStep
  >;

  @doc("Creates or updates a job step. This will implicitly create a new job version.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/steps/{stepName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the server.")
      @path
      serverName: string;

      @doc("The name of the job agent.")
      @path
      jobAgentName: string;

      @doc("The name of the job.")
      @path
      jobName: string;

      @doc("The name of the job step.")
      @path
      stepName: string;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;

      @doc("The requested state of the job step.")
      @body
      parameters: JobStep;
    },
    JobStep
  >;

  @doc("Deletes a job step. This will implicitly create a new job version.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/steps/{stepName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the server.")
      @path
      serverName: string;

      @doc("The name of the job agent.")
      @path
      jobAgentName: string;

      @doc("The name of the job.")
      @path
      jobName: string;

      @doc("The name of the job step to delete.")
      @path
      stepName: string;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    void
  >;
}

interface JobTargetExecutionsOperations {
  @doc("Lists target executions for all steps of a job execution.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/executions/{jobExecutionId}/targets")
  @get
  ListByJobExecution is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the server.")
      @path
      serverName: string;

      @doc("The name of the job agent.")
      @path
      jobAgentName: string;

      @doc("The name of the job to get.")
      @path
      jobName: string;

      @doc("The id of the job execution")
      @path
      jobExecutionId: string;

      @doc("If specified, only job executions created at or after the specified time are included.")
      @query("createTimeMin")
      createTimeMin?: utcDateTime;

      @doc("If specified, only job executions created before the specified time are included.")
      @query("createTimeMax")
      createTimeMax?: utcDateTime;

      @doc("If specified, only job executions completed at or after the specified time are included.")
      @query("endTimeMin")
      endTimeMin?: utcDateTime;

      @doc("If specified, only job executions completed before the specified time are included.")
      @query("endTimeMax")
      endTimeMax?: utcDateTime;

      @doc("If specified, only active or only completed job executions are included.")
      @query("isActive")
      isActive?: boolean;

      @doc("The number of elements in the collection to skip.")
      @query("$skip")
      $skip?: int32;

      @doc("The number of elements to return from the collection.")
      @query("$top")
      $top?: int32;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    ResourceListResult<JobExecution>
  >;

  @doc("Lists the target executions of a job step execution.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/executions/{jobExecutionId}/steps/{stepName}/targets")
  @get
  ListByStep is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the server.")
      @path
      serverName: string;

      @doc("The name of the job agent.")
      @path
      jobAgentName: string;

      @doc("The name of the job to get.")
      @path
      jobName: string;

      @doc("The id of the job execution")
      @path
      jobExecutionId: string;

      @doc("The name of the step.")
      @path
      stepName: string;

      @doc("If specified, only job executions created at or after the specified time are included.")
      @query("createTimeMin")
      createTimeMin?: utcDateTime;

      @doc("If specified, only job executions created before the specified time are included.")
      @query("createTimeMax")
      createTimeMax?: utcDateTime;

      @doc("If specified, only job executions completed at or after the specified time are included.")
      @query("endTimeMin")
      endTimeMin?: utcDateTime;

      @doc("If specified, only job executions completed before the specified time are included.")
      @query("endTimeMax")
      endTimeMax?: utcDateTime;

      @doc("If specified, only active or only completed job executions are included.")
      @query("isActive")
      isActive?: boolean;

      @doc("The number of elements in the collection to skip.")
      @query("$skip")
      $skip?: int32;

      @doc("The number of elements to return from the collection.")
      @query("$top")
      $top?: int32;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    ResourceListResult<JobExecution>
  >;

  @doc("Gets a target execution.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/executions/{jobExecutionId}/steps/{stepName}/targets/{targetId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the server.")
      @path
      serverName: string;

      @doc("The name of the job agent.")
      @path
      jobAgentName: string;

      @doc("The name of the job to get.")
      @path
      jobName: string;

      @doc("The unique id of the job execution")
      @path
      jobExecutionId: string;

      @doc("The name of the step.")
      @path
      stepName: string;

      @doc("The target id.")
      @path
      targetId: string;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    JobExecution
  >;
}

interface CapabilitiesOperations {
  @doc("Gets the subscription capabilities available for the specified location.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/capabilities")
  @get
  ListByLocation is Azure.Core.Foundations.Operation<
    {
      @doc("The location name whose capabilities are retrieved.")
      @path
      locationName: string;

      @doc("If specified, restricts the response to only include the selected item.")
      @query("include")
      include?: CapabilityGroup;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    LocationCapabilities
  >;
}

interface ManagedDatabaseColumnsOperations {
  @doc("List managed database columns")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns")
  @get
  ListByTable is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the managed instance.")
      @path
      managedInstanceName: string;

      @doc("The name of the database.")
      @path
      databaseName: string;

      @doc("The name of the schema.")
      @path
      schemaName: string;

      @doc("The name of the table.")
      @path
      tableName: string;

      @doc("An OData filter expression that filters elements in the collection.")
      @query("$filter")
      $filter?: string;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    ResourceListResult<DatabaseColumn>
  >;

  @doc("Get managed database column")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the managed instance.")
      @path
      managedInstanceName: string;

      @doc("The name of the database.")
      @path
      databaseName: string;

      @doc("The name of the schema.")
      @path
      schemaName: string;

      @doc("The name of the table.")
      @path
      tableName: string;

      @doc("The name of the column.")
      @path
      columnName: string;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    DatabaseColumn
  >;
}

interface ManagedDatabaseSchemasOperations {
  @doc("List managed database schemas")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas")
  @get
  ListByDatabase is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the managed instance.")
      @path
      managedInstanceName: string;

      @doc("The name of the database.")
      @path
      databaseName: string;

      @doc("An OData filter expression that filters elements in the collection.")
      @query("$filter")
      $filter?: string;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    ResourceListResult<DatabaseSchema>
  >;

  @doc("Get managed database schema")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas/{schemaName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the managed instance.")
      @path
      managedInstanceName: string;

      @doc("The name of the database.")
      @path
      databaseName: string;

      @doc("The name of the schema.")
      @path
      schemaName: string;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    DatabaseSchema
  >;
}

interface ManagedDatabaseTablesOperations {
  @doc("List managed database tables")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas/{schemaName}/tables")
  @get
  ListBySchema is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the managed instance.")
      @path
      managedInstanceName: string;

      @doc("The name of the database.")
      @path
      databaseName: string;

      @doc("The name of the schema.")
      @path
      schemaName: string;

      @doc("An OData filter expression that filters elements in the collection.")
      @query("$filter")
      $filter?: string;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    ResourceListResult<DatabaseTable>
  >;

  @doc("Get managed database table")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the managed instance.")
      @path
      managedInstanceName: string;

      @doc("The name of the database.")
      @path
      databaseName: string;

      @doc("The name of the schema.")
      @path
      schemaName: string;

      @doc("The name of the table.")
      @path
      tableName: string;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    DatabaseTable
  >;
}

interface ManagedDatabaseVulnerabilityAssessmentRuleBaselinesOperations {
  @doc("Gets a database's vulnerability assessment rule baseline.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/rules/{ruleId}/baselines/{baselineName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the managed instance.")
      @path
      managedInstanceName: string;

      @doc("The name of the database for which the vulnerability assessment rule baseline is defined.")
      @path
      databaseName: string;

      @doc("The name of the vulnerability assessment.")
      @path
      vulnerabilityAssessmentName: VulnerabilityAssessmentName;

      @doc("The vulnerability assessment rule ID.")
      @path
      ruleId: string;

      @doc("The name of the vulnerability assessment rule baseline (default implies a baseline on a database level rule and master for server level rule).")
      @path
      baselineName: VulnerabilityAssessmentPolicyBaselineName;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    DatabaseVulnerabilityAssessmentRuleBaseline
  >;

  @doc("Creates or updates a database's vulnerability assessment rule baseline.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/rules/{ruleId}/baselines/{baselineName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the managed instance.")
      @path
      managedInstanceName: string;

      @doc("The name of the database for which the vulnerability assessment rule baseline is defined.")
      @path
      databaseName: string;

      @doc("The name of the vulnerability assessment.")
      @path
      vulnerabilityAssessmentName: VulnerabilityAssessmentName;

      @doc("The vulnerability assessment rule ID.")
      @path
      ruleId: string;

      @doc("The name of the vulnerability assessment rule baseline (default implies a baseline on a database level rule and master for server level rule).")
      @path
      baselineName: VulnerabilityAssessmentPolicyBaselineName;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;

      @doc("The requested rule baseline resource.")
      @body
      parameters: DatabaseVulnerabilityAssessmentRuleBaseline;
    },
    DatabaseVulnerabilityAssessmentRuleBaseline
  >;

  @doc("Removes the database's vulnerability assessment rule baseline.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/rules/{ruleId}/baselines/{baselineName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the managed instance.")
      @path
      managedInstanceName: string;

      @doc("The name of the database for which the vulnerability assessment rule baseline is defined.")
      @path
      databaseName: string;

      @doc("The name of the vulnerability assessment.")
      @path
      vulnerabilityAssessmentName: VulnerabilityAssessmentName;

      @doc("The vulnerability assessment rule ID.")
      @path
      ruleId: string;

      @doc("The name of the vulnerability assessment rule baseline (default implies a baseline on a database level rule and master for server level rule).")
      @path
      baselineName: VulnerabilityAssessmentPolicyBaselineName;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    void
  >;
}

interface ManagedDatabaseVulnerabilityAssessmentsOperations {
  @doc("Gets the database's vulnerability assessment.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the managed instance.")
      @path
      managedInstanceName: string;

      @doc("The name of the database for which the vulnerability assessment is defined.")
      @path
      databaseName: string;

      @doc("The name of the vulnerability assessment.")
      @path
      vulnerabilityAssessmentName: VulnerabilityAssessmentName;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    DatabaseVulnerabilityAssessment
  >;

  @doc("Creates or updates the database's vulnerability assessment.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the managed instance.")
      @path
      managedInstanceName: string;

      @doc("The name of the database for which the vulnerability assessment is defined.")
      @path
      databaseName: string;

      @doc("The name of the vulnerability assessment.")
      @path
      vulnerabilityAssessmentName: VulnerabilityAssessmentName;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;

      @doc("The requested resource.")
      @body
      parameters: DatabaseVulnerabilityAssessment;
    },
    DatabaseVulnerabilityAssessment
  >;

  @doc("Removes the database's vulnerability assessment.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the managed instance.")
      @path
      managedInstanceName: string;

      @doc("The name of the database for which the vulnerability assessment is defined.")
      @path
      databaseName: string;

      @doc("The name of the vulnerability assessment.")
      @path
      vulnerabilityAssessmentName: VulnerabilityAssessmentName;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Lists the vulnerability assessments of a managed database.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments")
  @get
  ListByDatabase is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the managed instance.")
      @path
      managedInstanceName: string;

      @doc("The name of the database for which the vulnerability assessment is defined.")
      @path
      databaseName: string;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    ResourceListResult<DatabaseVulnerabilityAssessment>
  >;
}

interface ManagedDatabaseVulnerabilityAssessmentScansOperations {
  @doc("Executes a Vulnerability Assessment database scan.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/scans/{scanId}/initiateScan")
  @post
  InitiateScan is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the managed instance.")
      @path
      managedInstanceName: string;

      @doc("The name of the database.")
      @path
      databaseName: string;

      @doc("The name of the vulnerability assessment.")
      @path
      vulnerabilityAssessmentName: VulnerabilityAssessmentName;

      @doc("The vulnerability assessment scan Id of the scan to retrieve.")
      @path
      scanId: string;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Convert an existing scan result to a human readable format. If already exists nothing happens")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/scans/{scanId}/export")
  @post
  Export is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the managed instance.")
      @path
      managedInstanceName: string;

      @doc("The name of the scanned database.")
      @path
      databaseName: string;

      @doc("The name of the vulnerability assessment.")
      @path
      vulnerabilityAssessmentName: VulnerabilityAssessmentName;

      @doc("The vulnerability assessment scan Id.")
      @path
      scanId: string;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    DatabaseVulnerabilityAssessmentScansExport
  >;

  @doc("Lists the vulnerability assessment scans of a database.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/scans")
  @get
  ListByDatabase is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the managed instance.")
      @path
      managedInstanceName: string;

      @doc("The name of the database.")
      @path
      databaseName: string;

      @doc("The name of the vulnerability assessment.")
      @path
      vulnerabilityAssessmentName: VulnerabilityAssessmentName;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    ResourceListResult<VulnerabilityAssessmentScanRecord>
  >;

  @doc("Gets a vulnerability assessment scan record of a database.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/scans/{scanId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the managed instance.")
      @path
      managedInstanceName: string;

      @doc("The name of the database.")
      @path
      databaseName: string;

      @doc("The name of the vulnerability assessment.")
      @path
      vulnerabilityAssessmentName: VulnerabilityAssessmentName;

      @doc("The vulnerability assessment scan Id of the scan to retrieve.")
      @path
      scanId: string;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    VulnerabilityAssessmentScanRecord
  >;
}

interface ManagedRestorableDroppedDatabaseBackupShortTermRetentionPoliciesOperations {
  @doc("Gets a dropped database's short term retention policy.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/restorableDroppedDatabases/{restorableDroppedDatabaseId}/backupShortTermRetentionPolicies/{policyName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the managed instance.")
      @path
      managedInstanceName: string;

      @path
      restorableDroppedDatabaseId: string;

      @doc("The policy name.")
      @path
      policyName: ManagedShortTermRetentionPolicyName;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    ManagedBackupShortTermRetentionPolicy
  >;

  @doc("Sets a database's short term retention policy.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/restorableDroppedDatabases/{restorableDroppedDatabaseId}/backupShortTermRetentionPolicies/{policyName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the managed instance.")
      @path
      managedInstanceName: string;

      @path
      restorableDroppedDatabaseId: string;

      @doc("The policy name. Should always be \"default\".")
      @path
      policyName: ManagedShortTermRetentionPolicyName;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;

      @doc("The short term retention policy info.")
      @body
      parameters: ManagedBackupShortTermRetentionPolicy;
    },
    ManagedBackupShortTermRetentionPolicy | void
  >;

  @doc("Sets a database's short term retention policy.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/restorableDroppedDatabases/{restorableDroppedDatabaseId}/backupShortTermRetentionPolicies/{policyName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the managed instance.")
      @path
      managedInstanceName: string;

      @path
      restorableDroppedDatabaseId: string;

      @doc("The policy name. Should always be \"default\".")
      @path
      policyName: ManagedShortTermRetentionPolicyName;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;

      @doc("The short term retention policy info.")
      @body
      parameters: ManagedBackupShortTermRetentionPolicy;
    },
    ManagedBackupShortTermRetentionPolicy | void
  >;

  @doc("Gets a dropped database's short term retention policy list.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/restorableDroppedDatabases/{restorableDroppedDatabaseId}/backupShortTermRetentionPolicies")
  @get
  ListByRestorableDroppedDatabase is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the managed instance.")
      @path
      managedInstanceName: string;

      @path
      restorableDroppedDatabaseId: string;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    ResourceListResult<ManagedBackupShortTermRetentionPolicy>
  >;
}

interface ServerAdvisorsOperations {
  @doc("Gets a list of server advisors.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/advisors")
  @get
  ListByServer is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the server.")
      @path
      serverName: string;

      @doc("The child resources to include in the response.")
      @query("$expand")
      $expand?: string;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Gets a server advisor.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/advisors/{advisorName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the server.")
      @path
      serverName: string;

      @doc("The name of the Server Advisor.")
      @path
      advisorName: string;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    Advisor
  >;

  @doc("Updates a server advisor.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/advisors/{advisorName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the server.")
      @path
      serverName: string;

      @doc("The name of the Server Advisor.")
      @path
      advisorName: string;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;

      @doc("The requested advisor resource state.")
      @body
      parameters: Advisor;
    },
    Advisor
  >;
}

interface LongTermRetentionBackupsOperations {
  @doc("Lists the long term retention backups for a given location.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionBackups")
  @get
  ListByLocation is Azure.Core.Foundations.Operation<
    {
      @doc("The location of the database")
      @path
      locationName: string;

      @doc("Whether or not to only get the latest backup for each database.")
      @query("onlyLatestPerDatabase")
      onlyLatestPerDatabase?: boolean;

      @doc("Whether to query against just live databases, just deleted databases, or all databases.")
      @query("databaseState")
      databaseState?: DatabaseState;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    ResourceListResult<LongTermRetentionBackup>
  >;

  @doc("Lists the long term retention backups for a given server.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionBackups")
  @get
  ListByServer is Azure.Core.Foundations.Operation<
    {
      @doc("The location of the database")
      @path
      locationName: string;

      @doc("The name of the server")
      @path
      longTermRetentionServerName: string;

      @doc("Whether or not to only get the latest backup for each database.")
      @query("onlyLatestPerDatabase")
      onlyLatestPerDatabase?: boolean;

      @doc("Whether to query against just live databases, just deleted databases, or all databases.")
      @query("databaseState")
      databaseState?: DatabaseState;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    ResourceListResult<LongTermRetentionBackup>
  >;

  @doc("Copy an existing long term retention backup to a different server.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/copy")
  @post
  CopyByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The location of the database.")
      @path
      locationName: string;

      @doc("The name of the server")
      @path
      longTermRetentionServerName: string;

      @doc("The name of the database")
      @path
      longTermRetentionDatabaseName: string;

      @doc("The backup name.")
      @path
      backupName: string;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;

      @doc("The parameters needed for long term retention copy request")
      @body
      parameters: CopyLongTermRetentionBackupParameters;
    },
    LongTermRetentionBackupOperationResult | void
  >;

  @doc("Updates an existing long term retention backup.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/update")
  @post
  UpdateByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The location of the database.")
      @path
      locationName: string;

      @doc("The name of the server")
      @path
      longTermRetentionServerName: string;

      @doc("The name of the database")
      @path
      longTermRetentionDatabaseName: string;

      @doc("The backup name.")
      @path
      backupName: string;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;

      @doc("The requested backup resource state")
      @body
      parameters: UpdateLongTermRetentionBackupParameters;
    },
    LongTermRetentionBackupOperationResult | void
  >;

  @doc("Gets a long term retention backup.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}")
  @get
  GetByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The location of the database.")
      @path
      locationName: string;

      @doc("The name of the server")
      @path
      longTermRetentionServerName: string;

      @doc("The name of the database")
      @path
      longTermRetentionDatabaseName: string;

      @doc("The backup name.")
      @path
      backupName: string;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    LongTermRetentionBackup
  >;

  @doc("Deletes a long term retention backup.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}")
  @delete
  DeleteByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The location of the database")
      @path
      locationName: string;

      @doc("The name of the server")
      @path
      longTermRetentionServerName: string;

      @doc("The name of the database")
      @path
      longTermRetentionDatabaseName: string;

      @doc("The backup name.")
      @path
      backupName: string;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Lists all long term retention backups for a database.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups")
  @get
  ListByResourceGroupDatabase is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The location of the database")
      @path
      locationName: string;

      @doc("The name of the server")
      @path
      longTermRetentionServerName: string;

      @doc("The name of the database")
      @path
      longTermRetentionDatabaseName: string;

      @doc("Whether or not to only get the latest backup for each database.")
      @query("onlyLatestPerDatabase")
      onlyLatestPerDatabase?: boolean;

      @doc("Whether to query against just live databases, just deleted databases, or all databases.")
      @query("databaseState")
      databaseState?: DatabaseState;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    ResourceListResult<LongTermRetentionBackup>
  >;

  @doc("Lists the long term retention backups for a given location.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionBackups")
  @get
  ListByResourceGroupLocation is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The location of the database")
      @path
      locationName: string;

      @doc("Whether or not to only get the latest backup for each database.")
      @query("onlyLatestPerDatabase")
      onlyLatestPerDatabase?: boolean;

      @doc("Whether to query against just live databases, just deleted databases, or all databases.")
      @query("databaseState")
      databaseState?: DatabaseState;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    ResourceListResult<LongTermRetentionBackup>
  >;

  @doc("Lists the long term retention backups for a given server.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionBackups")
  @get
  ListByResourceGroupServer is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The location of the database")
      @path
      locationName: string;

      @doc("The name of the server")
      @path
      longTermRetentionServerName: string;

      @doc("Whether or not to only get the latest backup for each database.")
      @query("onlyLatestPerDatabase")
      onlyLatestPerDatabase?: boolean;

      @doc("Whether to query against just live databases, just deleted databases, or all databases.")
      @query("databaseState")
      databaseState?: DatabaseState;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    ResourceListResult<LongTermRetentionBackup>
  >;
}

interface LongTermRetentionManagedInstanceBackupsOperations {
  @doc("Lists the long term retention backups for a given managed instance.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionManagedInstances/{managedInstanceName}/longTermRetentionManagedInstanceBackups")
  @get
  ListByInstance is Azure.Core.Foundations.Operation<
    {
      @doc("The location of the database")
      @path
      locationName: string;

      @doc("The name of the managed instance.")
      @path
      managedInstanceName: string;

      @doc("Whether or not to only get the latest backup for each database.")
      @query("onlyLatestPerDatabase")
      onlyLatestPerDatabase?: boolean;

      @doc("Whether to query against just live databases, just deleted databases, or all databases.")
      @query("databaseState")
      databaseState?: DatabaseState;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    ResourceListResult<ManagedInstanceLongTermRetentionBackup>
  >;

  @doc("Lists the long term retention backups for managed databases in a given location.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionManagedInstanceBackups")
  @get
  ListByLocation is Azure.Core.Foundations.Operation<
    {
      @doc("The location of the database.")
      @path
      locationName: string;

      @doc("Whether or not to only get the latest backup for each database.")
      @query("onlyLatestPerDatabase")
      onlyLatestPerDatabase?: boolean;

      @doc("Whether to query against just live databases, just deleted databases, or all databases.")
      @query("databaseState")
      databaseState?: DatabaseState;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    ResourceListResult<ManagedInstanceLongTermRetentionBackup>
  >;

  @doc("Gets a long term retention backup for a managed database.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionManagedInstances/{managedInstanceName}/longTermRetentionDatabases/{databaseName}/longTermRetentionManagedInstanceBackups/{backupName}")
  @get
  GetByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The location of the database.")
      @path
      locationName: string;

      @doc("The name of the managed instance.")
      @path
      managedInstanceName: string;

      @doc("The name of the managed database.")
      @path
      databaseName: string;

      @doc("The backup name.")
      @path
      backupName: string;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    ManagedInstanceLongTermRetentionBackup
  >;

  @doc("Deletes a long term retention backup.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionManagedInstances/{managedInstanceName}/longTermRetentionDatabases/{databaseName}/longTermRetentionManagedInstanceBackups/{backupName}")
  @delete
  DeleteByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The location of the database")
      @path
      locationName: string;

      @doc("The name of the managed instance.")
      @path
      managedInstanceName: string;

      @doc("The name of the managed database.")
      @path
      databaseName: string;

      @doc("The backup name.")
      @path
      backupName: string;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Lists all long term retention backups for a managed database.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionManagedInstances/{managedInstanceName}/longTermRetentionDatabases/{databaseName}/longTermRetentionManagedInstanceBackups")
  @get
  ListByResourceGroupDatabase is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The location of the database")
      @path
      locationName: string;

      @doc("The name of the managed instance.")
      @path
      managedInstanceName: string;

      @doc("The name of the managed database.")
      @path
      databaseName: string;

      @doc("Whether or not to only get the latest backup for each database.")
      @query("onlyLatestPerDatabase")
      onlyLatestPerDatabase?: boolean;

      @doc("Whether to query against just live databases, just deleted databases, or all databases.")
      @query("databaseState")
      databaseState?: DatabaseState;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    ResourceListResult<ManagedInstanceLongTermRetentionBackup>
  >;

  @doc("Lists the long term retention backups for a given managed instance.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionManagedInstances/{managedInstanceName}/longTermRetentionManagedInstanceBackups")
  @get
  ListByResourceGroupInstance is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The location of the database.")
      @path
      locationName: string;

      @doc("The name of the managed instance.")
      @path
      managedInstanceName: string;

      @doc("Whether or not to only get the latest backup for each database.")
      @query("onlyLatestPerDatabase")
      onlyLatestPerDatabase?: boolean;

      @doc("Whether to query against just live databases, just deleted databases, or all databases.")
      @query("databaseState")
      databaseState?: DatabaseState;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    ResourceListResult<ManagedInstanceLongTermRetentionBackup>
  >;

  @doc("Lists the long term retention backups for managed databases in a given location.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionManagedInstanceBackups")
  @get
  ListByResourceGroupLocation is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The location of the database.")
      @path
      locationName: string;

      @doc("Whether or not to only get the latest backup for each database.")
      @query("onlyLatestPerDatabase")
      onlyLatestPerDatabase?: boolean;

      @doc("Whether to query against just live databases, just deleted databases, or all databases.")
      @query("databaseState")
      databaseState?: DatabaseState;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    ResourceListResult<ManagedInstanceLongTermRetentionBackup>
  >;
}

interface ManagedDatabaseSensitivityLabelsOperations {
  @doc("Disables sensitivity recommendations on a given column")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}/sensitivityLabels/{sensitivityLabelSource}/disable")
  @post
  DisableRecommendation is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the managed instance.")
      @path
      managedInstanceName: string;

      @doc("The name of the database.")
      @path
      databaseName: string;

      @doc("The name of the schema.")
      @path
      schemaName: string;

      @doc("The name of the table.")
      @path
      tableName: string;

      @doc("The name of the column.")
      @path
      columnName: string;

      @path
      sensitivityLabelSource: "recommended";

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Enables sensitivity recommendations on a given column (recommendations are enabled by default on all columns)")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}/sensitivityLabels/{sensitivityLabelSource}/enable")
  @post
  EnableRecommendation is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the managed instance.")
      @path
      managedInstanceName: string;

      @doc("The name of the database.")
      @path
      databaseName: string;

      @doc("The name of the schema.")
      @path
      schemaName: string;

      @doc("The name of the table.")
      @path
      tableName: string;

      @doc("The name of the column.")
      @path
      columnName: string;

      @path
      sensitivityLabelSource: "recommended";

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    void
  >;
}

interface SensitivityLabelsOperations {
  @doc("Gets the sensitivity label of a given column")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}/sensitivityLabels/{sensitivityLabelSource}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the server.")
      @path
      serverName: string;

      @doc("The name of the database.")
      @path
      databaseName: string;

      @doc("The name of the schema.")
      @path
      schemaName: string;

      @doc("The name of the table.")
      @path
      tableName: string;

      @doc("The name of the column.")
      @path
      columnName: string;

      @doc("The source of the sensitivity label.")
      @path
      sensitivityLabelSource: SensitivityLabelSource;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    SensitivityLabel
  >;

  @doc("Creates or updates the sensitivity label of a given column")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}/sensitivityLabels/{sensitivityLabelSource}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the server.")
      @path
      serverName: string;

      @doc("The name of the database.")
      @path
      databaseName: string;

      @doc("The name of the schema.")
      @path
      schemaName: string;

      @doc("The name of the table.")
      @path
      tableName: string;

      @doc("The name of the column.")
      @path
      columnName: string;

      @doc("The source of the sensitivity label.")
      @path
      sensitivityLabelSource: "current";

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;

      @doc("The column sensitivity label resource.")
      @body
      parameters: SensitivityLabel;
    },
    SensitivityLabel
  >;

  @doc("Deletes the sensitivity label of a given column")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}/sensitivityLabels/{sensitivityLabelSource}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the server.")
      @path
      serverName: string;

      @doc("The name of the database.")
      @path
      databaseName: string;

      @doc("The name of the schema.")
      @path
      schemaName: string;

      @doc("The name of the table.")
      @path
      tableName: string;

      @doc("The name of the column.")
      @path
      columnName: string;

      @doc("The source of the sensitivity label.")
      @path
      sensitivityLabelSource: "current";

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    void
  >;
}

interface DatabaseSqlVulnerabilityAssessmentBaselinesOperations {
  @doc("Gets a list of database's sql vulnerability assessment rule baselines.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines")
  @get
  ListBySqlVulnerabilityAssessment is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the server.")
      @path
      serverName: string;

      @doc("The name of the database.")
      @path
      databaseName: string;

      @doc("The name of the vulnerability assessment.")
      @path
      vulnerabilityAssessmentName: VulnerabilityAssessmentName;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    ResourceListResult<DatabaseSqlVulnerabilityAssessmentBaselineSet>
  >;

  @doc("Gets a list of database's sql vulnerability assessment rule baselines.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the server.")
      @path
      serverName: string;

      @doc("The name of the database.")
      @path
      databaseName: string;

      @doc("The name of the vulnerability assessment.")
      @path
      vulnerabilityAssessmentName: VulnerabilityAssessmentName;

      @path
      baselineName: BaselineName;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    DatabaseSqlVulnerabilityAssessmentBaselineSet
  >;

  @doc("Add a database's vulnerability assessment rule baseline list.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the server.")
      @path
      serverName: string;

      @doc("The name of the database.")
      @path
      databaseName: string;

      @doc("The name of the vulnerability assessment.")
      @path
      vulnerabilityAssessmentName: VulnerabilityAssessmentName;

      @path
      baselineName: BaselineName;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;

      @doc("The requested rule baseline resource.")
      @body
      parameters: DatabaseSqlVulnerabilityAssessmentRuleBaselineListInput;
    },
    DatabaseSqlVulnerabilityAssessmentBaselineSet
  >;
}

interface DatabaseSqlVulnerabilityAssessmentExecuteScanOperations {
  @doc("Executes a Vulnerability Assessment database scan.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/initiateScan")
  @post
  Execute is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the server.")
      @path
      serverName: string;

      @doc("The name of the database.")
      @path
      databaseName: string;

      @doc("The name of the vulnerability assessment.")
      @path
      vulnerabilityAssessmentName: VulnerabilityAssessmentName;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    void
  >;
}

interface DatabaseSqlVulnerabilityAssessmentRuleBaselinesOperations {
  @doc("Gets a list of database's sql vulnerability assessment rule baselines.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}/rules")
  @get
  ListByBaseline is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the server.")
      @path
      serverName: string;

      @doc("The name of the database.")
      @path
      databaseName: string;

      @doc("The name of the vulnerability assessment.")
      @path
      vulnerabilityAssessmentName: VulnerabilityAssessmentName;

      @path
      baselineName: BaselineName;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    ResourceListResult<DatabaseSqlVulnerabilityAssessmentRuleBaseline>
  >;

  @doc("Gets a database's sql vulnerability assessment rule baseline.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}/rules/{ruleId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the server.")
      @path
      serverName: string;

      @doc("The name of the database.")
      @path
      databaseName: string;

      @doc("The name of the vulnerability assessment.")
      @path
      vulnerabilityAssessmentName: VulnerabilityAssessmentName;

      @path
      baselineName: BaselineName;

      @doc("The vulnerability assessment rule ID.")
      @path
      ruleId: string;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    DatabaseSqlVulnerabilityAssessmentRuleBaseline
  >;

  @doc("Creates or updates a database's vulnerability assessment rule baseline.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}/rules/{ruleId}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the server.")
      @path
      serverName: string;

      @doc("The name of the database.")
      @path
      databaseName: string;

      @doc("The name of the vulnerability assessment.")
      @path
      vulnerabilityAssessmentName: VulnerabilityAssessmentName;

      @path
      baselineName: BaselineName;

      @doc("The vulnerability assessment rule ID.")
      @path
      ruleId: string;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;

      @doc("The requested rule baseline resource.")
      @body
      parameters: DatabaseSqlVulnerabilityAssessmentRuleBaselineInput;
    },
    DatabaseSqlVulnerabilityAssessmentRuleBaseline
  >;

  @doc("Removes the database's vulnerability assessment rule baseline.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}/rules/{ruleId}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the server.")
      @path
      serverName: string;

      @doc("The name of the database.")
      @path
      databaseName: string;

      @doc("The name of the vulnerability assessment.")
      @path
      vulnerabilityAssessmentName: VulnerabilityAssessmentName;

      @path
      baselineName: BaselineName;

      @doc("The vulnerability assessment rule ID.")
      @path
      ruleId: string;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    void
  >;
}

interface DatabaseSqlVulnerabilityAssessmentScanResultOperations {
  @doc("Gets a vulnerability assessment scan record of a database.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/scans/{scanId}/scanResults")
  @get
  ListByScan is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the server.")
      @path
      serverName: string;

      @doc("The name of the database.")
      @path
      databaseName: string;

      @doc("The name of the SQL Vulnerability Assessment.")
      @path
      vulnerabilityAssessmentName: VulnerabilityAssessmentName;

      @doc("The scan id of the SQL Vulnerability Assessment scan to retrieve result from.")
      @path
      scanId: string;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    ResourceListResult<SqlVulnerabilityAssessmentScanResults>
  >;

  @doc("Gets a vulnerability assessment scan record of a database.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/scans/{scanId}/scanResults/{scanResultId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the server.")
      @path
      serverName: string;

      @doc("The name of the database.")
      @path
      databaseName: string;

      @doc("The name of the SQL Vulnerability Assessment.")
      @path
      vulnerabilityAssessmentName: VulnerabilityAssessmentName;

      @doc("The scan id of the SQL Vulnerability Assessment scan to retrieve result from.")
      @path
      scanId: string;

      @doc("The scan result id of the specific result to retrieve.")
      @path
      scanResultId: string;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    SqlVulnerabilityAssessmentScanResults
  >;
}

interface DatabaseSqlVulnerabilityAssessmentScansOperations {
  @doc("Lists the vulnerability assessment scans of a database.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/scans")
  @get
  ListBySqlVulnerabilityAssessments is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the server.")
      @path
      serverName: string;

      @doc("The name of the database.")
      @path
      databaseName: string;

      @doc("The name of the vulnerability assessment.")
      @path
      vulnerabilityAssessmentName: VulnerabilityAssessmentName;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    ResourceListResult<SqlVulnerabilityAssessmentScanRecord>
  >;

  @doc("Get a database vulnerability assessment scan result.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/scans/{scanId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the server.")
      @path
      serverName: string;

      @doc("The name of the database.")
      @path
      databaseName: string;

      @doc("The name of the vulnerability assessment.")
      @path
      vulnerabilityAssessmentName: VulnerabilityAssessmentName;

      @doc("The vulnerability assessment scan Id of the scan to retrieve.")
      @path
      scanId: string;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    SqlVulnerabilityAssessmentScanRecord
  >;
}

interface DatabaseSqlVulnerabilityAssessmentsSettingsOperations {
  @doc("Lists SQL Vulnerability Assessment policies associated with a database.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments")
  @get
  ListByDatabase is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the server.")
      @path
      serverName: string;

      @doc("The name of the database.")
      @path
      databaseName: string;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    ResourceListResult<SqlVulnerabilityAssessment>
  >;

  @doc("Gets SQL Vulnerability Assessment policy for database.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the server.")
      @path
      serverName: string;

      @doc("The name of the database.")
      @path
      databaseName: string;

      @doc("The name of the SQL Vulnerability Assessment.")
      @path
      vulnerabilityAssessmentName: VulnerabilityAssessmentName;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    SqlVulnerabilityAssessment
  >;
}
