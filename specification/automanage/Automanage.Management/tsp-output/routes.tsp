import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Automanage;

interface ConfigurationProfilesVersionsOperations {
  @doc("Creates a configuration profile version")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/configurationProfiles/{configurationProfileName}/versions/{versionName}")
  @put
  createOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the configuration profile.")
      @path
      configurationProfileName: string;

      @doc("The configuration profile version name.")
      @path
      versionName: string;

      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("Parameters supplied to create or update configuration profile.")
      @body
      parameters: ConfigurationProfile;
    },
    ConfigurationProfile
  >;

  @doc("Get information about a configuration profile version")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/configurationProfiles/{configurationProfileName}/versions/{versionName}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      @doc("The configuration profile name.")
      @path
      configurationProfileName: string;

      @doc("The configuration profile version name.")
      @path
      versionName: string;

      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;
    },
    ConfigurationProfile
  >;

  @doc("Delete a configuration profile version")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/configurationProfiles/{configurationProfileName}/versions/{versionName}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("Name of the configuration profile")
      @path
      configurationProfileName: string;

      @doc("The configuration profile version name.")
      @path
      versionName: string;

      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Retrieve a list of configuration profile version for a configuration profile ")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/configurationProfiles/{configurationProfileName}/versions")
  @get
  listChildResources is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the configuration profile.")
      @path
      configurationProfileName: string;

      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;
    },
    ResourceListResult<ConfigurationProfile>
  >;
}

interface ConfigurationProfileAssignmentsOperations {
  @doc("Get list of configuration profile assignments")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridCompute/machines/{machineName}/providers/Microsoft.Automanage/configurationProfileAssignments")
  @get
  listByMachineName is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the Arc machine.")
      @path
      machineName: string;
    },
    ResourceListResult<ConfigurationProfileAssignment>
  >;

  @doc("Get list of configuration profile assignments")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHci/clusters/{clusterName}/providers/Microsoft.Automanage/configurationProfileAssignments")
  @get
  listByClusterName is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the Arc machine.")
      @path
      clusterName: string;
    },
    ResourceListResult<ConfigurationProfileAssignment>
  >;
}

interface ServicePrincipalsOperations {
  @doc("Get the Automanage AAD first party Application Service Principal details for the subscription id.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Automanage/servicePrincipals")
  @get
  listBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;
    },
    ServicePrincipalListResult
  >;

  @doc("Get the Automanage AAD first party Application Service Principal details for the subscription id.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Automanage/servicePrincipals/default")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;
    },
    ServicePrincipal
  >;
}

interface ConfigurationProfileHCRPAssignmentsOperations {
  @doc("Creates an association between a ARC machine and Automanage configuration profile")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridCompute/machines/{machineName}/providers/Microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}")
  @put
  createOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the Arc machine.")
      @path
      machineName: string;

      @doc("Name of the configuration profile assignment. Only default is supported.")
      @path
      configurationProfileAssignmentName: string;

      @doc("Parameters supplied to the create or update configuration profile assignment.")
      @body
      parameters: ConfigurationProfileAssignment;
    },
    ConfigurationProfileAssignment
  >;

  @doc("Get information about a configuration profile assignment")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridCompute/machines/{machineName}/providers/Microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the Arc machine.")
      @path
      machineName: string;

      @doc("The configuration profile assignment name.")
      @path
      configurationProfileAssignmentName: string;
    },
    ConfigurationProfileAssignment
  >;

  @doc("Delete a configuration profile assignment")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridCompute/machines/{machineName}/providers/Microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the Arc machine.")
      @path
      machineName: string;

      @doc("Name of the configuration profile assignment")
      @path
      configurationProfileAssignmentName: string;
    },
    void
  >;
}

interface HCRPReportsOperations {
  @doc("Get information about a report associated with a configuration profile assignment run")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridCompute/machines/{machineName}/providers/Microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}/reports/{reportName}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the Arc machine.")
      @path
      machineName: string;

      @doc("The configuration profile assignment name.")
      @path
      configurationProfileAssignmentName: string;

      @doc("The report name.")
      @path
      reportName: string;
    },
    Report
  >;

  @doc("Retrieve a list of reports within a given configuration profile assignment")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridCompute/machines/{machineName}/providers/Microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}/reports")
  @get
  listByConfigurationProfileAssignments is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the Arc machine.")
      @path
      machineName: string;

      @doc("The configuration profile assignment name.")
      @path
      configurationProfileAssignmentName: string;
    },
    ResourceListResult<Report>
  >;
}

interface ConfigurationProfileHCIAssignmentsOperations {
  @doc("Creates an association between a AzureStackHCI cluster and Automanage configuration profile")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHci/clusters/{clusterName}/providers/Microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}")
  @put
  createOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the Arc machine.")
      @path
      clusterName: string;

      @doc("Name of the configuration profile assignment. Only default is supported.")
      @path
      configurationProfileAssignmentName: string;

      @doc("Parameters supplied to the create or update configuration profile assignment.")
      @body
      parameters: ConfigurationProfileAssignment;
    },
    ConfigurationProfileAssignment
  >;

  @doc("Get information about a configuration profile assignment")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHci/clusters/{clusterName}/providers/Microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the Arc machine.")
      @path
      clusterName: string;

      @doc("The configuration profile assignment name.")
      @path
      configurationProfileAssignmentName: string;
    },
    ConfigurationProfileAssignment
  >;

  @doc("Delete a configuration profile assignment")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHci/clusters/{clusterName}/providers/Microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the Arc machine.")
      @path
      clusterName: string;

      @doc("Name of the configuration profile assignment")
      @path
      configurationProfileAssignmentName: string;
    },
    void
  >;
}

interface HCIReportsOperations {
  @doc("Get information about a report associated with a configuration profile assignment run")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHci/clusters/{clusterName}/providers/Microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}/reports/{reportName}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the Arc machine.")
      @path
      clusterName: string;

      @doc("The configuration profile assignment name.")
      @path
      configurationProfileAssignmentName: string;

      @doc("The report name.")
      @path
      reportName: string;
    },
    Report
  >;

  @doc("Retrieve a list of reports within a given configuration profile assignment")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHci/clusters/{clusterName}/providers/Microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}/reports")
  @get
  listByConfigurationProfileAssignments is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the Arc machine.")
      @path
      clusterName: string;

      @doc("The configuration profile assignment name.")
      @path
      configurationProfileAssignmentName: string;
    },
    ResourceListResult<Report>
  >;
}
