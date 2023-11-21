import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace ChaosManagementClient;

interface CapabilitiesOperations {
  @doc("Get a list of Capability resources that extend a Target resource..")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{parentProviderNamespace}/{parentResourceType}/{parentResourceName}/providers/Microsoft.Chaos/targets/{targetName}/capabilities")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("GUID that represents an Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("String that represents an Azure resource group.")
      @path
      resourceGroupName: string;

      @doc("String that represents a resource provider namespace.")
      @path
      parentProviderNamespace: string;

      @doc("String that represents a resource type.")
      @path
      parentResourceType: string;

      @doc("String that represents a resource name.")
      @path
      parentResourceName: string;

      @doc("String that represents a Target resource name.")
      @path
      targetName: string;

      @doc("String that sets the continuation token.")
      @query
      continuationToken: string;
    },
    CapabilityListResult
  >;

  @doc("Get a Capability resource that extends a Target resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{parentProviderNamespace}/{parentResourceType}/{parentResourceName}/providers/Microsoft.Chaos/targets/{targetName}/capabilities/{capabilityName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("GUID that represents an Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("String that represents an Azure resource group.")
      @path
      resourceGroupName: string;

      @doc("String that represents a resource provider namespace.")
      @path
      parentProviderNamespace: string;

      @doc("String that represents a resource type.")
      @path
      parentResourceType: string;

      @doc("String that represents a resource name.")
      @path
      parentResourceName: string;

      @doc("String that represents a Target resource name.")
      @path
      targetName: string;

      @doc("String that represents a Capability resource name.")
      @path
      capabilityName: string;
    },
    Capability
  >;

  @doc("Delete a Capability that extends a Target resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{parentProviderNamespace}/{parentResourceType}/{parentResourceName}/providers/Microsoft.Chaos/targets/{targetName}/capabilities/{capabilityName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("GUID that represents an Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("String that represents an Azure resource group.")
      @path
      resourceGroupName: string;

      @doc("String that represents a resource provider namespace.")
      @path
      parentProviderNamespace: string;

      @doc("String that represents a resource type.")
      @path
      parentResourceType: string;

      @doc("String that represents a resource name.")
      @path
      parentResourceName: string;

      @doc("String that represents a Target resource name.")
      @path
      targetName: string;

      @doc("String that represents a Capability resource name.")
      @path
      capabilityName: string;
    },
    void
  >;

  @doc("Create or update a Capability resource that extends a Target resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{parentProviderNamespace}/{parentResourceType}/{parentResourceName}/providers/Microsoft.Chaos/targets/{targetName}/capabilities/{capabilityName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("GUID that represents an Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("String that represents an Azure resource group.")
      @path
      resourceGroupName: string;

      @doc("String that represents a resource provider namespace.")
      @path
      parentProviderNamespace: string;

      @doc("String that represents a resource type.")
      @path
      parentResourceType: string;

      @doc("String that represents a resource name.")
      @path
      parentResourceName: string;

      @doc("String that represents a Target resource name.")
      @path
      targetName: string;

      @doc("String that represents a Capability resource name.")
      @path
      capabilityName: string;

      @doc("Capability resource to be created or updated.")
      @body
      capability: Capability;
    },
    Capability
  >;
}

interface CapabilityTypesOperations {
  @doc("Get a list of Capability Type resources for given Target Type and location.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Chaos/locations/{locationName}/targetTypes/{targetTypeName}/capabilityTypes")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("GUID that represents an Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("String that represents a Location resource name.")
      @path
      locationName: string;

      @doc("String that represents a Target Type resource name.")
      @path
      targetTypeName: string;

      @doc("String that sets the continuation token.")
      @query
      continuationToken: string;
    },
    CapabilityTypeListResult
  >;

  @doc("Get a Capability Type resource for given Target Type and location.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Chaos/locations/{locationName}/targetTypes/{targetTypeName}/capabilityTypes/{capabilityTypeName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("GUID that represents an Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("String that represents a Location resource name.")
      @path
      locationName: string;

      @doc("String that represents a Target Type resource name.")
      @path
      targetTypeName: string;

      @doc("String that represents a Capability Type resource name.")
      @path
      capabilityTypeName: string;
    },
    CapabilityType
  >;
}

interface ExperimentsOperations {
  @doc("Get a list of Experiment resources in a subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Chaos/experiments")
  @get
  ListAll is Azure.Core.Foundations.Operation<
    {
      @doc("GUID that represents an Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("""
Optional value that indicates whether to filter results based on if the
Experiment is currently running. If null, then the results will not be
filtered.
""")
      @query
      running: boolean;

      @doc("String that sets the continuation token.")
      @query
      continuationToken: string;
    },
    ExperimentListResult
  >;

  @doc("Get a list of Experiment resources in a resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Chaos/experiments")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("GUID that represents an Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("String that represents an Azure resource group.")
      @path
      resourceGroupName: string;

      @doc("""
Optional value that indicates whether to filter results based on if the
Experiment is currently running. If null, then the results will not be
filtered.
""")
      @query
      running: boolean;

      @doc("String that sets the continuation token.")
      @query
      continuationToken: string;
    },
    ExperimentListResult
  >;

  @doc("Delete a Experiment resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Chaos/experiments/{experimentName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("GUID that represents an Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("String that represents an Azure resource group.")
      @path
      resourceGroupName: string;

      @doc("String that represents a Experiment resource name.")
      @path
      experimentName: string;
    },
    void
  >;

  @doc("Get a Experiment resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Chaos/experiments/{experimentName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("GUID that represents an Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("String that represents an Azure resource group.")
      @path
      resourceGroupName: string;

      @doc("String that represents a Experiment resource name.")
      @path
      experimentName: string;
    },
    Experiment
  >;

  @doc("Create or update a Experiment resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Chaos/experiments/{experimentName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("GUID that represents an Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("String that represents an Azure resource group.")
      @path
      resourceGroupName: string;

      @doc("String that represents a Experiment resource name.")
      @path
      experimentName: string;

      @doc("Experiment resource to be created or updated.")
      @body
      experiment: Experiment;
    },
    Experiment
  >;

  @doc("The operation to update an experiment.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Chaos/experiments/{experimentName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("GUID that represents an Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("String that represents an Azure resource group.")
      @path
      resourceGroupName: string;

      @doc("String that represents a Experiment resource name.")
      @path
      experimentName: string;

      @doc("Parameters supplied to the Update experiment operation.")
      @body
      experiment: ExperimentUpdate;
    },
    Experiment
  >;

  @doc("Cancel a running Experiment resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Chaos/experiments/{experimentName}/cancel")
  @post
  Cancel is Azure.Core.Foundations.Operation<
    {
      @doc("GUID that represents an Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("String that represents an Azure resource group.")
      @path
      resourceGroupName: string;

      @doc("String that represents a Experiment resource name.")
      @path
      experimentName: string;
    },
    ExperimentCancelOperationResult
  >;

  @doc("Start a Experiment resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Chaos/experiments/{experimentName}/start")
  @post
  Start is Azure.Core.Foundations.Operation<
    {
      @doc("GUID that represents an Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("String that represents an Azure resource group.")
      @path
      resourceGroupName: string;

      @doc("String that represents a Experiment resource name.")
      @path
      experimentName: string;
    },
    ExperimentStartOperationResult
  >;

  @doc("Get a list of statuses of a Experiment resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Chaos/experiments/{experimentName}/statuses")
  @get
  ListAllStatuses is Azure.Core.Foundations.Operation<
    {
      @doc("GUID that represents an Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("String that represents an Azure resource group.")
      @path
      resourceGroupName: string;

      @doc("String that represents a Experiment resource name.")
      @path
      experimentName: string;
    },
    ExperimentStatusListResult
  >;

  @doc("Get a status of a Experiment resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Chaos/experiments/{experimentName}/statuses/{statusId}")
  @get
  GetStatus is Azure.Core.Foundations.Operation<
    {
      @doc("GUID that represents an Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("String that represents an Azure resource group.")
      @path
      resourceGroupName: string;

      @doc("String that represents a Experiment resource name.")
      @path
      experimentName: string;

      @doc("GUID that represents a Experiment status.")
      @path
      statusId: string;
    },
    ExperimentStatus
  >;

  @doc("Get a list of execution details of a Experiment resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Chaos/experiments/{experimentName}/executionDetails")
  @get
  ListExecutionDetails is Azure.Core.Foundations.Operation<
    {
      @doc("GUID that represents an Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("String that represents an Azure resource group.")
      @path
      resourceGroupName: string;

      @doc("String that represents a Experiment resource name.")
      @path
      experimentName: string;
    },
    ExperimentExecutionDetailsListResult
  >;

  @doc("Get an execution detail of a Experiment resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Chaos/experiments/{experimentName}/executionDetails/{executionDetailsId}")
  @get
  GetExecutionDetails is Azure.Core.Foundations.Operation<
    {
      @doc("GUID that represents an Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("String that represents an Azure resource group.")
      @path
      resourceGroupName: string;

      @doc("String that represents a Experiment resource name.")
      @path
      experimentName: string;

      @doc("GUID that represents a Experiment execution detail.")
      @path
      executionDetailsId: string;
    },
    ExperimentExecutionDetails
  >;
}

interface OperationsOperations {
  @doc("Get a list all available Operations.")
  @route("/providers/Microsoft.Chaos/operations")
  @get
  ListAll is Azure.Core.Foundations.Operation<{}, OperationListResult>;
}

interface TargetTypesOperations {
  @doc("Get a list of Target Type resources for given location.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Chaos/locations/{locationName}/targetTypes")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("GUID that represents an Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("String that represents a Location resource name.")
      @path
      locationName: string;

      @doc("String that sets the continuation token.")
      @query
      continuationToken: string;
    },
    TargetTypeListResult
  >;

  @doc("Get a Target Type resources for given location.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Chaos/locations/{locationName}/targetTypes/{targetTypeName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("GUID that represents an Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("String that represents a Location resource name.")
      @path
      locationName: string;

      @doc("String that represents a Target Type resource name.")
      @path
      targetTypeName: string;
    },
    TargetType
  >;
}

interface TargetsOperations {
  @doc("Get a list of Target resources that extend a tracked regional resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{parentProviderNamespace}/{parentResourceType}/{parentResourceName}/providers/Microsoft.Chaos/targets")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("GUID that represents an Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("String that represents an Azure resource group.")
      @path
      resourceGroupName: string;

      @doc("String that represents a resource provider namespace.")
      @path
      parentProviderNamespace: string;

      @doc("String that represents a resource type.")
      @path
      parentResourceType: string;

      @doc("String that represents a resource name.")
      @path
      parentResourceName: string;

      @doc("String that sets the continuation token.")
      @query
      continuationToken: string;
    },
    TargetListResult
  >;

  @doc("Get a Target resource that extends a tracked regional resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{parentProviderNamespace}/{parentResourceType}/{parentResourceName}/providers/Microsoft.Chaos/targets/{targetName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("GUID that represents an Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("String that represents an Azure resource group.")
      @path
      resourceGroupName: string;

      @doc("String that represents a resource provider namespace.")
      @path
      parentProviderNamespace: string;

      @doc("String that represents a resource type.")
      @path
      parentResourceType: string;

      @doc("String that represents a resource name.")
      @path
      parentResourceName: string;

      @doc("String that represents a Target resource name.")
      @path
      targetName: string;
    },
    Target
  >;

  @doc("Delete a Target resource that extends a tracked regional resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{parentProviderNamespace}/{parentResourceType}/{parentResourceName}/providers/Microsoft.Chaos/targets/{targetName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("GUID that represents an Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("String that represents an Azure resource group.")
      @path
      resourceGroupName: string;

      @doc("String that represents a resource provider namespace.")
      @path
      parentProviderNamespace: string;

      @doc("String that represents a resource type.")
      @path
      parentResourceType: string;

      @doc("String that represents a resource name.")
      @path
      parentResourceName: string;

      @doc("String that represents a Target resource name.")
      @path
      targetName: string;
    },
    void
  >;

  @doc("Create or update a Target resource that extends a tracked regional resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{parentProviderNamespace}/{parentResourceType}/{parentResourceName}/providers/Microsoft.Chaos/targets/{targetName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("GUID that represents an Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("String that represents an Azure resource group.")
      @path
      resourceGroupName: string;

      @doc("String that represents a resource provider namespace.")
      @path
      parentProviderNamespace: string;

      @doc("String that represents a resource type.")
      @path
      parentResourceType: string;

      @doc("String that represents a resource name.")
      @path
      parentResourceName: string;

      @doc("String that represents a Target resource name.")
      @path
      targetName: string;

      @doc("Target resource to be created or updated.")
      @body
      target: Target;
    },
    Target
  >;
}
