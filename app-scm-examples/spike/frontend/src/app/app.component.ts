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
    try {
      const r = await fetch('/api/hello');
      const t = await r.text();
      this.out = `status=${r.status}\n${t}`;
    } catch (e: any) {
      this.out = `error: ${e?.message ?? e}`;
    }
  }
}