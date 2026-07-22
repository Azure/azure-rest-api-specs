@doc("The generic name value pair.")
model NameValuePair<TName, TValue> {
  @doc("The name.")
  name?: TName;

  @doc("The value.")
  value?: TValue;
}

@doc("The generic name value pair.")
model NameValuePairReadOnly<TName, TValue> {
  @doc("The name.")
  @visibility(Lifecycle.Read)
  name?: TName;

  @doc("The value.")
  @visibility(Lifecycle.Read)
  value?: TValue;
}
