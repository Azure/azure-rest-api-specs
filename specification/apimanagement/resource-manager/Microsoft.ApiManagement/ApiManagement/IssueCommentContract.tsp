import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./IssueContract.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ApiManagement;
/**
 * Issue Comment Contract details.
 */
@parentResource(IssueContract)
model IssueCommentContract
  is Azure.ResourceManager.ProxyResource<IssueCommentContractProperties> {
  ...ResourceNameParameter<
    Resource = IssueCommentContract,
    KeyName = "commentId",
    SegmentName = "comments",
    NamePattern = "^[^*#&+:<>?]+$"
  >;
}

@armResourceOperations
interface IssueCommentContracts {
  /**
   * Gets the details of the issue Comment for an API specified by its identifier.
   */
  get is ArmResourceRead<
    IssueCommentContract,
    Response = ArmResponse<IssueCommentContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Gets the entity state (Etag) version of the issue Comment for an API specified by its identifier.
   */
  getEntityTag is ArmResourceCheckExistence<
    IssueCommentContract,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Creates a new Comment for the Issue in an API or updates an existing one.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    IssueCommentContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response = (ArmResponse<IssueCommentContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }) | (ArmCreatedResponse<IssueCommentContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    })
  >;

  /**
   * Deletes the specified comment from an Issue.
   */
  delete is ArmResourceDeleteSync<
    IssueCommentContract,
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
   * Lists all comments for the Issue associated with the specified API.
   */
  listByService is ArmResourceListByParent<
    IssueCommentContract,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| name | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| userId | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>
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
    Response = ArmResponse<IssueCommentCollection>
  >;
}

@@maxLength(IssueCommentContract.name, 256);
@@minLength(IssueCommentContract.name, 1);
@@doc(IssueCommentContract.name,
  "Comment identifier within an Issue. Must be unique in the current Issue."
);
@@doc(IssueCommentContract.properties, "Properties of the Issue Comment.");
@@doc(IssueCommentContracts.createOrUpdate::parameters.resource,
  "Create parameters."
);
