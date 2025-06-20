# Utiliza la imagen oficial de .NET para construir el proyecto
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copia el archivo .csproj con la ruta correcta
COPY MiProyectoWebApi/MiProyectoWebApi.csproj MiProyectoWebApi/MiProyectoWebApi.csproj
WORKDIR /app/MiProyectoWebApi
RUN dotnet restore

# Copia el resto de los archivos del proyecto
COPY MiProyectoWebApi/. MiProyectoWebApi/
WORKDIR /app/MiProyectoWebApi
RUN dotnet publish -c Release -o out

# Utiliza la imagen de runtime para ejecutar la app
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/MiProyectoWebApi/out .

# Render expone el puerto 80 por defecto
EXPOSE 80

# Comando para ejecutar la aplicación
ENTRYPOINT ["dotnet", "MiProyectoWebApi.dll"]
