# Codebase Analyzer Agent

Generic agent for analyzing external codebases. Returns structured findings without loading the full codebase into main context.

## Usage

Launch via Task tool with `subagent_type: Explore`:

```
Task(
  prompt: <see template below>,
  subagent_type: "Explore",
  model: "haiku"  # lightweight for efficiency
)
```

## Prompt Template

```
Analyze the codebase at: {codebase_path}

Questions:
{questions}

For each question, report:
- **Found:** yes/no
- **Location:** file path and line number if found
- **Pattern:** exact signature, structure, or code snippet
- **Notes:** any relevant context

Be concise. Only report what was asked. Do not explore beyond the questions.

Format response as:

## Q1: {first question}
- Found: yes
- Location: src/foo/bar.py:42
- Pattern: `def on_chunk(self, text: str) -> None`
- Notes: Called from streaming handler

## Q2: {second question}
...
```

## Example

**Input:**
```
Analyze the codebase at: ~/projects/simply/lumina

Questions:
1. How are streaming LLM responses handled? Look for callbacks like on_token, on_delta, on_chunk.
2. What content types are supported in messages? Look for ContentBlock, TextContent, ImageContent.
```

**Output:**
```
## Q1: Streaming LLM responses
- Found: yes
- Location: Lumina/Services/LLMService.swift:127
- Pattern: `func onChunk(_ text: String) async`
- Notes: Uses AsyncStream, delegates to ConversationViewModel

## Q2: Content types in messages
- Found: yes
- Location: Lumina/Models/Message.swift:23
- Pattern: `enum ContentBlock { case text(String), image(Data, mimeType: String) }`
- Notes: No audio support yet
```

## Best Practices

1. **Specific questions** — Ask for exact patterns, not "tell me about X"
2. **One concern per question** — Easier to parse results
3. **Include search hints** — "Look for X, Y, Z" helps the agent find things
4. **Keep it lightweight** — Use haiku model, limit scope
