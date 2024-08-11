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
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace SplitIO.Experimentation {
  @doc("Supported API versions for the SplitIO.Experimentation resource provider.")
  enum Versions {
    @doc("2024-07-01-preview api version")
    @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
    v24_07_preview: "2024-07-01-preview",
  }

  interface Operations extends Azure.ResourceManager.Operations {}

  @doc("Properties of the experimentation workspace")
  model ExperimentationWorkspaceProperties {
    @doc("Provisioning state of the resource.")
    @visibility("read")
    provisioningState?: ResourceProvisioningState;

    @doc("Access policy for an experimentation workspace.")
    accessPolicy: AccessPolicy;

    @doc("Data source that telemetry data required for experimentation will be retrieved from.")
    dataSource?: DataSource;
  }

  @doc("Access policy for an experimentation workspace.")
  model AccessPolicy {
    @doc("Application id used for access to the experimentation workspace.")
    applicationId: string;

    @added(Versions.v24_07_preview)
    @doc("A default role given to a user calling the Split.IO data plane when the user has no assigned role.")
    defaultRole?: DataPlaneRole;

    @doc("Endpoint used for access to the experimentation workspace.")
    @visibility("read")
    dataPlaneEndpoint?: url;
  }

  @doc("Role required for data plane access.")
  union DataPlaneRole {
    /** None data plane role is assigned to user by default. */
    None: "None",

    /** ExperimentationDataReader data plane role is assigned to user by default. */
    ExperimentationDataReader: "ExperimentationDataReader",

    /** ExperimentationDataOwner data plane role is assigned to user by default. */
    ExperimentationDataOwner: "ExperimentationDataOwner",

    string,
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
    create is ArmResourceCreateOrUpdateAsync<ExperimentationWorkspace>;
    update is ArmResourcePatchAsync<
      ExperimentationWorkspace,
      ExperimentationWorkspaceProperties
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

    @doc("The application ID URI of Split.IO data plane authentication application.")
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

      @doc("The id of the Split.IO data plane authentication application in Guid format.")
      @path
      applicationId: string,

      @doc("The parameter of exchange token action.")
      @body
      exchangeTokenParameters: ExchangeTokenParameters,
    ): ExchangeTokenResult | ErrorResponse;
  }
}
