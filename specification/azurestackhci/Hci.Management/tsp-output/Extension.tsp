import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ArcSetting.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureStackHCI;
@doc("Details of a particular extension in HCI Cluster.")
@parentResource(ArcSetting)
model Extension is ProxyResource<ExtensionProperties> {
  @doc("The name of the machine extension.")
  @path
  @key("extensionName")
  @segment("extensions")
  name: string;
}

@armResourceOperations
interface Extensions {
  @doc("Get particular Arc Extension of HCI Cluster.")
  get is ArmResourceRead<Extension>;

  @doc("Create Extension for HCI cluster.")
  create is ArmResourceCreateOrUpdateAsync<
    Extension,
    BaseParameters<Extension>,
    ArmAsyncOperationHeader
  >;

  @doc("Update Extension for HCI cluster.")
  update is ArmCustomPatchAsync<Extension, Extension>;

  @doc("Delete particular Arc Extension of HCI Cluster.")
  delete is ArmResourceDeleteAsync<
    Extension,
    BaseParameters<Extension>,
    ArmAsyncOperationHeader
  >;

  @doc("List all Extensions under ArcSetting resource.")
  listByArcSetting is ArmResourceListByParent<Extension>;

  @doc("Upgrade a particular Arc Extension of HCI Cluster.")
  upgrade is ArmResourceActionNoResponseContentAsync<
    Extension,
    ExtensionUpgradeParameters,
    BaseParameters<Extension>,
    ArmAsyncOperationHeader
  >;
}

@@projectedName(Extensions.create::parameters.resource, "json", "extension");
@@extension(Extensions.create::parameters.resource,
  "x-ms-client-name",
  "extension"
);
@@doc(Extensions.create::parameters.resource,
  "Details of the Machine Extension to be created."
);
@@projectedName(Extensions.update::parameters.properties, "json", "extension");
@@extension(Extensions.update::parameters.properties,
  "x-ms-client-name",
  "extension"
);
@@doc(Extensions.update::parameters.properties,
  "Details of the Machine Extension to be created."
);
@@projectedName(Extensions.upgrade::parameters.body,
  "json",
  "extensionUpgradeParameters"
);
@@extension(Extensions.upgrade::parameters.body,
  "x-ms-client-name",
  "extensionUpgradeParameters"
);
@@doc(Extensions.upgrade::parameters.body,
  "Parameters supplied to the Upgrade Extensions operation."
);
