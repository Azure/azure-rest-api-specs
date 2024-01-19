import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
@doc("A hostname binding object.")
@parentResource(Site)
model HostNameBinding is ProxyResource<HostNameBindingProperties> {
  @doc("Hostname in the hostname binding.")
  @path
  @key("hostName")
  @segment("hostNameBindings")
  name: string;
}

@armResourceOperations
interface HostNameBindings {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Get the named hostname binding for an app (or deployment slot, if specified).")
  @operationId("WebApps_GetHostNameBinding")
  getHostNameBinding is ArmResourceRead<HostNameBinding>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Creates a hostname binding for an app.")
  @operationId("WebApps_CreateOrUpdateHostNameBinding")
  createOrUpdateHostNameBinding is ArmResourceCreateOrReplaceSync<HostNameBinding>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Deletes a hostname binding for an app.")
  @operationId("WebApps_DeleteHostNameBinding")
  deleteHostNameBinding is ArmResourceDeleteSync<HostNameBinding>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Get hostname bindings for an app or a deployment slot.")
  @operationId("WebApps_ListHostNameBindings")
  listHostNameBindings is ArmResourceListByParent<HostNameBinding>;
}

@@projectedName(HostNameBindings.createOrUpdateHostNameBinding::parameters.resource,
  "json",
  "hostNameBinding"
);
@@extension(HostNameBindings.createOrUpdateHostNameBinding::parameters.resource,
  "x-ms-client-name",
  "hostNameBinding"
);
@@doc(HostNameBindings.createOrUpdateHostNameBinding::parameters.resource,
  "Binding details. This is the JSON representation of a HostNameBinding object."
);
