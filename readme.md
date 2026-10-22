# Proxecto Docker: PostgreSQL 17 e Adminer para Xestión de Albergues

Este proxecto desprega unha contorna de base de datos relacional PostgreSQL 17 cunha interface web de xestión (Adminer 4) mediante Docker Compose, automatizando a creación do esquema e a carga inicial de datos.

---

Como arrancar o proxecto paso a paso

**Acceder ao directorio do proxecto:**
   ```bash
   ```
   cd ~/bda/e1-albergues

**Copiar e configurar o ficheiro de variables de contorno:**
Copia o ficheiro de plantilla .env.example para crear o teu .env local:
```
Bash
cp .env.example .env
```
Edita o ficheiro .env se desexas definir un usuario, contrasinal ou nome de base de datos personalizados.

**Arrancar os servizos con Docker Compose:**
Executa o seguinte comando para descargar as imaxes e iniciar os contenedores en segundo plano:
```
Bash
docker compose up -d
```
**Acceder a Adminer:**
Abre o navegador en http://localhost:8080 e introduce os seguintes datos de acceso:

Sistema: PostgreSQL

Servidor: db

Usuario: O valor definido en POSTGRES_USER do teu .env

Contrasinal: O valor definido en POSTGRES_PASSWORD do teu .env

Base de datos: O valor definido en POSTGRES_DB do teu .env

Paso,Comando,Resultado obtido
1,docker compose up -d,"Despréganse os servizos db e adminer. Execútanse automaticamente os scripts 01_esquema.sql e 02_datos.sql, creandose a táboa albergues con 8 rexistros iniciais."
2,Inserir un albergue novo desde Adminer,"Execútase un INSERT desde a interface web (ex. ""Albergue de Proba""). A táboa pasa a ter 9 rexistros."
3,docker compose downe docker compose up -d,"Elimínanse os contenedores e a rede, pero mantense o volume db_data. Ao reiniciar, os datos persisten e a táboa segue tendo os 9 rexistros (incluído o albergue novo)."
4,docker compose down -ve docker compose up -d,"A opción -v elimina o volume con nome db_data. Cando se volven iniciar os servizos, créase un volume desde cero e a base de datos restáurase ao seu estado orixinal con 8 rexistros, perdéndose o albergue inserido no paso 2."

Por que no paso 4 o resultado é distinto?
No paso 3, o comando docker compose down detén e elimina os contenedores, pero conserva o volume de datos (db_data) no disco local do host. Por iso, ao levantar de novo o servizo, PostgreSQL reutiliza esa carpeta de datos existente mantendo a información intacta.

No paso 4, a opción -v (--volumes) indica a Docker Compose que debe eliminar de forma explícita todos os volumes asociados aos servizos. Ao borrarse o volume db_data, a información acumulada elimínase por completo. Cando o contenedor de PostgreSQL volta a arrancar e atopa a súa carpeta de datos baleira, detecta que é unha nova instalación e volve executar os scripts do directorio /docker-entrypoint-initdb.d (01_esquema.sql e 02_datos.sql), deixando a base de datos únicamente coa carga inicial.
