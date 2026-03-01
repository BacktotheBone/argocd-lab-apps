#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"

echo "[1/3] Frontend: creando Angular dentro de ./frontend (forzando si hay ficheros)..."
if [ ! -f "$ROOT/frontend/angular.json" ]; then
  mkdir -p "$ROOT/frontend"
  (cd "$ROOT" && npx -y @angular/cli@17 new spike-frontend \
    --directory frontend \
    --force \
    --skip-git \
    --routing=false \
    --style=css \
    --standalone \
    --minimal)
else
  echo " - Ya existe frontend/angular.json, no regenero."
fi

echo "[2/3] Parchando app.component.ts..."
mkdir -p "$ROOT/frontend/src/app"
cat > "$ROOT/frontend/src/app/app.component.ts" <<'EOT'
import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  standalone: true,
  template: `
    <main style="font-family: system-ui; padding: 24px;">
      <h1>Spike Frontend</h1>
      <button (click)="call()">Call backend</button>
      <pre style="margin-top:16px; white-space: pre-wrap;">{{ out }}</pre>
    </main>
  `
})
export class AppComponent {
  out = 'Click "Call backend"';
  async call() {
    const r = await fetch('/api/hello');
    this.out = await r.text();
  }
}
EOT

echo "[3/3] Listo."
