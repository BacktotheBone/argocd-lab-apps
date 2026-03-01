var builder = WebApplication.CreateBuilder(args);

var app = builder.Build();

app.MapGet("/api", () => Results.Ok("backend ok"));
app.MapGet("/api/health", () => Results.Ok(new { status = "ok" }));
app.MapGet("/api/hello", () => Results.Ok("hello from backend"));

app.Run();