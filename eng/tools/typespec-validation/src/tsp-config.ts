import { parse as yamlParse } from "yaml";

export type TspConfig = {
  emit?: string[];
  options?: Record<string, Record<string, string>>;
  linter?: {
    extends?: string[];
  };
};

export function parse(src: string): TspConfig {
  return yamlParse(src) as TspConfig;
}
