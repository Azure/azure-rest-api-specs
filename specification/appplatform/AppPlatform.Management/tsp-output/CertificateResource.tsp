import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ServiceResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AppPlatform;
@doc("Certificate resource payload.")
@parentResource(ServiceResource)
model CertificateResource is ProxyResource<CertificateProperties> {
  @doc("The name of the certificate resource.")
  @path
  @key("certificateName")
  @segment("certificates")
  name: string;
}

@armResourceOperations
interface CertificateResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get the certificate resource.")
  @operationId("Certificates_Get")
  get is ArmResourceRead<CertificateResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or update certificate resource.")
  @operationId("Certificates_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<CertificateResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete the certificate resource.")
  @operationId("Certificates_Delete")
  delete is ArmResourceDeleteAsync<CertificateResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List all the certificates of one user.")
  @operationId("Certificates_List")
  list is ArmResourceListByParent<CertificateResource>;
}

@@projectedName(CertificateResources.createOrUpdate::parameters.resource,
  "json",
  "certificateResource"
);
@@extension(CertificateResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "certificateResource"
);
@@doc(CertificateResources.createOrUpdate::parameters.resource,
  "Parameters for the create or update operation"
);
