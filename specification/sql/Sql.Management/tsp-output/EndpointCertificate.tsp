import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * Certificate used on an endpoint on the Managed Instance.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(ManagedInstance)
@includeInapplicableMetadataInPayload(false)
model EndpointCertificate extends ProxyResource {
  /**
   * Type of the endpoint whose certificate the customer is looking for.
   */
  @path
  @key("endpointType")
  @segment("endpointCertificates")
  @visibility("read")
  name: string;

  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: EndpointCertificateProperties;
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
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("EndpointCertificates_ListByInstance")
  listByInstance is ArmResourceListByParent<EndpointCertificate>;
}
