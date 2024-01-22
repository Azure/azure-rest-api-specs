import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Automanage;

interface ConfigurationProfilesVersionsOperations {
  /**
   * Creates a configuration profile version
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/configurationProfiles/{configurationProfileName}/versions/{versionName}")
  @put
  createOrUpdate is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the configuration profile.
       */
      @path
      configurationProfileName: string;

      /**
       * The configuration profile version name.
       */
      @path
      versionName: string;

      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * Parameters supplied to create or update configuration profile.
       */
      @body
      parameters: ConfigurationProfile;
    },
    ConfigurationProfile
  >;

  /**
   * Get information about a configuration profile version
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/configurationProfiles/{configurationProfileName}/versions/{versionName}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * The configuration profile name.
       */
      @path
      configurationProfileName: string;

      /**
       * The configuration profile version name.
       */
      @path
      versionName: string;

      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;
    },
    ConfigurationProfile
  >;

  /**
   * Delete a configuration profile version
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/configurationProfiles/{configurationProfileName}/versions/{versionName}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * Name of the configuration profile
       */
      @path
      configurationProfileName: string;

      /**
       * The configuration profile version name.
       */
      @path
      versionName: string;

      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Retrieve a list of configuration profile version for a configuration profile
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/configurationProfiles/{configurationProfileName}/versions")
  @get
  listChildResources is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the configuration profile.
       */
      @path
      configurationProfileName: string;

      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;
    },
    ResourceListResult<ConfigurationProfile>
  >;
}

interface ConfigurationProfileAssignmentsOperations {
  /**
   * Get list of configuration profile assignments
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridCompute/machines/{machineName}/providers/Microsoft.Automanage/configurationProfileAssignments")
  @get
  listByMachineName is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The name of the Arc machine.
       */
      @path
      machineName: string;
    },
    ResourceListResult<ConfigurationProfileAssignment>
  >;

  /**
   * Get list of configuration profile assignments
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHci/clusters/{clusterName}/providers/Microsoft.Automanage/configurationProfileAssignments")
  @get
  listByClusterName is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The name of the Arc machine.
       */
      @path
      clusterName: string;
    },
    ResourceListResult<ConfigurationProfileAssignment>
  >;
}

interface ServicePrincipalsOperations {
  /**
   * Get the Automanage AAD first party Application Service Principal details for the subscription id.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Automanage/servicePrincipals")
  @get
  listBySubscription is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;
    },
    ServicePrincipalListResult
  >;

  /**
   * Get the Automanage AAD first party Application Service Principal details for the subscription id.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Automanage/servicePrincipals/default")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;
    },
    ServicePrincipal
  >;
}

interface ConfigurationProfileHCRPAssignmentsOperations {
  /**
   * Creates an association between a ARC machine and Automanage configuration profile
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridCompute/machines/{machineName}/providers/Microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}")
  @put
  createOrUpdate is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The name of the Arc machine.
       */
      @path
      machineName: string;

      /**
       * Name of the configuration profile assignment. Only default is supported.
       */
      @path
      configurationProfileAssignmentName: string;

      /**
       * Parameters supplied to the create or update configuration profile assignment.
       */
      @body
      parameters: ConfigurationProfileAssignment;
    },
    ConfigurationProfileAssignment
  >;

  /**
   * Get information about a configuration profile assignment
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridCompute/machines/{machineName}/providers/Microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of the Arc machine.
       */
      @path
      machineName: string;

      /**
       * The configuration profile assignment name.
       */
      @path
      configurationProfileAssignmentName: string;
    },
    ConfigurationProfileAssignment
  >;

  /**
   * Delete a configuration profile assignment
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridCompute/machines/{machineName}/providers/Microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of the Arc machine.
       */
      @path
      machineName: string;

      /**
       * Name of the configuration profile assignment
       */
      @path
      configurationProfileAssignmentName: string;
    },
    void
  >;
}

interface HCRPReportsOperations {
  /**
   * Get information about a report associated with a configuration profile assignment run
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridCompute/machines/{machineName}/providers/Microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}/reports/{reportName}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The name of the Arc machine.
       */
      @path
      machineName: string;

      /**
       * The configuration profile assignment name.
       */
      @path
      configurationProfileAssignmentName: string;

      /**
       * The report name.
       */
      @path
      reportName: string;
    },
    Report
  >;

  /**
   * Retrieve a list of reports within a given configuration profile assignment
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridCompute/machines/{machineName}/providers/Microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}/reports")
  @get
  listByConfigurationProfileAssignments is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The name of the Arc machine.
       */
      @path
      machineName: string;

      /**
       * The configuration profile assignment name.
       */
      @path
      configurationProfileAssignmentName: string;
    },
    ResourceListResult<Report>
  >;
}

interface ConfigurationProfileHCIAssignmentsOperations {
  /**
   * Creates an association between a AzureStackHCI cluster and Automanage configuration profile
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHci/clusters/{clusterName}/providers/Microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}")
  @put
  createOrUpdate is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The name of the Arc machine.
       */
      @path
      clusterName: string;

      /**
       * Name of the configuration profile assignment. Only default is supported.
       */
      @path
      configurationProfileAssignmentName: string;

      /**
       * Parameters supplied to the create or update configuration profile assignment.
       */
      @body
      parameters: ConfigurationProfileAssignment;
    },
    ConfigurationProfileAssignment
  >;

  /**
   * Get information about a configuration profile assignment
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHci/clusters/{clusterName}/providers/Microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of the Arc machine.
       */
      @path
      clusterName: string;

      /**
       * The configuration profile assignment name.
       */
      @path
      configurationProfileAssignmentName: string;
    },
    ConfigurationProfileAssignment
  >;

  /**
   * Delete a configuration profile assignment
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHci/clusters/{clusterName}/providers/Microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The name of the Arc machine.
       */
      @path
      clusterName: string;

      /**
       * Name of the configuration profile assignment
       */
      @path
      configurationProfileAssignmentName: string;
    },
    void
  >;
}

interface HCIReportsOperations {
  /**
   * Get information about a report associated with a configuration profile assignment run
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHci/clusters/{clusterName}/providers/Microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}/reports/{reportName}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of the Arc machine.
       */
      @path
      clusterName: string;

      /**
       * The configuration profile assignment name.
       */
      @path
      configurationProfileAssignmentName: string;

      /**
       * The report name.
       */
      @path
      reportName: string;
    },
    Report
  >;

  /**
   * Retrieve a list of reports within a given configuration profile assignment
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHci/clusters/{clusterName}/providers/Microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}/reports")
  @get
  listByConfigurationProfileAssignments is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The name of the Arc machine.
       */
      @path
      clusterName: string;

      /**
       * The configuration profile assignment name.
       */
      @path
      configurationProfileAssignmentName: string;
    },
    ResourceListResult<Report>
  >;
}
