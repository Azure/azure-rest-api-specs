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
 * Portal Revision's contract details.
 */
@parentResource(ApiManagementServiceResource)
model PortalRevisionContract
  is Azure.ResourceManager.ProxyResource<PortalRevisionContractProperties> {
  ...ResourceNameParameter<
    Resource = PortalRevisionContract,
    KeyName = "portalRevisionId",
    SegmentName = "portalRevisions",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface PortalRevisionContracts {
  /**
   * Gets the developer portal's revision specified by its identifier.
   */
  get is ArmResourceRead<
    PortalRevisionContract,
    Response = ArmResponse<PortalRevisionContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Gets the developer portal revision specified by its identifier.
   */
  getEntityTag is ArmResourceCheckExistence<
    PortalRevisionContract,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Creates a new developer portal's revision by running the portal's publishing. The `isCurrent` property indicates if the revision is publicly accessible.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    PortalRevisionContract,
    Response = ArmResourceCreatedResponse<
      PortalRevisionContract,
      LroHeaders = ArmCombinedLroHeaders<FinalResult = PortalRevisionContract>
    > & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Updates the description of specified portal revision or makes it current.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    PortalRevisionContract,
    PatchModel = PortalRevisionContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    },
    Response = (ArmResponse<PortalRevisionContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }) | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = PortalRevisionContract>>
  >;

  /**
   * Lists developer portal's revisions.
   */
  listByService is ArmResourceListByParent<
    PortalRevisionContract,
    Parameters = {
      /**
       * | Field       | Supported operators    | Supported functions               |
       * |-------------|------------------------|-----------------------------------|
       *
       * |name | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith|
       * |description | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith|
       * |isCurrent | eq, ne |    |
       *
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
    Response = ArmResponse<PortalRevisionCollection>
  >;
}

@@maxLength(PortalRevisionContract.name, 256);
@@minLength(PortalRevisionContract.name, 1);
@@doc(PortalRevisionContract.name,
  "Portal revision identifier. Must be unique in the current API Management service instance."
);
@@doc(PortalRevisionContract.properties, "Properties of the portal revisions.");
@@doc(PortalRevisionContracts.createOrUpdate::parameters.resource, "");
@@doc(PortalRevisionContracts.update::parameters.properties, "");
