namespace OpenAI {
  scalar integer extends TypeSpec.int64;
  scalar numeric extends TypeSpec.float64;
}

namespace Azure.AI.Projects {
  scalar integer extends OpenAI.integer;
  scalar numeric extends OpenAI.numeric;
}
