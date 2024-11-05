import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

#suppress "@azure-tools/typespec-azure-core/casing-style" "SplitIO is a case-sensitive name"
namespace SplitIO {

}

@armProviderNamespace
@service({
  title: "Split.IO Experimentation",
})
@versioned(SplitIO.Experimentation.Versions)
namespace SplitIO.Experimentation {
  @doc("Supported API versions for the SplitIO.Experimentation resource provider.")
  enum Versions {
    @doc("Dependent on Azure.ResourceManager.Versions.v1_0_Preview_1")
    @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
    @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
    v1_preview: "2024-03-01-preview",
  }

  interface Operations extends Azure.ResourceManager.Operations {}

  @doc("Properties of the experimentation workspace")
  model ExperimentationWorkspaceProperties {
    @doc("Provisioning state of the resource.")
    @visibility("read")
    provisioningState?: ExperimentationWorkspaceProvisioningState;

    @doc("Access policy for an experimentation workspace.")
    accessPolicy: AccessPolicy;

    @doc("Data source that telemetry data required for experimentation will be retrieved from.")
    dataSource?: DataSource;
  }

  @doc("The experimentation workspace resource provisioning state")
  union ExperimentationWorkspaceProvisioningState {
    string,
    ResourceProvisioningState,

    @doc("Accepted provisioning state.")
    Accepted: "Accepted",

    @doc("Created provisioning state.")
    Created: "Created",

    @doc("Deleting provisioning state.")
    Deleting: "Deleting",
  }

  @doc("Access policy for an experimentation workspace.")
  model AccessPolicy {
    @doc("Application id used for access to the experimentation workspace.")
    applicationId: string;

    @doc("Endpoint used for access to the experimentation workspace.")
    @visibility("read")
    dataPlaneEndpoint?: string;
  }

  @doc("Data source that telemetry data required for experimentation will be retrieved from.")
  model DataSource {
    @doc("Log Analytics data source.")
    logAnalytics?: LogAnalytics;
  }

  scalar LogAnalyticsWorkspaceResourceId
    extends Azure.Core.armResourceIdentifier<[
      {
        type: "Microsoft.OperationalInsights/workspaces",
      }
    ]>;

  scalar StorageAccountResourceId
    extends Azure.Core.armResourceIdentifier<[
      {
        type: "Microsoft.Storage/storageAccounts",
      }
    ]>;

  @doc("The Log Analytics workspace which telemetry data required for experimentation will be retrieved from.")
  model LogAnalytics {
    @doc("Resource id of the Log Analytics workspace.")
    resourceId: LogAnalyticsWorkspaceResourceId;

    @doc("Resource id of the storage account associated with the Log Analytics workspace.")
    storageAccountResourceId: StorageAccountResourceId;

    @doc("Controls whether data flow from the configured Log Analytics workspace into the experimentation workspace is enabled.")
    enabled: boolean;
  }

  @doc("A ExperimentationWorkspace Resource by Split.IO")
  model ExperimentationWorkspace
    is TrackedResource<ExperimentationWorkspaceProperties> {
    @key("workspaceName")
    @segment("experimentationWorkspaces")
    @pattern("^[a-zA-Z0-9](?!.*--)[a-zA-Z0-9-]*[a-zA-Z0-9]$")
    @minLength(5)
    @maxLength(50)
    @doc("The name of the ExperimentationWorkspace resource")
    @path
    name: string;

    ...ResourceSkuProperty;
    ...ManagedServiceIdentityProperty;
  }

  @armResourceOperations
  interface ExperimentationWorkspaces {
    get is ArmResourceRead<ExperimentationWorkspace>;
    #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
    @Azure.Core.useFinalStateVia("azure-async-operation")
    create is ArmResourceCreateOrUpdateAsync<
      ExperimentationWorkspace,
      LroHeaders = Azure.Core.Foundations.RetryAfterHeader
    >;
    update is ArmCustomPatchAsync<
      ExperimentationWorkspace,
      Azure.ResourceManager.Foundations.ResourceUpdateModel<
        ExperimentationWorkspace,
        ExperimentationWorkspaceProperties
      >
    >;
    delete is ArmResourceDeleteWithoutOkAsync<ExperimentationWorkspace>;
    listByResourceGroup is ArmResourceListByParent<ExperimentationWorkspace>;
    listBySubscription is ArmListBySubscription<ExperimentationWorkspace>;
  }

  @doc("The exchange token parameters for exchanging Split.IO data plane authentication token.")
  model ExchangeTokenParameters {
    @doc("The bearer token that is used for exchanging Split.IO data plane authentication token.")
    @secret
    token: string;

    @doc("The resource of Split.IO data plane authentication token.")
    resource: string;
  }

  @doc("The exchange token result that contains the bearer token which is used for Split.IO data plane authentication.")
  model ExchangeTokenResult {
    @doc("The bearer token that is used for Split.IO data plane authentication.")
    @visibility("read")
    @secret
    token: string;
  }

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Need to remove autoroute"
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/SplitIO.Experimentation/experimentationWorkspaces/{workspaceName}/dataPlaneApplications/{applicationId}")
  interface DataPlaneApplications {
    #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "Need to remove autoroute"
    @doc("The action to exchange Split.IO data plane authentication token.")
    @route("exchangeToken")
    @post
    @action
    exchangeToken(
      ...ApiVersionParameter,
      ...SubscriptionIdParameter,
      ...ResourceGroupParameter,

      @doc("The name of the ExperimentationWorkspace resource.")
      @path
      @pattern("^[a-zA-Z0-9](?!.*--)[a-zA-Z0-9-]*[a-zA-Z0-9]$")
      @minLength(5)
      @maxLength(50)
      workspaceName: string,

      @doc("The id of the Split.IO data plane authentication application.")
      @path
      applicationId: string,

      @doc("The parameter of exchange token action.")
      @body
      exchangeTokenParameters: ExchangeTokenParameters,
    ): ExchangeTokenResult | ErrorResponse;
  }
}
