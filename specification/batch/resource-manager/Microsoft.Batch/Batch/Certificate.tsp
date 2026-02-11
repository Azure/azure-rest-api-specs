import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./BatchAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Versioning;

namespace Microsoft.Batch;
/**
 * Contains information about a certificate.
 */
@parentResource(BatchAccount)
model Certificate
  is Azure.ResourceManager.ProxyResource<CertificateProperties> {
  ...ResourceNameParameter<
    Resource = Certificate,
    KeyName = "certificateName",
    SegmentName = "certificates",
    NamePattern = "^[\\w]+-[\\w]+$"
  >;

  /**
   * The ETag of the resource, used for concurrency statements.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Legacy design"
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * The tags of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Legacy design"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "legacy design"
  tags?: Record<string>;
}

@armResourceOperations
@tag("Certificate")
interface Certificates {
  /**
   * Warning: This operation is deprecated and will be removed after February, 2024. Please use the [Azure KeyVault Extension](https://learn.microsoft.com/azure/batch/batch-certificate-migration-guide) instead.
   */
  #deprecated "Removal of feature"
  @removed(Versions.v2025_06_01)
  get is ArmResourceRead<
    Certificate,
    Response = ArmResponse<Certificate> & {
      /**
       * The ETag HTTP response header. This is an opaque string. You can use it to detect whether the resource has changed between requests. In particular, you can pass the ETag to one of the If-Match or If-None-Match headers.
       */
      @header("ETag")
      etag?: string;
    },
    Error = CloudError
  >;

  /**
   * Warning: This operation is deprecated and will be removed after February, 2024. Please use the [Azure KeyVault Extension](https://learn.microsoft.com/azure/batch/batch-certificate-migration-guide) instead.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "Legacy behavior"
  #deprecated "Removal of feature"
  @removed(Versions.v2025_06_01)
  create is Azure.ResourceManager.Legacy.CreateOrReplaceAsync<
    Certificate,
    Request = CertificateCreateOrUpdateParameters,
    Parameters = {
      /**
       * The entity state (ETag) version of the certificate to update. A value of "*" can be used to apply the operation only if the certificate already exists. If omitted, this operation will always be applied.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Legacy casing"
      @header("If-Match")
      `If-Match`?: string;

      /**
       * Set to '*' to allow a new certificate to be created, but to prevent updating an existing certificate. Other values will be ignored.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Legacy casing"
      @header("If-None-Match")
      `If-None-Match`?: string;
    },
    Response = ArmResourceUpdatedResponse<Certificate> & {
      /**
       * The ETag HTTP response header. This is an opaque string. You can use it to detect whether the resource has changed between requests. In particular, you can pass the ETag to one of the If-Match or If-None-Match headers.
       */
      @header("ETag")
      etag?: string;
    },
    Error = CloudError
  >;

  /**
   * Warning: This operation is deprecated and will be removed after February, 2024. Please use the [Azure KeyVault Extension](https://learn.microsoft.com/azure/batch/batch-certificate-migration-guide) instead.
   */
  #deprecated "Removal of feature"
  @removed(Versions.v2025_06_01)
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    Certificate,
    PatchModel = CertificateCreateOrUpdateParameters,
    Parameters = {
      /**
       * The entity state (ETag) version of the certificate to update. This value can be omitted or set to "*" to apply the operation unconditionally.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Legacy casing"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response = ArmResponse<Certificate> & {
      /**
       * The ETag HTTP response header. This is an opaque string. You can use it to detect whether the resource has changed between requests. In particular, you can pass the ETag to one of the If-Match or If-None-Match headers.
       */
      @header("ETag")
      etag?: string;
    },
    Error = CloudError
  >;

  /**
   * Warning: This operation is deprecated and will be removed after February, 2024. Please use the [Azure KeyVault Extension](https://learn.microsoft.com/azure/batch/batch-certificate-migration-guide) instead.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Legacy design"
  #deprecated "Removal of feature"
  @removed(Versions.v2025_06_01)
  delete is ArmResourceDeleteWithoutOkAsync<
    Certificate,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Warning: This operation is deprecated and will be removed after February, 2024. Please use the [Azure KeyVault Extension](https://learn.microsoft.com/azure/batch/batch-certificate-migration-guide) instead.
   */
  #deprecated "Removal of feature"
  @removed(Versions.v2025_06_01)
  listByBatchAccount is ArmResourceListByParent<
    Certificate,
    Parameters = {
      /**
       * The maximum number of items to return in the response.
       */
      @query("maxresults")
      maxresults?: int32;

      /**
       * Comma separated list of properties that should be returned. e.g. "properties/provisioningState". Only top level properties under properties/ are valid for selection.
       */
      @query("$select")
      $select?: string;

      /**
       * OData filter expression. Valid properties for filtering are "properties/provisioningState", "properties/provisioningStateTransitionTime", "name".
       */
      @query("$filter")
      $filter?: string;
    },
    Response = ArmResponse<ListCertificatesResult>,
    Error = CloudError
  >;

  /**
   * If you try to delete a certificate that is being used by a pool or compute node, the status of the certificate changes to deleteFailed. If you decide that you want to continue using the certificate, you can use this operation to set the status of the certificate back to active. If you intend to delete the certificate, you do not need to run this operation after the deletion failed. You must make sure that the certificate is not being used by any resources, and then you can try again to delete the certificate.
   *
   * Warning: This operation is deprecated and will be removed after February, 2024. Please use the [Azure KeyVault Extension](https://learn.microsoft.com/azure/batch/batch-certificate-migration-guide) instead.
   */
  #deprecated "Removal of feature"
  @removed(Versions.v2025_06_01)
  @action("cancelDelete")
  cancelDeletion is ArmResourceActionSync<
    Certificate,
    void,
    Response = ArmResponse<Certificate> & {
      /**
       * The ETag HTTP response header. This is an opaque string. You can use it to detect whether the resource has changed between requests. In particular, you can pass the ETag to one of the If-Match or If-None-Match headers.
       */
      @header("ETag")
      etag?: string;
    },
    Error = CloudError
  >;
}

@@maxLength(Certificate.name, 45);
@@minLength(Certificate.name, 5);
@@doc(Certificate.name,
  "The identifier for the certificate. This must be made up of algorithm and thumbprint separated by a dash, and must match the certificate data in the request. For example SHA1-a3d1c5."
);
@@doc(Certificate.properties,
  "The properties associated with the certificate."
);
@@doc(Certificates.create::parameters.resource,
  "Additional parameters for certificate creation."
);
@@doc(Certificates.update::parameters.properties,
  "Certificate entity to update."
);
@@summary(Certificates.listByBatchAccount,
  "Lists all of the certificates in the specified account."
);
@@summary(Certificates.get,
  "Gets information about the specified certificate."
);
@@summary(Certificates.create,
  "Creates a new certificate inside the specified account."
);
@@summary(Certificates.update,
  "Updates the properties of an existing certificate."
);
@@summary(Certificates.delete, "Deletes the specified certificate.");
@@summary(Certificates.cancelDeletion,
  "Cancels a failed deletion of a certificate from the specified account."
);
