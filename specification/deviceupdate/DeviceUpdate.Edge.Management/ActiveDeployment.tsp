import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./UpdateAccount.tsp";

using Azure.ResourceManager;
using Azure.ClientGenerator.Core;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Microsoft.DeviceUpdate;
/**
 * The details of an active deployment that is currently being offered to agents.
 */
@parentResource(UpdateAccount)
model ActiveDeployment
  is Azure.ResourceManager.TrackedResource<ActiveDeploymentProperties> {
  ...ResourceNameParameter<
    Resource = ActiveDeployment,
    KeyName = "activeDeploymentName",
    SegmentName = "activeDeployments",
    NamePattern = "^[A-Za-z0-9]+(-[A-Za-z0-9]+)*$"
  >;

  // Extended location is not included in TrackedResource yet
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Edge location of the ActiveDeployment.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @added(Versions.v2025_04_01_preview)
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
interface ActiveDeployments {
  /**
   * Returns Active Deployment details.
   */
  get is ArmResourceRead<ActiveDeployment>;

  /**
   * Creates or updates an Active Deployment.
   */
  create is ArmResourceCreateOrReplaceSync<ActiveDeployment>;

  /**
   * Updates Active Deployment.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<ActiveDeployment, TagUpdate>;

  /**
   * Delete Active Deployment.
   */
  delete is ArmResourceDeleteSync<ActiveDeployment>;

  /**
   * Returns active deployments for the given update account name.
   */
  listByUpdateAccount is ArmResourceListByParent<ActiveDeployment>;
}

@@maxLength(ActiveDeployment.name, 73);
@@minLength(ActiveDeployment.name, 1);
@@doc(ActiveDeployment.name, "Active Deployment Name.");
@@doc(ActiveDeployments.create::parameters.resource,
  "Active Deployment details."
);
@@doc(ActiveDeployments.update::parameters.properties, "Updated tags.");

#suppress "deprecated" "LEGACY - DO NOT COPY - FIX"
@@encodedName(ActiveDeployments.create::parameters.resource,
  "application/json",
  "activeDeployment"
);
@@clientName(ActiveDeployments.create::parameters.resource, "activeDeployment");

#suppress "deprecated" "LEGACY - DO NOT COPY - FIX"
@@encodedName(ActiveDeployments.update::parameters.properties,
  "application/json",
  "tagUpdatePayload"
);
@@clientName(ActiveDeployments.update::parameters.properties,
  "tagUpdatePayload"
);
