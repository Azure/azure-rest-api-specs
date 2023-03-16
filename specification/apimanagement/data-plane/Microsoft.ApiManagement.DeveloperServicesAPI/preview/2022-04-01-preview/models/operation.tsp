namespace DeveloperServicesAPI.Models;

model Operation {
  id: string;
  name: string;
  description: string;
  method: Method;
  urlTemplate: string;
  templateParameters: Parameter[];
  request: Request;
  responses: Response[];
  tags: Tag[];
}

model Parameter {
  name?: string;
  description?: string;
  type?: string;
  required?: boolean;
  defaultValue?: string;
  values?: string[];
  schemaId?: string;
  typeName?: string;
  // examples?: Dictionary<TKey, TValue>;
}

model Request {
  description?: string;
  queryParameters?: Parameter[];
  headers?: Parameter[];
  representations?: Representation[];
}

model Response {
  statusCode?: int32;
  description?: string;
  headers?: Parameter[];
  representations?: Representation[];
}

model Representation {
  contentType?: string;
  // examples?: Dictionary<TKey, TValue>;
  schemaId?: string;
  typeName?: string;
  formParameters?: Parameter[];
}
