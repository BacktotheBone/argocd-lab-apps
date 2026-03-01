FROM mcr.microsoft.com/dotnet/sdk:8.0-noble AS build
WORKDIR /src
COPY . .
RUN dotnet restore ./app-spike-backend.csproj
RUN dotnet publish ./app-spike-backend.csproj -c Release -o /out /p:UseAppHost=false

FROM mcr.microsoft.com/dotnet/aspnet:8.0-noble-chiseled
WORKDIR /app
ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080
COPY --from=build /out .
ENTRYPOINT ["dotnet", "app-spike-backend.dll"]