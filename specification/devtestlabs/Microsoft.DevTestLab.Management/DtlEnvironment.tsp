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
 * An environment, which is essentially an ARM template deployment.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
@Azure.ResourceManager.Legacy.customAzureResource
@Http.Private.includeInapplicableMetadataInPayload(false)
model DtlEnvironment extends Resource {
  @visibility(Lifecycle.Read)
  @path
  @key
  @segment("environments")
  name: string;

  properties: EnvironmentProperties;
}

@armResourceOperations
interface EnvironmentOps
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
        Resource = DtlEnvironment,
        KeyName = "name",
        SegmentName = "environments",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface DtlEnvironments {
  /**
   * Get environment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Environments_Get")
  get is EnvironmentOps.Read<
    DtlEnvironment,
    Parameters = {
      /**
       * Specify the $expand query. Example: 'properties($select=deploymentProperties)'
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * Create or replace an existing environment. This operation can take a while to complete.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Environments_CreateOrUpdate")
  createOrUpdate is EnvironmentOps.CreateOrUpdateAsync<
    DtlEnvironment,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Allows modifying tags of environments. All other properties will be ignored.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-patch" "Already contains tags"
  @patch(#{ implicitOptionality: false })
  @operationId("Environments_Update")
  update is EnvironmentOps.CustomPatchSync<
    DtlEnvironment,
    PatchModel = DtlEnvironmentFragment
  >;

  /**
   * Delete environment. This operation can take a while to complete.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("Environments_Delete")
  delete is EnvironmentOps.DeleteWithoutOkAsync<
    DtlEnvironment,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List environments in a given user profile.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Environments_List")
  list is EnvironmentOps.List<
    DtlEnvironment,
    Parameters = {
      /**
       * Specify the $expand query. Example: 'properties($select=deploymentProperties)'
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
    Response = ArmResponse<DtlEnvironmentList>
  >;
}

@@doc(DtlEnvironment.name, "The name of the environment.");
@@doc(DtlEnvironment.properties, "The properties of the environment.");
@@doc(DtlEnvironments.createOrUpdate::parameters.resource,
  "An environment, which is essentially an ARM template deployment."
);
@@doc(DtlEnvironments.update::parameters.properties,
  "An environment, which is essentially an ARM template deployment."
);
