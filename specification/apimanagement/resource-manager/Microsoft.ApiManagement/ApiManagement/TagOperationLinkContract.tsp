import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./TagContract.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ApiManagement;
/**
 * Tag-operation link details.
 */
@parentResource(TagContract)
model TagOperationLinkContract
  is Azure.ResourceManager.ProxyResource<TagOperationLinkContractProperties> {
  ...ResourceNameParameter<
    Resource = TagOperationLinkContract,
    KeyName = "operationLinkId",
    SegmentName = "operationLinks",
    NamePattern = "^[^*#&+:<>?]+$"
  >;
}

@armResourceOperations
interface TagOperationLinkContractOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of the API Management service. */
        @path
        @segment("service")
        @key
        @pattern("^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$")
        @minLength(1)
        @maxLength(50)
        serviceName: string,

        /** Tag identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("tags")
        @key
        @pattern("^[^*#&+:<>?]+$")
        @minLength(1)
        @maxLength(80)
        tagId: string,
      },
      {
        /** Tag-operation link identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("operationLinks")
        @key
        @pattern("^[^*#&+:<>?]+$")
        @minLength(1)
        @maxLength(80)
        operationLinkId: string,
      }
    > {}

@armResourceOperations
interface TagOperationLinkContracts {
  /**
   * Gets the operation link for the tag.
   */
  get is TagOperationLinkContractOps.Read<
    TagOperationLinkContract,
    Response = ArmResponse<TagOperationLinkContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Adds an operation to the specified tag via link.
   */
  createOrUpdate is TagOperationLinkContractOps.CreateOrUpdateSync<TagOperationLinkContract>;

  /**
   * Deletes the specified operation from the specified tag.
   */
  delete is TagOperationLinkContractOps.DeleteSync<TagOperationLinkContract>;

  /**
   * Lists a collection of the operation links associated with a tag.
   */
  listByProduct is TagOperationLinkContractOps.List<
    TagOperationLinkContract,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| operationId | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>
       */
      @query("$filter")
      $filter?: string;

      /**
       * Number of records to return.
       */
      @minValue(1)
      @query("$top")
      $top?: int32;

      /**
       * Number of records to skip.
       */
      @minValue(0)
      @query("$skip")
      $skip?: int32;
    },
    Response = ArmResponse<TagOperationLinkCollection>
  >;
}
@armResourceOperations
interface WorkspaceTagOperationLinkOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of the API Management service. */
        @path
        @segment("service")
        @key
        @pattern("^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$")
        @minLength(1)
        @maxLength(50)
        serviceName: string,

        /** Workspace identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("workspaces")
        @key
        @pattern("^[^*#&+:<>?]+$")
        @minLength(1)
        @maxLength(80)
        workspaceId: string,

        /** Tag identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("tags")
        @key
        @pattern("^[^*#&+:<>?]+$")
        @minLength(1)
        @maxLength(80)
        tagId: string,
      },
      {
        /** Tag-operation link identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("operationLinks")
        @key
        @pattern("^[^*#&+:<>?]+$")
        @minLength(1)
        @maxLength(80)
        operationLinkId: string,
      }
    > {}

@armResourceOperations
interface WorkspaceTagOperationLink {
  /**
   * Gets the operation link for the tag.
   */
  get is WorkspaceTagOperationLinkOps.Read<
    TagOperationLinkContract,
    Response = ArmResponse<TagOperationLinkContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Adds an operation to the specified tag via link.
   */
  createOrUpdate is WorkspaceTagOperationLinkOps.CreateOrUpdateSync<TagOperationLinkContract>;

  /**
   * Deletes the specified operation from the specified tag.
   */
  delete is WorkspaceTagOperationLinkOps.DeleteSync<TagOperationLinkContract>;

  /**
   * Lists a collection of the operation links associated with a tag.
   */
  listByProduct is WorkspaceTagOperationLinkOps.List<
    TagOperationLinkContract,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| operationId | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>
       */
      @query("$filter")
      $filter?: string;

      /**
       * Number of records to return.
       */
      @minValue(1)
      @query("$top")
      $top?: int32;

      /**
       * Number of records to skip.
       */
      @minValue(0)
      @query("$skip")
      $skip?: int32;
    },
    Response = ArmResponse<TagOperationLinkCollection>
  >;
}

@@maxLength(TagOperationLinkContract.name, 80);
@@minLength(TagOperationLinkContract.name, 1);
@@doc(TagOperationLinkContract.name,
  "Tag-operation link identifier. Must be unique in the current API Management service instance."
);
@@doc(TagOperationLinkContract.properties,
  "Tag-API link entity contract properties."
);
@@doc(TagOperationLinkContracts.createOrUpdate::parameters.resource,
  "Create or update parameters."
);
@@doc(WorkspaceTagOperationLink.createOrUpdate::parameters.resource,
  "Create or update parameters."
);
