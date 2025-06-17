# Prisma schemas for duckarchive projects

Single place to store Prisma schemas for various duckarchive projects.

# Usage

1. Install the package:
    ```bash
    npm install github:duckarchive/prisma
    ```

2. Update _package.json_ to include the following:
    ```diff
    {
      "scripts": {
    +    "prisma:generate": "prisma generate",
    +    "postinstall": "prisma generate"
      },
    +  "prisma": {
    +    "schema": "node_modules/@duckarchive/prisma/SCHEMA_NAME/schema.prisma"
    +  }
    }
    ```

3. Add environment variables to your `.env` file:
    ```env
    DATABASE_URL="postgresql://..."
    ```

4. Run the following command to generate Prisma client:
    ```bash
    # run only once, later it will generate automatically during "npm install":
    npm run prisma:generate
    ```