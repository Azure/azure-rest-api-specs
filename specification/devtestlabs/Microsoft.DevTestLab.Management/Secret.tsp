import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevTestLab;
/**
 * A secret.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
@Azure.ResourceManager.Legacy.customAzureResource
@Http.Private.includeInapplicableMetadataInPayload(false)
model Secret extends Resource {
  @visibility(Lifecycle.Read)
  @path
  @key
  @segment("secrets")
  name: string;

  properties: SecretProperties;
}

@armResourceOperations
interface SecretOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of the lab. */
        @path @segment("labs") labName: string,

        /** The name of the user profile. */
        @path @segment("users") userName: string,
      },
      KeysOf<ResourceNameParameter<
        Resource = Secret,
        KeyName = "name",
        SegmentName = "secrets",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface Secrets {
  /**
   * Get secret.
   */
  get is SecretOps.Read<
    Secret,
    Parameters = {
      /**
       * Specify the $expand query. Example: 'properties($select=value)'
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * Create or replace an existing secret. This operation can take a while to complete.
   */
  createOrUpdate is SecretOps.CreateOrUpdateAsync<
    Secret,
    LroHeaders = ArmLroLocationHeader<FinalResult = Secret> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Allows modifying tags of secrets. All other properties will be ignored.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-patch" "Already contains tags"
  @patch(#{ implicitOptionality: false })
  update is SecretOps.CustomPatchSync<Secret, PatchModel = SecretFragment>;

  /**
   * Delete secret.
   */
  delete is SecretOps.DeleteSync<Secret>;

  /**
   * List secrets in a given user profile.
   */
  list is SecretOps.List<
    Secret,
    Parameters = {
      /**
       * Specify the $expand query. Example: 'properties($select=value)'
       */
      @query("$expand")
      $expand?: string;

      /**
       * The filter to apply to the operation. Example: '$filter=contains(name,'myName')
       */
      @query("$filter")
      $filter?: string;

      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'
       */
      @query("$top")
      $top?: int32;

      /**
       * The ordering expression for the results, using OData notation. Example: '$orderby=name desc'
       */
      @query("$orderby")
      $orderby?: string;
    },
    Response = ArmResponse<SecretList>
  >;
}

@@doc(Secret.name, "The name of the secret.");
@@doc(Secret.properties, "The properties of the resource.");
@@doc(Secrets.createOrUpdate::parameters.resource, "A secret.");
@@doc(Secrets.update::parameters.properties, "A secret.");
