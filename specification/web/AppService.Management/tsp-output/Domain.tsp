import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
/**
 * Information about a domain.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
model Domain extends Resource {
  /**
   * Name of the domain.
   */
  @path
  @key("domainName")
  @segment("domains")
  @visibility("read")
  name: string;

  /**
   * Domain resource specific properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: DomainProperties;
}

@armResourceOperations
interface Domains {
  /**
   * Description for Get a domain.
   */
  get is ArmResourceRead<Domain>;

  /**
   * Description for Creates or updates a domain.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Domain>;

  /**
   * Description for Creates or updates a domain.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<Domain, DomainPatchResource>;

  /**
   * Description for Delete a domain.
   */
  delete is ArmResourceDeleteSync<
    Domain,
    {
      ...BaseParameters<Domain>;

      /**
       * Specify <code>true</code> to delete the domain immediately. The default is <code>false</code> which deletes the domain after 24 hours.
       */
      @query("forceHardDeleteDomain")
      forceHardDeleteDomain?: boolean;
    }
  >;

  /**
   * Description for Get all domains in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Domains_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<Domain>;

  /**
   * Description for Get all domains in a subscription.
   */
  list is ArmListBySubscription<Domain>;

  /**
   * Description for Renew a domain.
   */
  renew is ArmResourceActionSync<Domain, void, void>;
}

@@projectedName(Domains.createOrUpdate::parameters.resource, "json", "domain");
@@extension(Domains.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "domain"
);
@@doc(Domains.createOrUpdate::parameters.resource,
  "Domain registration information."
);
@@projectedName(Domains.update::parameters.properties, "json", "domain");
@@extension(Domains.update::parameters.properties,
  "x-ms-client-name",
  "domain"
);
@@doc(Domains.update::parameters.properties,
  "Domain registration information."
);
