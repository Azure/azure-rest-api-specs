/*
  Definitions of elements defined for Batch processor.
*/
using OpenAPI;
namespace Microsoft.Monitor;

@doc("an operator to be used by a receiver for json array parsing.")
model JsonArrayMapperOperator {
  @doc("Json array mapper source.")
  @pattern("^(body(?:\\.[^.]{1,14})?|attributes\\.[^.]{1,14})$")
  sourceField?: MessageFieldType = MessageFieldType.body;

  @doc("Json array mapper destination.")
  @pattern("^(body(?:\\.[^.]{1,14})?|attributes\\.[^.]{1,14}|attributes)$")
  destinationField?: MessageFieldType = MessageFieldType.attributes;

  @doc("Json array mapper keys. the output will be a map containing keys and its keys and the parsed input json array fields as matching values")
  keys: string[];
}

@doc("json array source and destination types. This are the options to read the json array from and write the parsed output to.")
union MessageFieldType {
  @doc("A field inside the body or the attributes of the message, for example body.jArrayInput. sub-field must be shorter than 15 chars")
  string,

  @doc("The message's body field")
  body: "body",

  @doc("The message's attributes field")
  attributes: "attributes",
}
