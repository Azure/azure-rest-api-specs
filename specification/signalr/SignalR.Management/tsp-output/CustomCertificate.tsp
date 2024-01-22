import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SignalRResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.SignalRService;
/**
 * A custom certificate.
 */
@parentResource(SignalRResource)
model CustomCertificate is ProxyResource<CustomCertificateProperties> {
  /**
   * Custom certificate name
   */
  @path
  @key("certificateName")
  @segment("customCertificates")
  name: string;
}

@armResourceOperations
interface CustomCertificates {
  /**
   * Get a custom certificate.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SignalRCustomCertificates_Get")
  get is ArmResourceRead<CustomCertificate>;

  /**
   * Create or update a custom certificate.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SignalRCustomCertificates_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<CustomCertificate>;

  /**
   * Delete a custom certificate.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SignalRCustomCertificates_Delete")
  delete is ArmResourceDeleteSync<CustomCertificate>;

  /**
   * List all custom certificates.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SignalRCustomCertificates_List")
  list is ArmResourceListByParent<CustomCertificate>;
}

@@projectedName(CustomCertificates.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(CustomCertificates.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(CustomCertificates.createOrUpdate::parameters.resource, "");
