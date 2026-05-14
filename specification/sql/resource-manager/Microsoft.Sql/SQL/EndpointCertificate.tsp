import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * Certificate used on an endpoint on the Managed Instance.
 */
@parentResource(ManagedInstance)
model EndpointCertificate
  is Azure.ResourceManager.ProxyResource<EndpointCertificateProperties> {
  ...ResourceNameParameter<
    Resource = EndpointCertificate,
    KeyName = "endpointType",
    SegmentName = "endpointCertificates",
    NamePattern = ""
  >;
}

@armResourceOperations
interface EndpointCertificates {
  /**
   * Gets a certificate used on the endpoint with the given id.
   */
  get is ArmResourceRead<EndpointCertificate>;

  /**
   * List certificates used on endpoints on the target instance.
   */
  listByInstance is ArmResourceListByParent<EndpointCertificate>;
}

@@doc(EndpointCertificate.name,
  "Type of the endpoint whose certificate the customer is looking for."
);
@@doc(EndpointCertificate.properties, "Resource properties.");
