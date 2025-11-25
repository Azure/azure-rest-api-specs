import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * The Managed Network resource
 */
model NetworkManager
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<NetworkManagerProperties> {
  ...ResourceNameParameter<
    Resource = NetworkManager,
    KeyName = "networkManagerName",
    SegmentName = "networkManagers",
    NamePattern = "^[0-9a-zA-Z]([0-9a-zA-Z_.-]{0,62}[0-9a-zA-Z_])?$"
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface NetworkManagers {
  /**
   * Gets the specified Network Manager.
   */
  get is ArmResourceRead<NetworkManager, Error = CloudError>;

  /**
   * Creates or updates a Network Manager.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<NetworkManager, Error = CloudError>;

  /**
   * Patch NetworkManager.
   */
  @patch(#{ implicitOptionality: false })
  patch is ArmCustomPatchSync<NetworkManager, PatchModel = PatchObject, Error = CloudError>;

  /**
   * Deletes a network manager.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<NetworkManager,
    Parameters = {
      /**
       * Deletes the resource even if it is part of a deployed configuration. If the configuration has been deployed, the service will do a cleanup deployment in the background, prior to the delete.
       */
      @query("force")
      force?: boolean;
    },
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,  Error = CloudError>;

  /**
   * List network managers in a resource group.
   */
  list is ArmResourceListByParent<NetworkManager,
    Parameters = {
      /**
       * An optional query parameter which specifies the maximum number of records to be returned by the server.
       */
      @maxValue(20)
      @minValue(1)
      @query("$top")
      $top?: int32;

      /**
       * SkipToken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skipToken parameter that specifies a starting point to use for subsequent calls.
       */
      @query("$skipToken")
      $skipToken?: string;
    }, Error = CloudError>;

  /**
   * List all network managers in a subscription.
   */
  listBySubscription is ArmListBySubscription<NetworkManager,
    Parameters = {
      /**
       * An optional query parameter which specifies the maximum number of records to be returned by the server.
       */
      @maxValue(20)
      @minValue(1)
      @query("$top")
      $top?: int32;

      /**
       * SkipToken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skipToken parameter that specifies a starting point to use for subsequent calls.
       */
      @query("$skipToken")
      $skipToken?: string;
    }, Error = CloudError>;

  /**
   * Lists active connectivity configurations in a network manager.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ListActiveConnectivityConfigurations")
  @list
  listActiveConnectivityConfigurations is ArmResourceActionSync<NetworkManager,
    ActiveConfigurationParameter,
    ArmResponse<ActiveConnectivityConfigurationsListResult>,
    Parameters = {
      /**
       * An optional query parameter which specifies the maximum number of records to be returned by the server.
       */
      @maxValue(20)
      @minValue(1)
      @query("$top")
      $top?: int32;
    }
  , Error = CloudError>;

  /**
   * Lists active security admin rules in a network manager.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ListActiveSecurityAdminRules")
  @list
  listActiveSecurityAdminRules is ArmResourceActionSync<NetworkManager,
    ActiveConfigurationParameter,
    ArmResponse<ActiveSecurityAdminRulesListResult>,
    Parameters = {
      /**
       * An optional query parameter which specifies the maximum number of records to be returned by the server.
       */
      @maxValue(20)
      @minValue(1)
      @query("$top")
      $top?: int32;
    }
  , Error = CloudError>;

  /**
   * Post a Network Manager Commit.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NetworkManagerCommits_Post")
  @action("commit")
  post is ArmResourceActionAsync<NetworkManager,
    NetworkManagerCommit,
    ArmResponse<NetworkManagerCommit>
  , Error = CloudError>;

  /**
   * Post to List of Network Manager Deployment Status.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NetworkManagerDeploymentStatus_List")
  @list
  @action("listDeploymentStatus")
  networkManagerDeploymentStatusList is ArmResourceActionSync<NetworkManager,
    NetworkManagerDeploymentStatusParameter,
    ArmResponse<NetworkManagerDeploymentStatusListResult>,
    Parameters = {
      /**
       * An optional query parameter which specifies the maximum number of records to be returned by the server.
       */
      @maxValue(20)
      @minValue(1)
      @query("$top")
      $top?: int32;
    }
  , Error = CloudError>;
}

@@doc(NetworkManager.name, "The name of the network manager.");
@@doc(NetworkManager.properties, "The network manager properties");
@@doc(NetworkManagers.createOrUpdate::parameters.resource,
  "Parameters supplied to specify which network manager is."
);
@@doc(NetworkManagers.patch::parameters.properties,
  "Parameters supplied to specify which network manager is."
);
@@doc(NetworkManagers.listActiveConnectivityConfigurations::parameters.body,
  "Active Configuration Parameter."
);
@@doc(NetworkManagers.listActiveSecurityAdminRules::parameters.body,
  "Active Configuration Parameter."
);
@@doc(NetworkManagers.post::parameters.body,
  "Parameters supplied to specify which Managed Network commit is."
);
@@doc(NetworkManagers.networkManagerDeploymentStatusList::parameters.body,
  "Parameters supplied to specify which Managed Network deployment status is."
);
