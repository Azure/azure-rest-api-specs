import "@typespec/versioning";

using TypeSpec.Versioning;

@doc("Faked shared model")
model FakedSharedModel {
  @doc("The tag.")
  tag: string;

  @doc("The created date.")
  createdAt: utcDateTime;

  @doc("The last modified date. Added in version 2023-02-01.")
  @added(WidgetAnalytics.Versions.v2023_02_01)
  modifiedAt?: utcDateTime;
}
