import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./BatchAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Batch;
/**
 * Contains information about a certificate.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(BatchAccount)
@includeInapplicableMetadataInPayload(false)
model Certificate extends ProxyResource {
  /**
   * The identifier for the certificate. This must be made up of algorithm and thumbprint separated by a dash, and must match the certificate data in the request. For example SHA1-a3d1c5.
   */
  @maxLength(45)
  @minLength(5)
  @pattern("^[\\w]+-[\\w]+$")
  @path
  @key("certificateName")
  @segment("certificates")
  @visibility("read")
  name: string;

  /**
   * The properties associated with the certificate.
   */
  @extension("x-ms-client-flatten", true)
  properties?: CertificateProperties;
}

@armResourceOperations
interface Certificates {
  /**
   * Warning: This operation is deprecated and will be removed after February, 2024. Please use the [Azure KeyVault Extension](https://learn.microsoft.com/azure/batch/batch-certificate-migration-guide) instead.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Certificate_Get")
  get is ArmResourceRead<Certificate>;

  /**
   * Warning: This operation is deprecated and will be removed after February, 2024. Please use the [Azure KeyVault Extension](https://learn.microsoft.com/azure/batch/batch-certificate-migration-guide) instead.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Certificate_Create")
  create is ArmResourceCreateOrReplaceSync<
    Certificate,
    {
      ...BaseParameters<Certificate>;

      /**
       * The entity state (ETag) version of the certificate to update. A value of "*" can be used to apply the operation only if the certificate already exists. If omitted, this operation will always be applied.
       */
      @header
      `If-Match`?: string;

      /**
       * Set to '*' to allow a new certificate to be created, but to prevent updating an existing certificate. Other values will be ignored.
       */
      @header
      `If-None-Match`?: string;
    }
  >;

  /**
   * Warning: This operation is deprecated and will be removed after February, 2024. Please use the [Azure KeyVault Extension](https://learn.microsoft.com/azure/batch/batch-certificate-migration-guide) instead.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Certificate_Update")
  update is ArmCustomPatchSync<
    Certificate,
    CertificateCreateOrUpdateParameters,
    {
      ...BaseParameters<Certificate>;

      /**
       * The entity state (ETag) version of the certificate to update. This value can be omitted or set to "*" to apply the operation unconditionally.
       */
      @header
      `If-Match`?: string;
    }
  >;

  /**
   * Warning: This operation is deprecated and will be removed after February, 2024. Please use the [Azure KeyVault Extension](https://learn.microsoft.com/azure/batch/batch-certificate-migration-guide) instead.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Certificate_Delete")
  delete is ArmResourceDeleteAsync<
    Certificate,
    BaseParameters<Certificate>,
    ArmLroLocationHeader
  >;

  /**
   * Warning: This operation is deprecated and will be removed after February, 2024. Please use the [Azure KeyVault Extension](https://learn.microsoft.com/azure/batch/batch-certificate-migration-guide) instead.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Certificate_ListByBatchAccount")
  listByBatchAccount is ArmResourceListByParent<
    Certificate,
    {
      ...BaseParameters<Certificate>;

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
    }
  >;

  /**
   * If you try to delete a certificate that is being used by a pool or compute node, the status of the certificate changes to deleteFailed. If you decide that you want to continue using the certificate, you can use this operation to set the status of the certificate back to active. If you intend to delete the certificate, you do not need to run this operation after the deletion failed. You must make sure that the certificate is not being used by any resources, and then you can try again to delete the certificate.
   *
   * Warning: This operation is deprecated and will be removed after February, 2024. Please use the [Azure KeyVault Extension](https://learn.microsoft.com/azure/batch/batch-certificate-migration-guide) instead.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Certificate_CancelDeletion")
  cancelDeletion is ArmResourceActionSync<Certificate, void, Certificate>;
}

@@projectedName(Certificates.create::parameters.resource, "json", "parameters");
@@extension(Certificates.create::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(Certificates.create::parameters.resource,
  "Additional parameters for certificate creation."
);
@@projectedName(Certificates.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(Certificates.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(Certificates.update::parameters.properties,
  "Certificate entity to update."
);
