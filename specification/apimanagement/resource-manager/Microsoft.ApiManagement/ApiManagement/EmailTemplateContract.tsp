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
 * Email Template details.
 */
@parentResource(ApiManagementServiceResource)
model EmailTemplateContract
  is Azure.ResourceManager.ProxyResource<EmailTemplateContractProperties> {
  ...ResourceNameParameter<
    Resource = EmailTemplateContract,
    KeyName = "templateName",
    SegmentName = "templates",
    NamePattern = "",
    Type = TemplateName
  >;
}

@armResourceOperations
interface EmailTemplateContractsOps
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
        /** API revision identifier. Must be unique in the current API Management service instance. Non-current revision has ;rev=n as a suffix where n is the revision number. */
        @path
        @segment("templates")
        @key
        templateName: TemplateName,
      }
    > {}

@armResourceOperations
interface EmailTemplateContracts {
  /**
   * Gets the details of the email template specified by its identifier.
   */
  get is ArmResourceRead<
    EmailTemplateContract,
    Response = ArmResponse<EmailTemplateContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Gets the entity state (Etag) version of the email template specified by its identifier.
   */
  getEntityTag is ArmResourceCheckExistence<
    EmailTemplateContract,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Updates an Email Template.
   */
  createOrUpdate is EmailTemplateContractsOps.CreateOrUpdateSync<
    EmailTemplateContract,
    Request = EmailTemplateUpdateParameters,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    }
  >;

  /**
   * Updates API Management email template
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    EmailTemplateContract,
    PatchModel = EmailTemplateUpdateParameters,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    },
    Response = ArmResponse<EmailTemplateContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Reset the Email Template to default template provided by the API Management service instance.
   */
  delete is ArmResourceDeleteSync<
    EmailTemplateContract,
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
   * Gets all email templates
   */
  listByService is ArmResourceListByParent<
    EmailTemplateContract,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| name | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>
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
    Response = ArmResponse<EmailTemplateCollection>
  >;
}

@@doc(EmailTemplateContract.name, "Email Template Name Identifier.");
@@doc(EmailTemplateContract.properties,
  "Email Template entity contract properties."
);
@@doc(EmailTemplateContracts.createOrUpdate::parameters.resource,
  "Email Template update parameters."
);
@@doc(EmailTemplateContracts.update::parameters.properties,
  "Update parameters."
);
