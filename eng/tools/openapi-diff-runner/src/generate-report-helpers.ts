import { MessageLevel, MessageLine, MessageRecord } from "./types/message.js";

export const parseCompleteMessageData = (body: string): MessageRecord[] => {
  // currently we only care about Result format only
  // todo: raw message support
  const messageLines = body
    .split(/[\r\n]+/)
    .filter((l) => l) // filter out empty lines
    .map((l) => JSON.parse(l.trim()) as MessageLine);
  return parseMessageLines(messageLines);
};

const severityMap: Record<MessageLevel, number> = {
  Error: 0,
  Warning: 1,
  Info: 2,
};

const typeMap: Record<"Result" | "Raw" | "Markdown", number> = {
  Result: 0,
  Raw: 1,
  Markdown: 2,
};

export function msgCompare(a: MessageRecord, b: MessageRecord) {
  let aPostfix = a.type === "Result" && a.id ? a.id : "";
  let bPostfix = b.type === "Result" && b.id ? b.id : "";
  return `${severityMap[a.level]}${typeMap[a.type]}${aPostfix}`.localeCompare(
    `${severityMap[b.level]}${typeMap[b.type]}${bPostfix}`,
  );
}

export const parseMessageLines = (messageLines: MessageLine[]) => {
  const messages = messageLines.map((l) => (Array.isArray(l) ? l : [l]));
  return _.flatMap(messages, (m) => m).sort(msgCompare) || [];
};
