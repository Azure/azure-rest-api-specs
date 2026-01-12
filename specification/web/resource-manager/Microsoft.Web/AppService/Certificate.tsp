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

  /** Kind of resource. If the resource is an app, you can refer to https://github.com/Azure/app-service-linux-docs/blob/master/Things_You_Should_Know/kind_property.md#app-service-resource-kind-reference for details supported values for kind. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;
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
  @summary("Get a certificate.")
  get is CertificateOps.Read<
    Certificate,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Create or update a certificate.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Create or update a certificate.")
  createOrUpdate is CertificateOps.CreateOrUpdateSync<
    Certificate,
    Response = ArmResourceUpdatedResponse<Certificate>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Create or update a certificate.
   */
  @summary("Create or update a certificate.")
  @patch(#{ implicitOptionality: false })
  update is CertificateOps.CustomPatchSync<
    Certificate,
    PatchModel = CertificatePatchResource,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Delete a certificate.
   */
  @summary("Delete a certificate.")
  delete is CertificateOps.DeleteSync<
    Certificate,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Get all certificates in a resource group.
   */
  @summary("Get all certificates in a resource group.")
  listByResourceGroup is CertificateOps.List<
    Certificate,
    Response = ArmResponse<CertificateCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Get all certificates for a subscription.
   */
  @summary("Get all certificates for a subscription.")
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
  @summary("Get a certificate belonging to a given site.")
  get is SiteCertificateOps.Read<
    Certificate,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Create or update a certificate under a given site.
   */
  @summary("Create or update a certificate under a given site.")
  createOrUpdate is SiteCertificateOps.CreateOrUpdateSync<
    Certificate,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Create or update a certificate under a given site.
   */
  @summary("Create or update a certificate under a given site.")
  @patch(#{ implicitOptionality: false })
  update is SiteCertificateOps.CustomPatchSync<
    Certificate,
    PatchModel = CertificatePatchResource,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Delete a certificate from the site.
   */
  @summary("Delete a certificate from the site.")
  delete is SiteCertificateOps.DeleteSync<
    Certificate,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Get all certificates in a resource group under a site.
   */
  @summary("Get all certificates in a resource group under a site.")
  list is SiteCertificateOps.List<
    Certificate,
    Response = ArmResponse<CertificateCollection>,
    OverrideErrorType = DefaultErrorResponse
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
  @summary("Get a certificate for a given site and deployment slot.")
  getSlot is CertificateOperationGroupOps.Read<
    Certificate,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Create or update a certificate in a given site and deployment slot.
   */
  @summary("Create or update a certificate in a given site and deployment slot.")
  createOrUpdateSlot is CertificateOperationGroupOps.CreateOrUpdateSync<
    Certificate,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Create or update a certificate for a site and deployment slot.
   */
  @summary("Create or update a certificate for a site and deployment slot.")
  @patch(#{ implicitOptionality: false })
  updateSlot is CertificateOperationGroupOps.CustomPatchSync<
    Certificate,
    PatchModel = CertificatePatchResource,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Delete a certificate for a given site and deployment slot.
   */
  @summary("Delete a certificate for a given site and deployment slot.")
  deleteSlot is CertificateOperationGroupOps.DeleteSync<
    Certificate,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Get all certificates in a resource group for a given site and a deployment slot.
   */
  @summary("Get all certificates in a resource group for a given site and a deployment slot.")
  listSlot is CertificateOperationGroupOps.List<
    Certificate,
    Response = ArmResponse<CertificateCollection>,
    OverrideErrorType = DefaultErrorResponse
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
