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

namespace Microsoft.Security;
@doc("Configures how to correlate scan data and logs with resources associated with the subscription.")
@subscriptionResource
model IngestionSetting is ProxyResource<AnyObject> {
  @doc("Name of the ingestion setting")
  @path
  @key("ingestionSettingName")
  @segment("ingestionSettings")
  name: string;
}

@armResourceOperations
interface IngestionSettings {
  @doc("Settings for ingesting security data and logs to correlate with resources associated with the subscription.")
  get is ArmResourceRead<IngestionSetting>;

  @doc("Create setting for ingesting security data and logs to correlate with resources associated with the subscription.")
  create is ArmResourceCreateOrReplaceSync<IngestionSetting>;

  @doc("Deletes the ingestion settings for this subscription.")
  delete is ArmResourceDeleteSync<IngestionSetting>;

  @doc("Settings for ingesting security data and logs to correlate with resources associated with the subscription.")
  list is ArmResourceListByParent<IngestionSetting>;

  @doc("Returns the token that is used for correlating ingested telemetry with the resources in the subscription.")
  listTokens is ArmResourceActionSync<
    IngestionSetting,
    void,
    IngestionSettingToken
  >;

  @doc("Connection strings for ingesting security scan logs and data.")
  listConnectionStrings is ArmResourceActionSync<
    IngestionSetting,
    void,
    ConnectionStrings
  >;
}

@@projectedName(IngestionSettings.create::parameters.resource,
  "json",
  "ingestionSetting"
);
@@extension(IngestionSettings.create::parameters.resource,
  "x-ms-client-name",
  "ingestionSetting"
);
@@doc(IngestionSettings.create::parameters.resource,
  "Ingestion setting object"
);
