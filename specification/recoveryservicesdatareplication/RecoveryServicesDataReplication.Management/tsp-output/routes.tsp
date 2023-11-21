import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace AzureSiteRecoveryManagementServiceAPI;

interface DraOperations {
  @summary("Gets the fabric agent (Dra).")
  @doc("Gets the details of the fabric agent.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataReplication/replicationFabrics/{fabricName}/fabricAgents/{fabricAgentName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The fabric name.")
      @path
      fabricName: string;

      @doc("The fabric agent (Dra) name.")
      @path
      fabricAgentName: string;
    },
    DraModel
  >;

  @summary("Puts the fabric agent (Dra).")
  @doc("Creates the fabric agent.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataReplication/replicationFabrics/{fabricName}/fabricAgents/{fabricAgentName}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The fabric name.")
      @path
      fabricName: string;

      @doc("The fabric agent (Dra) name.")
      @path
      fabricAgentName: string;

      @doc("Dra model.")
      @body
      body: DraModel;
    },
    DraModel
  >;

  @summary("Deletes the fabric agent (Dra).")
  @doc("Deletes the fabric agent.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataReplication/replicationFabrics/{fabricName}/fabricAgents/{fabricAgentName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The fabric name.")
      @path
      fabricName: string;

      @doc("The fabric agent (Dra) name.")
      @path
      fabricAgentName: string;
    },
    void
  >;

  @summary("Lists the fabric agents (Dras).")
  @doc("Gets the list of fabric agents in the given fabric.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataReplication/replicationFabrics/{fabricName}/fabricAgents")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The fabric name.")
      @path
      fabricName: string;
    },
    DraModelCollection
  >;
}

interface DraOperationStatusOperations {
  @summary("Gets the fabric agent (Dra) operation status.")
  @doc("Tracks the results of an asynchronous operation on the fabric agent.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataReplication/replicationFabrics/{fabricName}/fabricAgents/{fabricAgentName}/operations/{operationId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The fabric name.")
      @path
      fabricName: string;

      @doc("The fabric agent (Dra) name.")
      @path
      fabricAgentName: string;

      @doc("The ID of an ongoing async operation.")
      @path
      operationId: string;
    },
    OperationStatus
  >;
}

interface EmailConfigurationOperations {
  @summary("Gets the email configuration setting.")
  @doc("Gets the details of the alert configuration setting.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataReplication/replicationVaults/{vaultName}/alertSettings/{emailConfigurationName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The vault name.")
      @path
      vaultName: string;

      @doc("The email configuration name.")
      @path
      emailConfigurationName: string;
    },
    EmailConfigurationModel
  >;

  @summary("Creates email configuration settings.")
  @doc("Creates an alert configuration setting for the given vault.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataReplication/replicationVaults/{vaultName}/alertSettings/{emailConfigurationName}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The vault name.")
      @path
      vaultName: string;

      @doc("The email configuration name.")
      @path
      emailConfigurationName: string;

      @doc("EmailConfiguration model.")
      @body
      body: EmailConfigurationModel;
    },
    EmailConfigurationModel
  >;

  @summary("Lists the email configuration settings.")
  @doc("Gets the list of alert configuration settings for the given vault.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataReplication/replicationVaults/{vaultName}/alertSettings")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The vault name.")
      @path
      vaultName: string;
    },
    EmailConfigurationModelCollection
  >;
}

interface EventOperations {
  @summary("Gets the event.")
  @doc("Gets the details of the event.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataReplication/replicationVaults/{vaultName}/events/{eventName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The vault name.")
      @path
      vaultName: string;

      @doc("The event name.")
      @path
      eventName: string;
    },
    EventModel
  >;

  @summary("Lists the events.")
  @doc("Gets the list of events in the given vault.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataReplication/replicationVaults/{vaultName}/events")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The vault name.")
      @path
      vaultName: string;

      @doc("Filter string.")
      @query
      $filter: string;

      @doc("Continuation token.")
      @query
      continuationToken: string;
    },
    EventModelCollection
  >;
}

interface FabricOperations {
  @summary("Gets the fabric.")
  @doc("Gets the details of the fabric.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataReplication/replicationFabrics/{fabricName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The fabric name.")
      @path
      fabricName: string;
    },
    FabricModel
  >;

  @summary("Puts the fabric.")
  @doc("Creates the fabric.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataReplication/replicationFabrics/{fabricName}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The fabric name.")
      @path
      fabricName: string;

      @doc("Fabric properties.")
      @body
      body: FabricModel;
    },
    FabricModel
  >;

  @summary("Updates the fabric.")
  @doc("Performs update on the fabric.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataReplication/replicationFabrics/{fabricName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The fabric name.")
      @path
      fabricName: string;

      @doc("Fabric properties.")
      @body
      body: FabricModelUpdate;
    },
    FabricModel | void
  >;

  @summary("Deletes the fabric.")
  @doc("Removes the fabric.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataReplication/replicationFabrics/{fabricName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The fabric name.")
      @path
      fabricName: string;
    },
    void
  >;

  @summary("Lists the fabrics.")
  @doc("Gets the list of fabrics in the given subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.DataReplication/replicationFabrics")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("Continuation token from the previous call.")
      @query
      continuationToken: string;
    },
    FabricModelCollection
  >;

  @summary("Lists the fabrics.")
  @doc("Gets the list of fabrics in the given subscription and resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataReplication/replicationFabrics")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Continuation token from the previous call.")
      @query
      continuationToken: string;
    },
    FabricModelCollection
  >;
}

interface FabricOperationsStatusOperations {
  @summary("Gets the fabric operation status.")
  @doc("Tracks the results of an asynchronous operation on the fabric.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataReplication/replicationFabrics/{fabricName}/operations/{operationId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The fabric name.")
      @path
      fabricName: string;

      @doc("The ID of an ongoing async operation.")
      @path
      operationId: string;
    },
    OperationStatus
  >;
}

interface PolicyOperations {
  @summary("Gets the policy.")
  @doc("Gets the details of the policy.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataReplication/replicationVaults/{vaultName}/replicationPolicies/{policyName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The vault name.")
      @path
      vaultName: string;

      @doc("The policy name.")
      @path
      policyName: string;
    },
    PolicyModel
  >;

  @summary("Puts the policy.")
  @doc("Creates the policy.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataReplication/replicationVaults/{vaultName}/replicationPolicies/{policyName}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The vault name.")
      @path
      vaultName: string;

      @doc("The policy name.")
      @path
      policyName: string;

      @doc("Policy model.")
      @body
      body: PolicyModel;
    },
    PolicyModel
  >;

  @summary("Deletes the policy.")
  @doc("Removes the policy.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataReplication/replicationVaults/{vaultName}/replicationPolicies/{policyName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The vault name.")
      @path
      vaultName: string;

      @doc("The policy name.")
      @path
      policyName: string;
    },
    void
  >;

  @summary("Lists the policies.")
  @doc("Gets the list of policies in the given vault.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataReplication/replicationVaults/{vaultName}/replicationPolicies")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The vault name.")
      @path
      vaultName: string;
    },
    PolicyModelCollection
  >;
}

interface PolicyOperationStatusOperations {
  @summary("Gets the policy operation status.")
  @doc("Tracks the results of an asynchronous operation on the policy.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataReplication/replicationVaults/{vaultName}/replicationPolicies/{policyName}/operations/{operationId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The vault name.")
      @path
      vaultName: string;

      @doc("The policy name.")
      @path
      policyName: string;

      @doc("The ID of an ongoing async operation.")
      @path
      operationId: string;
    },
    OperationStatus
  >;
}

interface ProtectedItemOperations {
  @summary("Gets the protected item.")
  @doc("Gets the details of the protected item.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataReplication/replicationVaults/{vaultName}/protectedItems/{protectedItemName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The vault name.")
      @path
      vaultName: string;

      @doc("The protected item name.")
      @path
      protectedItemName: string;
    },
    ProtectedItemModel
  >;

  @summary("Puts the protected item.")
  @doc("Creates the protected item.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataReplication/replicationVaults/{vaultName}/protectedItems/{protectedItemName}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The vault name.")
      @path
      vaultName: string;

      @doc("The protected item name.")
      @path
      protectedItemName: string;

      @doc("Protected item model.")
      @body
      body: ProtectedItemModel;
    },
    ProtectedItemModel
  >;

  @summary("Deletes the protected item.")
  @doc("Removes the protected item.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataReplication/replicationVaults/{vaultName}/protectedItems/{protectedItemName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The vault name.")
      @path
      vaultName: string;

      @doc("The protected item name.")
      @path
      protectedItemName: string;

      @doc("A flag indicating whether to do force delete or not.")
      @query
      forceDelete: boolean;
    },
    void
  >;

  @summary("Lists the protected items.")
  @doc("Gets the list of protected items in the given vault.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataReplication/replicationVaults/{vaultName}/protectedItems")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The vault name.")
      @path
      vaultName: string;
    },
    ProtectedItemModelCollection
  >;

  @summary("Performs planned failover.")
  @doc("Performs the planned failover on the protected item.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataReplication/replicationVaults/{vaultName}/protectedItems/{protectedItemName}/plannedFailover")
  @post
  PlannedFailover is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The vault name.")
      @path
      vaultName: string;

      @doc("The protected item name.")
      @path
      protectedItemName: string;

      @doc("Planned failover model.")
      @body
      body: PlannedFailoverModel;
    },
    PlannedFailoverModel | void
  >;
}

interface ProtectedItemOperationStatusOperations {
  @summary("Gets the protected item operation status.")
  @doc("Tracks the results of an asynchronous operation on the protected item.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataReplication/replicationVaults/{vaultName}/protectedItems/{protectedItemName}/operations/{operationId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The vault name.")
      @path
      vaultName: string;

      @doc("The protected item name.")
      @path
      protectedItemName: string;

      @doc("The ID of an ongoing async operation.")
      @path
      operationId: string;
    },
    OperationStatus
  >;
}

interface RecoveryPointsOperations {
  @summary("Gets the recovery point.")
  @doc("Gets the details of the recovery point of a protected item.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataReplication/replicationVaults/{vaultName}/protectedItems/{protectedItemName}/recoveryPoints/{recoveryPointName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The vault name.")
      @path
      vaultName: string;

      @doc("The protected item name.")
      @path
      protectedItemName: string;

      @doc("The recovery point name.")
      @path
      recoveryPointName: string;
    },
    RecoveryPointModel
  >;

  @summary("Lists the recovery points.")
  @doc("Gets the list of recovery points of the given protected item.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataReplication/replicationVaults/{vaultName}/protectedItems/{protectedItemName}/recoveryPoints")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The vault name.")
      @path
      vaultName: string;

      @doc("The protected item name.")
      @path
      protectedItemName: string;
    },
    RecoveryPointModelCollection
  >;
}

interface ReplicationExtensionOperations {
  @summary("Gets the replication extension.")
  @doc("Gets the details of the replication extension.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataReplication/replicationVaults/{vaultName}/replicationExtensions/{replicationExtensionName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The vault name.")
      @path
      vaultName: string;

      @doc("The replication extension name.")
      @path
      replicationExtensionName: string;
    },
    ReplicationExtensionModel
  >;

  @summary("Puts the replication extension.")
  @doc("Creates the replication extension in the given vault.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataReplication/replicationVaults/{vaultName}/replicationExtensions/{replicationExtensionName}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The vault name.")
      @path
      vaultName: string;

      @doc("The replication extension name.")
      @path
      replicationExtensionName: string;

      @doc("Replication extension model.")
      @body
      body: ReplicationExtensionModel;
    },
    ReplicationExtensionModel
  >;

  @summary("Deletes the replication extension.")
  @doc("Deletes the replication extension in the given vault.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataReplication/replicationVaults/{vaultName}/replicationExtensions/{replicationExtensionName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The vault name.")
      @path
      vaultName: string;

      @doc("The replication extension name.")
      @path
      replicationExtensionName: string;
    },
    void
  >;

  @summary("Lists the replication extensions.")
  @doc("Gets the list of replication extensions in the given vault.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataReplication/replicationVaults/{vaultName}/replicationExtensions")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The vault name.")
      @path
      vaultName: string;
    },
    ReplicationExtensionModelCollection
  >;
}

interface ReplicationExtensionOperationStatusOperations {
  @summary("Gets the replication extension operation status.")
  @doc("Tracks the results of an asynchronous operation on the replication extension.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataReplication/replicationVaults/{vaultName}/replicationExtensions/{replicationExtensionName}/operations/{operationId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The vault name.")
      @path
      vaultName: string;

      @doc("The replication extension name.")
      @path
      replicationExtensionName: string;

      @doc("The ID of an ongoing async operation.")
      @path
      operationId: string;
    },
    OperationStatus
  >;
}

@summary("Performs the resource name availability check.")
@doc("Checks the resource name availability.")
@route("/subscriptions/{subscriptionId}/providers/Microsoft.DataReplication/locations/{location}/checkNameAvailability")
@post
op CheckNameAvailability is Azure.Core.Foundations.Operation<
  {
    @doc("The ID of the target subscription. The value must be an UUID.")
    @path
    subscriptionId: string;

    @doc("The name of the Azure region.")
    @path
    location: string;

    @doc("Resource details.")
    @body
    body: CheckNameAvailabilityModel;
  },
  CheckNameAvailabilityResponseModel
>;

@summary("Performs resource deployment validation.")
@doc("Performs resource deployment validation.")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataReplication/deployments/{deploymentId}/preflight")
@post
op DeploymentPreflight is Azure.Core.Foundations.Operation<
  {
    @doc("The ID of the target subscription. The value must be an UUID.")
    @path
    subscriptionId: string;

    @doc("The name of the resource group. The name is case insensitive.")
    @path
    resourceGroupName: string;

    @doc("Deployment Id.")
    @path
    deploymentId: string;

    @doc("Deployment preflight model.")
    @body
    body: DeploymentPreflightModel;
  },
  DeploymentPreflightModel
>;

interface OperationsOperations {
  @summary("Get a list of REST API operations supported by Microsoft.DataReplication.")
  @doc("Gets the operations.")
  @route("/providers/Microsoft.DataReplication/operations")
  @get
  List is Azure.Core.Foundations.Operation<{}, OperationListResult>;
}

interface VaultOperations {
  @summary("Gets the vault.")
  @doc("Gets the details of the vault.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataReplication/replicationVaults/{vaultName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The vault name.")
      @path
      vaultName: string;
    },
    VaultModel
  >;

  @summary("Puts the vault.")
  @doc("Creates the vault.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataReplication/replicationVaults/{vaultName}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The vault name.")
      @path
      vaultName: string;

      @doc("Vault properties.")
      @body
      body: VaultModel;
    },
    VaultModel
  >;

  @summary("Updates the vault.")
  @doc("Performs update on the vault.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataReplication/replicationVaults/{vaultName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The vault name.")
      @path
      vaultName: string;

      @doc("Vault properties.")
      @body
      body: VaultModelUpdate;
    },
    VaultModel | void
  >;

  @summary("Deletes the vault.")
  @doc("Removes the vault.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataReplication/replicationVaults/{vaultName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The vault name.")
      @path
      vaultName: string;
    },
    void
  >;

  @summary("Lists the vaults.")
  @doc("Gets the list of vaults in the given subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.DataReplication/replicationVaults")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("Continuation token from the previous call.")
      @query
      continuationToken: string;
    },
    VaultModelCollection
  >;

  @summary("Lists the vaults.")
  @doc("Gets the list of vaults in the given subscription and resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataReplication/replicationVaults")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Continuation token from the previous call.")
      @query
      continuationToken: string;
    },
    VaultModelCollection
  >;
}

interface VaultOperationStatusOperations {
  @summary("Gets the vault operation status.")
  @doc("Tracks the results of an asynchronous operation on the vault.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataReplication/replicationVaults/{vaultName}/operations/{operationId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The vault name.")
      @path
      vaultName: string;

      @doc("The ID of an ongoing async operation.")
      @path
      operationId: string;
    },
    OperationStatus
  >;
}

interface WorkflowOperations {
  @summary("Gets the job (workflow).")
  @doc("Gets the details of the job.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataReplication/replicationVaults/{vaultName}/jobs/{jobName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The vault name.")
      @path
      vaultName: string;

      @doc("The job (workflow) name.")
      @path
      jobName: string;
    },
    WorkflowModel
  >;

  @summary("Lists the jobs (workflows).")
  @doc("Gets the list of jobs in the given vault.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataReplication/replicationVaults/{vaultName}/jobs")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The vault name.")
      @path
      vaultName: string;

      @doc("Filter string.")
      @query
      $filter: string;

      @doc("Continuation token.")
      @query
      continuationToken: string;
    },
    WorkflowModelCollection
  >;
}

interface WorkflowOperationStatusOperations {
  @summary("Gets the job (workflow) operation status.")
  @doc("Tracks the results of an asynchronous operation on the job.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataReplication/replicationVaults/{vaultName}/jobs/{jobName}/operations/{operationId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The vault name.")
      @path
      vaultName: string;

      @doc("The job (workflow) name.")
      @path
      jobName: string;

      @doc("The ID of an ongoing async operation.")
      @path
      operationId: string;
    },
    OperationStatus
  >;
}
