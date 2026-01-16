import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ApiContract.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ApiManagement;
/**
 * Tool details.
 */
@parentResource(ApiContract)
model ToolContract
  is Azure.ResourceManager.ProxyResource<ToolContractProperties> {
  ...ResourceNameParameter<
    Resource = ToolContract,
    KeyName = "toolId",
    SegmentName = "tools",
    NamePattern = "(^[\\w]+$)|(^[\\w][\\w\\-]+[\\w]$)"
  >;
}

@armResourceOperations
interface ToolContracts {
  /**
   * Gets the details of the API Tool specified by its identifier.
   */
  get is ArmResourceRead<
    ToolContract,
    Response = ArmResponse<ToolContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Gets the entity state (Etag) version of the API tool specified by its identifier.
   */
  getEntityTag is ArmResourceCheckExistence<
    ToolContract,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Creates a new tool in the API or updates an existing one.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    ToolContract,
    Response = (ArmResponse<ToolContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }) | (ArmCreatedResponse<ToolContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    })
  >;

  /**
   * Updates the details of the tool in the API specified by its identifier.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    ToolContract,
    PatchModel = ToolContract,
    Response = ArmResponse<ToolContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Deletes the specified tool in the API.
   */
  delete is ArmResourceDeleteSync<ToolContract>;

  /**
   * Lists a collection of the MCP tools for the specified API.
   */
  listByApi is ArmResourceListByParent<
    ToolContract,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| name | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| description | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>
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
    Response = ArmResponse<ToolCollection>
  >;
}

@@maxLength(ToolContract.name, 80);
@@minLength(ToolContract.name, 1);
@@doc(ToolContract.name,
  "Tool identifier within an API. Must be unique in the current API Management service instance."
);
@@doc(ToolContract.properties, "Properties of the Tool Contract.");
@@doc(ToolContracts.createOrUpdate::parameters.resource, "Create parameters.");
@@doc(ToolContracts.update::parameters.properties,
  "API Tool Update parameters."
);
