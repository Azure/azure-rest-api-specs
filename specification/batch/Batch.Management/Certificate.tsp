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
}

@armResourceOperations
interface Certificates {
  /**
   * Warning: This operation is deprecated and will be removed after February, 2024. Please use the [Azure KeyVault Extension](https://learn.microsoft.com/azure/batch/batch-certificate-migration-guide) instead.
   */
  #deprecated "true"
  get is ArmResourceRead<
    Certificate,
    Response = ArmResponse<Certificate> & {
      @header("ETag")
      etag?: string;
    },
    Error = CloudError
  >;

  /**
   * Warning: This operation is deprecated and will be removed after February, 2024. Please use the [Azure KeyVault Extension](https://learn.microsoft.com/azure/batch/batch-certificate-migration-guide) instead.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #deprecated "true"
  create is ArmResourceCreateOrReplaceSync<
    Certificate,
    Parameters = {
      /**
       * The entity state (ETag) version of the certificate to update. A value of "*" can be used to apply the operation only if the certificate already exists. If omitted, this operation will always be applied.
       */
      @header("If-Match")
      idMatch?: string;

      /**
       * Set to '*' to allow a new certificate to be created, but to prevent updating an existing certificate. Other values will be ignored.
       */
      @header("If-None-Match")
      ifNoneMatch?: string;
    },
    Response = ArmResourceUpdatedResponse<Certificate> & {
      @header("ETag")
      etag?: string;
    },
    Error = CloudError
  >;

  /**
   * Warning: This operation is deprecated and will be removed after February, 2024. Please use the [Azure KeyVault Extension](https://learn.microsoft.com/azure/batch/batch-certificate-migration-guide) instead.
   */
  #deprecated "true"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    Certificate,
    PatchModel = CertificateCreateOrUpdateParameters,
    Parameters = {
      /**
       * The entity state (ETag) version of the certificate to update. This value can be omitted or set to "*" to apply the operation unconditionally.
       */
      @header("If-Match")
      ifMatch?: string;
    },
    Response = ArmResponse<Certificate> & {
      @header("ETag")
      etag?: string;
    },
    Error = CloudError
  >;

  /**
   * Warning: This operation is deprecated and will be removed after February, 2024. Please use the [Azure KeyVault Extension](https://learn.microsoft.com/azure/batch/batch-certificate-migration-guide) instead.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #deprecated "true"
  delete is ArmResourceDeleteWithoutOkAsync<
    Certificate,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Warning: This operation is deprecated and will be removed after February, 2024. Please use the [Azure KeyVault Extension](https://learn.microsoft.com/azure/batch/batch-certificate-migration-guide) instead.
   */
  #deprecated "true"
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
  #deprecated "true"
  @action("cancelDelete")
  cancelDeletion is ArmResourceActionSync<
    Certificate,
    void,
    Response = ArmResponse<Certificate> & {
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
