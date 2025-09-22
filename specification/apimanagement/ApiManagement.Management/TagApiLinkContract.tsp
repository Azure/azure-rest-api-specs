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
 * Tag-API link details.
 */
@parentResource(TagContract)
model TagApiLinkContract
  is Azure.ResourceManager.ProxyResource<TagApiLinkContractProperties> {
  ...ResourceNameParameter<
    Resource = TagApiLinkContract,
    KeyName = "apiLinkId",
    SegmentName = "apiLinks",
    NamePattern = "^[^*#&+:<>?]+$"
  >;
}

@armResourceOperations
interface TagApiLinkContractOps
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
        serviceName: string,

        /** Tag identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("tags")
        @key
        @pattern("^[^*#&+:<>?]+$")
        tagId: string,
      },
      {
        /** Tag-API link identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("apiLinks")
        @key
        @pattern("^[^*#&+:<>?]+$")
        apiLinkId: string,
      }
    > {}

@armResourceOperations
interface TagApiLinkContracts {
  /**
   * Gets the API link for the tag.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("TagApiLink_Get")
  get is TagApiLinkContractOps.Read<TagApiLinkContract>;

  /**
   * Adds an API to the specified tag via link.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("TagApiLink_CreateOrUpdate")
  createOrUpdate is TagApiLinkContractOps.CreateOrUpdateSync<TagApiLinkContract>;

  /**
   * Deletes the specified API from the specified tag.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("TagApiLink_Delete")
  delete is TagApiLinkContractOps.DeleteSync<TagApiLinkContract>;

  /**
   * Lists a collection of the API links associated with a tag.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("TagApiLink_ListByProduct")
  listByProduct is TagApiLinkContractOps.List<
    TagApiLinkContract,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| apiId | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>
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
      @query("$skip")
      $skip?: int32;
    },
    Response = ArmResponse<TagApiLinkCollection>
  >;
}
@armResourceOperations
interface WorkspaceTagApiLinkOps
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
        serviceName: string,

        /** Workspace identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("workspaces")
        @key
        @pattern("^[^*#&+:<>?]+$")
        workspaceId: string,

        /** Tag identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("tags")
        @key
        @pattern("^[^*#&+:<>?]+$")
        tagId: string,
      },
      {
        /** Tag-API link identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("apiLinks")
        @key
        @pattern("^[^*#&+:<>?]+$")
        apiLinkId: string,
      }
    > {}

@armResourceOperations
interface WorkspaceTagApiLink {
  /**
   * Gets the API link for the tag.
   */
  get is WorkspaceTagApiLinkOps.Read<TagApiLinkContract>;

  /**
   * Adds an API to the specified tag via link.
   */
  createOrUpdate is WorkspaceTagApiLinkOps.CreateOrUpdateSync<TagApiLinkContract>;

  /**
   * Deletes the specified API from the specified tag.
   */
  delete is WorkspaceTagApiLinkOps.DeleteSync<TagApiLinkContract>;

  /**
   * Lists a collection of the API links associated with a tag.
   */
  listByProduct is WorkspaceTagApiLinkOps.List<
    TagApiLinkContract,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| apiId | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>
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
      @query("$skip")
      $skip?: int32;
    },
    Response = ArmResponse<TagApiLinkCollection>
  >;
}

@@maxLength(TagApiLinkContract.name, 80);
@@minLength(TagApiLinkContract.name, 1);
@@doc(TagApiLinkContract.name,
  "Tag-API link identifier. Must be unique in the current API Management service instance."
);
@@doc(TagApiLinkContract.properties,
  "Tag-API link entity contract properties."
);
@@doc(TagApiLinkContracts.createOrUpdate::parameters.resource,
  "Create or update parameters."
);
@@doc(WorkspaceTagApiLink.createOrUpdate::parameters.resource,
  "Create or update parameters."
);
