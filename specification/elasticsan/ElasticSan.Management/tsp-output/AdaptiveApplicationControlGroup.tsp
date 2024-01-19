import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AscLocation.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Security;

@parentResource(AscLocation)
model AdaptiveApplicationControlGroup
  is ProxyResource<AdaptiveApplicationControlGroupData> {
  @doc("Name of an application control machine group")
  @path
  @key("groupName")
  @segment("applicationWhitelistings")
  name: string;
}

@armResourceOperations
interface AdaptiveApplicationControlGroups {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets an application control VM/server group.")
  @operationId("AdaptiveApplicationControls_Get")
  get is ArmResourceRead<AdaptiveApplicationControlGroup>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Update an application control machine group")
  @operationId("AdaptiveApplicationControls_Put")
  put is ArmResourceCreateOrReplaceSync<AdaptiveApplicationControlGroup>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete an application control machine group")
  @operationId("AdaptiveApplicationControls_Delete")
  delete is ArmResourceDeleteSync<AdaptiveApplicationControlGroup>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets a list of application control machine groups for the subscription.")
  @operationId("AdaptiveApplicationControls_List")
  list is ArmListBySubscription<AdaptiveApplicationControlGroup>;
}

@@projectedName(AdaptiveApplicationControlGroups.put::parameters.resource,
  "json",
  "body"
);
@@extension(AdaptiveApplicationControlGroups.put::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(AdaptiveApplicationControlGroups.put::parameters.resource, "");
