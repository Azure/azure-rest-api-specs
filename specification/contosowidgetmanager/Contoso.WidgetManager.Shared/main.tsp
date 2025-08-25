@doc("Faked shared model")
model FakedSharedModel {
  @doc("The tag.")
  tag: string;

  @doc("The created date.")
  createdAt: utcDateTime;

  @doc("Optional description for the shared model.")
  description?: string;
}
