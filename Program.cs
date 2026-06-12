using System.Numerics;

var builder = WebApplication.CreateBuilder(args);

var port = Environment.GetEnvironmentVariable("PORT") ?? "3000";
builder.WebHost.UseUrls($"http://0.0.0:{port}");

var app = builder.Build();

app.MapGet("/getnum", (string? x, string? y, HttpContext context) => {
  if (string.IsNullOrWhiteSpace(x) || string.IsNullOrWhiteSpace(y) || 
      !BigInteger.TryParse(x, out BigInteger nx) || nx <= 0 ||
      !BigInteger.TryParse(y, out BigInteger ny) || ny <= 0) {
        return "NaN";
  }

  BigInteger gcd = BigInteger.GreatestCommonDivisor(nx, ny);
  BigInteger lcm = (nx * ny) / gcd;

  return lcm.ToString();
});

app.Run();
