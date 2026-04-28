# Notopia Report

- Written in Vietnamese

## About Notopia

A project to build a note taking app, support markdown using blocknote, graph view (like obsidian). Project not aim to replace other existed solution (Obsidian, Notion), but to be a playground for learning and experimenting with new technologies, and university project

The project detail is not in this repo, usually it should be somewhere like `../notopia/` (the monorepo which has `AGENTS.md` you should read for more technical detail)

### Tech

- `web` app: NextJS, Shadcn, tailwindcss
- `document` service: NestJS for blocknote serverside, with hocuspocus for collaboration
- `search-worker` service: NestJS, processing data to ship to Meilisearch
- `authorization` service: Go with Casbin for authorization, multi workspace
- `note` service: Go, mainly managing this whole business logic, strictly applying Clean Architecture, DDD, CQRS
- Most of those service use Event Driven Architecture, with Redpanda (kafka compat)

---

## Report

### Tech

- Typst
- Justfile for task running (build)

### Rules

- Do not mix Vietnamese with English, only keep English for specific English in Software Engineering that should not be used in Vietnamese causing confusion
- Should use context7 and web search for more exact information, before writing the report
- Reference in [ref.bib](./src/ref.bib)
- If commit, use `typstyle` cli to format first
- Use conventional commit
