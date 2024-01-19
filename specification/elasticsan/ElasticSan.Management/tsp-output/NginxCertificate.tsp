import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NginxDeployment.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Nginx.NginxPlus;

@parentResource(NginxDeployment)
model NginxCertificate is ProxyResource<NginxCertificateProperties> {
  @doc("The name of certificate")
  @path
  @key("certificateName")
  @segment("certificates")
  name: string;
}

@armResourceOperations
interface NginxCertificates {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a certificate of given NGINX deployment")
  @operationId("Certificates_Get")
  get is ArmResourceRead<NginxCertificate>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or update the NGINX certificates for given NGINX deployment")
  @operationId("Certificates_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    NginxCertificate,
    BaseParameters<NginxCertificate>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes a certificate from the NGINX deployment")
  @operationId("Certificates_Delete")
  delete is ArmResourceDeleteAsync<NginxCertificate>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List all certificates of given NGINX deployment")
  @operationId("Certificates_List")
  list is ArmResourceListByParent<NginxCertificate>;
}

@@projectedName(NginxCertificates.createOrUpdate::parameters.resource,
  "json",
  "body"
);
@@extension(NginxCertificates.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(NginxCertificates.createOrUpdate::parameters.resource, "The certificate");
