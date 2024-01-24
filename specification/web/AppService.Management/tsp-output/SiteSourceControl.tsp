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
 * Source control configuration for an app.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@singleton("web")
@Azure.ResourceManager.Private.armResourceInternal(SiteSourceControlProperties)
@includeInapplicableMetadataInPayload(false)
model SiteSourceControl extends ProxyOnlyResource {
  @key("sourcecontrol")
  @segment("sourcecontrols")
  name: string;

  /**
   * SiteSourceControl resource specific properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: SiteSourceControlProperties;
}

@armResourceOperations
interface SiteSourceControls {
  /**
   * Description for Gets the source control configuration of an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_GetSourceControlSlot")
  getSourceControlSlot is ArmResourceRead<SiteSourceControl>;

  /**
   * Description for Updates the source control configuration of an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_CreateOrUpdateSourceControlSlot")
  createOrUpdateSourceControlSlot is ArmResourceCreateOrReplaceAsync<SiteSourceControl>;

  /**
   * Description for Updates the source control configuration of an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("WebApps_UpdateSourceControlSlot")
  updateSourceControlSlot is ArmCustomPatchSync<
    SiteSourceControl,
    SiteSourceControl
  >;

  /**
   * Description for Deletes the source control configuration of an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_DeleteSourceControlSlot")
  deleteSourceControlSlot is ArmResourceDeleteSync<
    SiteSourceControl,
    {
      ...BaseParameters<SiteSourceControl>;

      @query("additionalFlags")
      additionalFlags?: string;
    }
  >;
}

@@projectedName(SiteSourceControls.createOrUpdateSourceControlSlot::parameters.resource,
  "json",
  "siteSourceControl"
);
@@extension(SiteSourceControls.createOrUpdateSourceControlSlot::parameters.resource,
  "x-ms-client-name",
  "siteSourceControl"
);
@@doc(SiteSourceControls.createOrUpdateSourceControlSlot::parameters.resource,
  "JSON representation of a SiteSourceControl object. See example."
);
@@projectedName(SiteSourceControls.updateSourceControlSlot::parameters.properties,
  "json",
  "siteSourceControl"
);
@@extension(SiteSourceControls.updateSourceControlSlot::parameters.properties,
  "x-ms-client-name",
  "siteSourceControl"
);
@@doc(SiteSourceControls.updateSourceControlSlot::parameters.properties,
  "JSON representation of a SiteSourceControl object. See example."
);
