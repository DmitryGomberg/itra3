FROM ://microsoft.com AS build
WORKDIR /src
COPY ["LCMservice.csproj", "./"]
RUN dotnet restore "./LCMservice.csproj"
COPY . .
RUN dotnet publish "LCMservice.csproj" -c Release -o /app/publish

FROM ://microsoft.com AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "LCMservice.dll"]
