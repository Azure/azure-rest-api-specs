import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./OperationContract.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ApiManagement;
/**
 * Tag Contract details.
 */
@parentResource(OperationContract)
model TagContract
  is Azure.ResourceManager.ProxyResource<TagContractProperties> {
  ...ResourceNameParameter<
    Resource = TagContract,
    KeyName = "tagId",
    SegmentName = "tags",
    NamePattern = "^[^*#&+:<>?]+$"
  >;
}

@armResourceOperations
interface TagContractOps
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

        /** API revision identifier. Must be unique in the current API Management service instance. Non-current revision has ;rev=n as a suffix where n is the revision number. */
        @path
        @segment("apis")
        @key
        @pattern("^[^*#&+:<>?]+$")
        @minLength(1)
        @maxLength(256)
        apiId: string,

        /** Operation identifier within an API. Must be unique in the current API Management service instance. */
        @path
        @segment("operations")
        @key
        @minLength(1)
        @maxLength(80)
        operationId: string,
      },
      {
        /** Tag identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("tags")
        @key
        @pattern("^[^*#&+:<>?]+$")
        @minLength(1)
        @maxLength(80)
        tagId: string,
      }
    > {}

@armResourceOperations
interface TagContracts {
  /**
   * Get tag associated with the Operation.
   */
  getByOperation is TagContractOps.Read<
    TagContract,
    Response = ArmResponse<TagContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Gets the entity state version of the tag specified by its identifier.
   */
  getEntityStateByOperation is TagContractOps.CheckExistence<
    TagContract,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  // FIXME: (ArmResourceCreateOrReplace): ArmResourceCreateOrReplaceAsync/ArmResourceCreateOrReplaceSync should have a body parameter.
  /**
   * Assign tag to the Operation.
   */
  assignToOperation is TagContractOps.CreateOrUpdateSync<
    TagContract,
    Request = void
  >;

  /**
   * Detach the tag from the Operation.
   */
  detachFromOperation is TagContractOps.DeleteSync<TagContract>;

  /**
   * Lists all Tags associated with the Operation.
   */
  listByOperation is TagContractOps.List<
    TagContract,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| displayName | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| name | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>
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
    Response = ArmResponse<TagCollection>
  >;
}
@armResourceOperations
interface TagOps
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

        /** API revision identifier. Must be unique in the current API Management service instance. Non-current revision has ;rev=n as a suffix where n is the revision number. */
        @path
        @segment("apis")
        @key
        @pattern("^[^*#&+:<>?]+$")
        @minLength(1)
        @maxLength(256)
        apiId: string,
      },
      {
        /** Tag identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("tags")
        @key
        @pattern("^[^*#&+:<>?]+$")
        @minLength(1)
        @maxLength(80)
        tagId: string,
      }
    > {}

@armResourceOperations
interface Tag {
  /**
   * Get tag associated with the API.
   */
  getByApi is TagOps.Read<
    TagContract,
    Response = ArmResponse<TagContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Gets the entity state version of the tag specified by its identifier.
   */
  getEntityStateByApi is TagOps.CheckExistence<
    TagContract,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  // FIXME: (ArmResourceCreateOrReplace): ArmResourceCreateOrReplaceAsync/ArmResourceCreateOrReplaceSync should have a body parameter.
  /**
   * Assign tag to the Api.
   */
  assignToApi is TagOps.CreateOrUpdateSync<
    TagContract,
    Request = void,
    Response = (ArmResponse<TagContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }) | (ArmResourceCreatedSyncResponse<TagContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    })
  >;

  /**
   * Detach the tag from the Api.
   */
  detachFromApi is TagOps.DeleteSync<TagContract>;

  /**
   * Lists all Tags associated with the API.
   */
  listByApi is TagOps.List<
    TagContract,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| displayName | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| name | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>
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
    Response = ArmResponse<TagCollection>
  >;
}
@armResourceOperations
interface TagContractOperationOps
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

        /** Product identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("products")
        @key
        @minLength(1)
        @maxLength(256)
        productId: string,
      },
      {
        /** Tag identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("tags")
        @key
        @pattern("^[^*#&+:<>?]+$")
        @minLength(1)
        @maxLength(80)
        tagId: string,
      }
    > {}

@armResourceOperations
interface TagContractOperation {
  /**
   * Get tag associated with the Product.
   */
  getByProduct is TagContractOperationOps.Read<
    TagContract,
    Response = ArmResponse<TagContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Gets the entity state version of the tag specified by its identifier.
   */
  getEntityStateByProduct is TagContractOperationOps.CheckExistence<
    TagContract,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  // FIXME: (ArmResourceCreateOrReplace): ArmResourceCreateOrReplaceAsync/ArmResourceCreateOrReplaceSync should have a body parameter.
  /**
   * Assign tag to the Product.
   */
  assignToProduct is TagContractOperationOps.CreateOrUpdateSync<
    TagContract,
    Request = void
  >;

  /**
   * Detach the tag from the Product.
   */
  detachFromProduct is TagContractOperationOps.DeleteSync<TagContract>;

  /**
   * Lists all Tags associated with the Product.
   */
  listByProduct is TagContractOperationOps.List<
    TagContract,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| displayName | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| name | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>
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
    Response = ArmResponse<TagCollection>
  >;
}
@armResourceOperations
interface TagContractOperationGroupOps
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
      },
      {
        /** Tag identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("tags")
        @key
        @pattern("^[^*#&+:<>?]+$")
        @minLength(1)
        @maxLength(80)
        tagId: string,
      }
    > {}

@armResourceOperations
interface TagContractOperationGroup {
  /**
   * Gets the details of the tag specified by its identifier.
   */
  get is TagContractOperationGroupOps.Read<
    TagContract,
    Response = ArmResponse<TagContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Gets the entity state version of the tag specified by its identifier.
   */
  getEntityState is TagContractOperationGroupOps.CheckExistence<
    TagContract,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Creates a tag.
   */
  createOrUpdate is TagContractOperationGroupOps.CreateOrUpdateSync<
    TagContract,
    Request = TagCreateUpdateParameters,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response = (ArmResponse<TagContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }) | (ArmResourceCreatedSyncResponse<TagContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    })
  >;

  /**
   * Updates the details of the tag specified by its identifier.
   */
  @patch(#{ implicitOptionality: false })
  update is TagContractOperationGroupOps.CustomPatchSync<
    TagContract,
    PatchModel = TagCreateUpdateParameters,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    },
    Response = ArmResponse<TagContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Deletes specific tag of the API Management service instance.
   */
  delete is TagContractOperationGroupOps.DeleteSync<
    TagContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    }
  >;

  /**
   * Lists a collection of tags defined within a service instance.
   */
  listByService is TagContractOperationGroupOps.List<
    TagContract,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| name | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| displayName | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>
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

      /**
       * Scope like 'apis', 'products' or 'apis/{apiId}
       */
      @query("scope")
      scope?: string;
    },
    Response = ArmResponse<TagCollection>
  >;
}
@armResourceOperations
interface WorkspaceTagOps
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
      },
      {
        /** Tag identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("tags")
        @key
        @pattern("^[^*#&+:<>?]+$")
        @minLength(1)
        @maxLength(80)
        tagId: string,
      }
    > {}

@armResourceOperations
interface WorkspaceTag {
  /**
   * Gets the details of the tag specified by its identifier.
   */
  get is WorkspaceTagOps.Read<
    TagContract,
    Response = ArmResponse<TagContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Gets the entity state version of the tag specified by its identifier.
   */
  getEntityState is WorkspaceTagOps.CheckExistence<
    TagContract,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Creates a tag.
   */
  createOrUpdate is WorkspaceTagOps.CreateOrUpdateSync<
    TagContract,
    Request = TagCreateUpdateParameters,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response = (ArmResponse<TagContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }) | (ArmResourceCreatedSyncResponse<TagContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    })
  >;

  /**
   * Updates the details of the tag specified by its identifier.
   */
  @patch(#{ implicitOptionality: false })
  update is WorkspaceTagOps.CustomPatchSync<
    TagContract,
    PatchModel = TagCreateUpdateParameters,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    },
    Response = ArmResponse<TagContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Deletes specific tag of the workspace in an API Management service instance.
   */
  delete is WorkspaceTagOps.DeleteSync<
    TagContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    }
  >;

  /**
   * Lists a collection of tags defined within a workspace in a service instance.
   */
  listByService is WorkspaceTagOps.List<
    TagContract,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| name | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| displayName | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>
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

      /**
       * Scope like 'apis', 'products' or 'apis/{apiId}
       */
      @query("scope")
      scope?: string;
    },
    Response = ArmResponse<TagCollection>
  >;
}

@@maxLength(TagContract.name, 80);
@@minLength(TagContract.name, 1);
@@doc(TagContract.name,
  "Tag identifier. Must be unique in the current API Management service instance."
);
@@doc(TagContract.properties, "Tag entity contract properties.");
@@doc(TagContractOperationGroup.createOrUpdate::parameters.resource,
  "Create parameters."
);
@@doc(TagContractOperationGroup.update::parameters.properties,
  "Update parameters."
);
@@doc(WorkspaceTag.createOrUpdate::parameters.resource, "Create parameters.");
@@doc(WorkspaceTag.update::parameters.properties, "Update parameters.");
