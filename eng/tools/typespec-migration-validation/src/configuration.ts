interface configuration {
  ignoreDescription: boolean;
  enumNameToCamelCase: boolean;
  ignorePathCase: boolean;
}

export const configuration: configuration = {
  ignoreDescription: true,
  enumNameToCamelCase: true,
  ignorePathCase: true, // Normalize the path 
};
