import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Web;
/**
 * SSL certificate for an app.
 */
model Certificate
  is Azure.ResourceManager.TrackedResource<CertificateProperties> {
  ...ResourceNameParameter<
    Resource = Certificate,
    KeyName = "name",
    SegmentName = "certificates",
    NamePattern = ""
  >;
}

@armResourceOperations
interface CertificateOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
      },
      {
        /** Name of the certificate. */
        @path
        @segment("certificates")
        @key
        name: string,
      }
    > {}

@armResourceOperations
interface Certificates {
  /**
   * Description for Get a certificate.
   */
  get is CertificateOps.Read<
    Certificate,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Create or update a certificate.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is CertificateOps.CreateOrUpdateSync<
    Certificate,
    Response = ArmResourceUpdatedResponse<Certificate>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Create or update a certificate.
   */
  @patch(#{ implicitOptionality: false })
  update is CertificateOps.CustomPatchSync<
    Certificate,
    PatchModel = CertificatePatchResource,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Delete a certificate.
   */
  delete is CertificateOps.DeleteSync<
    Certificate,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Get all certificates in a resource group.
   */
  listByResourceGroup is CertificateOps.List<
    Certificate,
    Response = ArmResponse<CertificateCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Get all certificates for a subscription.
   */
  list is Azure.ResourceManager.Extension.ListByTarget<
    Extension.Subscription,
    Certificate,
    Parameters = {
      /**
       * Return only information specified in the filter (using OData syntax). For example: $filter=KeyVaultId eq 'KeyVaultId'
       */
      @query("$filter")
      $filter?: string;
    },
    Response = ArmResponse<CertificateCollection>,
    Error = DefaultErrorResponse
  >;
}
@armResourceOperations
interface SiteCertificateOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of the site. */
        @path
        @segment("sites")
        @key
        @pattern("^[A-z][A-z0-9]*$")
        name: string,
      },
      {
        /** Name of the certificate. */
        @path
        @segment("certificates")
        @key
        @pattern("^[A-z][A-z0-9]*$")
        certificateName: string,
      }
    > {}

@armResourceOperations
interface SiteCertificates {
  /**
   * Get a certificate belonging to a given site.
   */
  get is SiteCertificateOps.Read<Certificate>;

  /**
   * Create or update a certificate under a given site.
   */
  createOrUpdate is SiteCertificateOps.CreateOrUpdateSync<Certificate>;

  /**
   * Create or update a certificate under a given site.
   */
  @patch(#{ implicitOptionality: false })
  update is SiteCertificateOps.CustomPatchSync<
    Certificate,
    PatchModel = CertificatePatchResource
  >;

  /**
   * Delete a certificate from the site.
   */
  delete is SiteCertificateOps.DeleteSync<Certificate>;

  /**
   * Get all certificates in a resource group under a site.
   */
  list is SiteCertificateOps.List<
    Certificate,
    Response = ArmResponse<CertificateCollection>
  >;
}
@armResourceOperations
interface CertificateOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of the site. */
        @path
        @segment("sites")
        @key
        @pattern("^[A-z][A-z0-9]*$")
        name: string,

        /** Name of the deployment slot. If a slot is not specified, the API will create a binding for the production slot. */
        @path
        @segment("slots")
        @key
        slot: string,
      },
      {
        /** Name of the certificate. */
        @path
        @segment("certificates")
        @key
        @pattern("^[A-z][A-z0-9]*$")
        certificateName: string,
      }
    > {}

@armResourceOperations
interface CertificateOperationGroup {
  /**
   * Get a certificate for a given site and deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SiteCertificates_GetSlot")
  getSlot is CertificateOperationGroupOps.Read<Certificate>;

  /**
   * Create or update a certificate in a given site and deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SiteCertificates_CreateOrUpdateSlot")
  createOrUpdateSlot is CertificateOperationGroupOps.CreateOrUpdateSync<Certificate>;

  /**
   * Create or update a certificate for a site and deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SiteCertificates_UpdateSlot")
  @patch(#{ implicitOptionality: false })
  updateSlot is CertificateOperationGroupOps.CustomPatchSync<
    Certificate,
    PatchModel = CertificatePatchResource
  >;

  /**
   * Delete a certificate for a given site and deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SiteCertificates_DeleteSlot")
  deleteSlot is CertificateOperationGroupOps.DeleteSync<Certificate>;

  /**
   * Get all certificates in a resource group for a given site and a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SiteCertificates_ListSlot")
  listSlot is CertificateOperationGroupOps.List<
    Certificate,
    Response = ArmResponse<CertificateCollection>
  >;
}

@@doc(Certificate.name, "Name of the certificate.");
@@doc(Certificate.properties, "Certificate resource specific properties");
@@doc(Certificates.createOrUpdate::parameters.resource,
  "Details of certificate, if it exists already."
);
@@doc(Certificates.update::parameters.properties,
  "Details of certificate, if it exists already."
);
@@doc(SiteCertificates.createOrUpdate::parameters.resource,
  "Details of certificate, if it exists already."
);
@@doc(SiteCertificates.update::parameters.properties,
  "Details of certificate, if it exists already."
);
@@doc(CertificateOperationGroup.createOrUpdateSlot::parameters.resource,
  "Details of certificate, if it exists already."
);
@@doc(CertificateOperationGroup.updateSlot::parameters.properties,
  "Details of certificate, if it exists already."
);
