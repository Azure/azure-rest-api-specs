import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./EnvironmentContainer.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MachineLearningServices;
/**
 * Azure Resource Manager resource envelope.
 */
@parentResource(EnvironmentContainer)
model EnvironmentVersion
  is Azure.ResourceManager.ProxyResource<EnvironmentVersionProperties, false> {
  ...ResourceNameParameter<
    Resource = EnvironmentVersion,
    KeyName = "version",
    SegmentName = "versions",
    NamePattern = ""
  >;
}

@armResourceOperations
interface EnvironmentVersionOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of Azure Machine Learning registry. This is case-insensitive */
        @path
        @segment("registries")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{2,32}$")
        registryName: string,

        /** Container name. This is case-sensitive. */
        @path
        @segment("environments")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$")
        environmentName: string,
      },
      {
        /** Version identifier. This is case-sensitive. */
        @path
        @segment("versions")
        @key
        version: string,
      }
    > {}

@armResourceOperations
interface EnvironmentVersions {
  /**
   * Get version.
   */
  @summary("Get version.")
  get is EnvironmentVersionOps.Read<EnvironmentVersion>;

  /**
   * Create or update version.
   */
  @Azure.Core.useFinalStateVia("original-uri")
  @summary("Create or update version.")
  createOrUpdate is EnvironmentVersionOps.CreateOrUpdateAsync<
    EnvironmentVersion,
    Response = ArmResourceUpdatedResponse<EnvironmentVersion> | (ArmResourceCreatedResponse<
      EnvironmentVersion,
      ArmAsyncOperationHeader
    > & {
      /**
       * Timeout for the client to use when polling the asynchronous operation.
       */
      @header("x-ms-async-operation-timeout")
      timeout: duration;
    })
  >;

  /**
   * Delete version.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Delete version.")
  delete is EnvironmentVersionOps.DeleteWithoutOkAsync<
    EnvironmentVersion,
    Response = ArmDeletedResponse | (ArmDeleteAcceptedLroResponse & {
      /**
       * Timeout for the client to use when polling the asynchronous operation.
       */
      @header("x-ms-async-operation-timeout")
      timeout: duration;
    }) | ArmDeletedNoContentResponse
  >;

  /**
   * List versions.
   */
  @summary("List versions.")
  list is EnvironmentVersionOps.List<
    EnvironmentVersion,
    Parameters = {
      /**
       * Ordering of list.
       */
      @query("$orderBy")
      $orderBy?: string;

      /**
       * Maximum number of records to return.
       */
      @query("$top")
      $top?: int32;

      /**
       * Continuation token for pagination.
       */
      @query("$skip")
      $skip?: string;

      /**
       * View type for including/excluding (for example) archived entities.
       */
      @query("listViewType")
      listViewType?: ListViewType = ListViewType.ActiveOnly;
    },
    Response = ArmResponse<EnvironmentVersionResourceArmPaginatedResult>
  >;
}
@armResourceOperations
interface EnvironmentVersionOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of Azure Machine Learning workspace. */
        @path
        @segment("workspaces")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
        workspaceName: string,

        /** Container name. This is case-sensitive. */
        @path
        @segment("environments")
        @key
        name: string,
      },
      {
        /** Version identifier. This is case-sensitive. */
        @path
        @segment("versions")
        @key
        version: string,
      }
    > {}

@armResourceOperations
interface EnvironmentVersionOperationGroup {
  /**
   * Get version.
   */
  @summary("Get version.")
  get is EnvironmentVersionOperationGroupOps.Read<EnvironmentVersion>;

  /**
   * Creates or updates an EnvironmentVersion.
   */
  @summary("Creates or updates an EnvironmentVersion.")
  createOrUpdate is EnvironmentVersionOperationGroupOps.CreateOrUpdateSync<EnvironmentVersion>;

  /**
   * Delete version.
   */
  @summary("Delete version.")
  delete is EnvironmentVersionOperationGroupOps.DeleteSync<EnvironmentVersion>;

  /**
   * List versions.
   */
  @summary("List versions.")
  list is EnvironmentVersionOperationGroupOps.List<
    EnvironmentVersion,
    Parameters = {
      /**
       * Ordering of list.
       */
      @query("$orderBy")
      $orderBy?: string;

      /**
       * Maximum number of records to return.
       */
      @query("$top")
      $top?: int32;

      /**
       * Continuation token for pagination.
       */
      @query("$skip")
      $skip?: string;

      /**
       * View type for including/excluding (for example) archived entities.
       */
      @query("listViewType")
      listViewType?: ListViewType = ListViewType.ActiveOnly;
    },
    Response = ArmResponse<EnvironmentVersionResourceArmPaginatedResult>
  >;

  /**
   * Publish version asset into registry.
   */
  @summary("Publish version asset into registry.")
  publish is EnvironmentVersionOperationGroupOps.ActionAsync<
    EnvironmentVersion,
    DestinationAsset,
    {
      @body body: void;
    },
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = void>
  >;
}

@@doc(EnvironmentVersion.name, "Version identifier. This is case-sensitive.");
@@doc(EnvironmentVersion.properties,
  "[Required] Additional attributes of the entity."
);
@@doc(EnvironmentVersions.createOrUpdate::parameters.resource,
  "Version entity to create or update."
);
@@doc(EnvironmentVersionOperationGroup.createOrUpdate::parameters.resource,
  "Definition of EnvironmentVersion."
);
@@doc(EnvironmentVersionOperationGroup.publish::parameters.body,
  "Destination registry info"
);
