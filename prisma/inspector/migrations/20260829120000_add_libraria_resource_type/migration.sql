-- AlterEnum
-- LIBRARIA (libraria.ua) gets its own type rather than reusing LIBRARY: the
-- scrapper registry allows one plugin per ResourceType and LIBRARY is taken by
-- the nbuv plugin.
ALTER TYPE "ResourceType" ADD VALUE 'LIBRARIA';
