import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "../models/models.tsp";
import "./ReportResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using OpenAPI;

namespace Microsoft.AppComplianceAutomation;
/**
 * A class represent an AppComplianceAutomation webhook resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Azure specs should not be using decorator"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Referencing elements inside Private namespace"
@parentResource(ReportResource)
@Http.Private.includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(WebhookProperties)
model WebhookResource extends Foundations.ProxyResource {
  /**
   * Webhook Name.
   */
  @pattern("^[-a-zA-Z0-9_]{1,50}$")
  @path
  @key("webhookName")
  @segment("webhooks")
  @visibility(Lifecycle.Read)
  name: string;

  /**
   * Webhook property.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy flattening"
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  @extension("x-ms-client-name", "properties")
  properties: WebhookProperties;
}

@armResourceOperations
@tag("AppComplianceAutomation")
interface WebhookResources {
  /**
   * Get the AppComplianceAutomation webhook and its properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "For backward compatibility"
  @operationId("Webhooks_Get")
  get is ArmResourceRead<WebhookResource>;

  /**
   * Create a new AppComplianceAutomation webhook or update an exiting AppComplianceAutomation webhook.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "For backward compatibility"
  @operationId("Webhooks_CreateOrUpdate")
  createOrUpdate is AcatOperations.AcatResourceCreateOrReplaceSync<WebhookResource>;

  /**
   * Update an exiting AppComplianceAutomation webhook.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "For backward compatibility"
  @operationId("Webhooks_Update")
  update is ArmCustomPatchSync<WebhookResource, WebhookResourcePatch>;

  /**
   * Delete an AppComplianceAutomation webhook.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "For backward compatibility"
  @operationId("Webhooks_Delete")
  delete is ArmResourceDeleteSync<WebhookResource>;

  /**
   * Get the AppComplianceAutomation webhook list.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "For backward compatibility"
  @operationId("Webhooks_List")
  list is ArmResourceListByParent<
    WebhookResource,
    {
      ...BaseParameters<WebhookResource>;
      ...QueryParameters;
    }
  >;
}

@@doc(WebhookResources.createOrUpdate::parameters.parameters,
  "Parameters for the create or update operation"
);
@@doc(WebhookResources.update::parameters.properties,
  "Parameters for the create or update operation"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Deprecated: Using encodedName for the body property is meaningless."
@@encodedName(WebhookResources.update::parameters.properties,
  "application/json",
  "parameters"
);
