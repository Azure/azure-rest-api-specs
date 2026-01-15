import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ComponentContainer.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MachineLearningServices;
/**
 * Azure Resource Manager resource envelope.
 */
@parentResource(ComponentContainer)
model ComponentVersion
  is Azure.ResourceManager.ProxyResource<ComponentVersionProperties, false> {
  ...ResourceNameParameter<
    Resource = ComponentVersion,
    KeyName = "version",
    SegmentName = "versions",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ComponentVersionOps
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

        /** Container name. */
        @path
        @segment("components")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$")
        componentName: string,
      },
      {
        /** Version identifier. */
        @path
        @segment("versions")
        @key
        version: string,
      }
    > {}

@armResourceOperations
interface ComponentVersions {
  /**
   * Get version.
   */
  @summary("Get version.")
  get is ComponentVersionOps.Read<ComponentVersion>;

  /**
   * Create or update version.
   */
  @Azure.Core.useFinalStateVia("original-uri")
  @summary("Create or update version.")
  createOrUpdate is ComponentVersionOps.CreateOrUpdateAsync<
    ComponentVersion,
    Response = ArmResourceUpdatedResponse<ComponentVersion> | (ArmResourceCreatedResponse<
      ComponentVersion,
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
  delete is ComponentVersionOps.DeleteWithoutOkAsync<
    ComponentVersion,
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
  list is ComponentVersionOps.List<
    ComponentVersion,
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
    },
    Response = ArmResponse<ComponentVersionResourceArmPaginatedResult>
  >;
}
@armResourceOperations
interface ComponentVersionOperationGroupOps
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

        /** Container name. */
        @path
        @segment("components")
        @key
        name: string,
      },
      {
        /** Version identifier. */
        @path
        @segment("versions")
        @key
        version: string,
      }
    > {}

@armResourceOperations
interface ComponentVersionOperationGroup {
  /**
   * Get version.
   */
  @summary("Get version.")
  get is ComponentVersionOperationGroupOps.Read<ComponentVersion>;

  /**
   * Create or update version.
   */
  @summary("Create or update version.")
  createOrUpdate is ComponentVersionOperationGroupOps.CreateOrUpdateSync<ComponentVersion>;

  /**
   * Delete version.
   */
  @summary("Delete version.")
  delete is ComponentVersionOperationGroupOps.DeleteSync<ComponentVersion>;

  /**
   * List component versions.
   */
  @summary("List component versions.")
  list is ComponentVersionOperationGroupOps.List<
    ComponentVersion,
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
    Response = ArmResponse<ComponentVersionResourceArmPaginatedResult>
  >;

  /**
   * Publish version asset into registry.
   */
  @summary("Publish version asset into registry.")
  publish is ComponentVersionOperationGroupOps.ActionAsync<
    ComponentVersion,
    DestinationAsset,
    {
      @body body: void;
    },
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = void>
  >;
}

@@doc(ComponentVersion.name, "Version identifier.");
@@doc(ComponentVersion.properties,
  "[Required] Additional attributes of the entity."
);
@@doc(ComponentVersions.createOrUpdate::parameters.resource,
  "Version entity to create or update."
);
@@doc(ComponentVersionOperationGroup.createOrUpdate::parameters.resource,
  "Version entity to create or update."
);
@@doc(ComponentVersionOperationGroup.publish::parameters.body,
  "Destination registry info"
);
