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
@doc("Source control configuration for an app.")
@singleton("web")
model SiteSourceControl is ProxyResource<SiteSourceControlProperties> {
  @key("sourcecontrol")
  @segment("sourcecontrols")
  name: string;
}

@armResourceOperations
interface SiteSourceControls {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Gets the source control configuration of an app.")
  @operationId("WebApps_GetSourceControlSlot")
  getSourceControlSlot is ArmResourceRead<SiteSourceControl>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Updates the source control configuration of an app.")
  @operationId("WebApps_CreateOrUpdateSourceControlSlot")
  createOrUpdateSourceControlSlot is ArmResourceCreateOrUpdateAsync<SiteSourceControl>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Updates the source control configuration of an app.")
  @operationId("WebApps_UpdateSourceControlSlot")
  updateSourceControlSlot is ArmCustomPatchSync<
    SiteSourceControl,
    SiteSourceControl
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Deletes the source control configuration of an app.")
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
