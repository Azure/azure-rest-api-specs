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
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
   * Unique identifier for this commit.
   */
  forceUpdateTag?: string;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
@added(Versions.v2025_07_01)
@armResourceOperations
interface Commits {
  /**
   * Gets the specified commit.
   */
  get is ArmResourceRead<Commit, Error = CloudError>;

  /**
   * Creates or updates a commit.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Commit,
    Error = CloudError
  >;

  /**
   * Deletes a commit.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    Commit,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Lists the specified commit.
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
