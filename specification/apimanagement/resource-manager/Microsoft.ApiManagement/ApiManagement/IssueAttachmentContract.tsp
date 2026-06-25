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
 * Issue Attachment Contract details.
 */
@parentResource(IssueContract)
model IssueAttachmentContract
  is Azure.ResourceManager.ProxyResource<IssueAttachmentContractProperties> {
  ...ResourceNameParameter<
    Resource = IssueAttachmentContract,
    KeyName = "attachmentId",
    SegmentName = "attachments",
    NamePattern = "^[^*#&+:<>?]+$"
  >;
}

@armResourceOperations
interface IssueAttachmentContractsOps
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

        /** Issue identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("issues")
        @key
        @pattern("^[^*#&+:<>?]+$")
        @minLength(1)
        @maxLength(256)
        issueId: string,
      },
      {
        /** Attachment identifier within an Issue. Must be unique in the current Issue. */
        @path
        @segment("attachments")
        @key
        @pattern("^[^*#&+:<>?]+$")
        @minLength(1)
        @maxLength(256)
        attachmentId: string,
      },
      ResourceName = "ApiIssueAttachment"
    > {}
@armResourceOperations
interface IssueAttachmentContracts {
  /**
   * Gets the details of the issue Attachment for an API specified by its identifier.
   */
  get is IssueAttachmentContractsOps.Read<
    IssueAttachmentContract,
    Response = ArmResponse<IssueAttachmentContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      eTag: string;
    }
  >;

  /**
   * Gets the entity state (Etag) version of the issue Attachment for an API specified by its identifier.
   */
  getEntityTag is IssueAttachmentContractsOps.CheckExistence<
    IssueAttachmentContract,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      eTag: string;
    }
  >;

  /**
   * Creates a new Attachment for the Issue in an API or updates an existing one.
   */
  createOrUpdate is IssueAttachmentContractsOps.CreateOrUpdateSync<
    IssueAttachmentContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response =
      | (ArmResponse<IssueAttachmentContract> & {
          /**
           * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
           */
          @header("ETag")
          eTag: string;
        })
      | (ArmCreatedResponse<IssueAttachmentContract> & {
          /**
           * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
           */
          @header("ETag")
          eTag: string;
        })
  >;

  /**
   * Deletes the specified comment from an Issue.
   */
  delete is IssueAttachmentContractsOps.DeleteSync<
    IssueAttachmentContract,
    Parameters = IfMatchHeaderParameter
  >;

  /**
   * Lists all attachments for the Issue associated with the specified API.
   */
  listByService is IssueAttachmentContractsOps.List<
    IssueAttachmentContract,
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
      @query("$skip")
      @minValue(0)
      $skip?: int32;
    },
    Response = ArmResponse<IssueAttachmentCollection>
  >;
}

@@maxLength(IssueAttachmentContract.name, 256);
@@minLength(IssueAttachmentContract.name, 1);
@@doc(
  IssueAttachmentContract.name,
  "Attachment identifier within an Issue. Must be unique in the current Issue."
);
@@doc(
  IssueAttachmentContract.properties,
  "Properties of the Issue Attachment."
);
@@doc(
  IssueAttachmentContracts.createOrUpdate::parameters.resource,
  "Create parameters."
);
