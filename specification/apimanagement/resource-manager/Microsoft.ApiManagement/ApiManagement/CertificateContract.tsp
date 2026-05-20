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
 * Certificate details.
 */
@parentResource(ApiManagementServiceResource)
model CertificateContract
  is Azure.ResourceManager.ProxyResource<CertificateContractProperties> {
  ...ResourceNameParameter<
    Resource = CertificateContract,
    KeyName = "certificateId",
    SegmentName = "certificates",
    NamePattern = "^[^*#&+:<>?]+$"
  >;
}

@armResourceOperations
interface CertificateContractOps
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
        /** Identifier of the certificate entity. Must be unique in the current API Management service instance. */
        @path
        @segment("certificates")
        @key
        @pattern("^[^*#&+:<>?]+$")
        @minLength(1)
        @maxLength(80)
        certificateId: string,
      }
    > {}

@armResourceOperations
interface CertificateContracts {
  /**
   * Gets the details of the certificate specified by its identifier.
   */
  get is CertificateContractOps.Read<
    CertificateContract,
    Response = ArmResponse<CertificateContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Gets the entity state (Etag) version of the certificate specified by its identifier.
   */
  getEntityTag is CertificateContractOps.CheckExistence<
    CertificateContract,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Creates or updates the certificate being used for authentication with the backend.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs(
    "https://azure.microsoft.com/en-us/documentation/articles/api-management-howto-mutual-certificates/",
    "How to secure back-end services using client certificate authentication in Azure API Management"
  )
  createOrUpdate is CertificateContractOps.CreateOrUpdateSync<
    CertificateContract,
    Request = CertificateCreateOrUpdateParameters,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response = (ArmResponse<CertificateContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }) | (ArmResourceCreatedSyncResponse<CertificateContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    })
  >;

  /**
   * Deletes specific certificate.
   */
  delete is CertificateContractOps.DeleteSync<
    CertificateContract,
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
   * Lists a collection of all certificates in the specified service instance.
   */
  listByService is CertificateContractOps.List<
    CertificateContract,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| name | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| subject | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| thumbprint | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| expirationDate | filter | ge, le, eq, ne, gt, lt |     |</br>
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
       * When set to true, the response contains only certificates entities which failed refresh.
       */
      @query("isKeyVaultRefreshFailed")
      isKeyVaultRefreshFailed?: boolean;
    },
    Response = ArmResponse<CertificateCollection>
  >;

  /**
   * From KeyVault, Refresh the certificate being used for authentication with the backend.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs(
    "https://azure.microsoft.com/en-us/documentation/articles/api-management-howto-mutual-certificates/",
    "How to secure back-end services using client certificate authentication in Azure API Management"
  )
  refreshSecret is CertificateContractOps.ActionSync<
    CertificateContract,
    void,
    Response = ArmResponse<CertificateContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;
}
@armResourceOperations
interface WorkspaceCertificateOps
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
        /** Identifier of the certificate entity. Must be unique in the current API Management service instance. */
        @path
        @segment("certificates")
        @key
        @pattern("^[^*#&+:<>?]+$")
        @minLength(1)
        @maxLength(80)
        certificateId: string,
      }
    > {}

@armResourceOperations
interface WorkspaceCertificate {
  /**
   * Gets the details of the certificate specified by its identifier.
   */
  get is WorkspaceCertificateOps.Read<
    CertificateContract,
    Response = ArmResponse<CertificateContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Gets the entity state (Etag) version of the certificate specified by its identifier.
   */
  getEntityTag is WorkspaceCertificateOps.CheckExistence<
    CertificateContract,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Creates or updates the certificate being used for authentication with the backend.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs(
    "https://azure.microsoft.com/en-us/documentation/articles/api-management-howto-mutual-certificates/",
    "How to secure back-end services using client certificate authentication in Azure API Management"
  )
  createOrUpdate is WorkspaceCertificateOps.CreateOrUpdateSync<
    CertificateContract,
    Request = CertificateCreateOrUpdateParameters,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response = (ArmResponse<CertificateContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }) | (ArmResourceCreatedSyncResponse<CertificateContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    })
  >;

  /**
   * Deletes specific certificate.
   */
  delete is WorkspaceCertificateOps.DeleteSync<
    CertificateContract,
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
   * Lists a collection of all certificates in the specified workspace.
   */
  listByWorkspace is WorkspaceCertificateOps.List<
    CertificateContract,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| name | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| subject | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| thumbprint | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| expirationDate | filter | ge, le, eq, ne, gt, lt |     |</br>
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
       * When set to true, the response contains only certificates entities which failed refresh.
       */
      @query("isKeyVaultRefreshFailed")
      isKeyVaultRefreshFailed?: boolean;
    },
    Response = ArmResponse<CertificateCollection>
  >;

  /**
   * From KeyVault, Refresh the certificate being used for authentication with the backend.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs(
    "https://azure.microsoft.com/en-us/documentation/articles/api-management-howto-mutual-certificates/",
    "How to secure back-end services using client certificate authentication in Azure API Management"
  )
  refreshSecret is WorkspaceCertificateOps.ActionSync<
    CertificateContract,
    void,
    Response = ArmResponse<CertificateContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;
}

@@maxLength(CertificateContract.name, 80);
@@minLength(CertificateContract.name, 1);
@@doc(CertificateContract.name,
  "Identifier of the certificate entity. Must be unique in the current API Management service instance."
);
@@doc(CertificateContract.properties, "Certificate properties details.");
@@doc(CertificateContracts.createOrUpdate::parameters.resource,
  "Create or Update parameters."
);
@@doc(WorkspaceCertificate.createOrUpdate::parameters.resource,
  "Create or Update parameters."
);
