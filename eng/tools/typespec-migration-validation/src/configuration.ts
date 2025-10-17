interface configuration {
  ignoreDescription: boolean;
  enumNameToCamelCase: boolean;
  ignorePathCase: boolean;
  ignoreDefinitionCase: boolean;
}

export const configuration: configuration = {
  ignoreDescription: true,
  enumNameToCamelCase: true,
  ignorePathCase: true, // Normalize the path
  ignoreDefinitionCase: false, // Sort in "definitions" ignores casing
};
