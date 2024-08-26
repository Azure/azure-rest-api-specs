/*
  Definitions of elements defined for different TCP receivers.
*/

using TypeSpec.Versioning;
using OpenAPI;

namespace Microsoft.Monitor;

@doc("Base receiver using TCP as transport protocol.")
model TcpReceiver {
  @doc("TCP endpoint definition. Example: 0.0.0.0:<port>.")
  @pattern("^[a-zA-Z0-9-\\.]+:[0-9]+$")
  endpoint: string;
}

@doc("Receiver using UDP as transport protocol.")
model UdpReceiver is TcpReceiver {
  @doc("The encoding of the stream being received.")
  encoding?: StreamEncodingType = StreamEncodingType.nop;

  @doc("Max read queue length.")
  @minValue(100)
  @maxValue(100000)
  readQueueLength?: int32 = 1000;

  @doc("Json array mapper - allows this udp receiver to parse a value from a given source field as a json array, match a key to each parsed value and output the key-value map to a given output field.")
  jsonArrayMapper?: JsonArrayMapper;
}

@doc("Encoding types for streams.")
union StreamEncodingType {
  string,

  @doc("No encoding validation. Treats the file as a stream of raw bytes.")
  nop: "nop",

  @doc("UTF-8 encoding.")
  utf_8: "utf-8",

  @doc("UTF-16 encoding with little-endian byte order.")
  utf_16le: "utf-16le",

  @doc("UTF-16 encoding with little-endian byte order.")
  utf_16be: "utf-16be",

  @doc("ASCII encoding.")
  ascii: "ascii",

  @doc("The Big5 Chinese character encoding.")
  big5: "big5",
}

@doc("A component that allows parsing a value from sourceField as a json array, match a key to each parsed value from keys, and output the key-value map to destinationField field.")
model JsonArrayMapper {
  @doc("Define a source field from which a json array will be read and parsed to it's elements. The number of elements in the json array is expected to be the same as the length of keys.")
  sourceField?: JsonMapperSourceField;

  @doc("Define a destination field to which the parsed output will be written. The output is a map, it's keys is the given keys array and the matching values are the parsed json array elements.")
  destinationField?: JsonMapperDestinationField;

  @doc("Define the names of the keys in the resulting map. The input json array elements are mapped in order, one for every key.")
  keys: string[];
}

@doc("JsonArrayMapper source field used to describe the field from which the json array will be read.")
model JsonMapperSourceField {
  @doc("Define a source field name from which the json array mapper will read the json array. Leaving this empty, means reading the body of the message itself.")
  fieldName?: string;
}

@doc("JsonArrayMapper destination field used to describe the field to which the parsed output will be written.")
model JsonMapperDestinationField {
  @doc("Define the destination's element. The element is the body or the attributes of the message, to which the json array mapper will write the output map.")
  destination?: JsonMapperElement = JsonMapperElement.Attributes;

  @doc("Define a destination field name under the given element. Leaving this empty, means the root of the element. In case element=attributes and fieldName is empty, the object's attributes themselves will contain the key value output pairs.")
  fieldName?: string;
}

@doc("JsonArrayMapper element types.")
union JsonMapperElement {
  string,

  @doc("Read or write the json array from or to the body of the message.")
  Body: "body",

  @doc("Read or write the json array from or to the attributes of the message.")
  Attributes: "attributes",
}
