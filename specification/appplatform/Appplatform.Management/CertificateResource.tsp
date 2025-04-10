import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ServiceResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AppPlatform;
/**
 * Certificate resource payload.
 */
@parentResource(ServiceResource)
model CertificateResource
  is Azure.ResourceManager.ProxyResource<CertificateProperties> {
  ...ResourceNameParameter<
    Resource = CertificateResource,
    KeyName = "certificateName",
    SegmentName = "certificates",
    NamePattern = ""
  >;
}

@armResourceOperations
interface CertificateResources {
  /**
   * Get the certificate resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Certificates_Get")
  get is ArmResourceRead<CertificateResource>;

  /**
   * Create or update certificate resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @operationId("Certificates_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    CertificateResource,
    Response = ArmResourceUpdatedResponse<CertificateResource> | ArmResourceCreatedResponse<
      CertificateResource,
      ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
    > | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: CertificateResource;
    })
  >;

  /**
   * Delete the certificate resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("Certificates_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    CertificateResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List all the certificates of one user.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Certificates_List")
  list is ArmResourceListByParent<
    CertificateResource,
    Response = ArmResponse<CertificateResourceCollection>
  >;
}

@@doc(CertificateResource.name, "The name of the certificate resource.");
@@doc(CertificateResource.properties,
  "Properties of the certificate resource payload."
);
@@doc(CertificateResources.createOrUpdate::parameters.resource,
  "Parameters for the create or update operation"
);
