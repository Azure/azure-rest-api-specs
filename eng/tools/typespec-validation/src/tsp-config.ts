import { parse as yamlParse } from "yaml";

export type TspConfig = {
  options?: Record<string, Record<string, string>>;
};

export function parse(src: string): TspConfig {
  return yamlParse(src) as TspConfig;
}
