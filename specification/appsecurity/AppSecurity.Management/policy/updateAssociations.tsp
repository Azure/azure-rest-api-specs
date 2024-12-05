using OpenAPI;

namespace Microsoft.AppSecurity;

@doc("Request body of updateAssociations operation")
model UpdateAssociationsRequest {
  @doc("Associations to add")
  @extension("x-ms-identifiers", ["resourceId"])
  toAdd: AppProtectAssociation[];

  @doc("Associations to remove")
  @extension("x-ms-identifiers", ["resourceId"])
  toRemove: AppProtectAssociation[];
}

@doc("Response body of updateAssociations operation")
model UpdateAssociationsResponse {
  @doc("The associations of the policy after the update")
  @extension("x-ms-identifiers", ["resourceId"])
  associations: AppProtectAssociation[];
}

scalar AppProtectAssociationResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "string",
    }
  ]>;

@doc("AppProtect association definition")
model AppProtectAssociation {
  @doc("Associated ARM resource ID")
  resourceId: AppProtectAssociationResourceId;
}
