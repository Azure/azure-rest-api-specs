import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ApiManagementServiceResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ApiManagement;
/**
 * Markdown documentation details.
 */
@parentResource(ApiManagementServiceResource)
model DocumentationContract
  is Azure.ResourceManager.ProxyResource<DocumentationContractProperties> {
  ...ResourceNameParameter<
    Resource = DocumentationContract,
    KeyName = "documentationId",
    SegmentName = "documentations",
    NamePattern = "^[^*#&+:<>?]+$"
  >;
}

@armResourceOperations
interface DocumentationContracts {
  /**
   * Gets the details of the Documentation specified by its identifier.
   */
  get is ArmResourceRead<
    DocumentationContract,
    Response = ArmResponse<DocumentationContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Gets the entity state (Etag) version of the Documentation by its identifier.
   */
  getEntityTag is ArmResourceCheckExistence<
    DocumentationContract,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Creates a new Documentation or updates an existing one.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    DocumentationContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response = (ArmResponse<DocumentationContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }) | (ArmResourceCreatedSyncResponse<DocumentationContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    })
  >;

  /**
   * Updates the details of the Documentation for an API specified by its identifier.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    DocumentationContract,
    PatchModel = DocumentationUpdateContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    },
    Response = ArmResponse<DocumentationContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Deletes the specified Documentation from an API.
   */
  delete is ArmResourceDeleteSync<
    DocumentationContract,
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
   * Lists all Documentations of the API Management service instance.
   */
  listByService is ArmResourceListByParent<
    DocumentationContract,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| name | filter | eq |  contains |</br>
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
    Response = ArmResponse<DocumentationCollection>
  >;
}

@@maxLength(DocumentationContract.name, 256);
@@minLength(DocumentationContract.name, 1);
@@doc(DocumentationContract.name,
  "Documentation identifier. Must be unique in the current API Management service instance."
);
@@doc(DocumentationContract.properties, "Markdown Documentation details.");
@@doc(DocumentationContracts.createOrUpdate::parameters.resource,
  "Create parameters."
);
@@doc(DocumentationContracts.update::parameters.properties,
  "Documentation Update parameters."
);
