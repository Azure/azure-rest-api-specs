import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.HorizonDb;

@added(Versions.v2026_10_01)
@doc("Represents a PostgreSQL role that is a member of the azure_pg_admin role and is mapped to a Microsoft Entra principal.")
@parentResource(Cluster)
model MicrosoftEntraAdministrator
  is Azure.ResourceManager.ProxyResource<MicrosoftEntraAdministratorProperties> {
  @doc("The Microsoft Entra object identifier of the principal mapped to the PostgreSQL role, represented as an RFC 4122 GUID.")
  @pattern("^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$")
  @key("objectId")
  @path
  @segment("microsoftEntraAdministrators")
  name: string;
}

@added(Versions.v2026_05_01_preview)
@removed(Versions.v2026_10_01)
@doc("Represents an Entra ID administrator configured on a HorizonDB cluster.")
@parentResource(Cluster)
model HorizonDbAdministrator
  is Azure.ResourceManager.ProxyResource<HorizonDbAdministratorProperties> {
  @doc("The Entra ID object identifier of the principal (an RFC 4122 GUID).")
  @pattern("^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$")
  @key("objectId")
  @path
  @segment("administrators")
  name: string;
}

@added(Versions.v2026_05_01_preview)
@removed(Versions.v2026_10_01)
@doc("Properties of a HorizonDB administrator.")
model HorizonDbAdministratorProperties {
  @doc("The display name or UPN of the Entra ID principal. For users, typically the User Principal Name (e.g., admin@contoso.com). For groups, the group display name. For service principals, the application display name.")
  @maxLength(256)
  @visibility(Lifecycle.Read, Lifecycle.Create)
  principalName: string;

  @doc("The type of the Entra ID principal.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  principalType: PrincipalTypes;

  @doc("The Entra ID object identifier of the principal (an RFC 4122 GUID). On PUT requests, this value comes from the URI path parameter.")
  @visibility(Lifecycle.Read)
  objectId?: string;

  @doc("The Entra ID tenant identifier (an RFC 4122 GUID). If omitted, defaults to the tenant of the subscription.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  tenantId?: string;

  @doc("The provisioning state of the administrator.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@added(Versions.v2026_10_01)
@doc("Properties of a PostgreSQL role that is a member of azure_pg_admin and mapped to a Microsoft Entra principal.")
model MicrosoftEntraAdministratorProperties {
  @doc("The display name or user principal name of the Microsoft Entra principal mapped to the PostgreSQL role. For users, this is typically the user principal name, such as admin@contoso.com. For groups, this is the group display name. For service principals, this is the application display name.")
  @maxLength(256)
  @visibility(Lifecycle.Read, Lifecycle.Create)
  principalName: string;

  @doc("The type of Microsoft Entra principal mapped to the PostgreSQL role.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  principalType: PrincipalTypes;

  @doc("The Microsoft Entra object identifier of the principal mapped to the PostgreSQL role, represented as an RFC 4122 GUID. On PUT requests, this value comes from the URI path parameter.")
  @visibility(Lifecycle.Read)
  objectId?: string;

  @doc("The identifier of the Microsoft Entra tenant containing the mapped principal, represented as an RFC 4122 GUID. If omitted, this value defaults to the tenant of the subscription.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  tenantId?: string;

  @doc("The provisioning state of the PostgreSQL role and Microsoft Entra principal mapping.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@added(Versions.v2026_05_01_preview)
@removed(Versions.v2026_10_01)
@doc("The properties for adding a HorizonDB administrator.")
model HorizonDbAdministratorPropertiesForAdd {
  @doc("The display name or UPN of the Entra ID principal. For users, typically the User Principal Name (e.g., admin@contoso.com). For groups, the group display name. For service principals, the application display name.")
  @maxLength(256)
  principalName: string;

  @doc("The type of the Entra ID principal.")
  principalType: PrincipalTypes;

  @doc("The Entra ID tenant identifier (an RFC 4122 GUID). If omitted, defaults to the tenant of the subscription.")
  tenantId?: string;
}

@added(Versions.v2026_05_01_preview)
@removed(Versions.v2026_10_01)
@doc("The request body for adding a HorizonDB administrator.")
model HorizonDbAdministratorAdd {
  @doc("The properties for adding a HorizonDB administrator.")
  properties: HorizonDbAdministratorPropertiesForAdd;
}

@added(Versions.v2026_10_01)
@doc("Properties for creating or updating a PostgreSQL role that is a member of azure_pg_admin and mapped to a Microsoft Entra principal.")
model MicrosoftEntraAdministratorPropertiesForAdd {
  @doc("The display name or user principal name of the Microsoft Entra principal to map to the PostgreSQL role. For users, this is typically the user principal name, such as admin@contoso.com. For groups, this is the group display name. For service principals, this is the application display name.")
  @maxLength(256)
  principalName: string;

  @doc("The type of Microsoft Entra principal to map to the PostgreSQL role.")
  principalType: PrincipalTypes;

  @doc("The identifier of the Microsoft Entra tenant containing the principal to map, represented as an RFC 4122 GUID. If omitted, this value defaults to the tenant of the subscription.")
  tenantId?: string;
}

@added(Versions.v2026_10_01)
@doc("The request body for creating or updating a PostgreSQL role that is a member of azure_pg_admin and mapped to a Microsoft Entra principal.")
model MicrosoftEntraAdministratorAdd {
  @doc("The PostgreSQL role and Microsoft Entra principal mapping properties.")
  properties: MicrosoftEntraAdministratorPropertiesForAdd;
}

@added(Versions.v2026_05_01_preview)
@doc("The type of Microsoft Entra principal mapped to a PostgreSQL role.")
union PrincipalTypes {
  string,

  @doc("An unknown or unrecognized type. This value is for internal use and is not accepted in requests.")
  Unknown: "Unknown",

  @doc("A Microsoft Entra ID user account.")
  User: "User",

  @doc("A Microsoft Entra ID security group. All members of the group inherit administrator privileges.")
  Group: "Group",

  @doc("A Microsoft Entra ID application or service principal used for automated workloads.")
  ServicePrincipal: "ServicePrincipal",
}

@added(Versions.v2026_10_01)
@doc("Operations for PostgreSQL roles that are members of azure_pg_admin and mapped to Microsoft Entra principals.")
@armResourceOperations
interface MicrosoftEntraAdministrators {
  @doc("Gets information about a PostgreSQL role that is a member of azure_pg_admin and mapped to a Microsoft Entra principal.")
  get is ArmResourceRead<MicrosoftEntraAdministrator>;

  @doc("Creates or updates a PostgreSQL role that is a member of azure_pg_admin and mapped to a Microsoft Entra principal.")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is Azure.ResourceManager.Legacy.CreateOrReplaceAsync<
    MicrosoftEntraAdministrator,
    Request = MicrosoftEntraAdministratorAdd
  >;

  @doc("Deletes a PostgreSQL role that is a member of azure_pg_admin and mapped to a Microsoft Entra principal.")
  delete is ArmResourceDeleteWithoutOkAsync<
    MicrosoftEntraAdministrator,
    Response =
      | ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
          Azure.Core.Foundations.RetryAfterHeader>
      | ArmDeletedNoContentResponse
  >;

  @doc("Lists the PostgreSQL roles in a cluster that are members of azure_pg_admin and mapped to Microsoft Entra principals.")
  list is ArmResourceListByParent<MicrosoftEntraAdministrator>;
}

@added(Versions.v2026_05_01_preview)
@removed(Versions.v2026_10_01)
@armResourceOperations
interface HorizonDbAdministrators {
  @doc("Gets information about a HorizonDB administrator.")
  get is ArmResourceRead<HorizonDbAdministrator>;

  @doc("Creates a new HorizonDB administrator or updates an existing administrator.")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is Azure.ResourceManager.Legacy.CreateOrReplaceAsync<
    HorizonDbAdministrator,
    Request = HorizonDbAdministratorAdd
  >;

  @doc("Deletes a HorizonDB administrator.")
  delete is ArmResourceDeleteWithoutOkAsync<
    HorizonDbAdministrator,
    Response =
      | ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
          Azure.Core.Foundations.RetryAfterHeader>
      | ArmDeletedNoContentResponse
  >;

  @doc("Lists all HorizonDB administrators in a cluster.")
  list is ArmResourceListByParent<HorizonDbAdministrator>;
}
