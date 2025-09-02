# my first react project (next.js) — step-by-step

Prereqs:

- install Node.js LTS (18+).
- in a terminal, pick/create a folder you don’t mind using.

Step 1: scaffold the app

```bash
npx create-next-app@latest ansible-map
# when prompted:
# ✔ TypeScript? → No
# ✔ ESLint? → Yes
# ✔ Tailwind? → No (we'll add it ourselves in a sec)
# ✔ src/ directory? → Yes (optional but tidy)
# ✔ App Router? → Yes
# ✔ import alias? → @/*
cd ansible-map
```

Step 2: add tailwind css

```bash
npm install -D tailwindcss postcss autoprefixer
npx tailwindcss init -p
```

Edit tailwind.config.js content to include all app files:

```js
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./src/pages/**/*.{js,jsx}",
    "./src/components/**/*.{js,jsx}",
    "./src/app/**/*.{js,jsx}"
  ],
  theme: { extend: {} },
  plugins: [],
}
```

Open ./src/app/globals.css and make sure it has:

```css
@tailwind base;
@tailwind components;
@tailwind utilities;
```

Step 3: install UI deps

```bash
npm install lucide-react
npx shadcn@latest init -d
# add the components we use:
npx shadcn@latest add card badge
```

This creates /src/components/ui/ with card and badge.
if the alias @/* didn’t get created, add jsconfig.json at project root:

```json
{
  "compilerOptions": {
    "baseUrl": ".",
    "paths": { "@/*": ["./src/*"] }
  }
}
```

Step 4: add your component
Create src/components/AnsibleToolMap.jsx and paste the code from the canvas (it already imports from @/components/ui/... and lucide-react).

Step 5: render it on the homepage

Edit src/app/page.js:

```jsx
import AnsibleToolMap from "@/components/AnsibleToolMap";

export default function Page() {
  return (
    <main className="min-h-screen p-6 bg-white">
      <AnsibleToolMap />
    </main>
  );
}
```

Step 6: run it

```bash
npm run dev
```

Open http://localhost:3000
