import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.App;

interface AvailableWorkloadProfilesOperations {
  @summary("Get available workload profiles by location.")
  @doc("Get all available workload profiles for a location.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.App/locations/{location}/availableManagedEnvironmentsWorkloadProfileTypes")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of Azure region.")
      @minLength(1)
      @path
      location: string;
    },
    AvailableWorkloadProfilesCollection
  >;
}

interface BillingMetersOperations {
  @summary("Get billing meters by location.")
  @doc("Get all billingMeters for a location.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.App/locations/{location}/billingMeters")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of Azure region.")
      @minLength(1)
      @path
      location: string;
    },
    BillingMeterCollection
  >;
}

interface ContainerAppsDiagnosticsOperations {
  @summary("Get the Revisions for a given Container App.")
  @doc("Get the Revisions for a given Container App.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/containerApps/{containerAppName}/detectorProperties/revisionsApi/revisions/")
  @get
  listRevisions is Azure.Core.Foundations.Operation<
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

      @doc("Name of the Container App for which Revisions are needed.")
      @path
      containerAppName: string;

      @doc("The filter to apply on the operation.")
      @query("$filter")
      $filter?: string;
    },
    ResourceListResult<Revision>
  >;

  @summary("Get a revision of a Container App.")
  @doc("Get a revision of a Container App.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/containerApps/{containerAppName}/detectorProperties/revisionsApi/revisions/{revisionName}")
  @get
  getRevision is Azure.Core.Foundations.Operation<
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

      @doc("Name of the Container App.")
      @path
      containerAppName: string;

      @doc("Name of the Container App Revision.")
      @path
      revisionName: string;
    },
    Revision
  >;

  @summary("Get the properties of a Container App.")
  @doc("Get the properties of a Container App.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/containerApps/{containerAppName}/detectorProperties/rootApi/")
  @get
  getRoot is Azure.Core.Foundations.Operation<
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

      @doc("Name of the Container App.")
      @path
      containerAppName: string;
    },
    ContainerApp
  >;
}

interface ManagedEnvironmentDiagnosticsOperations {
  @summary("Get the list of diagnostics for a given Managed Environment.")
  @doc("Get the list of diagnostics for a Managed Environment used to host container apps.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/managedEnvironments/{environmentName}/detectors")
  @get
  listDetectors is Azure.Core.Foundations.Operation<
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

      @doc("Name of the Environment.")
      @path
      environmentName: string;
    },
    ResourceListResult<Diagnostics>
  >;

  @summary("Get the diagnostics data for a given Managed Environment.")
  @doc("Get the diagnostics data for a Managed Environment used to host container apps.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/managedEnvironments/{environmentName}/detectors/{detectorName}")
  @get
  getDetector is Azure.Core.Foundations.Operation<
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

      @doc("Name of the Environment.")
      @path
      environmentName: string;

      @doc("Name of the Managed Environment detector.")
      @path
      detectorName: string;
    },
    Diagnostics
  >;
}

interface ManagedEnvironmentsOperations {
  @summary("Get all Environments for a subscription.")
  @doc("Get all Managed Environments for a subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.App/managedEnvironments")
  @get
  listBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;
    },
    ManagedEnvironmentsCollection
  >;

  @summary("Get all the Environments in a resource group.")
  @doc("Get all the Managed Environments in a resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/managedEnvironments")
  @get
  listByResourceGroup is Azure.Core.Foundations.Operation<
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
    },
    ManagedEnvironmentsCollection
  >;

  @summary("Get the properties of a Managed Environment.")
  @doc("Get the properties of a Managed Environment used to host container apps.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/managedEnvironments/{environmentName}")
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

      @doc("Name of the Environment.")
      @path
      environmentName: string;
    },
    ManagedEnvironment
  >;

  @summary("Creates or updates a Managed Environment.")
  @doc("Creates or updates a Managed Environment used to host container apps.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/managedEnvironments/{environmentName}")
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

      @doc("Name of the Environment.")
      @path
      environmentName: string;

      @doc("Configuration details of the Environment.")
      @body
      environmentEnvelope: ManagedEnvironment;
    },
    ManagedEnvironment
  >;

  @summary("Delete a Managed Environment.")
  @doc("Delete a Managed Environment if it does not have any container apps.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/managedEnvironments/{environmentName}")
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

      @doc("Name of the Environment.")
      @path
      environmentName: string;
    },
    void
  >;

  @summary("Update Managed Environment's properties.")
  @doc("Patches a Managed Environment using JSON Merge Patch")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/managedEnvironments/{environmentName}")
  @patch
  update is Azure.Core.Foundations.Operation<
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

      @doc("Name of the Environment.")
      @path
      environmentName: string;

      @doc("Configuration details of the Environment.")
      @body
      environmentEnvelope: ManagedEnvironment;
    },
    ManagedEnvironment | void
  >;

  @summary("Get auth token for a managed environment")
  @doc("Checks if resource name is available.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/managedEnvironments/{environmentName}/getAuthtoken")
  @post
  getAuthToken is Azure.Core.Foundations.Operation<
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

      @doc("Name of the Managed Environment.")
      @path
      environmentName: string;
    },
    EnvironmentAuthToken
  >;

  @summary("Get all workload Profile States for a Managed Environment..")
  @doc("Get all workload Profile States for a Managed Environment.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/managedEnvironments/{environmentName}/workloadProfileStates")
  @get
  listWorkloadProfileStates is Azure.Core.Foundations.Operation<
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

      @doc("Name of the Managed Environment.")
      @path
      environmentName: string;
    },
    WorkloadProfileStatesCollection
  >;
}

interface CertificatesOperations {
  @summary("Get the Certificates in a given managed environment.")
  @doc("Get the Certificates in a given managed environment.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/managedEnvironments/{environmentName}/certificates")
  @get
  list is Azure.Core.Foundations.Operation<
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

      @doc("Name of the Managed Environment.")
      @path
      environmentName: string;
    },
    ResourceListResult<Certificate>
  >;

  @summary("Get the specified Certificate.")
  @doc("Get the specified Certificate.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/managedEnvironments/{environmentName}/certificates/{certificateName}")
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

      @doc("Name of the Managed Environment.")
      @path
      environmentName: string;

      @doc("Name of the Certificate.")
      @path
      certificateName: string;
    },
    Certificate
  >;

  @summary("Create or Update a Certificate.")
  @doc("Create or Update a Certificate.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/managedEnvironments/{environmentName}/certificates/{certificateName}")
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

      @doc("Name of the Managed Environment.")
      @path
      environmentName: string;

      @doc("Name of the Certificate.")
      @path
      certificateName: string;

      @doc("Certificate to be created or updated")
      @body
      certificateEnvelope?: Certificate;
    },
    Certificate
  >;

  @summary("Deletes the specified Certificate.")
  @doc("Deletes the specified Certificate.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/managedEnvironments/{environmentName}/certificates/{certificateName}")
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

      @doc("Name of the Managed Environment.")
      @path
      environmentName: string;

      @doc("Name of the Certificate.")
      @path
      certificateName: string;
    },
    void
  >;

  @summary("Update properties of a certificate")
  @doc("Patches a certificate. Currently only patching of tags is supported")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/managedEnvironments/{environmentName}/certificates/{certificateName}")
  @patch
  update is Azure.Core.Foundations.Operation<
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

      @doc("Name of the Managed Environment.")
      @path
      environmentName: string;

      @doc("Name of the Certificate.")
      @path
      certificateName: string;

      @doc("Properties of a certificate that need to be updated")
      @body
      certificateEnvelope: CertificatePatch;
    },
    Certificate
  >;
}

interface NamespacesOperations {
  @summary("Checks the resource name availability.")
  @doc("Checks if resource name is available.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/managedEnvironments/{environmentName}/checkNameAvailability")
  @post
  checkNameAvailability is Azure.Core.Foundations.Operation<
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

      @doc("Name of the Managed Environment.")
      @path
      environmentName: string;

      @doc("The check name availability request.")
      @body
      checkNameAvailabilityRequest: CheckNameAvailabilityRequest;
    },
    CheckNameAvailabilityResponse
  >;
}

interface DaprComponentsOperations {
  @summary("Get the Dapr Components for a managed environment.")
  @doc("Get the Dapr Components for a managed environment.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/managedEnvironments/{environmentName}/daprComponents")
  @get
  list is Azure.Core.Foundations.Operation<
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

      @doc("Name of the Managed Environment.")
      @path
      environmentName: string;
    },
    ResourceListResult<DaprComponent>
  >;

  @summary("Get a dapr component.")
  @doc("Get a dapr component.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/managedEnvironments/{environmentName}/daprComponents/{componentName}")
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

      @doc("Name of the Managed Environment.")
      @path
      environmentName: string;

      @doc("Name of the Dapr Component.")
      @path
      componentName: string;
    },
    DaprComponent
  >;

  @summary("Creates or updates a Dapr Component.")
  @doc("Creates or updates a Dapr Component in a Managed Environment.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/managedEnvironments/{environmentName}/daprComponents/{componentName}")
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

      @doc("Name of the Managed Environment.")
      @path
      environmentName: string;

      @doc("Name of the Dapr Component.")
      @path
      componentName: string;

      @doc("Configuration details of the Dapr Component.")
      @body
      daprComponentEnvelope: DaprComponent;
    },
    DaprComponent
  >;

  @summary("Delete a Dapr Component.")
  @doc("Delete a Dapr Component from a Managed Environment.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/managedEnvironments/{environmentName}/daprComponents/{componentName}")
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

      @doc("Name of the Managed Environment.")
      @path
      environmentName: string;

      @doc("Name of the Dapr Component.")
      @path
      componentName: string;
    },
    void
  >;

  @summary("List secrets for a dapr component")
  @doc("List secrets for a dapr component")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/managedEnvironments/{environmentName}/daprComponents/{componentName}/listSecrets")
  @post
  listSecrets is Azure.Core.Foundations.Operation<
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

      @doc("Name of the Managed Environment.")
      @path
      environmentName: string;

      @doc("Name of the Dapr Component.")
      @path
      componentName: string;
    },
    DaprSecretsCollection
  >;
}
