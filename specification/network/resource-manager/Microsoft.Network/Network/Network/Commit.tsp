import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./NetworkManager.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Network;

/**
 * The commit resource
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Using ChildResource base type with includeInapplicableMetadataInPayload for consistency with all existing Network Manager child resources (e.g., ScopeConnection, AdminRuleCollection, ConnectivityConfiguration)"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "ChildResource is the established pattern for all Network Manager child resources to maintain consistent swagger output across the service"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Inheriting from ChildResource is required to match the existing Network Manager resource model hierarchy"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Using Legacy.feature(Features.networkManager) for consistency with all Network Manager resources in this TypeSpec project"
@parentResource(NetworkManager)
@Http.Private.includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
@added(Versions.v2025_07_01)
model Commit extends ChildResource {
  properties?: CommitProperties;

  @visibility(Lifecycle.Read)
  @path
  @key("commitName")
  @segment("commits")
  @pattern("^[a-zA-Z0-9_.-]*$")
  name: string;

  /**
   * The system metadata related to this resource.
   */
  @visibility(Lifecycle.Read)
  systemData?: Azure.ResourceManager.Foundations.SystemData;
}

/**
 * Properties of commit
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Using Legacy.feature(Features.networkManager) for consistency with all Network Manager resources"
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
@added(Versions.v2025_07_01)
model CommitProperties {
  /**
   * A description of the commit.
   */
  description?: string;

  /**
   * The provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Unique identifier for this resource.
   */
  @visibility(Lifecycle.Read)
  resourceGuid?: string;

  /**
   * Commit Type.
   */
  commitType: ConfigurationType;

  /**
   * List of configuration IDs.
   */
  configurationIds?: Azure.Core.armResourceIdentifier[];

  /**
   * List of target locations.
   */
  targetLocations: string[];

  /**
   * List of active locations.
   */
  @visibility(Lifecycle.Read)
  activeLocations?: string[];

  /**
   * A value that, when changed, forces the commit to be re-evaluated and redeployed.
   */
  forceUpdateTag?: string;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Using Legacy.feature(Features.networkManager) for consistency with all Network Manager resources"
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
@added(Versions.v2025_07_01)
@armResourceOperations
// Note: PATCH/Update operation is intentionally omitted. This is consistent with other
// Network Manager child resources (e.g., ScopeConnection, ConnectivityConfiguration,
// NetworkManagerRoutingConfiguration) which also only expose GET, PUT, DELETE, and List.
// Commits are immutable deployment records — partial updates are not semantically meaningful.
// Customers should use PUT (CreateOrUpdate) to replace the full resource.
interface Commits {
  /**
   * Gets the specified commit.
   */
  get is ArmResourceRead<Commit, Error = CloudError>;

  /**
   * Creates or updates a commit.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Commit, Error = CloudError>;

  /**
   * Deletes a commit.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Delete returns 202/204 for async deletion, matching the pattern used by other Network Manager child resources (e.g., AdminRuleCollection, NetworkManagerRoutingConfiguration)"
  delete is ArmResourceDeleteWithoutOkAsync<
    Commit,
    Response = ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Lists all commits for the specified network manager.
   */
  list is ArmResourceListByParent<
    Commit,
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
    },
    Error = CloudError
  >;
}

@@doc(Commit.name, "The name of the commit.");
@@doc(Commit.properties, "The Commit properties");
@@doc(Commits.createOrUpdate::parameters.resource,
  "Parameters supplied to specify which commit to create"
);
