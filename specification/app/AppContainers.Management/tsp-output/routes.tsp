import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.App;

interface AvailableWorkloadProfilesOperations {
  /**
   * Get all available workload profiles for a location.
   */
  @summary("Get available workload profiles by location.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.App/locations/{location}/availableManagedEnvironmentsWorkloadProfileTypes")
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
       * The name of Azure region.
       */
      @minLength(1)
      @path
      location: string;
    },
    AvailableWorkloadProfilesCollection
  >;
}

interface BillingMetersOperations {
  /**
   * Get all billingMeters for a location.
   */
  @summary("Get billing meters by location.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.App/locations/{location}/billingMeters")
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
       * The name of Azure region.
       */
      @minLength(1)
      @path
      location: string;
    },
    BillingMeterCollection
  >;
}

interface ContainerAppsDiagnosticsOperations {
  /**
   * Get the Revisions for a given Container App.
   */
  @summary("Get the Revisions for a given Container App.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/containerApps/{containerAppName}/detectorProperties/revisionsApi/revisions/")
  @get
  listRevisions is Azure.Core.Foundations.Operation<
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
       * Name of the Container App for which Revisions are needed.
       */
      @path
      containerAppName: string;

      /**
       * The filter to apply on the operation.
       */
      @query("$filter")
      $filter?: string;
    },
    ResourceListResult<Revision>
  >;

  /**
   * Get a revision of a Container App.
   */
  @summary("Get a revision of a Container App.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/containerApps/{containerAppName}/detectorProperties/revisionsApi/revisions/{revisionName}")
  @get
  getRevision is Azure.Core.Foundations.Operation<
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
       * Name of the Container App.
       */
      @path
      containerAppName: string;

      /**
       * Name of the Container App Revision.
       */
      @path
      revisionName: string;
    },
    Revision
  >;

  /**
   * Get the properties of a Container App.
   */
  @summary("Get the properties of a Container App.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/containerApps/{containerAppName}/detectorProperties/rootApi/")
  @get
  getRoot is Azure.Core.Foundations.Operation<
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
       * Name of the Container App.
       */
      @path
      containerAppName: string;
    },
    ContainerApp
  >;
}

interface ManagedEnvironmentDiagnosticsOperations {
  /**
   * Get the list of diagnostics for a Managed Environment used to host container apps.
   */
  @summary("Get the list of diagnostics for a given Managed Environment.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/managedEnvironments/{environmentName}/detectors")
  @get
  listDetectors is Azure.Core.Foundations.Operation<
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
       * Name of the Environment.
       */
      @path
      environmentName: string;
    },
    ResourceListResult<Diagnostics>
  >;

  /**
   * Get the diagnostics data for a Managed Environment used to host container apps.
   */
  @summary("Get the diagnostics data for a given Managed Environment.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/managedEnvironments/{environmentName}/detectors/{detectorName}")
  @get
  getDetector is Azure.Core.Foundations.Operation<
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
       * Name of the Environment.
       */
      @path
      environmentName: string;

      /**
       * Name of the Managed Environment detector.
       */
      @path
      detectorName: string;
    },
    Diagnostics
  >;
}

interface ManagedEnvironmentsOperations {
  /**
   * Get all Managed Environments for a subscription.
   */
  @summary("Get all Environments for a subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.App/managedEnvironments")
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
    ManagedEnvironmentsCollection
  >;

  /**
   * Get all the Managed Environments in a resource group.
   */
  @summary("Get all the Environments in a resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/managedEnvironments")
  @get
  listByResourceGroup is Azure.Core.Foundations.Operation<
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
    },
    ManagedEnvironmentsCollection
  >;

  /**
   * Get the properties of a Managed Environment used to host container apps.
   */
  @summary("Get the properties of a Managed Environment.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/managedEnvironments/{environmentName}")
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
       * Name of the Environment.
       */
      @path
      environmentName: string;
    },
    ManagedEnvironment
  >;

  /**
   * Creates or updates a Managed Environment used to host container apps.
   */
  @summary("Creates or updates a Managed Environment.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/managedEnvironments/{environmentName}")
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
       * Name of the Environment.
       */
      @path
      environmentName: string;

      /**
       * Configuration details of the Environment.
       */
      @body
      environmentEnvelope: ManagedEnvironment;
    },
    ManagedEnvironment
  >;

  /**
   * Delete a Managed Environment if it does not have any container apps.
   */
  @summary("Delete a Managed Environment.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/managedEnvironments/{environmentName}")
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
       * Name of the Environment.
       */
      @path
      environmentName: string;
    },
    void
  >;

  /**
   * Patches a Managed Environment using JSON Merge Patch
   */
  @summary("Update Managed Environment's properties.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/managedEnvironments/{environmentName}")
  @patch
  update is Azure.Core.Foundations.Operation<
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
       * Name of the Environment.
       */
      @path
      environmentName: string;

      /**
       * Configuration details of the Environment.
       */
      @body
      environmentEnvelope: ManagedEnvironment;
    },
    ManagedEnvironment | void
  >;

  /**
   * Checks if resource name is available.
   */
  @summary("Get auth token for a managed environment")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/managedEnvironments/{environmentName}/getAuthtoken")
  @post
  getAuthToken is Azure.Core.Foundations.Operation<
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
       * Name of the Managed Environment.
       */
      @path
      environmentName: string;
    },
    EnvironmentAuthToken
  >;

  /**
   * Get all workload Profile States for a Managed Environment.
   */
  @summary("Get all workload Profile States for a Managed Environment..")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/managedEnvironments/{environmentName}/workloadProfileStates")
  @get
  listWorkloadProfileStates is Azure.Core.Foundations.Operation<
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
       * Name of the Managed Environment.
       */
      @path
      environmentName: string;
    },
    WorkloadProfileStatesCollection
  >;
}

interface CertificatesOperations {
  /**
   * Get the Certificates in a given managed environment.
   */
  @summary("Get the Certificates in a given managed environment.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/managedEnvironments/{environmentName}/certificates")
  @get
  list is Azure.Core.Foundations.Operation<
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
       * Name of the Managed Environment.
       */
      @path
      environmentName: string;
    },
    ResourceListResult<Certificate>
  >;

  /**
   * Get the specified Certificate.
   */
  @summary("Get the specified Certificate.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/managedEnvironments/{environmentName}/certificates/{certificateName}")
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
       * Name of the Managed Environment.
       */
      @path
      environmentName: string;

      /**
       * Name of the Certificate.
       */
      @path
      certificateName: string;
    },
    Certificate
  >;

  /**
   * Create or Update a Certificate.
   */
  @summary("Create or Update a Certificate.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/managedEnvironments/{environmentName}/certificates/{certificateName}")
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
       * Name of the Managed Environment.
       */
      @path
      environmentName: string;

      /**
       * Name of the Certificate.
       */
      @path
      certificateName: string;

      /**
       * Certificate to be created or updated
       */
      @body
      certificateEnvelope?: Certificate;
    },
    Certificate
  >;

  /**
   * Deletes the specified Certificate.
   */
  @summary("Deletes the specified Certificate.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/managedEnvironments/{environmentName}/certificates/{certificateName}")
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
       * Name of the Managed Environment.
       */
      @path
      environmentName: string;

      /**
       * Name of the Certificate.
       */
      @path
      certificateName: string;
    },
    void
  >;

  /**
   * Patches a certificate. Currently only patching of tags is supported
   */
  @summary("Update properties of a certificate")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/managedEnvironments/{environmentName}/certificates/{certificateName}")
  @patch
  update is Azure.Core.Foundations.Operation<
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
       * Name of the Managed Environment.
       */
      @path
      environmentName: string;

      /**
       * Name of the Certificate.
       */
      @path
      certificateName: string;

      /**
       * Properties of a certificate that need to be updated
       */
      @body
      certificateEnvelope: CertificatePatch;
    },
    Certificate
  >;
}

interface NamespacesOperations {
  /**
   * Checks if resource name is available.
   */
  @summary("Checks the resource name availability.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/managedEnvironments/{environmentName}/checkNameAvailability")
  @post
  checkNameAvailability is Azure.Core.Foundations.Operation<
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
       * Name of the Managed Environment.
       */
      @path
      environmentName: string;

      /**
       * The check name availability request.
       */
      @body
      checkNameAvailabilityRequest: CheckNameAvailabilityRequest;
    },
    CheckNameAvailabilityResponse
  >;
}

interface DaprComponentsOperations {
  /**
   * Get the Dapr Components for a managed environment.
   */
  @summary("Get the Dapr Components for a managed environment.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/managedEnvironments/{environmentName}/daprComponents")
  @get
  list is Azure.Core.Foundations.Operation<
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
       * Name of the Managed Environment.
       */
      @path
      environmentName: string;
    },
    ResourceListResult<DaprComponent>
  >;

  /**
   * Get a dapr component.
   */
  @summary("Get a dapr component.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/managedEnvironments/{environmentName}/daprComponents/{componentName}")
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
       * Name of the Managed Environment.
       */
      @path
      environmentName: string;

      /**
       * Name of the Dapr Component.
       */
      @path
      componentName: string;
    },
    DaprComponent
  >;

  /**
   * Creates or updates a Dapr Component in a Managed Environment.
   */
  @summary("Creates or updates a Dapr Component.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/managedEnvironments/{environmentName}/daprComponents/{componentName}")
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
       * Name of the Managed Environment.
       */
      @path
      environmentName: string;

      /**
       * Name of the Dapr Component.
       */
      @path
      componentName: string;

      /**
       * Configuration details of the Dapr Component.
       */
      @body
      daprComponentEnvelope: DaprComponent;
    },
    DaprComponent
  >;

  /**
   * Delete a Dapr Component from a Managed Environment.
   */
  @summary("Delete a Dapr Component.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/managedEnvironments/{environmentName}/daprComponents/{componentName}")
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
       * Name of the Managed Environment.
       */
      @path
      environmentName: string;

      /**
       * Name of the Dapr Component.
       */
      @path
      componentName: string;
    },
    void
  >;

  /**
   * List secrets for a dapr component
   */
  @summary("List secrets for a dapr component")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/managedEnvironments/{environmentName}/daprComponents/{componentName}/listSecrets")
  @post
  listSecrets is Azure.Core.Foundations.Operation<
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
       * Name of the Managed Environment.
       */
      @path
      environmentName: string;

      /**
       * Name of the Dapr Component.
       */
      @path
      componentName: string;
    },
    DaprSecretsCollection
  >;
}
